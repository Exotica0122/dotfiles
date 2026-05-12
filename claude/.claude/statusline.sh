#!/usr/bin/env bash
set -eu

input=$(cat)
model=$(printf '%s' "$input" | jq -r '.model.display_name // "claude"')
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // "."')
basename_cwd=$(basename "$cwd")
branch=$(git -C "$cwd" branch --show-current 2>/dev/null || true)

printf '\033[36m%s\033[0m \033[2m|\033[0m \033[33m%s\033[0m' "$model" "$basename_cwd"
[ -n "$branch" ] && printf ' \033[2m|\033[0m \033[32m%s\033[0m' "$branch"
