FROM ubuntu:latest

# Install dependencies for Neovim, Neovim, and Tmux
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
    && add-apt-repository ppa:neovim-ppa/unstable -y \
    && apt-get update \
    && apt-get install -y neovim \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.config/nvim /root/workspace

WORKDIR /root/workspace

CMD ["/bin/bash"]

