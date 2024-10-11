# Personal Development Platform (PDP)

PDP is a Docker-based development environment that provides a consistent, maintainable, iterative setup across different machines and servers.

## Setup Instructions

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/pdp.git
   cd pdp
   ```

2. Run the bootstrap script to set up Docker and SSH:
   ```
   ./bootstrap.sh
   ```
   Follow the prompts to set up your GitHub SSH key and .bash_secrets file.

3. (Optional) Restart your machine to ensure all changes take effect.

4. Add the following alias to your host system's ~/.bashrc:
   ```bash
   pdp() {
       local script_path="$HOME/path/to/pdp.sh"
       if [ -f "$script_path" ]; then
           "$script_path" "$(pwd)"
       else
           echo "PDP script not found at $script_path"
       fi
   }
   ```
   Replace `$HOME/path/to/pdp.sh` with the actual path to your pdp.sh script.

5. Source your .bashrc or start a new terminal session:
   ```
   source ~/.bashrc
   ```

## Usage

Once set up, you can start your development environment from any directory by running:

```
pdp
```

This will start a Docker container with your current directory mounted and all your configurations in place.

## SSH Key Management

The PDP system is set up to use SSH agent forwarding. This means that the SSH keys you've set up on your host system will be available inside the Docker container. Here's what you need to know:

1. The bootstrap script sets up your SSH key for GitHub on the host system.
2. When you start a PDP container, it automatically starts an SSH agent and adds your key.
3. You should be able to use Git with SSH authentication inside the container without additional setup.

If you encounter any SSH-related issues, ensure that:
- Your SSH key is properly set up on your host system
- The SSH agent is running on your host (`eval $(ssh-agent -s)`)
- Your key is added to the SSH agent on the host (`ssh-add ~/.ssh/id_ed25519`)

## Caveats

This system is designed for efficient development with the creator's preferred tools. It has not been extensively tested for modifying root host system files. Use caution when working with system-level changes.

## Maintenance

To update your PDP:

1. Pull the latest changes from the repository
2. Rebuild your Docker image by running `pdp.sh`

## Customization

Modify the configuration files in the respective directories (bash, tmux, neovim) to customize your environment. Changes will be reflected in new container instances.
