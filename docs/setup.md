# Setup Guide

1. **Prerequisites**:
   - Docker
   - Docker Compose
   - X11 server (for Linux systems)

2. **Installation**:
   - Clone the repository
   - Run `./setup.sh`
   - Add displayed SSH key to GitHub

3. **First Run**:
   - The script will build images and start containers
   - You'll be dropped into the main development container

4. **Verification**:
   - Test tmux copy/paste functionality
   - Ensure Neovim clipboard operations work as expected

For troubleshooting, refer to the logs of individual services using `docker-compose logs [service_name]`.
