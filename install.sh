#!/bin/bash

# Create ~/.config/nvim if it doesn't exist
mkdir -p ~/.config/nvim

# Remove all files in ~/.config/nvim
rm -rf ~/.config/nvim/*

# Copy all files in this folder to ~/.config/nvim
cp -r ./* ~/.config/nvim
