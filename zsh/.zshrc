###############################################################################
# Shell
###############################################################################

# Set vim to lvim
alias vim=lvim
# Utility
alias c=clear
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
