FROM debian:bookworm-slim AS final

# Set environment variables for the user and group
ARG USERNAME=wanderer
ARG GROUPNAME=trg
ARG USER_UID=1000
ARG USER_GID=1000

# Additional ARGs for tool versions
ARG T_2MS
ARG T_CHECKOV
ARG T_CLAIR
ARG T_CLOUDSPLAINING
ARG T_DEPCHECK
ARG T_DETECT_SECRETS
ARG T_DOCKLE
ARG T_GITXRAY
ARG T_GITLEAKS
ARG T_GRYPE
ARG T_HADOLINT
ARG T_KICS
ARG T_LEGITIFY
ARG T_NODEJSSCAN
ARG T_RETIRE
ARG T_SCOUTSUITE
ARG T_SEMGREP
ARG T_SNYK
ARG T_TRIVY
ARG T_TRUFFLEHOG
ARG T_DEPSCAN

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
    default-jre \
    yarn \
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
RUN echo 'export PS1="%F{green}%n@%m %F{blue}%1~ %F{yellow}$%f "' >> $HOME/.zshrc

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

# Set GOBIN to /usr/local/bin for Go binaries
ENV GOBIN=/usr/local/bin
ENV PATH="${GOBIN}:${PATH}"

# # Install pnpm using npm installed via asdf Node.js
RUN npm install -g pnpm
ENV PNPM_HOME="/home/${USERNAME}/.local/share/pnpm"
ENV PATH="${PNPM_HOME}:${PNPM_HOME}/global/node_modules/.bin:${PATH}"

# Pnpm-related tools
RUN pnpm install -g eslint-plugin-security \
    eslint-plugin-no-unsanitized \
    eslint-plugin-no-secrets \
    node-version-audit \
    yarn-audit-fix \
    better-npm-audit \
    installed-check \
    # snyk@${T_SNYK} \
    retire@${T_RETIRE}

# Pipx-related tools
RUN pipx install gitxray==$T_GITXRAY \
    && pipx install semgrep==$T_SEMGREP \
    # && pipx install detect-secrets==$T_DETECT_SECRETS \
    && pipx install nodejsscan==$T_NODEJSSCAN \
    # && pipx install cloudsplaining==$T_CLOUDSPLAINING \
    && pipx install checkov==$T_CHECKOV \
    # && pipx install scoutsuite==$T_SCOUTSUITE \
    && pipx install git+https://github.com/shortdoom/gh-fake-analyzer.git \
    && pipx ensurepath

# # Install git-secrets
# RUN git clone https://github.com/awslabs/git-secrets.git git-secrets \
#     && cd git-secrets \
#     && sudo make install \
#     && rm -rf secrets

# # Install gitleaks
# RUN arch=$(dpkg --print-architecture) \
#     && if [ "$arch" = "amd64" ]; then arch="x64"; fi \
#     && wget https://github.com/gitleaks/gitleaks/releases/download/v${T_GITLEAKS}/gitleaks_${T_GITLEAKS}_linux_$arch.tar.gz \
#     -O gitleaks.tar.gz \
#     && sudo tar -xzf gitleaks.tar.gz -C /usr/local/bin gitleaks \
#     && sudo chmod +x /usr/local/bin/gitleaks \
#     && rm gitleaks.tar.gz

# # Install legitify
# RUN wget https://github.com/Legit-Labs/legitify/releases/download/v${T_LEGITIFY}/legitify_${T_LEGITIFY}_linux_$(dpkg --print-architecture).tar.gz \
#     -O legitify.tar.gz \
#     && sudo tar -xzf legitify.tar.gz -C /usr/local/bin legitify \
#     && sudo chmod +x /usr/local/bin/legitify \
#     && rm legitify.tar.gz

# # Install kics
# RUN git clone https://github.com/Checkmarx/kics.git -b v${T_KICS}  \
#     && cd kics \
#     && go mod vendor \
#     && go build -o ./bin/kics cmd/console/main.go \
#     && sudo ln -s /src/kics/bin/kics /usr/local/bin/kics \
#     && echo 'export KICS_QUERIES_PATH=/src/kics/assets/queries' >> ~/.zshrc

# Install Trivy
RUN arch=$(dpkg --print-architecture) \
    && if [ "$arch" = "amd64" ]; then arch="64bit"; fi \
    && if [ "$arch" = "arm64" ]; then arch="ARM64"; fi \
    && wget https://github.com/aquasecurity/trivy/releases/download/v${T_TRIVY}/trivy_${T_TRIVY}_Linux-$arch.deb \
    && sudo dpkg -i trivy_${T_TRIVY}_Linux-$arch.deb \
    && rm trivy_${T_TRIVY}_Linux-$arch.deb

# Install Trufflehog
RUN wget https://github.com/trufflesecurity/trufflehog/releases/download/v${T_TRUFFLEHOG}/trufflehog_${T_TRUFFLEHOG}_linux_$(dpkg --print-architecture).tar.gz \
    -O trufflehog.tar.gz \
    && sudo tar -xzf trufflehog.tar.gz -C /usr/local/bin trufflehog \
    && sudo chmod +x /usr/local/bin/trufflehog \
    && rm trufflehog.tar.gz

# # Install hadolint
# RUN arch=$(dpkg --print-architecture) \
#     && if [ "$arch" = "amd64" ]; then arch="x86_64"; fi \
#     && if [ "$arch" = "arm64" ]; then arch="arm64"; fi \
#     && wget https://github.com/hadolint/hadolint/releases/download/v${T_HADOLINT}/hadolint-Linux-$arch \
#     && chmod +x hadolint-Linux-$arch \
#     && sudo mv hadolint-Linux-$arch /usr/local/bin/hadolint

# # Install grype
# RUN wget https://github.com/anchore/grype/releases/download/v${T_GRYPE}/grype_${T_GRYPE}_linux_$(dpkg --print-architecture).deb \
#     && sudo dpkg -i grype_${T_GRYPE}_linux_$(dpkg --print-architecture).deb \
#     && rm grype_${T_GRYPE}_linux_$(dpkg --print-architecture).deb


# Install dependency-check
RUN wget -q https://github.com/jeremylong/DependencyCheck/releases/download/v${T_DEPCHECK}/dependency-check-${T_DEPCHECK}-release.zip \
    -O dependency-check.zip \
    && unzip dependency-check.zip && rm -f dependency-check.zip \
    && chmod +x dependency-check/bin/dependency-check.sh \
    && sudo ln -s /src/dependency-check/bin/dependency-check.sh /usr/local/bin/dependency-check

# Install dockle
RUN curl -L -o dockle.deb https://github.com/goodwithtech/dockle/releases/download/v${T_DOCKLE}/dockle_${T_DOCKLE}_Linux-64bit.deb \
    && sudo dpkg -i dockle.deb && rm dockle.deb

# Install 2ms
RUN wget https://github.com/checkmarx/2ms/releases/download/v${T_2MS}/linux-amd64.zip \
    && unzip linux-amd64.zip && rm -f linux-amd64.zip \
    && sudo mv 2ms /usr/local/bin/2ms \
    && sudo chmod +x /usr/local/bin/2ms

# Install clair
RUN wget https://github.com/quay/clair/releases/download/v${T_CLAIR}/clairctl-linux-$(dpkg --print-architecture) \
    -O clairctl \
    && chmod +x clairctl \
    && sudo mv clairctl /usr/local/bin/clairctl

# Install depscan
RUN curl -LO https://github.com/owasp-dep-scan/depscan-bin/releases/download/v${T_DEPSCAN}/depscan-linux-amd64 \
    && chmod +x depscan-linux-amd64 \
    && sudo mv depscan-linux-amd64 /usr/local/bin/depscan

# Clean up
RUN sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/*

# Configure MOTD
COPY --link --chown=root:root motd /etc/motd
RUN echo '\ncat /etc/motd\n' >> ~/.zshrc

# Set working directory
WORKDIR /home/${USERNAME}
CMD ["/bin/zsh"]
