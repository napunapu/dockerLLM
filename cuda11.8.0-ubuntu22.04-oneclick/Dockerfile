ARG CUDA_VERSION="12.1.1"
ARG CUDNN_VERSION="8"
ARG UBUNTU_VERSION="22.04"
ARG DOCKER_FROM=thebloke/cuda$CUDA_VERSION-ubuntu$UBUNTU_VERSION-textgen:latest 

# Base image
FROM $DOCKER_FROM as base

ARG APTPKGS="zsh wget tmux tldr nvtop vim neovim curl rsync net-tools less iputils-ping 7zip zip unzip"

# Install useful command line utility software
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends $APTPKGS && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get upgrade -y
RUN apt update -y && apt upgrade -y
RUN apt install nano

# Set up git to support LFS, and to store credentials; useful for Huggingface Hub
RUN git config --global credential.helper store && \
    git lfs install

# Install Oh My Zsh for better command line experience: https://github.com/ohmyzsh/ohmyzsh
RUN bash -c "ZSH=/root/ohmyzsh $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Add some config files for a nicer command line setup
COPY conf-files/vimrc /root/.vimrc
COPY conf-files/zshrc /root/.zshrc
COPY conf-files/thebloke.zsh-theme /root/ohmyzsh/custom/themes/
COPY conf-files/tmux.conf /root/.tmux.conf
# This file is for macOS users using iTerm2. It provides these features: https://iterm2.com/documentation-shell-integration.html
COPY conf-files/iterm2_shell_integration.zsh /root/.iterm2_shell_integration.zsh
# Set default shell to ZSH
COPY conf-files/passwd /etc/passwd

COPY scripts /root/scripts
RUN cd /root/scripts
RUN pip install rich
RUN pip install --upgrade gradio 
RUN cd ..
COPY conf-files/credentials /root/credentials

COPY --chmod=755 start-with-ui.sh /start.sh

WORKDIR /workspace

ENTRYPOINT [ "/start.sh" ]
