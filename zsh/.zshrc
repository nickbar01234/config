###############################################################################
# Shell
###############################################################################

# Utility
alias vim=lvim
alias c=clear
alias q="exit"
# Default python3
alias python=python3
# Editor
export EDITOR=lvim
# Quickly edit config
alias zshrc="vim ~/.zshrc"
alias zshenv="vim ~/.zshenv"

###############################################################################
# oh-my-zsh
###############################################################################

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=gnzh
# zsh installation path
export ZSH="$HOME/.oh-my-zsh"
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
# Plugins
plugins=(
  alias-finder # alias-finder <alias>
  common-aliases # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases
  git # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
  autojump # j <file | folder>
)
# Apply oh-my-zsh
source "$ZSH/oh-my-zsh.sh"
# zsh syntax highlighting
source /Users/nickbar01234/zsh-plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pnpm
export PNPM_HOME="/Users/nickbar01234/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Disable pager for git log
unset LESS
