# Config

This repo contains my terminal configurations and a script to sync my local
config files with Github.

The script to sync config files took inspiration from [Tai
Duong](https://medium.com/nerd-for-tech/organize-and-auto-back-up-your-zshrc-files-to-github-364a262b3227).

## Setup

The script was written for Macbooks. If you're on Window or Linux, you
will have to do some digging / write your own script. Luckily, the core
ideas are similar:

1. Install an API to monitor filesystem changes. I used [fswatch](https://github.com/emcrisostomo/fswatch).
2. Write a script to listen to config changes. When changes are detected, the
script can copy the file to your backup folder.
3. Setup your script as a background task.

### macOS

Initialize a new repo to store the config files. Copy `listener.sh` to your
repo. This file defines a mapping from a config file path to its backup folder
in the repo - you can add or remove files here.

```sh
typeset -A configs
configs=(
  $HOME/.zshenv $ZSH_STORE
  $HOME/.zshrc $ZSH_STORE
  $HOME/.config/lvim/config.lua $LVIM_STORE
  $HOME/.config/lvim/init.lua $LVIM_STORE
  # Add your config file and backup location here...
)
```

Copy `com.nickbar01234.backup-config.plist` to your repo. You can change
the filename to use your username instead (mine is nickbar01234). You will
need to update the paths inside the file to match your file system. 

To start the script as a background task:

1. `cp com.<username>.backup-config.plist ~/Library/LaunchAgents/`
2. `cd ~/Library/LaunchAgents/`
3. `launchctl load com.<username>.backup-config.plist`
4. If `launchctl list | grep com.<username>.backup-config` returns 0 exit
status then the background task started correctly
4. Test Github push by modifying your config file. You can check for error logs
from the path you defined for `StandardErrorPath` in `com.<username>.backup-config.plist`
