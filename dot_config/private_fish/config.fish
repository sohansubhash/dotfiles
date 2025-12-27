if status is-interactive
    # Commands to run in interactive sessions can go here
end

# XDG
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache

# Colima
set -x COLIMA_HOME $XDG_CONFIG_HOME/colima

# Docker
set -x DOCKER_CONFIG $XDG_CONFIG_HOME/docker

# Deno
set -x DENO_INSTALL_ROOT $HOME/.local/bin

# pnpm
set -gx PNPM_HOME "/Users/sohan/Library/pnpm"

# npm 
set -x NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -x NPM_CONFIG_PREFIX $XDG_DATA_HOME/npm

# Rust / Cargo
set -x RUSTUP_HOME $XDG_DATA_HOME/rustup
set -x CARGO_HOME $XDG_DATA_HOME/cargo

# Go
# set -x GOPATH $HOME/Developer/go

# PlatformIO
set -x PLATFORMIO_HOME $XDG_DATA_HOME/platformio

# Claude
# set -x CLAUDE_HOME $XDG_DATA_HOME/claude

# Codex
set -x CODEX_HOME $XDG_CONFIG_HOME/codex

# ADB
set -x ANDROID_USER_HOME $XDG_CONFIG_HOME/android
