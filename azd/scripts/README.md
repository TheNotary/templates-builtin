# Scripts

This directory is a Ruby gem (`foo_bar`) that implements the azd hook lifecycle scripts referenced in `azure.yaml`.

## Structure

```
scripts/
├── exe/                         # Hook entry points (called by azd)
│   ├── preprovision             # Runs before `azd provision`
│   ├── postprovision            # Runs after `azd provision`
│   ├── predeploy                # Runs before `azd deploy`
│   └── postdeploy               # Runs after `azd deploy`
├── lib/
│   ├── foo_bar.rb               # Main gem loader
│   └── foo_bar/
│       ├── version.rb           # Gem version
│       ├── helpers.rb           # Shared helpers (logging, shell, tool detection)
│       └── validation/
│           └── local_environment.rb  # Pre-flight tool & auth checks
└── spec/                        # RSpec tests
```

## How Hooks Work

Each `exe/` script is a thin wrapper that loads the gem and calls a module:

```ruby
#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "foo_bar"

FooBar::YourModule.run
```

azd invokes these via the `hooks:` section in `azure.yaml`.

## Adding a New Hook Module

1. Create a new file under `lib/foo_bar/` (e.g., `lib/foo_bar/provisioning/setup.rb`)
2. Define a module with a `.run` method:
   ```ruby
   module FooBar
     module Provisioning
       module Setup
         extend FooBar::Helpers

         def self.run
           log "Running setup…"
           # your logic here
         end
       end
     end
   end
   ```
3. Add `require_relative "foo_bar/provisioning/setup"` to `lib/foo_bar.rb`
4. Call it from the appropriate `exe/` hook script

## Running Tests

```
cd scripts
bundle install
bundle exec rspec
```
