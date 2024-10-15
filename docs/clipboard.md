# Clipboard System

PDP uses a custom clipboard service to enable seamless copying and pasting between the Docker container and the host system.

## Components

1. **Clipboard Service** (`clipboard_service.py`):
   - Runs in a separate container
   - Listens for clipboard operations on port 12345
   - Uses `xsel` to interact with the host's X11 clipboard

2. **Tmux Configuration**:
   - Configured to send copied text to the clipboard service
   - Uses `nc` (netcat) to communicate with the service

3. **Neovim Configuration**:
   - Uses leader keys for explicit clipboard operations
   - `<leader>y`: Copy to server clipboard
   - `<leader>p` or `<leader>P`: Paste from server clipboard

## How It Works

1. When text is copied in tmux, it's sent to the clipboard service
2. The clipboard service uses `xsel` to set the host's clipboard
3. When pasting in Neovim with `<leader>p`, it fetches from the clipboard service
4. The clipboard service retrieves the content using `xsel` and sends it back

This system allows for clipboard sharing while maintaining Neovim's performance for regular operations.

## Customization

To modify clipboard behavior, edit:
- `clipboard_service.py` for the service logic
- `dev-config/tmux/tmux.conf` for tmux configuration
- `dev-config/nvim/init.lua` for Neovim configuration
