# Foo Bar

TODO: Delete this and the text above, and describe your project

## Quick Start

```
$ git clone FOO_GIT_REPO_URL
$ cd foo-bar
$ azd up
```

## Prerequisites

- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli)
- [Azure Developer CLI (azd)](https://learn.microsoft.com/azure/developer/azure-developer-cli/install-azd)
- [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (for hook scripts)

## Project Structure

```
foo-bar/
├── azure.yaml              # azd project definition (infra + hooks)
│
├── infra/
│   ├── main.bicep           # Subscription-scoped Bicep entry point
│   ├── main.parameters.json # Parameter bindings
│   ├── abbreviations.json   # Azure resource naming conventions
│   └── modules/             # Reusable Bicep modules
│       └── storage.bicep    # Example module
│
└── scripts/                 # Ruby gem for azd hook lifecycle
    ├── foo_bar.gemspec
    ├── Gemfile
    ├── exe/                 # Hook entry points
    │   ├── preprovision
    │   ├── postprovision
    │   ├── predeploy
    │   └── postdeploy
    └── lib/
        └── foo_bar/         # Hook implementation modules
```

## Development

Infrastructure is defined in Bicep under `infra/`. Add new modules in `infra/modules/` and wire them into `infra/main.bicep`.

Hook scripts live under `scripts/` as a Ruby gem. See `scripts/README.md` for details on adding new hook logic.
