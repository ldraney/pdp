#!/bin/bash

# Get the current directory from the first argument, or use the current directory if not provided
CURRENT_DIR="${1:-$(pwd)}"

# Build the Clipper Docker image
docker build -t clipper -f Dockerfile.clipper .

# Build the main Docker image
docker build -t pdp .

# Ensure SSH agent is running on the host
eval $(ssh-agent -s)

# Run the Docker container
docker run -it --rm \
  -p 8377:8377 \
  -v "${HOME}/projects/pdp/bash/.bashrc:/root/.bashrc" \
  -v "${HOME}/projects/pdp/bash/.bash_secrets:/root/.bash_secrets" \
  -v "${HOME}/projects/pdp/tmux/.tmux.conf:/root/.tmux.conf" \
  -v "${HOME}/projects/pdp/neovim:/root/.config/nvim" \
  -v "${HOME}/.ssh:/root/.ssh" \
  -v "${SSH_AUTH_SOCK}:/ssh-agent" \
  -e SSH_AUTH_SOCK=/ssh-agent \
  -v "${CURRENT_DIR}:/root/workspace" \
  -w "/root/workspace" \
  pdp /bin/bash -c "
    # Fix SSH directory permissions
    chmod 700 /root/.ssh
    chmod 600 /root/.ssh/*
    
    # Start SSH agent and add key
    eval \$(ssh-agent -s)
    ssh-add /root/.ssh/id_ed25519
    
    # Start bash
    exec /bin/bash
  "
