# Container OSS DevOps Security Tools

Unified repository with OSS security tools, just `make exec` and dive into the container!

There are some tools that have not been integrated to the main container itself, given their nature,
but have been or will be added to the repository with an explanation on how to run them separately.

## First step

### Firing up the container

```bash
% make
Usage:
  make <target>

Targets:
  build    Build the Docker image with the software versions described in the .env file
  release  Build the Docker image with the software versions described in the .env file, but from a specific release of this repo
  latest   Build the Docker image with the latest version for each tool
  exec     Run an interactive shell inside the container

Examples:
  make
  make build
  make release
  make latest
  make exec
```

## Second step

Now you have your container up and running, but what am I supposed to do with it?
Well, go to **[how to use the tools inside](./HOWTO.md)** to understand how each one of them actually work.

### Tools included in this repository

- [x] 2ms: Too many secrets (2MS) helps people protect their secrets on any file or on systems like CMS, chats, and git. (<https://github.com/Checkmarx/2ms>)
- [x] better-npm-audit: Provides additional features on top of the existing npm audit options. (<https://www.npmjs.com/package/better-npm-audit>)
- [x] checkov: Prevent cloud misconfigurations and find vulnerabilities during build-time in infrastructure as code, container images, and open-source packages. (<https://github.com/bridgecrewio/checkov>)
- [x] clair: Vulnerability Static Analysis for Containers. (<https://github.com/quay/clair>)
- [x] Cloudsplaining: AWS IAM assessment tool. (<https://github.com/salesforce/cloudsplaining>)
- [ ] cloudsploit: AWS security scanning and monitoring tool for detecting threats and misconfigurations. (<https://github.com/aquasecurity/cloudsploit>)
- [x] DependencyCheck: OWASP dependency-check is a software composition analysis utility that detects publicly disclosed vulnerabilities in application dependencies. (<https://github.com/jeremylong/DependencyCheck>)
- [x] detect-secrets: yet another one. (<https://github.com/Yelp/detect-secrets>)
- [x] dockle: Container Image Linter for Security, helping build the Best-Practice Docker Image, easy to start. (<https://github.com/goodwithtech/dockle>)
- [x] eslint-plugin-no-secrets: An ESLint plugin to find strings that might be secrets/credentials. (<https://www.npmjs.com/package/eslint-plugin-no-secrets>)
- [x] eslint-plugin-no-unsanitized: Custom ESLint rule to disallow unsafe innerHTML, outerHTML, insertAdjacentHTML, and alike. (<https://www.npmjs.com/package/eslint-plugin-no-unsanitized>)
- [x] eslint-plugin-security: ESLint rules for Node Security. (<https://www.npmjs.com/package/eslint-plugin-security>)
- [x] falco: Cloud Native Runtime Security. (<https://github.com/falcosecurity/falco>)
- [x] generic: A set of GitHub actions for checking your projects for vulnerabilities. (<https://github.com/snyk/actions>)
- [x] gh-fake-analyzer: Dump github profile data for analysis. (<https://github.com/shortdoom/gh-fake-analyzer/tree/main>)
- [x] git-secrets: Works along with git, preventing secrets from being pushed to a repo. (<https://github.com/awslabs/git-secrets>)
- [x] gitxray: A multifaceted security tool that leverages Public GitHub REST APIs for OSINT, Forensics, Pentesting, and more. (<https://github.com/kulkansecurity/gitxray>)
- [x] gitleaks: Protect and discover secrets. (<https://github.com/gitleaks/gitleaks>)
- [x] grype: A vulnerability scanner for container images and filesystems. (<https://github.com/anchore/grype/>)
- [x] harden-runner: Network egress filtering and runtime security for GitHub-hosted and self-hosted runners. (<https://github.com/step-security/harden-runner>)
- [x] hadolint: Dockerfile linter. (<https://github.com/hadolint/hadolint>)
- [x] installed-check: Verifies that installed modules comply with the requirements specified in package.json. (<https://www.npmjs.com/package/installed-check>)
- [x] kics: Find security vulnerabilities, compliance issues, and infrastructure misconfigurations early in the development cycle of your infrastructure-as-code. (<https://github.com/Checkmarx/kics>)
- [x] kube-bench: Checks whether Kubernetes is deployed according to security best practices as defined in the CIS Kubernetes Benchmark. (<https://github.com/aquasecurity/kube-bench>)
- [x] lavamoat: Tools for sandboxing your dependency graph. (<https://github.com/LavaMoat/lavamoat>)
- [x] legitify: Detect and remediate misconfigurations and security risks across all your GitHub and GitLab assets. (<https://github.com/Legit-Labs/legitify>)
- [x] node-version-audit: Node Version Audit is a tool to check Node.js version against a regularly updated list of CVE exploits, new releases, and end of life dates. (<https://www.npmjs.com/package/node-version-audit>)
- [x] nodejsscan: A static security code scanner for Node.js applications. (<https://github.com/ajinabraham/NodeJsScan>)
- [x] npm audit: This built-in npm command checks for vulnerabilities in your installed packages.
- [ ] prowler: AWS security best practices assessment, auditing, hardening, and incident response tool. (<https://github.com/prowler-cloud/prowler>)
- [x] retirejs: Scanner detecting the use of JavaScript libraries with known vulnerabilities. (<https://github.com/RetireJS/retire.js>)
- [x] scoutsuite: Multi-Cloud Security Auditing Tool. (<https://github.com/nccgroup/ScoutSuite>)
- [x] secure-repo: Orchestrate GitHub Actions Security. (<https://github.com/step-security/secure-repo>)
- [x] semgrep: Lightweight static analysis for many languages. (<https://github.com/semgrep/semgrep>)
- [x] snyk: Snyk CLI scans and monitors your projects for security vulnerabilities. (<https://github.com/snyk/cli>)
- [x] trivy: Find vulnerabilities, misconfigurations, secrets, SBOM in containers, Kubernetes, code repositories, clouds, and more. (<https://github.com/aquasecurity/trivy>)
- [x] trufflehog: Find, verify, and analyze leaked credentials. (<https://github.com/trufflesecurity/trufflehog>) [Easy marketplace] (https://github.com/marketplace/actions/trufflehog-oss)
- [x] wait-for-secrets: 2fa for GHA. (<https://github.com/step-security/wait-for-secrets>)
- [x] yarn-audit-fix: The missing yarn audit fix. (<https://www.npmjs.com/package/yarn-audit-fix>)
