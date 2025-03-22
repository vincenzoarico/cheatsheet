# Cheatsheet
A personal terminal cheatsheet also with the contribution of tealdeer and cheat.sh.

# Prerequisites

## Tealdeer
Advice for you is to enable auto-update local cache:
1. `tldr --seed-config` to create a basic config.
2. `tldr --show-paths` to show your config file path and activate the auto-update option using nano/vim.

# Preconfiguration
```
mkdir -p ~/.local/bin
cp cheatsheet.sh ~/.local/bin/cheatsheet
chmod +x ~/.local/bin/cheatsheet
```
Bash:
```
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```
ZSH:
```
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

# Usage  
You can see the usage with the `cheatsheet help` command.

# Examples

# Notes 
Never execute `cheatsheet update` to update tealdeer if you didn't install it with Homebrew. You must consider a manual update of the tealdeer.
