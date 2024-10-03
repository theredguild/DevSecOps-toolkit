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
    make \
    vim \
    unzip \
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

# Explicitly setting user home
ENV HOME="/home/wanderer"

# Set the default shell to zsh
ENV SHELL=/usr/bin/zsh

# Running everything under zsh
SHELL ["/usr/bin/zsh", "-c"]

# Set the prompt
RUN echo "autoload -U colors && colors" >> $HOME/.zshrc
RUN echo 'export "PS1=%F{green}%n@%m %F{blue}%1~ %F{yellow}➜ %f "' >> $HOME/.zshrc

# Building everything inside /src
WORKDIR /src

ENV ASDF_DIR="$HOME/.asdf"
RUN git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch v0.14.1
RUN echo '. $ASDF_DIR/asdf.sh' >> $HOME/.zshrc \
    && echo 'fpath=(${ASDF_DIR}/completions $fpath)' >> $HOME/.zshrc \
    && echo 'autoload -Uz compinit && compinit' >> $HOME/.zshrc \
    && . $ASDF_DIR/asdf.sh 

ENV PATH="${ASDF_DIR}/bin:${ASDF_DIR}/shims:$PATH"

# Install Node.js and Go using asdf
RUN . $ASDF_DIR/asdf.sh \
    && asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git \
    && asdf install nodejs latest \
    && asdf global nodejs latest

RUN . $ASDF_DIR/asdf.sh \
    && asdf plugin add golang https://github.com/asdf-community/asdf-golang.git \
    && asdf install golang latest \
    && asdf global golang latest

# # Install pnpm using npm installed via asdf Node.js
RUN npm install -g pnpm
ENV PNPM_HOME="/home/${USERNAME}/.local/share/pnpm"
ENV PATH="${PNPM_HOME}:${PNPM_HOME}/global/node_modules/.bin:${PATH}"

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
ENV PATH="${GOBIN}:${PATH}"

# Install gitxray
RUN . $HOME/.asdf/asdf.sh \
    go install github.com/kulkansecurity/gitxray@latest

# Install git-secrets
RUN git clone https://github.com/awslabs/git-secrets.git git-secrets
RUN cd git-secrets \
    && sudo make install \
    && rm -rf secrets

# Install detect-secrets
RUN pipx install detect-secrets

# Install gitleaks
RUN git clone https://github.com/gitleaks/gitleaks.git gitleaks \
    && cd gitleaks \
    && make build

# Install gitxray
RUN pipx install gitxray

# Install gh-fake-analyzer
RUN git clone https://github.com/shortdoom/gh-fake-analyzer.git
RUN cd gh-fake-analyzer \
    && mv .env.example .env \
    && python3 -m venv gfa \
    && source gfa/bin/activate \
    && pip install -r requirements.txt \
    && exit


# Create a script to run the gh-fake-analyzer
USER root
RUN echo '#!/bin/zsh\n\
source /src/gh-fake-analyzer/gfa/bin/activate\n\
python3 /src/gh-fake-analyzer/analyze.py "$@"\n\
deactivate' > /usr/local/bin/gh-fake-analyzer \
    && chmod +x /usr/local/bin/gh-fake-analyzer \
    && chown -R wanderer:trg /usr/local/bin/gh-fake-analyzer

USER wanderer

# Install Trivy
RUN wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list \
    && sudo apt-get update && sudo apt-get install -y trivy

# Install Trufflehog
RUN wget -qO - https://github.com/trufflesecurity/trufflehog/releases/download/v3.82.6/trufflehog_3.82.6_linux_$(dpkg --print-architecture).tar.gz | \
    sudo tar -xzf - trufflehog -C /usr/local/bin


# Install 2ms
RUN wget -qO - https://github.com/checkmarx/2ms/releases/latest/download/linux-amd64.zip | \
    funzip - > /usr/local/bin/2ms \
    && chmod +x /usr/local/bin/2ms

# Install clair
RUN wget -qO /usr/local/bin/clair https://github.com/quay/clair/releases/download/v4.7.4/clairctl-linux-$(dpkg --print-architecture) \
    && chmod +x /usr/local/bin/clair

# Install snyk
RUN ARCH=$(dpkg --print-architecture) \
    && if [ "$ARCH" = "amd64" ]; then \
    wget -qO /usr/local/bin/snyk https://github.com/snyk/cli/releases/download/v1.1293.1/snyk-linux; \
    elif [ "$ARCH" = "arm64" ]; then \
    wget -qO /usr/local/bin/snyk https://github.com/snyk/cli/releases/download/v1.1293.1/snyk-linux-arm64; \
    fi \
    && chmod +x /usr/local/bin/snyk


# Clean up
RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# Configure MOTD
COPY --link --chown=root:root motd /etc/motd
RUN echo '\ncat /etc/motd\n' >> ~/.zshrc

# Set working directory
WORKDIR /home/${USERNAME}
CMD ["/bin/zsh"]
