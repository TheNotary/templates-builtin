require "foo_bar/version"
require "foo_bar/constants"
require "foo_bar/config"


module FooBar
  # Your code goes here...
  def self.main
    "test"
  end

  def self.help
    msg = <<-EOF
foo-bar
TODO: Update this to be correct to this tool!
Commands:
  ls           - List things
  run          - Run things
  status       - Show status
EOF
  end
end
