# frozen_string_literal: true

require_relative "foo_bar/version"
require_relative "foo_bar/helpers"
require_relative "foo_bar/timing_report"
require_relative "foo_bar/lifecycle_runner"
require_relative "foo_bar/log_azd"
require_relative "foo_bar/validation/local_environment"
require_relative "foo_bar/provisioning/grant_roles_to_az_user"
require_relative "foo_bar/deploy/enable_storage_access"

module FooBar
end
