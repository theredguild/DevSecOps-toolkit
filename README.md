# container-sec-tools
Container/s with OSS security tools

## Usage

```bash
% make
Usage:
  make <target> [tool] [args...]

Targets:
  build-all                Build Docker images for all tools
  build <tool>             Build Docker image for a specific tool (e.g., make build trivy)
  run <tool> -- [args...]  Run a specific tool (e.g., make run trufflehog -- git ssh://github.com/reynico/container-sec-tools --only-verified)
  list                     List all available tools
  clean                    Remove all Docker images

Available tools:
  trivy trufflehog
```