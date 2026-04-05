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

printf "${green}%s${reset} %s%s" "$display_dir" "$git_part" "$model_part"
