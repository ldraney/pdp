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

setup_github_ssh

