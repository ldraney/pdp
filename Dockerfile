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

# Create necessary directories
RUN mkdir -p /root/.config/nvim /root/workspace /root/.ssh

# Set up SSH config to not strictly check host keys (optional, use with caution)
RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config

WORKDIR /root/workspace

CMD ["/bin/bash"]
