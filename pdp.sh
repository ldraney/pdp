#!/bin/bash

# Get the current directory from the first argument, or use the current directory if not provided
CURRENT_DIR="${1:-$(pwd)}"

# Build the Clipper Docker image
docker build -t clipper -f Dockerfile.clipper .

# Build the SSH setup image
docker build -t ssh-setup -f Dockerfile.ssh .

# Build the main Docker image
docker build -t pdp .

# Display the SSH public key
echo "Your SSH public key is:"
# docker run --rm ssh-setup cat /root/.ssh/id_rsa.pub.txt
docker run --rm ssh-setup cat /root/.ssh/id_rsa.pub

echo "Please add this key to your GitHub account before proceeding."
echo "Press any key to continue..."
read -n 1 -s

# Run the Docker container
docker run -it --rm \
  -p 8377:8377 \
  -v "${HOME}/projects/pdp/bash/.bashrc:/root/.bashrc" \
  -v "${HOME}/projects/pdp/bash/.bash_secrets:/root/.bash_secrets" \
  -v "${HOME}/projects/pdp/tmux/.tmux.conf:/root/.tmux.conf" \
  -v "${HOME}/projects/pdp/neovim:/root/.config/nvim" \
  -v "${CURRENT_DIR}:/root/workspace" \
  -w "/root/workspace" \
  pdp /bin/bash
