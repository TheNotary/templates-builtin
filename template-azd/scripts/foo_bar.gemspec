# frozen_string_literal: true

require_relative "lib/foo_bar/version"

Gem::Specification.new do |spec|
  spec.name          = "foo_bar"
  spec.version       = FooBar::VERSION
  spec.authors       = ["TheNotary"]
  spec.summary       = "Infrastructure automation scripts for foo-bar"
  spec.description   = "Ruby gem wrapping the foo-bar azd deployment hooks " \
                        "with structured validation, provisioning, and deployment scripts."
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.files = Dir.glob("lib/**/*.rb") + Dir.glob("exe/*")
  spec.bindir        = "exe"
  spec.executables   = Dir.glob("exe/*").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.13"
end
