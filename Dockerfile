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
    wget \
    xsel \
    netcat-openbsd \
    ncurses-term \
    && add-apt-repository ppa:neovim-ppa/unstable -y \
    && apt-get update \
    && apt-get install -y neovim \
    && rm -rf /var/lib/apt/lists/*

# Copy SSH setup from the ssh-setup stage
COPY --from=ssh-setup /root/.ssh /root/.ssh
# COPY --from=ssh-setup /root/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

# Create necessary directories
RUN mkdir -p /root/.config/nvim /root/workspace

WORKDIR /root/workspace

# CMD ["/bin/bash"]
# Change the CMD to keep the container running
CMD ["tail", "-f", "/dev/null"]

