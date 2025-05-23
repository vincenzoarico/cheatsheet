# Cheatsheet
A personal terminal cheatsheet, with the contribution of tealdeer and cheat.sh.

## Prerequisites

### Tealdeer
Install it.

MacOS install (if you use Homebrew):
`brew install tealdeer`

Advice for you is to enable auto-update local cache:
1. `tldr --seed-config` to create a basic config.
2. `tldr --show-paths` to show your config file path and activate the auto-update option using nano/vim.

## Preconfiguration
```
mkdir -p ~/.local/bin
cp cheatsheet.sh ~/.local/bin/cheatsheet
chmod +x ~/.local/bin/cheatsheet
```

Bash shell:
```
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

ZSH shell:
```
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Usage  
You can see the usage with the `cheatsheet help` command.

### Examples
```
cheatsheet update
cheatsheet execute "docker compose" 
cheatsheet add_command "docker compose" "docker compose up" "New command description"
cheatsheet add_command "git add" "git add -A" "command"
cheatsheet add_command "git add" "git add -f" "another command"
cheatsheet print_command "git add"
cheatsheet print_commands
```

All commands are easy to understand except `cheatsheet execute <family-cmd>`, which is used to print not only your added commands relative to that ***\<family-cmd\>*** but also the cheat.sh and the tealdeer execution for that ***\<family-cmd\>***.

### Storage location
All your commands are stored at this directory path: `$HOME/.cheatsheet_commands/`. Inside this folder will be all \<family-cmd\>.txt files, where you will find all your added commands.

## Notes 
Never execute `cheatsheet update` to update tealdeer if you didn't install it with Homebrew (Mac OS). You must consider a manual update of the tealdeer.
