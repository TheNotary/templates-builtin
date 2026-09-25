# syntax=docker/dockerfile:1

FROM rust:1-bookworm AS plen-build

# plen is pure Rust with no native C dependencies, so it links cleanly against
# musl. Building it static keeps the same binary usable from any base image.
#
# The triple is derived from `uname -m` rather than hard-coded: this repo is
# developed on both x86_64 and aarch64 hosts, and naming the wrong arch makes
# the musl link fail with "cc: unrecognized command-line option '-m64'".
RUN apt-get update \
    && apt-get install -y --no-install-recommends musl-tools \
    && rm -rf /var/lib/apt/lists/* \
    && rustup target add "$(uname -m)-unknown-linux-musl"

WORKDIR /src
COPY --from=plen . .

# crates/plen-cli/build.rs shells out to git for a version stamp and falls back
# to "unknown" when .git is missing, so excluding it from the context is safe.
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    triple="$(uname -m)-unknown-linux-musl" \
    && cargo build --release --locked --target "$triple" -p plen-cli \
    && cp "target/$triple/release/plen" /usr/local/bin/plen

#FROM mcr.microsoft.com/devcontainers/javascript-node:1-22-bookworm
FROM mcr.microsoft.com/devcontainers/ruby:4-bookworm

RUN apt-get update \
    && apt-get install -y --no-install-recommends tmux \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN chown -R 1000:1000 /app

#COPY --from=coding-harness . .

COPY --from=plen-build /usr/local/bin/plen /usr/local/bin/plen

