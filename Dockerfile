# Start with the Clipper stage
FROM clipper as clipper

FROM ubuntu:latest

# Copy Clipper and its start script from the clipper stage
COPY --from=clipper /usr/local/bin/clipper /usr/local/bin/clipper
COPY --from=clipper /usr/local/bin/start-clipper.sh /usr/local/bin/start-clipper.sh

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

# Create necessary directories
RUN mkdir -p /root/.config/nvim /root/workspace /root/.ssh

# Set up SSH config to not strictly check host keys (optional, use with caution)
RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config

WORKDIR /root/workspace

CMD ["/bin/bash"]
