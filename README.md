# Personal Development Platform (PDP)

PDP is a Docker-based development environment that provides a consistent, maintainable, iterative setup across different machines and servers.

## Setup Instructions

1. Clone this repository:
   ```
   mkdir $HOME/projects && cd $HOME/projects
   git clone https://github.com/ldraney/pdp.git
   cd pdp
   ```

2. Make sure docker is install correctly:
   ```
   ./scripts/install-docker.sh
   ```
   and run setup:
   ```
   ./setup.sh
   ```
   Follow the prompts to set up your GitHub SSH key and .bash_secrets file.

3. (Optional) Restart your machine to ensure all changes take effect.

4. (Optional) Add the following alias to your host system's ~/.bashrc:
   ```bash
   pdp() {
       local script_path="$HOME/projects/pdp/pdp.sh"
       if [ -f "$script_path" ]; then
           "$script_path" "$(pwd)"
       else
           echo "PDP script not found at $script_path"
       fi
   }
   ```
   Replace `$HOME/projects/pdp/pdp.sh` with the actual path to your pdp.sh script.

5. Source your .bashrc or start a new terminal session:
   ```
   source ~/.bashrc
   ```

## Usage
Once setting up the bash alias, you can start your development environment from any directory by running:
```
pdp
```
This will start a Docker container with your current directory mounted and all your configurations in place.

## Caveats

This system is designed for efficient development with the creator's preferred tools. It has not been extensively tested for modifying root host system files. Use caution when working with system-level changes.

## Maintenance
To update your PDP:
1. Pull the latest changes from the repository
2. Rebuild your Docker image by first running:
```
docker compose down --rmi all -v
```
and then `pdp`

## Customization
Modify the configuration files in the respective directories (bash, tmux, neovim) to customize your environment. Changes will be reflected in new container instances.
