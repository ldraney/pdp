#!/bin/bash

# Get the current directory from the first argument, or use the current directory if not provided
export CURRENT_DIR="${1:-$(pwd)}"

# Display the SSH public key
echo "Your SSH public key is:"
docker compose run --rm ssh-setup

echo "Please add this key to your GitHub account before proceeding."
echo "Press any key to continue..."
read -n 1 -s

# Start the services
docker compose up

# Clean up when done
docker compose down --rmi all -v

