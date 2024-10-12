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
    default-jre \
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

# Install gitxray
RUN . $HOME/.asdf/asdf.sh \
    go install github.com/kulkansecurity/gitxray@latest

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

# Install snyk
RUN pnpm install -g snyk

# Install retire.js
RUN pnpm install -g retire

# Install detect-secrets
RUN pipx install detect-secrets

# Install gitxray
RUN pipx install gitxray

# Install semgrep
RUN pipx install semgrep

# Install nodejsscan
RUN pipx install nodejsscan

# Install principalmapper
RUN pipx install principalmapper

# Install checkov
RUN pipx install checkov

# Install scoutsuite
RUN pipx install scoutsuite

# pipx environment path set
RUN pipx ensurepath

# Install git-secrets
RUN git clone https://github.com/awslabs/git-secrets.git git-secrets \
    && cd git-secrets \
    && sudo make install \
    && rm -rf secrets

# Install gitleaks
RUN git clone https://github.com/gitleaks/gitleaks.git gitleaks \
    && cd gitleaks \
    && make build \
    && sudo ln -s /src/gitleaks/gitleaks /usr/local/bin

# Install gh-fake-analyzer
# from mattareal until upstream gets patched
RUN git clone https://github.com/mattaereal/gh-fake-analyzer.git \
    && cd gh-fake-analyzer \
    && python3 -m venv gfa \
    && source gfa/bin/activate \
    && pip install -r requirements.txt \
    && exit

# Install legitify
RUN git clone https://github.com/Legit-Labs/legitify \
    && cd legitify \
    && go build \
    && sudo ln -s /src/legitify/legitify /usr/local/bin/legitify

# Install kics
RUN git clone https://github.com/Checkmarx/kics.git \
    && cd kics \
    && go mod vendor \
    && go build -o ./bin/kics cmd/console/main.go \
    && sudo ln -s /src/kics/bin/kics /usr/local/bin/kics

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
RUN curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sudo sh -s -- -b /usr/local/bin

# Install hadolint
RUN arch=$(dpkg --print-architecture) \
    && if [ "$arch" = "amd64" ]; then arch="x86_64"; fi \
    && wget -q https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-$arch \
    && chmod +x hadolint-Linux-$arch \
    && sudo mv hadolint-Linux-$arch /usr/local/bin/hadolint


# Install grype
RUN curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sudo sh -s -- -b /usr/local/bin

# Install dependency-check
RUN DEPCHECK_VERSION=$(curl -s https://jeremylong.github.io/DependencyCheck/current.txt) \
    && curl -Ls "https://github.com/jeremylong/DependencyCheck/releases/download/v${DEPCHECK_VERSION}/dependency-check-${DEPCHECK_VERSION}-release.zip" \
    --output dependency-check.zip \
    && unzip dependency-check.zip && rm -f dependency-check.zip \
    && chmod +x dependency-check/bin/dependency-check.sh \
    && sudo ln -s /src/dependency-check/bin/dependency-check.sh /usr/local/bin/dependency-check

# Install 2ms
RUN wget -qO - https://github.com/checkmarx/2ms/releases/latest/download/linux-$(dpkg --print-architecture).zip | \
    funzip - | sudo tee /usr/local/bin/2ms > /dev/null \
    && sudo chmod +x /usr/local/bin/2ms

# Install clair
RUN sudo wget -qO /usr/local/bin/clair https://github.com/quay/clair/releases/download/v4.8.0/clairctl-linux-$(dpkg --print-architecture) \
    && sudo chmod +x /usr/local/bin/clair

# Install Grype
RUN curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sudo sh -s -- -b /usr/local/bin

# Clean up
RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# Configure MOTD
COPY --link --chown=root:root motd /etc/motd
RUN echo '\ncat /etc/motd\n' >> ~/.zshrc

# Set working directory
WORKDIR /home/${USERNAME}
CMD ["/bin/zsh"]
