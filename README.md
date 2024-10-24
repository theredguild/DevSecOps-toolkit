# Container OSS DevOps Security Tools

Unified repository with OSS security tools, just `make exec` and dive into the container!

There are some tools that have not been integrated into the main container itself, given their nature,
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

- [x] 2ms: Detects and manages secrets in files and systems like CMS, chats, and git. (<https://github.com/Checkmarx/2ms>)
- [x] better-npm-audit: Enhances npm audit with additional features. (<https://www.npmjs.com/package/better-npm-audit>)
- [x] checkov: Scans infrastructure as code for misconfigurations and vulnerabilities. (<https://github.com/bridgecrewio/checkov>)
- [x] clair: Analyzes container images for vulnerabilities. (<https://github.com/quay/clair>)
- [x] cloudsplaining: Assesses AWS IAM policies for security risks. (<https://github.com/salesforce/cloudsplaining>)
- [x] cloudsploit: Scans AWS environments for security threats and misconfigurations. (<https://github.com/aquasecurity/cloudsploit>)
- [x] DependencyCheck: Identifies vulnerabilities in application dependencies. (<https://github.com/jeremylong/DependencyCheck>)
- [x] depscan: Scans for vulnerabilities in dependencies. (<https://github.com/owasp-dep-scan/depscan-bin>)
- [x] detect-secrets: Detects secrets in codebases to prevent leaks. (<https://github.com/Yelp/detect-secrets>)
- [x] dockle: Lints container images for security best practices. (<https://github.com/goodwithtech/dockle>)
- [x] eslint-plugin-no-secrets: ESLint plugin to detect potential secrets in code. (<https://www.npmjs.com/package/eslint-plugin-no-secrets>)
- [x] eslint-plugin-no-unsanitized: Prevents unsafe DOM manipulations in JavaScript. (<https://www.npmjs.com/package/eslint-plugin-no-unsanitized>)
- [x] eslint-plugin-security: Provides security rules for ESLint. (<https://www.npmjs.com/package/eslint-plugin-security>)
- [x] falco: Monitors runtime security events in cloud-native environments. (<https://github.com/falcosecurity/falco>)
- [x] generic: GitHub actions for vulnerability checks. (<https://github.com/snyk/actions>)
- [x] gh-fake-analyzer: Analyzes GitHub profiles for data insights. (<https://github.com/shortdoom/gh-fake-analyzer/tree/main>)
- [x] git-secrets: Prevents committing secrets to git repositories. (<https://github.com/awslabs/git-secrets>)
- [x] gitxray: Uses GitHub APIs for security analysis and OSINT. (<https://github.com/kulkansecurity/gitxray>)
- [x] gitleaks: Scans for secrets in code repositories. (<https://github.com/gitleaks/gitleaks>)
- [x] grype: Scans container images and filesystems for vulnerabilities. (<https://github.com/anchore/grype/>)
- [x] harden-runner: Secures GitHub Actions runners with network filtering. (<https://github.com/step-security/harden-runner>)
- [x] hadolint: Lints Dockerfiles for best practices. (<https://github.com/hadolint/hadolint>)
- [x] installed-check: Ensures installed modules match package.json requirements. (<https://www.npmjs.com/package/installed-check>)
- [x] kics: Detects security issues in infrastructure-as-code. (<https://github.com/Checkmarx/kics>)
- [ ] kube-bench: Checks Kubernetes deployments against CIS benchmarks. (<https://github.com/aquasecurity/kube-bench>)
- [x] lavamoat: Sandboxes dependency graphs for security. (<https://github.com/LavaMoat/lavamoat>)
- [x] legitify: Manages security risks in GitHub and GitLab assets. (<https://github.com/Legit-Labs/legitify>)
- [x] njsscan: Scans JavaScript applications for security vulnerabilities. (<https://github.com/ajinabraham/njsscan>)
- [x] node-version-audit: Audits Node.js versions for known vulnerabilities. (<https://www.npmjs.com/package/node-version-audit>)
- [x] nodejsscan: Scans Node.js applications for security issues. (<https://github.com/ajinabraham/NodeJsScan>)
- [x] npm audit: Checks installed packages for vulnerabilities.
- [x] octoscan: Scans GitHub repositories for sensitive information. (<https://github.com/synacktiv/octoscan>)
- [x] prowler: Audits AWS environments for security best practices. (<https://github.com/prowler-cloud/prowler>)
- [x] retirejs: Scans JavaScript libraries for known vulnerabilities. (<https://github.com/RetireJS/retire.js>)
- [x] scoutsuite: Audits multi-cloud environments for security issues. (<https://github.com/nccgroup/ScoutSuite>)
- [x] secure-repo: Secures GitHub Actions workflows. (<https://github.com/step-security/secure-repo>)
- [x] semgrep: Performs lightweight static analysis across languages. (<https://github.com/semgrep/semgrep>)
- [x] snyk: Scans projects for security vulnerabilities. (<https://github.com/snyk/cli>)
- [x] trivy: Scans for vulnerabilities and misconfigurations in various environments. (<https://github.com/aquasecurity/trivy>)
- [x] trufflehog: Finds and analyzes leaked credentials. (<https://github.com/trufflesecurity/trufflehog>) [Easy marketplace] (https://github.com/marketplace/actions/trufflehog-oss)
- [x] wait-for-secrets: Provides 2FA for GitHub Actions. (<https://github.com/step-security/wait-for-secrets>)
- [x] yarn-audit-fix: Adds missing fix functionality to yarn audit. (<https://www.npmjs.com/package/yarn-audit-fix>)