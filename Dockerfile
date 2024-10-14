# Start with the Clipper stage
FROM clipper as clipper

# SSH setup stage
FROM ssh-setup as ssh-setup

# Final stage
FROM ubuntu:latest

# Install dependencies for Neovim, Neovim, and Tmux and git
RUN apt-get update && apt-get install -y \
    software-properties-common \
    make \
    gcc \
    ripgrep \
    unzip \
    git \
    xclip \
    curl \
    tmux \
    git \
    openssh-client \
    && add-apt-repository ppa:neovim-ppa/unstable -y \
    && apt-get update \
    && apt-get install -y neovim \
    && rm -rf /var/lib/apt/lists/*

# trying to get tmux clipboard to work within container
RUN apt-get update && apt-get install -y \
    wget \
    xsel \
    && rm -rf /var/lib/apt/lists/*

# Copy Clipper, its start script, and config from the clipper stage
COPY --from=clipper /usr/local/bin/clipper /usr/local/bin/clipper
COPY --from=clipper /usr/local/bin/start-clipper.sh /usr/local/bin/start-clipper.sh
COPY --from=clipper /root/.config/clipper/clipper.json /root/.config/clipper/clipper.json

# Copy SSH setup from the ssh-setup stage
COPY --from=ssh-setup /root/.ssh /root/.ssh
# COPY --from=ssh-setup /root/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub

# Create necessary directories
RUN mkdir -p /root/.config/nvim /root/workspace

WORKDIR /root/workspace

# Use the start script as the entrypoint
ENTRYPOINT ["/usr/local/bin/start-clipper.sh"]
CMD ["/bin/bash"]
