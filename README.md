# container-sec-tools
Unified repository with OSS security tools, just `make exec` and dive into the container!

There are some tools that have not been integrated to the container itself, given their nature. For
those special cases, we have a separated section below. 

## Firing up the container

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

## Tools included in this container
Except for Hadolint all tools are being installed from their latest releases.

- [x] GitHub analysis (fake profiles, OSINT):
    - [x] gitxray: A multifaceted security tool that leverages Public GitHub REST APIs for OSINT,
      Forensics, Pentesting and more. (https://github.com/kulkansecurity/gitxray)
    - [x] gh-fake-analyzer: Dump github profile data for analysis.
      (https://github.com/shortdoom/gh-fake-analyzer/tree/main)

- [x] Only Secrets:
    - Previous to commit:
        - [x] git-secrets: Works along with git, preventing secrets from being pushed to a repo.
          (https://github.com/awslabs/git-secrets)
    - Post commit:
        - [x] trufflehog: Find, verify, and analyze leaked credentials.
          (https://github.com/trufflesecurity/trufflehog) [Easy
          marketplace](https://github.com/marketplace/actions/trufflehog-oss)
        - [x] gitleaks: Protect and discover secrets. (https://github.com/gitleaks/gitleaks) Also
          [git-leaks-action](https://github.com/gitleaks/gitleaks-action)
        - [x] 2ms: Too many secrets (2MS) helps people protect their secrets on any file or on
          systems like CMS, chats and git. (https://github.com/Checkmarx/2ms)
        - [x] detect-secrets: yet another one. (https://github.com/Yelp/detect-secrets)

- [ ] Vulnerability scanners:
    - [x] trivy: Find vulnerabilities, misconfigurations, secrets, SBOM in containers, Kubernetes,
      code repositories, clouds and more. (https://github.com/aquasecurity/trivy)
    - [x] clair: Vulnerability Static Analysis for Containers. (https://github.com/quay/clair)
    - [x] snyk: Snyk CLI scans and monitors your projects for security vulnerabilities.
      (https://github.com/snyk/cli)
    - [x] grype: A vulnerability scanner for container images and filesystems.
      (https://github.com/anchore/grype/)
    - [ ] falco: Cloud Native Runtime Security. (https://github.com/falcosecurity/falco)

- [ ] Static analysis:
    - [x] semgrep: Lightweight static analysis for many languages.
      (https://github.com/semgrep/semgrep)
        - [ ] docker-compose (https://semgrep.dev/p/docker-compose)
        - [ ] dockerfile (https://semgrep.dev/p/dockerfile)
        - [ ] kubernetes (https://semgrep.dev/p/kubernetes)
        - [ ] flawfinder (https://semgrep.dev/p/flawfinder)
    - [ ] sast-scan: Scan is a free & Open Source DevSecOps tool for performing static analysis
      based security testing of your applications and its dependencies. CI and Git friendly.
      (https://github.com/marksarka/sast-scan)

- [ ] Misconfigurations:
    - [x] legitify: Detect and remediate misconfigurations and security risks across all your GitHub
      and GitLab assets. (https://github.com/Legit-Labs/legitify)
    - [x] kics: Find security vulnerabilities, compliance issues, and infrastructure
      misconfigurations early in the development cycle of your infrastructure-as-code.
      (https://github.com/Checkmarx/kics) [Scan free](https://kics.checkmarx.net/) up to 4mb
      repositories.

- [ ] GitHub actions:
    - [ ] harden-runner: Network egress filtering and runtime security for GitHub-hosted and
      self-hosted runners. (https://github.com/step-security/harden-runner)
    - [ ] secure-repo: Orchestrate GitHub Actions Security.
      (https://github.com/step-security/secure-repo)
    - [ ] wait-for-secrets: 2fa for GHA. (https://github.com/step-security/wait-for-secrets)
    - [ ] generic: A set of GitHub actions for checking your projects for vulnerabilities.
      (https://github.com/snyk/actions)

- [ ] Container and/or cloud specific:
    - [ ] kube-bench: Checks whether Kubernetes is deployed according to security best practices as
      defined in the CIS Kubernetes Benchmark. (https://github.com/aquasecurity/kube-bench)
    - [x] checkov: Prevent cloud misconfigurations and find vulnerabilities during build-time in
      infrastructure as code, container images and open source packages.
      (https://github.com/bridgecrewio/checkov)
    - [x] scoutsuite: Multi-Cloud Security Auditing Tool. (https://github.com/nccgroup/ScoutSuite)
    - [x] pmapper: A tool for quickly evaluating IAM permissions in AWS.
      (https://github.com/nccgroup/PMapper)
    - [x] hadolint: Dockerfile linter. (https://github.com/hadolint/hadolint)

- [x] Dependency & lib checkers:
    - [x] DependencyCheck: OWASP dependency-check is a software composition analysis utility that
      detects publicly disclosed vulnerabilities in application dependencies.
      (https://github.com/jeremylong/DependencyCheck)
    - [x] retirejs: Scanner detecting the use of JavaScript libraries with known vulnerabilities.
      (https://github.com/RetireJS/retire.js)
    - [x] npm audit: This built-in npm command checks for vulnerabilities in your installed
      packages.
    - [x] installed-check: Verifies that installed modules comply with the requirements specified in
      package.json. (https://www.npmjs.com/package/installed-check)
    - [x] better-npm-audit: Provides additional features on top of the existing npm audit options.
      (https://www.npmjs.com/package/better-npm-audit)
    - [x] eslint-plugin-security: ESLint rules for Node Security.
      (https://www.npmjs.com/package/eslint-plugin-security)
    - [x] eslint-plugin-no-unsanitized: Custom ESLint rule to disallow unsafe innerHTML, outerHTML,
      insertAdjacentHTML and alike. (https://www.npmjs.com/package/eslint-plugin-no-unsanitized)
    - [x] eslint-plugin-no-secrets: An ESLint plugin to find strings that might be
      secrets/credentials. (https://www.npmjs.com/package/eslint-plugin-no-secrets)
    - [x] node-version-audit: Node Version Audit is a tool to check Node.js version against a
      regularly updated list of CVE exploits, new releases, and end of life dates.
      (https://www.npmjs.com/package/node-version-audit)
    - [x] yarn-audit-fix: The missing yarn audit fix. (https://www.npmjs.com/package/yarn-audit-fix)
    - [x] better-npm-audit: Additional features on top of the existing npm audit options.
      (https://www.npmjs.com/package/better-npm-audit)
    - [x] nodejsscan: A static security code scanner for Node.js applications.
      (https://github.com/ajinabraham/NodeJsScan)
    - [ ] lavamoat: Tools for sandboxing your dependency graph.
      (https://github.com/LavaMoat/lavamoat)

## How to use the tools inside

### OSINT and Forensics for GitHub
#### gitxray
[GitHub](https://github.com/kulkansecurity/gitxray) | [Website](https://www.gitxray.com/)
Gitxray (short for Git X-Ray) is a multifaceted security tool designed for use on GitHub
repositories. It can serve many purposes, including OSINT and Forensics. `gitxray` leverages public
GitHub REST APIs to gather information that would otherwise be very time-consuming to obtain
manually. Additionally, it seeks out information in unconventional places.

Gitxray can be used to, for example:
```bash
# Find sensitive information in contributor profiles disclosed by accident within, for example,
# Armored PGP Keys, or Key Names.
gitxray -r https://github.com/some-org/some-repository -v -f user_input

# Identify threat actors in a Repository. You may spot co-owned or shared accounts, as well as
# inspect public events to spot fake Stargazers.
gitxray -r https://github.com/some-org/some-repository -v -f keys,association,starred

# Identify fake or infected Repositories. It can detect tampered commit dates as well as, for
# example, Release assets updated post-release.
gitxray -r https://github.com/some-org/some-repository -v -f warning

# Forensics use-cases, such as filtering results by date in order to check what else happened on the
# day of an incident.
gitxray -r https://github.com/some-org/some-repository -v -f 2024-09-01

# And a lot more! Run a full X-Ray in Verbose mode to collect a ton of data.
gitxray -r https://github.com/some-org/some-repository -v
```

Please refer to the Documentation for additional use-cases and introductory information.

##### Documentation
- [https://kulkansecurity.github.io/gitxray/](https://kulkansecurity.github.io/gitxray/)
- [https://www.gitxray.com/](https://www.gitxray.com/)

#### gh-fake-analyzer
[GitHub](https://github.com/shortdoom/gh-fake-analyzer)
Download and analyze profile data for any GitHub user or organization. This reconnaissance tool is designed for the OSINT/security community, enabling the inspection of potential bot, scammer, blackhat, or fake employee accounts for dark patterns (see, Malicious GitHub Accounts)

```bash
# Analyzing users
python analyze.py <username> # analyze a single user
python analyze.py <username> --out_path /path/to/dir # save to different than /out dir

# Optionally, rename `targets.example` to `targets` 
python analyze.py # read from "targets" and analyze all
python analyze.py --targets <path> # custom_file.txt to read from as "targets"   
python analyze.py <us

# Monitor users
python monitor.py --username <username> # Monitor single user
python monitor.py --targets <file> # Monitor multiple usernames
```


### Find secrets in repositories

#### git-secrets
[GitHub](https://github.com/awslabs/git-secrets)
Prevents you from committing passwords and other sensitive information to a git repository. Set up rules, and scan.

Install git-hooks so you can scan before commiting
```bash
git secrets --install
```

Adds a prohibited pattern to the current repo:
```bash
git secrets --add '[A-Z0-9]{20}'
```

Adds a prohibited pattern to the global git config:
```bash
git secrets --add --global '[A-Z0-9]{20}'
git secrets --add 'password\s*=\s*.+'
```

Add a configuration template if you want to add hooks to all repositories you initialize or clone in the future.

```bash
git secrets --register-aws --global
```

Scan!
```bash
# Scan for secrets inside history
git secrets --scan-history

# Scan files and folders
git secrets --scan .env
git secrets --scan tests/*
git secrets --scan -r deployment/
```

For more examples and advanced usage refer to their repository.

#### trufflehog
[GitHub](https://github.com/trufflesecurity/trufflehog) | [Action](https://github.com/marketplace/actions/trufflehog-oss)

Find, verify, and analyze leaked credentials.

To start with the wizardm you can run `sudo trufflehog` and follow the steps! But if you want a
specific command, you can run each of them manually. Check `--help` to see them all. You can scan
from git, to s3/gcs buckets; docker images, CIs, and even your filesystem.

```
trufflehog --no-update git https://github.com/trufflesecurity/test_keys --only-verified
```

#### gitleaks
[GitHub](https://github.com/gitleaks/gitleaks) | [Action](https://github.com/gitleaks/gitleaks-action)
Gitleaks is a SAST tool for detecting and preventing hardcoded secrets like passwords, API keys, and
tokens in git repos. Gitleaks is an easy-to-use, all-in-one solution for detecting secrets, past or
present, in your code.

```
➜  ~/code(master) gitleaks git -v

    ○
    │╲
    │ ○
    ○ ░
    ░    gitleaks


Finding:     "export BUNDLE_ENTERPRISE__CONTRIBSYS__COM=cafebabe:deadbeef",
Secret:      cafebabe:deadbeef
RuleID:      sidekiq-secret
Entropy:     2.609850
File:        cmd/generate/config/rules/sidekiq.go
Line:        23
Commit:      cd5226711335c68be1e720b318b7bc3135a30eb2
Author:      John
Email:       john@users.noreply.github.com
Date:        2022-08-03T12:31:40Z
Fingerprint: cd5226711335c68be1e720b318b7bc3135a30eb2:cmd/generate/config/rules/sidekiq.go:sidekiq-secret:23
```


#### 2ms
[GitHub](https://github.com/Checkmarx/2ms) | [Action](https://github.com/Checkmarx/2ms/blob/master/.github/workflows/release.yml) | [Azure](https://learn.microsoft.com/en-us/azure/devops/pipelines/create-first-pipeline)
Too many secrets (2ms) is an open source CLI tool, powered by Checkmarx, that enables you to identify sensitive data such as secrets, authentication keys and passwords that are stored in your system in unencrypted text. This tool supports scanning of internal communication platforms (Slack, Discord), content management (Confluence, Paligo) and source code storage locations (Git repo, local directory).
This application is written in Go language and is based on the framework provided by gitleaks.

The tool checks the content using a series of rules that are designed to identify a wide range of sensitive items such as AWS access token, Bitbucket Client ID, GitHub PAT etc. For a complete list of rules, see their docs.


```bash
# Scan a local repo
2ms git . 

 # Scan filesystem's current path
2ms filesystem --path .
```

[How to get a Discord token.](https://www.geeksforgeeks.org/how-to-get-discord-token/)
```bash
# Scan a Discord server
2ms discord --token <YOUR_TOKEN> --server 1097814317077897307 --duration 9999h
```

For more examples refer to their official documentation.

#### detect-secrets
Yet another tool for detecting secrets. [GitHub](https://github.com/Yelp/detect-secrets)


##### Quickstart:

```bash
# Create a baseline of potential secrets currently found in your git repository.
detect-secrets scan > .secrets.baseline
# or, to run it from a different directory:
detect-secrets -C /path/to/directory scan > /path/to/directory/.secrets.baseline

# Scanning non-git tracked files:
detect-secrets scan test_data/ --all-files > .secrets.baseline

# Scanning Staged Files Only
git diff --staged --name-only -z | xargs -0 detect-secrets-hook --baseline .secrets.baseline
# Scanning All Tracked Files
git ls-files -z | xargs -0 detect-secrets-hook --baseline .secrets.baseline

# Viewing All Enabled Plugins:
detect-secrets scan --list-all-plugins 
```

For more examples and advanced usage refer to their official documentation.

### Vulnerability scanners
#### trivy
[GitHub](https://github.com/aquasecurity/trivy) | [Action](https://github.com/aquasecurity/trivy-action) | [VSCode](https://github.com/aquasecurity/trivy-vscode-extension)
Find vulnerabilities, misconfigurations, secrets, SBOM in containers, Kubernetes, code repositories,
clouds, and more. 

General usage:

```bash
trivy <target> [--scanners <scanner1,scanner2>] <subject>
```


```bash
trivy image python:3.4-alpine
trivy fs --scanners vuln,secret,misconfig myproject/
trivy k8s --report summary cluster
```

#### clair (WIP - NOT WORKING)
[GitHub](https://github.com/quay/clair)
> The documentation for clair is currently incomplete. The provided config.yaml file from their
> documentation side is not longer being accepted by clair and requires manual modification.

Clair is an open source project for the static analysis of vulnerabilities in application containers (currently including OCI and docker).

Since clair scans containers, it is best to run it separately.

```bash
docker pull quay.io/projectquay/clair:4.7.4
# Alternatively you can try and pull latest but it did not work out for me
docker pull quay.io/projectquay/clair
``` 

```bash
# Download sample config
wget -q https://github.com/quay/clair/blob/main/config.yaml.sample \
--output-document /tmp/clair/config.yaml
# Run clair
docker run -p 6060:6060 -p 6061:6061 \
-v /tmp/clair:/clair/config \
quay.io/projectquay/clair:4.7.4 -conf /clair/config/config.yaml -mode combo
```

One liner if you don't want a container:
```bash
sudo wget -qO /usr/local/bin/clair https://github.com/quay/clair/releases/download/v4.7.4/clairctl-linux-$(dpkg --print-architecture) \
&& sudo chmod +x /usr/local/bin/clair
```

#### snyk
[GitHub](https://github.com/snyk/cli) | [Website](https://snyk.io/)

A developer-first, cloud-native security tool to scan and monitor your software development projects
for security vulnerabilities. Snyk scans multiple content types for security issues:

- [**Snyk Open Source**](https://docs.snyk.io/scan-using-snyk/snyk-open-source): Find and
  automatically fix open-source vulnerabilities
- [**Snyk Code**](https://docs.snyk.io/scan-using-snyk/snyk-code): Find and fix vulnerabilities in
  your application code in real time
- [**Snyk Container**](https://docs.snyk.io/scan-using-snyk/snyk-container): Find and fix
  vulnerabilities in container images and Kubernetes applications
- [**Snyk Infrastructure as Code**](https://docs.snyk.io/scan-using-snyk/scan-infrastructure): Find
  and fix insecure configurations in Terraform and Kubernetes code

Before you start using it, you need to authenticate. A free tier would do just fine for now:
```bash
snyk auth --auth-type=token # literally this command, it will provide a link from where to auth.
```

By simply running `snyk` you'll see the available commands with their description. Some of them are
`test`, `container`, `iac`, `code`, `log4shell`, and `monitor` among others.

You can scan a container for vulnerabilities with this simple command for example:
```bash
snyk container test vulnerables/web-dvwa
```

And you can even monitor them through their website. For more information, refer to the
documentation and examples for each command.


#### grype
[GitHub](https://github.com/anchore/grype/)

A vulnerability scanner for container images and
filesystems. Easily install the binary to try it out. Works with Syft, the powerful SBOM (software
bill of materials) tool for container images and filesystems.

Supports the following image sources:
```bash
  grype yourrepo/yourimage:tag             defaults to using images from a Docker daemon
  grype path/to/yourproject                a Docker tar, OCI tar, OCI directory, SIF container, or generic filesystem directory
```
You can also explicitly specify the scheme to use:
```bash
grype podman:yourrepo/yourimage:tag          explicitly use the Podman daemon
grype docker:yourrepo/yourimage:tag          explicitly use the Docker daemon
grype docker-archive:path/to/yourimage.tar   use a tarball from disk for archives created from "docker save"
grype oci-archive:path/to/yourimage.tar      use a tarball from disk for OCI archives (from Podman or otherwise)
grype oci-dir:path/to/yourimage              read directly from a path on disk for OCI layout directories (from Skopeo or otherwise)
grype singularity:path/to/yourimage.sif      read directly from a Singularity Image Format (SIF) container on disk
grype dir:path/to/yourproject                read directly from a path on disk (any directory)
grype file:path/to/yourfile                  read directly from a file on disk
grype sbom:path/to/syft.json                 read Syft JSON from path on disk
grype registry:yourrepo/yourimage:tag        pull image directly from a registry (no container runtime required)
grype purl:path/to/purl/file                 read a newline separated file of purls from a path on disk
```


#### falco (WIP)
[GitHub](https://github.com/falcosecurity/falco) | [Website](https://falco.org/)

Falco is a cloud native runtime security tool for Linux operating systems. It is designed to detect
and alert on abnormal behavior and potential security threats in real-time.

At its core, Falco is a kernel monitoring and detection agent that observes events, such as
syscalls, based on custom rules. Falco can enhance these events by integrating metadata from the
container runtime and Kubernetes. The collected events can be analyzed off-host in SIEM or data lake
systems.

Falco comes with its own container. Current instructions on how to run it are incomplete. Come back
later dear wanderer!


### Static analysis
#### semgrep
[GitHub](https://github.com/semgrep/semgrep) | [Website](https://semgrep.dev)

Powerful, customizable lightweight static analysis for many languages. 

1. Run `semgrep login` to create your account and login to Semgrep.

Logging into Semgrep gets you access to:
- [Semgrep Supply Chain](https://semgrep.dev/products/semgrep-supply-chain): A dependency scanner that detects reachable vulnerabilities in third party libraries
- [Semgrep Code's Pro rules](https://semgrep.dev/products/semgrep-code): 600+ high confidence rules written by Semgrep's security research team
- [Semgrep Code's Pro engine](https://semgrep.dev/products/pro-engine/): An advanced code analysis engine, designed to detect complex vulnerabilities, and reduce false positives
  
2. Go to your app's root directory and run `semgrep ci`. This will scan your project to check for vulnerabilities in your source code and its dependencies.

3.  Try writing your own query interactively with `-e`. For example, a check for Python == where the
    left and right hand sides are the same (potentially a bug):
    `semgrep -e '$X == $X' --lang=py path/to/src`

##### More information

Semgrep has an entire ecosystem which consists of the following: Code, Supply Chain, Secrets, Appsec Platform, OSS Engine. They provide a range of resources for you to run analysis and scan from vulnerabilities to secrets.

To learn more about Semgrep, visit:

- [Semgrep Playground](https://semgrep.dev/editor) - An online interactive tool for writing and sharing rules.
- [Semgrep Registry](https://semgrep.dev/explore) - 2,000+ community-driven rules covering security, correctness, and dependency vulnerabilities.

#### sast-scan (WIP)
[GitHub](https://github.com/marksarka/sast-scan)

Scan is a free & Open Source DevSecOps tool for performing static analysis based security testing of
your applications and its dependencies. CI and Git friendly.

Right now we're planning to incorporate it to the repo, but on its own container given the amount of
tools that it brings inside, some of them even overlap. If you want to do it by yourself you can just follow their documentation running `sh <(curl https://slscan.sh)`, or simply:
```bash
docker pull shiftleft/scan-slim:latest
docker save -o scanslim.tar shiftleft/scan-slim:latest
# podman save --format oci-archive -o scanslim.tar shiftleft/scan-slim:latest
docker run --rm -e "WORKSPACE=${PWD}" -v $PWD:/app shiftleft/scan scan --src /app/scanslim.tar -o /app/reports --type docker
```


### Misconfigurations

#### legitify
[GitHub](https://github.com/Legit-Labs/legitify) | [Action](https://github.com/marketplace/actions/legitify-analyze)

Detect and remediate misconfigurations and security risks across all your GitHub and GitLab assets.


#### kics
Find security vulnerabilities, compliance issues, and infrastructure misconfigurations early in the
development cycle of your infrastructure-as-code. [GitHub](https://github.com/Checkmarx/kics) [Scan
free](https://kics.checkmarx.net/) up to 4mb repositories.



### Container and/or cloud specific
#### kube-bench
Checks whether Kubernetes is deployed according to security best practices as defined in the CIS
Kubernetes Benchmark. [GitHub](https://github.com/aquasecurity/kube-bench)

#### checkov
Prevent cloud misconfigurations and find vulnerabilities during build-time in infrastructure as
code, container images, and open source packages. [GitHub](https://github.com/bridgecrewio/checkov)

#### scoutsuite
Multi-Cloud Security Auditing Tool. [GitHub](https://github.com/nccgroup/ScoutSuite)

#### pmapper
A tool for quickly evaluating IAM permissions in AWS. [GitHub](https://github.com/nccgroup/PMapper)

#### hadolint
Dockerfile linter. [GitHub](https://github.com/hadolint/hadolint)

### Dependency & lib checkers
#### DependencyCheck
OWASP dependency-check is a software composition analysis utility that detects publicly disclosed
vulnerabilities in application dependencies. [GitHub](https://github.com/jeremylong/DependencyCheck)

#### retirejs
Scanner detecting the use of JavaScript libraries with known vulnerabilities.
[GitHub](https://github.com/RetireJS/retire.js)

#### npm audit
This built-in npm command checks for vulnerabilities in your installed packages.

#### installed-check
Verifies that installed modules comply with the requirements specified in package.json.
[npm](https://www.npmjs.com/package/installed-check)

#### better-npm-audit
Provides additional features on top of the existing npm audit options.
[npm](https://www.npmjs.com/package/better-npm-audit)

#### eslint-plugin-security
ESLint rules for Node Security. [npm](https://www.npmjs.com/package/eslint-plugin-security)

#### eslint-plugin-no-unsanitized
Custom ESLint rule to disallow unsafe innerHTML, outerHTML, insertAdjacentHTML and alike.
[npm](https://www.npmjs.com/package/eslint-plugin-no-unsanitized)

#### eslint-plugin-no-secrets
An ESLint plugin to find strings that might be secrets/credentials.
[npm](https://www.npmjs.com/package/eslint-plugin-no-secrets)

#### node-version-audit
Node Version Audit is a tool to check Node.js version against a regularly updated list of CVE
exploits, new releases, and end of life dates.
[npm](https://www.npmjs.com/package/node-version-audit)

#### yarn-audit-fix
The missing yarn audit fix. [npm](https://www.npmjs.com/package/yarn-audit-fix)

#### better-npm-audit
Additional features on top of the existing npm audit options.
[npm](https://www.npmjs.com/package/better-npm-audit)

#### nodejsscan
A static security code scanner for Node.js applications.
[GitHub](https://github.com/ajinabraham/NodeJsScan)

#### lavamoat
Tools for sandboxing your dependency graph. [GitHub](https://github.com/LavaMoat/lavamoat)

### Special cases (more tools)
In this section we're going to describe a set of tools that for different reasons are not, or cannot
be included in the repository.

### Containers
#### falco
https://falco.org/docs/setup/container/

#### sast-scan


### Supply-chain
#### lavamoat

#### GitHub actions
##### harden-runner
Network egress filtering and runtime security for GitHub-hosted and self-hosted runners.
[GitHub](https://github.com/step-security/harden-runner)

##### secure-repo
Orchestrate GitHub Actions Security. [GitHub](https://github.com/step-security/secure-repo)

##### wait-for-secrets
2fa for GHA. [GitHub](https://github.com/step-security/wait-for-secrets)

##### generic
A set of GitHub actions for checking your projects for vulnerabilities.
[GitHub](https://github.com/snyk/actions)

