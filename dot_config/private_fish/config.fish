if status is-interactive
    # Commands to run in interactive sessions can go here
end

# XDG
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

# Fish vim mode
set -g fish_key_bindings fish_vi_key_bindings

# Colima
set -x COLIMA_HOME $XDG_CONFIG_HOME/colima

# Docker
set -x DOCKER_CONFIG $XDG_CONFIG_HOME/docker

# Kube
set -gx KUBECONFIG "$XDG_CONFIG_HOME/kube/config"

# Deno
set -x DENO_INSTALL_ROOT $HOME/.local/bin

# npm
set -x NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -x NPM_CONFIG_PREFIX $XDG_DATA_HOME/npm

# Rust / Cargo
set -x RUSTUP_HOME $XDG_DATA_HOME/rustup
set -x CARGO_HOME $XDG_DATA_HOME/cargo

# Go
set -x GOENV $XDG_CONFIG_HOME/go/env
set -x GOPATH $XDG_DATA_HOME/go
set -x GOMODCACHE $XDG_CACHE_HOME/go
set -x GOBIN $HOME/.local/bin

# PlatformIO
set -x PLATFORMIO_HOME $XDG_DATA_HOME/platformio

# Claude
set -x CLAUDE_CONFIG_DIR $XDG_DATA_HOME/claude

# Codex
set -x CODEX_HOME $XDG_CONFIG_HOME/codex

# ADB
set -x ANDROID_USER_HOME $XDG_CONFIG_HOME/android

# Fly
set -x FLY_CONFIG $XDG_CONFIG_HOME/fly

# pnpm
set -gx PNPM_HOME "$XDG_DATA_HOME/pnpm"
fish_add_path --global "$PNPM_HOME/bin"
