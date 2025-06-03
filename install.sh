#!/bin/bash

read -p "This will delete everything in ~/.config/nvim, continue? [y/N] " choice
choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')

if [ "$choice" = "Y" ]; then
  # Create ~/.config/nvim if it doesn't exist
  mkdir -p ~/.config/nvim

  # Remove all files in ~/.config/nvim
  rm -rf ~/.config/nvim/*

  # Copy all files in this folder to ~/.config/nvim
  cp -r ./* ~/.config/nvim

  echo "Config installed."
else
  echo "Aborted."
fi

