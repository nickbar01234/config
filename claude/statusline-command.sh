#!/usr/bin/env bash
# Claude Code status line — mirrors jaischeema zsh theme
# Input: JSON via stdin

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')

# Shorten home directory to ~
home="$HOME"
display_dir="${cwd/#$home/\~}"

# Git branch (skip optional locks)
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  git_branch=$(git -C "$cwd" -c core.hooksPath=/dev/null symbolic-ref --short HEAD 2>/dev/null \
    || git -C "$cwd" -c core.hooksPath=/dev/null rev-parse --short HEAD 2>/dev/null)
fi

# ANSI colors (will render dimmed in status line)
magenta='\033[1;35m'
green='\033[1;32m'
red='\033[0;31m'
blue='\033[1;34m'
yellow='\033[0;33m'
cyan='\033[0;36m'
reset='\033[0m'

# Model and effort
model_name=$(echo "$input" | jq -r '.model.display_name // empty')
effort=$(jq -r '.effortLevel // empty' ~/.claude/settings.json 2>/dev/null)

model_part=""
if [ -n "$model_name" ]; then
  if [ -n "$effort" ]; then
    model_part=$(printf "${cyan}[%s | effort:%s]${reset} " "$model_name" "$effort")
  else
    model_part=$(printf "${cyan}[%s]${reset} " "$model_name")
  fi
fi

if [ -n "$git_branch" ]; then
  # Check for dirty state
  if git -C "$cwd" -c core.hooksPath=/dev/null diff --quiet 2>/dev/null \
    && git -C "$cwd" -c core.hooksPath=/dev/null diff --cached --quiet 2>/dev/null; then
    git_part=$(printf "${blue}±(%s${blue})${reset} " "${git_branch}")
  else
    git_part=$(printf "${blue}±(%s${blue}) ${yellow}✗${reset} " "${git_branch}")
  fi
else
  git_part=""
fi

# Token usage from context_window (only shown after first API call)
# used_percentage and context_window_size are reliable pre-calculated fields.
# Derive token count as used_percentage * context_window_size / 100 to match
# what the percentage reflects (cumulative session context, not a single call).
# current_usage.input_tokens is only the last individual API call — not useful here.
token_part=""
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
window_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
if [ -n "$used_pct" ] && [ -n "$window_size" ]; then
  # Derive token count from percentage * window size
  input_tokens=$(awk "BEGIN { printf \"%.0f\", $used_pct * $window_size / 100 }")
  # Format as compact numbers: e.g. 45k / 200k
  fmt_tokens=$(awk "BEGIN { t=$input_tokens; if(t>=1000) printf \"%.0fk\", t/1000; else printf \"%d\", t }")
  fmt_window=$(awk "BEGIN { w=$window_size; if(w>=1000) printf \"%.0fk\", w/1000; else printf \"%d\", w }")
  pct_int=$(printf "%.0f" "$used_pct")
  token_part=$(printf "${red}[ctx:%s/%s %d%%]${reset} " "$fmt_tokens" "$fmt_window" "$pct_int")
fi

printf "${green}%s${reset} %s\n%s%s" "$display_dir" "$git_part" "$model_part" "$token_part"
