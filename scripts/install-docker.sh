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

# Main script execution
install_docker

echo "Remember to log out and back in for Docker group changes to take effect."
echo ""
echo "Please copy from lastpass the bash_secrets and add it to a ./bash/.bash_secrets file "
# echo "Please ensure you're logged into LastPass CLI before continuing."
# read -p "Press Enter to retrieve .bash_secrets from LastPass..."
# lpass show -c --notes "Dotfiles/.bash_secrets"
# echo "Content copied to clipboard. Please paste it into ~/.bash_secrets"
read -p "Press Enter when you've created ./bash/.bash_secrets..."
echo "setup complete!  please run pdp.sh and copy the pdp snippet to this host's bashrc"
