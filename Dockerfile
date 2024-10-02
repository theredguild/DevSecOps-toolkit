FROM debian:bookworm-slim AS final

# Set environment variables for the user and group
ARG USERNAME=wanderer
ARG GROUPNAME=trg
ARG USER_UID=1000
ARG USER_GID=1000

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    python3 \
    python3-venv \
    python3-dev \
    python3-pip \
    gnupg \
    dirmngr \
    ca-certificates \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libffi-dev \
    liblzma-dev \
    zsh \
    pipx \
    sudo \
    # # Does this make sense with asdf installing nodejs?
    npm \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Create a user group named trg and a user named wanderer with specified UID and GID
RUN groupadd --gid $USER_GID $GROUPNAME && \
useradd --uid $USER_UID --gid $USER_GID --create-home $USERNAME

# Configure passwordless sudo for the user wanderer
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Optionally, add the user to the sudo group
RUN usermod -aG sudo $USERNAME

# Switch to the new user
USER $USERNAME

# Set the default shell to zsh
ENV SHELL=/usr/bin/zsh

# Running everything under zsh
SHELL ["/usr/bin/zsh", "-c"]

RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.14.1 \
    && echo '. $HOME/.asdf/asdf.sh' >> $HOME/.zshrc \
    && echo 'fpath=(${ASDF_DIR}/completions $fpath)' >> $HOME/.zshrc \
    && echo 'autoload -Uz compinit && compinit' >> $HOME/.zshrc \
    && . $HOME/.asdf/asdf.sh 

# Install Node.js and Go using asdf
RUN . $HOME/.asdf/asdf.sh \
    && asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git \
    && asdf install nodejs latest \
    && asdf global nodejs latest \
    && sudo npm install -g pnpm

RUN . $HOME/.asdf/asdf.sh \
    && asdf plugin add golang https://github.com/asdf-community/asdf-golang.git \
    && asdf install golang latest \
    && asdf global golang latest

# # Install pnpm using npm installed via asdf Node.js
# RUN sudo npm install -g pnpm

ENV PNPM_HOME="/home/${USERNAME}/.local/share/pnpm"
ENV PATH="$PNPM_HOME:$PNPM_HOME/global/node_modules/.bin:${PATH}"

# Install ESLint and plugins using pnpm
RUN pnpm install -g eslint \
    eslint-plugin-security \
    eslint-plugin-no-unsanitized \
    eslint-plugin-no-secrets

# Install additional npm tools using pnpm
RUN pnpm install -g node-version-audit \
    yarn-audit-fix \
    better-npm-audit \
    installed-check

# Set GOBIN to /usr/local/bin for Go binaries
ENV GOBIN=/usr/local/bin

# Install gitxray
RUN . $HOME/.asdf/asdf.sh \
    go install github.com/kulkansecurity/gitxray@latest

# Install git-secrets
RUN git clone https://github.com/awslabs/git-secrets.git $HOME/secrets \
    && cd $HOME/secrets \
    && sudo make install \
    && rm -rf $HOME/secrets

# Install detect-secrets
RUN pipx install detect-secrets

# Install pmapper
RUN pipx install pmapper

# Install gh-fake-analyzer
RUN cd $HOME \
    && git clone https://github.com/shortdoom/gh-fake-analyzer.git \
    && cd gh-fake-analyzer \
    && python3 -m venv gfa \
    && source gfa/bin/activate \
    && pip install -r requirements.txt \
    && exit

# Install Trivy
RUN wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list \
    && sudo apt-get update && sudo apt-get install -y trivy

# Install Trufflehog
RUN wget -qO - https://github.com/trufflesecurity/trufflehog/releases/download/v3.82.6/trufflehog_3.82.6_linux_$(dpkg --print-architecture).tar.gz | \
    sudo tar -xzf - trufflehog -C /usr/local/bin

# Clean up
RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /home/${USERNAME}
CMD ["/bin/bash"]
