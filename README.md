# container-sec-tools
Unified container with OSS security tools, just `make exec` and dive into the container!

## Usage

```bash
% make
Usage:
  make <target>

Targets:
  build    Build the Docker image
  exec     Run an interactive shell inside the container
  test     Run tests to verify the Docker image and tools
  list     List the installed tools
  clean    Remove the Docker image

Optional target with parameters:
  run      Run a command inside the Docker container

Examples:
  make
  make build
  make exec
  make test
  make clean
  make run trivy image python:3.4-alpine


Installed Tools:
trivy
trufflehog
```