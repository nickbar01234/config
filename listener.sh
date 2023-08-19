#!/usr/bin/env zsh

# TODO(nickbar01234) - Restructure configuration files for maintainability.

if ! command -v fswatch &> /dev/null
then
  echo "[Required] brew install fswatch"
  exit 1
fi

if [ ! -d ".git" ] 
then
  echo "[Required] git init"
  exit 1
fi

echo "[Log] Start script to auto-backup config file"

# Folder of script
FOLDER=$(dirname ${0:a})
# TODO(nickbar01234) - Add configuration folders
ZSH_STORE=$FOLDER/zsh
LVIM_STORE=$FOLDER/lvim
BINARY_STORE=$FOLDER/bin

# Maps a config file to a folder to copy to for commit
typeset -A configs
configs=(
  $HOME/.zshenv $ZSH_STORE
  $HOME/.zshrc $ZSH_STORE
  $HOME/.config/lvim/config.lua $LVIM_STORE
  $HOME/.config/lvim/init.lua $LVIM_STORE
  $HOME/.local/bin/nickbar01234 $BINARY_STORE
)

fswatch -0 "${(@k)configs}" | while read -d "" file;
  do
    echo "[Log] $file has been modified"
    
    # Destination to copy config file to
    folder=$configs[$file]
    if [[ $folder = '' ]]
    then
      # We use dirname here instead if we want to track a folder instead
      # of specific files
      folder="$configs[$(dirname $file)]"
    fi

    echo $folder
    mkdir -p $folder
    cp $file $folder
    git add $folder
    git commit -m "Backup $file"
    git push origin main
  done
