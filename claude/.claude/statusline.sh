#!/usr/bin/env bash
set -eu

input=$(cat)
model=$(printf '%s' "$input" | jq -r '.model.display_name // "claude"')
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // "."')
basename_cwd=$(basename "$cwd")
branch=$(git -C "$cwd" branch --show-current 2>/dev/null || true)

printf '\033[36m%s\033[0m \033[2m|\033[0m \033[33m%s\033[0m' "$model" "$basename_cwd"
[ -n "$branch" ] && printf ' \033[2m|\033[0m \033[32m%s\033[0m' "$branch"

session_id=$(printf '%s' "$input" | jq -r '.session_id // ""')
links_file="$HOME/.claude/session-links/$session_id.tsv"
if [ -n "$session_id" ] && [ -s "$links_file" ]; then
  count=$(wc -l < "$links_file" | tr -d ' ')
  IFS=$'\t' read -r _ kind url _ < <(tail -n 1 "$links_file")
  case $kind in
    MR) label="!${url##*/}" ;;
    PR) label="#${url##*/}" ;;
    Jira) label="${url##*/}" ;;
    *) label="$kind" ;;
  esac
  printf ' \033[2m|\033[0m \033]8;;%s\a\033[34;4m%s\033[0m\033]8;;\a' "$url" "$label"
  if [ "$count" -gt 1 ]; then printf ' \033[2m+%s\033[0m' "$((count - 1))"; fi
fi
