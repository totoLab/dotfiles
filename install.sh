#!/bin/sh

set -xe

# Check if zsh is installed
if ! command -v zsh &> /dev/null
then
    echo "zsh is not installed. Please install it first."
    exit 1
fi

# Change the default shell to zsh
if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s $(command -v zsh)
    echo "Default shell changed to zsh."
fi

# Create the .config/zsh directory if it doesn't exist
ZSH_CONFIG_DIR="$HOME/.config/zsh"
if [ ! -d "$ZSH_CONFIG_DIR" ]; then
    mkdir -p "$ZSH_CONFIG_DIR"
    echo "Created directory $ZSH_CONFIG_DIR"
fi

# Copy all zsh configuration files and directories to .config/zsh/
cp .zshrc "$ZSH_CONFIG_DIR/"
cp .profile "$ZSH_CONFIG_DIR/"
cp .zshaliases "$ZSH_CONFIG_DIR/"
cp .shell_prompt "$ZSH_CONFIG_DIR/"

echo "Copied all zsh configuration files to $ZSH_CONFIG_DIR/"

# Create a soft link in $HOME for .zshrc -> .config/zsh/.zshrc
ln -sf "$ZSH_CONFIG_DIR/.zshrc" "$HOME/.zshrc"
echo "Created a symlink for .zshrc in the home directory"

# Source the .zshrc file
source "$HOME/.zshrc"
echo "Sourced the .zshrc file"
