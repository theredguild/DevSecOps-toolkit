# Container OSS DevOps Security Tools (minimal workshop version)

Minimal toolkit container for a 2024 Devcon Workshop.
Just run `make exec` and dive into the container!

## First step

### Firing up the container

```bash
% make
Usage:
  make <target>

Targets:
  build    Build the Docker image with the software versions described in the .env file
  rebuild  Forces build, even if a previous image exists. Won't delete the previous ones.
  release  Build the Docker image with the software versions described in the .env file, but from a specific release of this repo
  latest   Build the Docker image with the latest version for each tool
  exec     Run an interactive shell inside the container

Examples:
  make
  make build
  make rebuild
  make release
  make latest
  make exec
```

## Second step

Now you have your container up and running, but what am I supposed to do with it?
Well, go to **[how to use the tools inside](./HOWTO.md)** to understand how each one of them actually work.

### Tools included in this minimal repository

#### GitHub OSINT & Profile Analysis

- **[gitxray](https://github.com/kulkansecurity/gitxray)**: OSINT, forensics, and pentesting on GitHub profiles.
- **[gh-fake-analyzer](https://github.com/shortdoom/gh-fake-analyzer)**: GitHub profile analysis tool.

---

#### Secrets Scanning

- **[trufflehog](https://github.com/trufflesecurity/trufflehog)**: Finds secrets in repositories and cloud storage.
- **[2ms](https://github.com/Checkmarx/2ms)**: Detects and protects secrets across files, including CMS, chat systems, and Git repositories.

---

#### Vulnerability Scanning

- **[Trivy](https://github.com/aquasecurity/trivy)**: All-in-one scanner for vulnerabilities, misconfigurations, and secrets in containers, IaC, and more.
- **[OWASP DependencyCheck](https://github.com/jeremylong/DependencyCheck)**: Scans project dependencies for known vulnerabilities using CVE data.
- **[clair](https://github.com/quay/clair)**: Static analysis tool for identifying vulnerabilities in container images based on CVE data.
- **[depscan](https://github.com/owasp-dep-scan/depscan-bin)**: Security scanning tool for dependencies, assisting with software composition analysis.

---

#### Infrastructure-as-Code (IaC) Security

- **[checkov](https://github.com/bridgecrewio/checkov)**: Scans infrastructure-as-code files for misconfigurations and security risks across cloud, Kubernetes, and Terraform.

---

#### Container Image Security & Best Practices

- **[dockle](https://github.com/goodwithtech/dockle)**: Linter for container images, promoting Dockerfile security best practices and identifying misconfigurations.

---

#### Static Code Analysis

- **[semgrep](https://github.com/semgrep/semgrep)**: Lightweight static analysis tool for enforcing security rules across codebases.
- **[nodejsscan](https://github.com/ajinabraham/NodeJsScan)**: Static security analysis for Node.js applications.
