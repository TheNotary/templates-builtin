# Foo::Bar

[![Build](https://github.com/YOUR_GITHUB_OWNER/YOUR_REPO/actions/workflows/ci-main.yaml/badge.svg)](https://github.com/YOUR_GITHUB_OWNER/YOUR_REPO/actions/workflows/ci-main.yaml)
[![Latest Version](https://img.shields.io/github/v/release/YOUR_GITHUB_OWNER/YOUR_REPO?label=latest)](https://github.com/YOUR_GITHUB_OWNER/YOUR_REPO/releases/latest)

TODO: Delete this and the text above, and describe your project

## Installation

Download this repo with git.  

```
$ git clone FOO_GIT_REPO_URL
```

To build the docker container do:

    $ make build

To test the container do:

    $ make console
      
To run the container do:

    $ make run


## Development

Add system commands that need to be run in the `Dockerfile` in order to build the environment for the dockerized app.  

The `entrypoint.sh` should contain all the commands required to start the dockerized service.  

## Releasing

The template release automation is tag-driven and expects semantic version tags in the format `vX.Y.Z`.

1. Pick the next version, e.g. `0.1.0`.
2. Create and push the tag:

    $ make release-tag VERSION=0.1.0
    $ make release-push VERSION=0.1.0

    or manually:

    $ git tag -a v0.1.0 -m "Release v0.1.0"
    $ git push origin v0.1.0

Pushing a semver tag triggers `.github/workflows/release-image.yaml` and publishes both image tags: `{version}` and `latest`.


