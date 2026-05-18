# frozen_string_literal: true

require "fileutils"

module FooBar
  # Tee combined stdout/stderr to REPO_ROOT/logs/<name>.log so that
  # azd lifecycle hooks produce both real-time terminal output and a
  # persistent log file for later inspection.
  #
  # Typical usage from an exe script:
  #
  #   FooBar::LogAzd.tee_to_log!("predeploy")
  #
  module LogAzd
    LOG_DIR = File.join(FooBar::Helpers::REPO_ROOT, "logs")

    def self.tee_to_log!(name)
      return if @tee_installed
      @tee_installed = true

      FileUtils.mkdir_p(LOG_DIR)
      log_path = File.join(LOG_DIR, "#{name}.log")

      read_io, write_io = IO.pipe

      # tee child inherits the original fd 1 / fd 2 (azd's pipes) BEFORE
      # we redirect them in this process.
      tee_pid = Process.spawn("tee", log_path,
        in:  read_io,
        out: STDOUT,
        err: STDERR,
      )
      read_io.close

      # Save the originals so we can restore fd 1 / fd 2 at exit. Without
      # this, fd 1 stays as a dup of the pipe write end after we reopen,
      # and tee never sees EOF — making the at_exit waitpid deadlock.
      orig_stdout = STDOUT.dup
      orig_stderr = STDERR.dup

      STDOUT.reopen(write_io)
      STDERR.reopen(write_io)

      # disable Ruby's write buffering
      STDOUT.sync = true
      STDERR.sync = true
      write_io.close

      at_exit do
        begin
          STDOUT.flush
          STDERR.flush
        rescue StandardError
          # ignore
        end
        # Restore fd 1 / fd 2 to the originals. This drops the last
        # references to the pipe write end inside this process, so tee
        # observes EOF on its stdin and exits cleanly. azd, which is
        # reading the original fd 1 / fd 2, also sees EOF and proceeds.
        begin
          STDOUT.reopen(orig_stdout)
          STDERR.reopen(orig_stderr)
        rescue StandardError
          # ignore
        end
        begin
          Process.waitpid(tee_pid)
        rescue Errno::ECHILD, Errno::ESRCH
          # already reaped
        end
      end

      log_path
    end
  end
end
