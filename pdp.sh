#!/bin/bash

# Get the current directory from the first argument, or use the current directory if not provided
CURRENT_DIR="${1:-$(pwd)}"

# Build the Docker image if it doesn't exist
docker build -t pdp .

# Ensure SSH agent is running on the host
eval $(ssh-agent -s)

# Run the Docker container
docker run -it --rm \
  -v "${HOME}/projects/pdp/bash/.bashrc:/root/.bashrc" \
  -v "${HOME}/projects/pdp/bash/.bash_secrets:/root/.bash_secrets" \
  -v "${HOME}/projects/pdp/tmux/.tmux.conf:/root/.tmux.conf" \
  -v "${HOME}/projects/pdp/neovim:/root/.config/nvim" \
  -v "${HOME}/.ssh:/root/.ssh:ro" \
  -v "${SSH_AUTH_SOCK}:/ssh-agent" \
  -e SSH_AUTH_SOCK=/ssh-agent \
  -v "${CURRENT_DIR}:/root/workspace" \
  -w "/root/workspace" \
  pdp /bin/bash -c "
    eval \$(ssh-agent -s)
    ssh-add /root/.ssh/id_ed25519
    exec /bin/bash
  "
