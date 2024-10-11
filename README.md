# portable-dev-workstation
if docker is there, there should only be iteration. 

# Portable Development Environment

This repository contains configurations and scripts to set up a portable development environment using Docker. It allows you to quickly set up a consistent environment on any machine with Docker installed, giving you access to your preferred configurations for tmux, bash, and Neovim.

## Overview

The setup consists of:
- Docker configurations for creating a development environment
- Configuration files for tmux, bash, and Neovim
- A setup script to automate the environment creation

## Prerequisites

- Docker
- Docker Compose
- Git
- SSH

## Quick Start
1. Clone this repository:
   ```
   git clone https://github.com/ldraney/dotfiles.git
   cd dotfiles
   ```

2. Run the setup script:
   ```
   ./setup.sh
   ```
This script will:
- Check for Docker and Docker Compose
- Build and start your development environment
