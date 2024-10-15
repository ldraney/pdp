#!/bin/bash

# Get the current directory from the first argument, or use the current directory if not provided
export CURRENT_DIR="${1:-$(pwd)}"

# Ensure docker-compose.yml is in the current directory
if [ ! -f "docker-compose.yml" ]; then
    echo "docker-compose.yml not found in the current directory."
    exit 1
fi

# Build the images
docker compose build

# Display the SSH public key
echo "Your SSH public key is:"
docker-compose run --rm ssh-setup

echo "Please add this key to your GitHub account before proceeding."
echo "Press any key to continue..."
read -n 1 -s
