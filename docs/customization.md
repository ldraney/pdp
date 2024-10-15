# Customization Guide

PDP is designed to be easily customizable to fit your development needs.

## Dockerfile Customization

Modify `Dockerfile` to add or remove development tools. For example:

```dockerfile
RUN apt-get update && apt-get install -y your-package-name
```

## Tmux Configuration

Edit `dev-config/tmux/tmux.conf` to adjust tmux settings. For example:

```
# Change prefix key to C-a
set -g prefix C-a
unbind C-b
bind C-a send-prefix
```

## Neovim Configuration

Modify `dev-config/nvim/init.lua` to change Neovim settings or add plugins. For example:

```lua
-- Add a new plugin
use 'tpope/vim-fugitive'

-- Change a setting
vim.opt.number = true
```

## Clipboard Service

To modify clipboard behavior, edit `clipboard_service.py`. Be sure to update the corresponding Tmux and Neovim configurations if you change the service's interface.

Remember to rebuild your Docker images after making changes:

```
docker compose build
```
