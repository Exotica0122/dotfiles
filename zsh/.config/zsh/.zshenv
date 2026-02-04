# ~/.zshenv should source this file:
# echo "source ~/.config/zsh/.zshenv" >> ~/.zshenv

# Platform: Darwin = macOS, Linux = Arch etc.
_is_macos() { [[ "$(uname)" == Darwin ]]; }
_is_linux() { [[ "$(uname)" == Linux ]]; }

# XDG Base Directory Specification
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# brew
if _is_macos; then
  export PATH="$PATH:/opt/homebrew/bin"
fi

# fnm (Node version manager)
if _is_macos; then
  export PATH="$HOME/Library/Application Support/fnm:$PATH"
else
  export PATH="$HOME/.local/share/fnm:$PATH"
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"

# fly.io
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# golang
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
if command -v brew &>/dev/null; then
  export GOROOT="$(brew --prefix golang 2>/dev/null)/libexec"
fi
[[ -z "$GOROOT" && -d "$HOME/.asdf/installs/golang" ]] && export GOROOT="$HOME/.asdf/installs/golang/$(ls "$HOME/.asdf/installs/golang" 2>/dev/null | tail -n1)/go"
[[ -z "$GOROOT" && _is_linux && -d /usr/lib/go ]] && export GOROOT=/usr/lib/go
export PATH="$PATH:$GOPATH/bin"
[[ -n "$GOROOT" ]] && export PATH="$PATH:$GOROOT/bin"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# vim stuff
export VISUAL="nvim"
export EDITOR=$VISUAL

# pnpm
if _is_macos; then
  export PNPM_HOME="$HOME/Library/pnpm"
else
  export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
fi
export PATH="$PNPM_HOME:$PATH"

export PATH="$PATH:$HOME/.config/emacs/bin/doom"
