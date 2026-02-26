autoload -Uz compinit
compinit

# fnm
export PATH="$HOME/.fnm:$PATH"
# if [ -d "$FNM_PATH" ]; then
#   export PATH="$FNM_PATH:$PATH"
#   eval "`fnm env`"
# fi

eval "$(fnm env --use-on-cd --shell zsh)"
[[ -f .nvmrc ]] && fnm use

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Platform
_is_macos() { [[ "$(uname)" == Darwin ]]; }
_is_linux() { [[ "$(uname)" == Linux ]]; }

alias p='docker compose exec php /app/docker/development/entrypoint.sh'

# Vim stuff
alias vim=nvim

# pnpm (PNPM_HOME set in .zshenv)
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) [[ -n "$PNPM_HOME" ]] && export PATH="$PNPM_HOME:$PATH" ;;
esac

# Homebrew prefix (macOS or Linux Homebrew)
_brew_prefix="${HOMEBREW_PREFIX:-$(brew --prefix 2>/dev/null)}"

autoload -U +X bashcompinit && bashcompinit
# Terraform completion: Homebrew or Arch (pacman)
if [[ -n "$_brew_prefix" && -x "$_brew_prefix/bin/terraform" ]]; then
  complete -o nospace -C "$_brew_prefix/bin/terraform" terraform
elif _is_linux && command -v terraform &>/dev/null; then
  complete -o nospace -C terraform terraform
fi

# zsh-vi-mode: Homebrew or Arch (e.g. AUR zsh-vi-mode)
if [[ -n "$_brew_prefix" && -f "$_brew_prefix/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]]; then
  source "$_brew_prefix/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
elif _is_linux && [[ -f /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi

# Powerlevel10k: Homebrew or Arch (zsh-theme-powerlevel10k)
if [[ -n "$_brew_prefix" && -f "$_brew_prefix/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$_brew_prefix/share/powerlevel10k/powerlevel10k.zsh-theme"
elif _is_linux && [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# zsh-autosuggestions: Homebrew or Arch
if [[ -n "$_brew_prefix" && -f "$_brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$_brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif _is_linux && [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# zsh-syntax-highlighting: Homebrew or Arch
if [[ -n "$_brew_prefix" && -f "$_brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$_brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif _is_linux && [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ---- Eza (better ls) -----
alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh 2>/dev/null)" || true
alias cd="z"

# p10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# LÖVE game framework: macOS app path vs Linux (love in PATH)
if _is_macos && [[ -x /Applications/love.app/Contents/MacOS/love ]]; then
  alias love="/Applications/love.app/Contents/MacOS/love"
fi

# opencode
export PATH=/Users/peteran/.opencode/bin:$PATH
alias c="opencode"

