#!/bin/bash

# Function to check if a command was successful
check_command() {
    if [ $? -ne 0 ]; then
        echo "Error: $1"
        exit 1
    fi
}

# Install Docker
install_docker() {
    echo "Installing Docker..."
    sudo -v
    sudo apt-get update
    sudo apt-get -y install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    check_command "Failed to install Docker"

    # Add user to docker group
    sudo groupadd docker
    sudo usermod -aG docker $USER
    check_command "Failed to add user to docker group"

    echo "Docker installed successfully. You may need to log out and back in for group changes to take effect."
}

# Generate SSH key and set up GitHub
setup_github_ssh() {
    echo "Creating SSH keys for GitHub..."
    ssh-keygen -t ed25519 -C "draneylucas@gmail.com"
    check_command "Failed to generate SSH key"

    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    check_command "Failed to add SSH key to agent"

    echo "Here's your public SSH key. Copy this to your GitHub account:"
    cat ~/.ssh/id_ed25519.pub

    echo "Press Enter after you've added the key to your GitHub account"
    read

    echo "Testing SSH connection to GitHub..."
    ssh -T git@github.com
}

# Main script execution
install_docker
setup_github_ssh

echo "Setup complete. Remember to log out and back in for Docker group changes to take effect."
