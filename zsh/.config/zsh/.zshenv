# ~/.zshenv should source this file:
# echo "source ~/.config/zsh/.zshenv" >> ~/.zshenv

# XDG Base Directory Specification
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# brew
export PATH=$PATH:/opt/homebrew/bin

# fnm
export PATH="/Users/peteran/Library/Application Support/fnm:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"

# fly.io
export FLYCTL_INSTALL="/Users/peteran/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# golang
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
# Homebrew
export GOROOT="$(brew --prefix golang)/libexec"
# Manual install
# export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export GOROOT=~/.asdf/installs/golang/1.24.0/go

# vim stuff
export VISUAL="nvim"
export EDITOR=$VISUAL

export PNPM_HOME="/Users/peteran/Library/pnpm"

export AWS_DEFAULT_PROFILE=ezyVetexport PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Android Studio
export ANDROID_HOME=$HOME/Library/Android/sdk && export PATH=$PATH:$ANDROID_HOME/emulator && export PATH=$PATH:$ANDROID_HOME/platform-tools
