#!/usr/bin/env bash
# shellcheck shell=bash


# Prerequisites: tealdeer (with auto-update actived).

# The 'cheatsheet <cmd>' command prints the <cmd> cheatsheet (cheat.sh + tealdeer + your commands).


# Path of your commands files
CHEATSHEET_COMMANDS="$HOME/.cheatsheet_commands"


# Colors
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"
SEPARATOR="──────────────────────────────────────────"


sanitize_name() {
    echo "$1" | tr ' ' '-'
}

# Function to update tealdeer
update() {
    echo "Check for tealdeer updates..."
    if brew outdated | grep -q "tealdeer"; then
        echo "Updating tealdeer..."
        brew upgrade tealdeer || echo "Error while updating tealdeer"
    else
        echo "Tealdeer is already updated"
    fi
    
    return 0
}

# Function to print all your commands
print_commands() {
    echo "My commands:"
    cat "$CHEATSHEET_COMMANDS"/*.txt 2>/dev/null
    
    return 0
}

# Function to print one of your commands
print_command() {
    local expected_params=1
    [[ $# -ne $expected_params ]] && {
        echo "Error: 'print_command' requires $expected_params parameter. Received $#."
        return 1
    }
    
    echo "My commands:"
    cat "$CHEATSHEET_COMMANDS/$(sanitize_name "$1").txt" 2>/dev/null
    
    return 0
}

# Function to add one of your command
add_command() {
    local expected_params=3
    [[ $# -ne $expected_params ]] && {
        echo "Error: 'add_command' requires $expected_params parameter. Received $#."
        return 1
    }
    
    ! test -f "$CHEATSHEET_COMMANDS/$(sanitize_name "$1").txt" && touch "$CHEATSHEET_COMMANDS/$(sanitize_name "$1").txt"
    echo "$2" >> "$CHEATSHEET_COMMANDS/$(sanitize_name "$1").txt"
    echo "Description: $3" >> "$CHEATSHEET_COMMANDS/$(sanitize_name "$1").txt"
    echo "Added: $(date +%Y-%m-%d)" >> "$CHEATSHEET_COMMANDS/$(sanitize_name "$1").txt"
    echo "" >> "$CHEATSHEET_COMMANDS/$(sanitize_name "$1").txt"
    echo "Added command: '$2'"
    
    return 0
}

execute() {
    local expected_params=1
    [[ $# -ne $expected_params ]] && {
        echo "Error: 'execute' requires $expected_params parameter. Received $#."
        return 1
    }
    
    local encoded_cmd_type=$(echo "$1" | sed 's/ /%20/g')

    # tldr --update &>/dev/null # tldr autoupdate


    # Tealdeer
    tealdeer_output=$(tldr "$1" 2>/dev/null)
    if [[ -n "$tealdeer_output" ]]; then
        echo "${GREEN}${SEPARATOR}\nTEALDEER\n${SEPARATOR}${RESET}"
        echo "$tealdeer_output"
    else 
	echo "${RED}Command not found in tldr${RESET}"
    fi

    # cheat.sh
    cheat_output=$(curl -s "cheat.sh/$encoded_cmd_type")
    if [[ -n "$cheat_output" ]]; then
        echo "${BLUE}${SEPARATOR}CHEAT.SH${SEPARATOR}${RESET}"
        echo "$cheat_output"
    else
	echo "${RED}Failed to fetch from cheat.sh${RESET}"
    fi

    # your commands
    custom_output=$(cat "$CHEATSHEET_COMMANDS/$(sanitize_name "$1").txt" 2>/dev/null)
    if [[ -n "$custom_output" ]]; then
        echo "${YELLOW}${SEPARATOR}YOUR COMMANDS${SEPARATOR}${RESET}"
        echo "$custom_output"
    else 
	echo "${RED}No personal commands found${RESET}"
    fi

    return 0
}

help(){
    echo "UPDATE (only if you have installed tealdeer with Homebrew): cheatsheet update"
    echo "PRINT ALL YOUR COMMANDS: cheatsheet print_commands"
    echo "PRINT ONE TYPE OF YOUR COMMANDS: cheatsheet print_command <cmd_type>"
    echo "ADD COMMAND: cheatsheet add_command <cmd_type> <cmd> <desc>"
    echo "CHEAT: cheatsheet execute <cmd>"
    echo "HELP: cheatsheet help"
    
    echo "Each command parameter has to be passed between "" if contains spaces"
    echo "Path to manage your commands: '$CHEATSHEET_COMMANDS'"
    
    return 0
}


main() {
    if ! test -d "$CHEATSHEET_COMMANDS"; then
        mkdir "$CHEATSHEET_COMMANDS"
    fi
    
    local function="$1"
    shift
    if declare -f "$function" &>/dev/null; then
        "$function" "$@"
    else
        echo "Function '$function' doesn't exist!"
        return 1
    fi
    
    return 0
}


main "$@"