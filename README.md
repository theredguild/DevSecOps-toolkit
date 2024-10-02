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
  clean    Remove the Docker image

Examples:
  make
  make build
  make exec
  make clean
```