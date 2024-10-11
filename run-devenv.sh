#!/bin/bash

# Build the Docker image if it doesn't exist
docker build -t devenv .

# Run the Docker container
docker run -it --rm \
  -v "${HOME}/projects/portable-dev-workstation/bash/.bashrc:/root/.bashrc" \
  -v "${HOME}/projects/portable-dev-workstation/tmux/.tmux.conf:/root/.tmux.conf" \
  -v "${HOME}/projects/portable-dev-workstation/neovim:/root/.config/nvim" \
  -v "$(pwd):/root/workspace" \
  -w "/root/workspace" \
  devenv
