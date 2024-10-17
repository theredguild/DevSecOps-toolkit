# How to use the tools inside

We leave you with a rough representative of what do these tools cover, so you get a better grasp on what to use them for.

**Secrets**
2ms, gitleaks, git-secrets, trufflehog

**GitHub / GitLab**
gitxray, gh-fake-analyzer, legitify

**Multi-purpose**
semgrep, trivy, kics

**IaC / SCA / Code**
checkov, scoutsuite, dependency-check

**Cloud**
falco, snyk, cloudsplaining

**Containers / Images**
clair, snyk, grype, hadolint, dockle

**NodeJS**
nodejsscan, retirejs, installed-check, better-npm-audit, eslint-plugin-security, eslint-plugin-no-unsanitized, eslint-plugin-no-secrets, node-version-audit, yarn-audit-fix


- [How to use the tools inside](#how-to-use-the-tools-inside)
  - [GitXray | Harvest public information from GitHub APIs](#gitxray--harvest-public-information-from-github-apis)
  - [GH Fake Analyzer | Script to analyze profile GitHub data](#gh-fake-analyzer--script-to-analyze-profile-github-data)
  - [git-secrets | Avoid commiting secrets](#git-secrets--avoid-commiting-secrets)
  - [Trufflehog | Find, verify, and analyze leaked credentials](#trufflehog--find-verify-and-analyze-leaked-credentials)
  - [Gitleaks | Detect and prevent secrets in git repos](#gitleaks--detect-and-prevent-secrets-in-git-repos)
  - [2ms | Identify secrets across an entire org](#2ms--identify-secrets-across-an-entire-org)
  - [detect-secrets | Detect and prevent secrets in a codebase](#detect-secrets--detect-and-prevent-secrets-in-a-codebase)
  - [Trivy | Very complete tool, misconfigs, vulns and more](#trivy--very-complete-tool-misconfigs-vulns-and-more)
  - [Clair (WIP - NOT WORKING) | Scan containers!](#clair-wip---not-working--scan-containers)
  - [Snyk | Scan and monitor containers, cloud](#snyk--scan-and-monitor-containers-cloud)
  - [Grype | Vuln scanner for images and fs](#grype--vuln-scanner-for-images-and-fs)
  - [Falco (WIP) | Cloud native runtime tool for Linux OS](#falco-wip--cloud-native-runtime-tool-for-linux-os)
  - [Semgrep | Static analyzer for almost anything](#semgrep--static-analyzer-for-almost-anything)
  - [sast-scan (WIP) | Static analysis with many many tools](#sast-scan-wip--static-analysis-with-many-many-tools)
  - [Legitify | GitHub and GitLab misconfiguration checker](#legitify--github-and-gitlab-misconfiguration-checker)
  - [KICS | IaC general purpose scanner](#kics--iac-general-purpose-scanner)
  - [Checkov | Static code analyzer and SCA tool for images and OSS](#checkov--static-code-analyzer-and-sca-tool-for-images-and-oss)
  - [ScoutSuite | Multi-cloud security-auditing tool](#scoutsuite--multi-cloud-security-auditing-tool)
  - [Cloudsplaining | AWS IAM assessment tool](#cloudsplaining--aws-iam-assessment-tool)
  - [Hadolint | Scans Dockerfiles for good linting practices](#hadolint--scans-dockerfiles-for-good-linting-practices)
  - [Dockle | Container image linter for security](#dockle--container-image-linter-for-security)
  - [DependencyCheck | Checks for public vulns on dependencies](#dependencycheck--checks-for-public-vulns-on-dependencies)
  - [nodejsscan | NodeJS application code scanner](#nodejsscan--nodejs-application-code-scanner)
  - [Lavamoat | JS framework to prevent supply-chain attacks](#lavamoat--js-framework-to-prevent-supply-chain-attacks)
  - [NodeJS specific tools](#nodejs-specific-tools)
    - [retirejs | Vuln scanner for JS](#retirejs--vuln-scanner-for-js)
    - [installed-check | Verifies modules are in tune with reqs in package.json](#installed-check--verifies-modules-are-in-tune-with-reqs-in-packagejson)
    - [better-npm-audit | npm audit++](#better-npm-audit--npm-audit)
    - [eslint-plugin-security | JS plugin to identify potential hotspots](#eslint-plugin-security--js-plugin-to-identify-potential-hotspots)
    - [eslint-plugin-no-unsanitized | ESLint rule to disallow unsafe patterns](#eslint-plugin-no-unsanitized--eslint-rule-to-disallow-unsafe-patterns)
    - [eslint-plugin-no-secrets | ESLint plugin to find secrets](#eslint-plugin-no-secrets--eslint-plugin-to-find-secrets)
    - [node-version-audit | Checks node's version for CVEs](#node-version-audit--checks-nodes-version-for-cves)
    - [yarn-audit-fix | Fixes issues found while yarn auditing](#yarn-audit-fix--fixes-issues-found-while-yarn-auditing)
  - [GitHub actions](#github-actions)
    - [List of secure measures for your repo](#list-of-secure-measures-for-your-repo)
    - [harden-runner | Prevent exfiltration, tampering, backdoors](#harden-runner--prevent-exfiltration-tampering-backdoors)
    - [wait-for-secrets | MFA for GHA](#wait-for-secrets--mfa-for-gha)
    - [Snyk Actions | Snyk's set of actions to check for vulns and more](#snyk-actions--snyks-set-of-actions-to-check-for-vulns-and-more)
    - [KICS Action | Static code analysis for IaC](#kics-action--static-code-analysis-for-iac)
    - [Legitify Action | Analyze your repo for misconfigs \& compliance issues](#legitify-action--analyze-your-repo-for-misconfigs--compliance-issues)
    - [Trivy Action | Add a thorough vuln scan to your CI/CD](#trivy-action--add-a-thorough-vuln-scan-to-your-cicd)
    - [2ms Action | Apply too many secrets to your workflow](#2ms-action--apply-too-many-secrets-to-your-workflow)
    - [GitLeaks Action | Add gitleaks as a github action](#gitleaks-action--add-gitleaks-as-a-github-action)
    - [Trufflehog Action | Continuously scan for secrets](#trufflehog-action--continuously-scan-for-secrets)
    - [Dockle action | Cointinuously scan for security issues in Docker files](#dockle-action--cointinuously-scan-for-security-issues-in-docker-files)
  - [Online version of some tools](#online-version-of-some-tools)

## GitXray | Harvest public information from GitHub APIs 

[GitHub](https://github.com/kulkansecurity/gitxray) | [Website](https://www.gitxray.com)

**OSINT | Forensics | GitHub**

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

- [https://kulkansecurity.github.io/gitxray/](https://kulkansecurity.github.io/gitxray/)
- [https://www.gitxray.com/](https://www.gitxray.com/)

## GH Fake Analyzer | Script to analyze profile GitHub data

[GitHub](https://github.com/shortdoom/gh-fake-analyzer)

**OSINT | GitHub | Script**

Download and analyze profile data for any GitHub user or organization. This reconnaissance tool is
designed for the OSINT/security community, enabling the inspection of potential bot, scammer,
blackhat, or fake employee accounts for dark patterns (see, Malicious GitHub Accounts)

```bash
gh-analyze <username> # analyze a single user
gh-analyze <username> --out_path /path/to/dir # save to different than /out dir
gh-analyze --targets <path> # custom_file.txt to read from as "targets"
gh-analyze <username> --commit_search # search github for commit messages (slow, experimental)
gh-analyze <username> --token <token> # provide GH_TOKEN to use for this run

gh-monitor --username <username> # Monitor single user
gh-monitor --targets <file> # Monitor multiple usernames
```

## git-secrets | Avoid commiting secrets

[GitHub](https://github.com/awslabs/git-secrets)

**Secrets | git | git-hook**

Prevents you from committing passwords and other sensitive information to a git repository. Set up
rules, and scan.

Install `git-hooks` on your repo so you can scan before commiting:

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

Add a configuration template if you want to add hooks to all repositories you initialize or clone in
the future.

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

## Trufflehog | Find, verify, and analyze leaked credentials

[GitHub](https://github.com/trufflesecurity/trufflehog) | [Action](https://github.com/marketplace/actions/trufflehog-oss)

**Secrets | Analysis | Various**

To start with the wizard you can run `sudo trufflehog` and follow the steps! But if you want a
specific command, you can run each of them manually. Check `--help` to see them all. You can scan
from git, to s3/gcs buckets; docker images, CIs, and even your filesystem.

```bash
trufflehog --no-update git https://github.com/trufflesecurity/test_keys --only-verified
```

## Gitleaks | Detect and prevent secrets in git repos

[GitHub](https://github.com/gitleaks/gitleaks) | [Action](https://github.com/gitleaks/gitleaks-action)

**Secrets | git**

Gitleaks is a SAST tool for detecting and preventing hardcoded secrets like passwords, API keys, and
tokens in git repos. Gitleaks is an easy-to-use, all-in-one solution for detecting secrets, past or
present, in your code.

```bash
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

## 2ms | Identify secrets across an entire org

[GitHub](https://github.com/Checkmarx/2ms) | [Action](https://github.com/Checkmarx/2ms/blob/master/.github/workflows/release.yml) | [Azure](https://learn.microsoft.com/en-us/azure/devops/pipelines/create-first-pipeline)

**Secrets | Various**

Too many secrets (2ms) is an open source CLI tool, powered by Checkmarx, that enables you to
identify sensitive data such as secrets, authentication keys and passwords that are stored in your
system in unencrypted text. This tool supports scanning of internal communication platforms (Slack,
Discord), content management (Confluence, Paligo) and source code storage locations (Git repo, local
directory). This application is written in Go language and is based on the framework provided by
gitleaks.

The tool checks the content using a series of rules that are designed to identify a wide range of
sensitive items such as AWS access token, Bitbucket Client ID, GitHub PAT etc. For a complete list
of rules, see their docs.

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

## detect-secrets | Detect and prevent secrets in a codebase

[GitHub](https://github.com/Yelp/detect-secrets)

**Secrets | Various**

detect-secrets is an aptly named module for (surprise, surprise) detecting secrets within a code
base.

However, unlike other similar packages that solely focus on finding secrets, this package is
designed with the enterprise client in mind: providing a backwards compatible, systematic means of:

- Preventing new secrets from entering the code base,
- Detecting if such preventions are explicitly bypassed, and
- Providing a checklist of secrets to roll, and migrate off to a more secure storage.

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

## Trivy | Very complete tool, misconfigs, vulns and more

[GitHub](https://github.com/aquasecurity/trivy) | [Action](https://github.com/aquasecurity/trivy-action) | [VSCode](https://github.com/aquasecurity/trivy-vscode-extension)

**Scanner | Vulns | Secrets | Misconfigs | Code | IaC**

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

## Clair (WIP - NOT WORKING) | Scan containers!

[GitHub](https://github.com/quay/clair)

**Static Analysis | Containers**

> The documentation for clair is currently incomplete. The provided config.yaml file from their
> documentation side is not longer being accepted by clair and requires manual modification.

Clair is an open source project for the static analysis of vulnerabilities in application containers
(currently including OCI and docker).

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

## Snyk | Scan and monitor containers, cloud

[GitHub](https://github.com/snyk/cli) | [Website](https://snyk.io/) | [Action](https://github.com/marketplace/actions/snyk)

**Monitor | Scanner | Cloud | IaC**

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

## Grype | Vuln scanner for images and fs

[GitHub](https://github.com/anchore/grype/)

**Scanner | Containers | Fs**

A vulnerability scanner for container images and filesystems. Easily install the binary to try it
out. Works with Syft, the powerful SBOM (software bill of materials) tool for container images and
filesystems.

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

## Falco (WIP) | Cloud native runtime tool for Linux OS

[GitHub](https://github.com/falcosecurity/falco) | [Website](https://falco.org/)

**Monitor | Monitor | Containers**

Falco is a cloud native runtime security tool for Linux operating systems. It is designed to detect
and alert on abnormal behavior and potential security threats in real-time.

At its core, Falco is a kernel monitoring and detection agent that observes events, such as
syscalls, based on custom rules. Falco can enhance these events by integrating metadata from the
container runtime and Kubernetes. The collected events can be analyzed off-host in SIEM or data lake
systems.

Falco comes with its own container. Current instructions on how to run it are incomplete. Come back
later dear wanderer!

## Semgrep | Static analyzer for almost anything

[GitHub](https://github.com/semgrep/semgrep) | [Website](https://semgrep.dev)

**Static Analysis | General purpose**

Powerful, customizable lightweight static analysis for many languages.

1. Run `semgrep login` to create your account and login to Semgrep.
    Logging into Semgrep gets you access to:
   - [Semgrep Supply Chain](https://semgrep.dev/products/semgrep-supply-chain): A dependency scanner
     that detects reachable vulnerabilities in third party libraries
   - [Semgrep Code's Pro rules](https://semgrep.dev/products/semgrep-code): 600+ high confidence rules
     written by Semgrep's security research team
   - [Semgrep Code's Pro engine](https://semgrep.dev/products/pro-engine/): An advanced code analysis
  engine, designed to detect complex vulnerabilities, and reduce false positives
1. Go to your app's root directory and run `semgrep ci`. This will scan your project to check for
   vulnerabilities in your source code and its dependencies.
1. Try writing your own query interactively with `-e`. For example, a check for Python == where the
    left and right hand sides are the same (potentially a bug): `semgrep -e '$X == $X' --lang=py
    path/to/src`

**Semgrep has an entire ecosystem** which consists of the following: **Code, Supply Chain, Secrets,
Appsec Platform, OSS Engine**. They provide a range of resources for you to run analysis and scan
from vulnerabilities to secrets.

To learn more about Semgrep, visit:

- [Semgrep Playground](https://semgrep.dev/editor) - An online interactive tool for writing and
  sharing rules.
- [Semgrep Registry](https://semgrep.dev/explore) - 2,000+ community-driven rules covering security,
  correctness, and dependency vulnerabilities.

**Rulesets** for you to run more specific actions:

```bash
# Security checks for docker-compose configuration files.
semgrep --config "p/docker-compose"
# Selected rules from Hadolint, a Dockerfile linter, rewritten in Semgrep
semgrep --config "p/dockerfile"
# Security checks for kubernetes configuration files.
semgrep --config "p/kubernetes"
# Universal linter to identify vulnerabilities in your code base with the flawfinder rule pack
semgrep --config "p/flawfinder"
```

## sast-scan (WIP) | Static analysis with many many tools

[GitHub](https://github.com/marksarka/sast-scan)

**Static Analysis | General purpose**

Scan is a free & Open Source DevSecOps tool for performing static analysis based security testing of
your applications and its dependencies. CI and Git friendly.

Right now we're planning to incorporate it to the repo, but on its own container given the amount of
tools that it brings inside, some of them even overlap. If you want to do it by yourself you can
just follow their documentation running `sh <(curl https://slscan.sh)`, or simply:

```bash
docker pull shiftleft/scan-slim:latest
docker save -o scanslim.tar shiftleft/scan-slim:latest
# podman save --format oci-archive -o scanslim.tar shiftleft/scan-slim:latest
docker run --rm -e "WORKSPACE=${PWD}" -v $PWD:/app shiftleft/scan scan --src /app/scanslim.tar -o /app/reports --type docker
```

## Legitify | GitHub and GitLab misconfiguration checker

[GitHub](https://github.com/Legit-Labs/legitify) | [Action](https://github.com/marketplace/actions/legitify-analyze)

**Scanner | Misconfig | GitHub | GitLab**

Detect and remediate misconfigurations and security risks across all your GitHub and GitLab assets.

```bash
legitify -t <your_token> analyze
SCM_TOKEN=<your_token> legitify analyze
```

1. To get the most out of legitify, you need to be an owner of at least one GitHub organization.
   Otherwise, you can still use the tool if you're an admin of at least one repository inside an
   organization, in which case you'll be able to see only repository-related policies results.
2. legitify requires a GitHub personal access token (PAT) to analyze your resources successfully,
   which can be either provided as an argument (`-t`) or as an environment variable (`SCM_TOKEN`).
   The PAT needs the following scopes for full analysis:

```plain
admin:org, read:enterprise, admin:org_hook, read:org, repo, read:repo_hook
```

See [Creating a Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) for more information.
Fine-grained personal access tokens are currently not supported.

By default, legitify will check the policies against all your resources (organizations,
repositories, members, actions). Archived repositories are skipped.

You can control which resources will be analyzed with command-line flags namespace and org:

- `--namespace (-n)`: will analyze policies that relate to the specified resources
- `--org`: will limit the analysis to the specified GitHub organizations or GitLab group, excluding
  archived repositories
- `--repo`: will limit the analysis to the specified GitHub repositories or GitLab projects
- `--scm`: specify the source code management platform. Possible values are: `github` or `gitlab`.
  Defaults to `github`. Please note: when running on GitLab, `--scm gitlab` is required.
- `--enterprise`: will specify which enterprises should be analyzed. Please note: in order to
  analyze an enterprise, an enterprise slug must be provided.

```bash
legitify -t <your_token> analyze --org org1,org2 --namespace organization,member
```

The above command will test organization and member policies against org1 and org2.

## KICS | IaC general purpose scanner

[GitHub](https://github.com/Checkmarx/kics) | [Action](https://github.com/marketplace/actions/kics-github-action) | [Scan](https://kics.checkmarx.net/)

**Scanner | Vulns | Misconfig | IaC**

Find security vulnerabilities, compliance issues, and infrastructure misconfigurations early in the
development cycle of your infrastructure-as-code.

Using kics out of the box is really easy, just run:

```bash
kics scan -p path/to/project
```

To obtain the best out of this tool, you should go on reading:

- [Understand how to configure KICS](configuration-file.md) so you can have a better KICS
  experience.
- [Explore KICS commands](commands.md) to see what you can do with KICS.
- [Explore supported platforms](platforms.md) to see which files you can scan with KICS.
- [Explore the queries internals](queries.md) for better understanding how KICS works.
- [Create a new query](creating-queries.md) to learn how to create your own custom queries.
- [Explore the output results format](results.md) and quickly fix the issues detected.
- [Contribute](CONTRIBUTING.md) if you want to go the extra mile.

## Checkov | Static code analyzer and SCA tool for images and OSS

[GitHub](https://github.com/bridgecrewio/checkov)

**Static Analysis | IaC | SCA**

**Checkov** is a static code analysis tool for infrastructure as code (IaC) and also a software
composition analysis (SCA) tool for images and open source packages.

It scans cloud infrastructure provisioned using [Terraform](https://terraform.io/), [Terraform plan](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Terraform%20Plan%20Scanning.md), [Cloudformation](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Cloudformation.md),
[AWS SAM](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/AWS%20SAM.md), [Kubernetes](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Kubernetes.md), [Helm charts](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Helm.md), [Kustomize](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Kustomize.md), [Dockerfile](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Dockerfile.md), [Serverless](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Serverless%20Framework.md), [Bicep](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Bicep.md), [OpenAPI](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/OpenAPI.md),
[ARM Templates](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Azure%20ARM%20templates.md), or [OpenTofu](https://opentofu.org/) and detects security and compliance misconfigurations using
graph-based scanning.

It performs [Software Composition Analysis (SCA) scanning](docs/7.Scan%20Examples/Sca.md) which is a scan of open source
packages and images for Common Vulnerabilities and Exposures (CVEs).

**Configure** an input folder or file:

```sh
checkov --directory /user/path/to/iac/code
```

Or a **specific file** or files

```sh
checkov --file /user/tf/example.tf
# or
checkov -f /user/cloudformation/example1.yml -f /user/cloudformation/example2.yml
```

For more examples take a look at the official repository.

## ScoutSuite | Multi-cloud security-auditing tool

[GitHub](https://github.com/nccgroup/ScoutSuite)

**Scanner | Risk Analysis | Cloud | Various**

Scout Suite is an open source multi-cloud security-auditing tool, which enables security posture
assessment of cloud environments. Using the APIs exposed by cloud providers, Scout Suite gathers
configuration data for manual inspection and highlights risk areas. Rather than going through dozens
of pages on the web consoles, Scout Suite presents a clear view of the attack surface automatically.

Scout Suite was designed by security consultants/auditors. It is meant to provide a point-in-time
security-oriented view of the cloud account it was run in. Once the data has been gathered, all
usage may be performed offline.

As such, it needs access to each one of the cloud services you want it to take a look.

Usage is really simple once you´ve configured credentials. Refer to the section of the wiki
[Configuration and usage](https://github.com/nccgroup/ScoutSuite/wiki).

The command `scout` will return the list of available providers, although **Digital Ocean**` wasn't
available to me when I last tried. Nevertheless, you can ask for help using `scout PROVIDER --help`

```bash
scout aws --help
# returns help on aws
scout aws --profile PROFILE
scout gcp --user-account
scout azure --cli
```

## Cloudsplaining | AWS IAM assessment tool

[GitHub](https://github.com/salesforce/cloudsplaining) | [ReadTheDocs](https://cloudsplaining.readthedocs.io/en/latest/)

**Scanner | AWS IAM**

Cloudsplaining is an AWS IAM Security Assessment tool that identifies violations of least privilege
and generates a risk-prioritized HTML report.

You must have AWS credentials configured that can be used by the CLI.

You must have the privileges to run `iam:GetAccountAuthorizationDetails`. The
`arn:aws:iam::aws:policy/SecurityAudit` policy includes this, as do many others that allow Read
access to the IAM Service.

To download the account authorization details, ensure you are authenticated to AWS, then run
cloudsplaining's download command:

```bash
cloudsplaining download
```

If you prefer to use your `~/.aws/credentials` file instead of environment variables, you can
specify the profile name:

```bash
cloudsplaining download --profile myprofile
```

It will download a JSON file in your current directory that contains your account authorization
detail information.

Now that we've downloaded the account authorization file, we can scan all of the AWS IAM policies.

```bash
cloudsplaining scan --exclusions-file exclusions.yml --input-file examples/files/example.json --output examples/files/
```

## Hadolint | Scans Dockerfiles for good linting practices

[GitHub](https://github.com/hadolint/hadolint) | [Scan](https://hadolint.github.io/hadolint)

**Static | Analysis | Dockerfile**

A smarter Dockerfile linter that helps you build [best practice](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices) Docker images. The linter parses
the Dockerfile into an AST and performs rules on top of the AST. It stands on the shoulders of
[ShellCheck](https://github.com/koalaman/shellcheck) to lint the Bash code inside `RUN` instructions.

Usage is very simple, to quickstart you can just feed a Dockerfile to it!

```bash
wanderer@trg $ hadolint Dockerfile
Dockerfile:5 DL3009 info: Delete the apt-get lists after installing something
Dockerfile:8 DL3015 info: Avoid additional packages by specifying `--no-install-recommends`
Dockerfile:8 DL3008 warning: Pin versions in apt get install. Instead of `apt-get install <package>` use `apt-get install <package>=<version>`
Dockerfile:8 DL3059 info: Multiple consecutive `RUN` instructions. Consider consolidation.
```

## Dockle | Container image linter for security

[GitHub](https://github.com/goodwithtech/dockle) | [Website](https://containers.goodwith.tech/) | [Action](https://github.com/goodwithtech/dockle-action)
Docker | Linter

1. Build [Best Practice](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/) Docker images
2. Build secure Docker images
Checkpoints includes [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/)

```bash
# Scan an image name (and a tag)
dockle goodwithtech/test-image:v1

# Scan an image file
docker save alpine:latest -o alpine.tar
dockle --input alpine.tar
```

For more examples go to their [docs](https://github.com/goodwithtech/dockle?tab=readme-ov-file#common-examples).

## DependencyCheck | Checks for public vulns on dependencies

[GitHub](https://github.com/jeremylong/DependencyCheck)

**Scanner | Dependencies | Generic**

OWASP dependency-check is a software composition analysis utility that detects publicly disclosed
vulnerabilities in application dependencies. Requires access to several externally hosted resources.
For more information.

In order to analyze some technology stacks dependency-check may require other development tools to
be installed. Some of the analysis listed below may be experimental and require the experimental
analyzers to be enabled.

1. To analyze .NET Assemblies the dotnet 8 run time or SDK must be installed. Assemblies targeting
   other run times can be analyzed - but 8 is required to run the analysis.
1. If analyzing GoLang projects `go` must be installed.
1. The analysis of `Elixir` projects requires `mix_audit`.
1. The analysis of `npm`, `pnpm`, and `yarn` projects requires `npm`, `pnpm`, or `yarn` to be
   installed. The analysis performed utilize the respective `audit` feature of each. It also uses
   RetireJS.
1. The analysis of Ruby is a wrapper around `bundle-audit`, which must be installed.

Currently, only analysis 2 and 4 have been prioritized given the nature of the repo.

```bash
dependency-check --out . --scan [path to files to be scanned]
```

The documentation suggests you obtain an NVD API Key from [NIST](https://nvd.nist.gov/developers/request-an-api-key) in order to download the database faster.
You can do that if you want, otherwise you'll have to wait a little.

## nodejsscan | NodeJS application code scanner

[GitHub](https://github.com/ajinabraham/NodeJsScan)

**Static Analyzer | NodeJS | Semgrep**

Static security code scanner (SAST) for Node.js applications powered by [libsast](https://github.com/ajinabraham/libsast) and [semgrep](https://github.com/returntocorp/semgrep).

```bash
nodejssscan -d path/to/nodejs/project/
```

## Lavamoat | JS framework to prevent supply-chain attacks

[GitHub](https://github.com/LavaMoat/lavamoat)

**Framework | Dependency | NodeJS**

Tools for sandboxing your dependency graph. This tool works differently, it is not something that
works "right" out of the box as you would say, not at least compared to the rest of the tools here.
But it is very effective on preventing supply chain attacks.

There's really no quick start. You need to install it on your project directly.

```bash
pnpm install --save-dev lavamoat
```

Initialize it.

```bash
npx lavamoat init
```

This generates a `lavamoat/node/policy.json` file, which will contain permissions for each
dependency. You can edit it, and set permissions for each package according to your security needs.
For example:

```json
{
  "resources": {
    "lodash": {
      "globals": {
        "process": true,
        "console": true
      },
      "packages": {
        "fs": false
      }
    }
  }
}
```

In this example, `lodash` is allowed to use `process` and `console` but not `fs` (file system).

Run your project with LavaMoat, which will enforce policies at runtime:

```bash
npx lavamoat node index.js # index.js or whatever is your entry-point.
```

When you add new dependencies or update existing ones, to regenerate the policy file with any new
dependencies run:

```bash
npx lavamoat update
```

Add a script in `package.json` to simplify running LavaMoat:

```json
"scripts": {
  "start": "lavamoat node index.js",
  "lavamoat-init": "lavamoat init",
  "lavamoat-update": "lavamoat update"
}

```

Now you can use `npm run start` to run LavaMoat instead of the full command.

Check the LavaMoat documentation for more advanced options, such as:

- Defining custom modules
- Setting up LavaMoat for browser environments
- Using sandboxed environments

## NodeJS specific tools

### retirejs | Vuln scanner for JS

[GitHub](https://github.com/RetireJS/retire.js) | [Website](https://retirejs.github.io/retire.js/)

**Scanner | Vulns | JavaScript**

Scanner detecting the use of JavaScript libraries with known vulnerabilities.

Just run `retire` inside any project.

### installed-check | Verifies modules are in tune with reqs in package.json

[npm](https://www.npmjs.com/package/installed-check) | [GitHub](https://github.com/voxpelli/node-installed-check)

**Checker | Modules | NodeJS**

Verifies that installed modules comply with the requirements specified in package.json.

By default checks engine ranges, peer dependency ranges and installed versions and, in mono-repos
using workspaces, by default checks all workspaces as well as the workspace root.

Just run it inside your repo and that's it. Here's an example using

```bash
# Ignore dev deps, treat warning as errors, and try to fix writing to disk.
installed-check --ignore-dev --strict --fix
# equivalent to
installed-check -d -s --fix 
```

For more uses, check out the official documentation.

### better-npm-audit | npm audit++

[npm](https://www.npmjs.com/package/better-npm-audit) | [GitHub](https://github.com/jeemok/better-npm-audit)

**Checker | NodeJS**

Provides additional features on top of the existing npm audit options.

Just run the command as you'd run `npm audit` inside a project.

```bash
better-npm-audit audit
```

Better yet, replace audit with this script so you can run it with `npm audit` instead:

```json
"scripts": {
  "prepush": "npm run test && npm run audit",
  "audit": "better-npm-audit audit"
}
```

### eslint-plugin-security | JS plugin to identify potential hotspots

[npm](https://www.npmjs.com/package/eslint-plugin-security) | [GitHub](https://github.com/eslint-community/eslint-plugin-security)

**Plugin | NodeJS**

ESLint rules for Node Security. This project will help identify potential security hotspots, but
finds a lot of false positives which need triage by a human. It also has TypeScript suppport.

```bash
npm install --save-dev eslint-plugin-security
# or
yarn add --dev eslint-plugin-security
```

**Flat config** (requires eslint >= v8.23.0) Add the following to your eslint.config.js file:

```js
const pluginSecurity = require('eslint-plugin-security');

module.exports = [pluginSecurity.configs.recommended];

```

For **eslintrc** config, and more, checkout their github.

### eslint-plugin-no-unsanitized | ESLint rule to disallow unsafe patterns

[npm](https://www.npmjs.com/package/eslint-plugin-no-unsanitized) | [GitHub](https://github.com/mozilla/eslint-plugin-no-unsanitized/issues)

**Plugin | NodeJS**

Custom ESLint rule to disallow unsafe innerHTML, outerHTML, insertAdjacentHTML and alike.

```bash
yarn add -D eslint-plugin-no-unsanitized
npm install --save-dev eslint-plugin-no-unsanitized
```

For a **Flat config**:

```js
import nounsanitized from "eslint-plugin-no-unsanitized";

export default config = [nounsanitized.configs.recommended];
```

For **eslintrc** config, and rules selection, checkout their github.

### eslint-plugin-no-secrets | ESLint plugin to find secrets

[npm](https://www.npmjs.com/package/eslint-plugin-no-secrets) | [GitHub](https://github.com/nickdeis/eslint-plugin-no-secrets)

**Plugin | NodeJS**

An ESLint plugin to find strings that might be secrets/credentials.

**Flat config** below:

```js
import noSecrets from "eslint-plugin-no-secrets";

export default [
  {
    files: ["**/*.js"],
    plugins: {
      "no-secrets": noSecrets,
    },
    rules: {
      "no-secrets/no-secrets": "error",
    },
  },
];
```

Refer to the documentation to decrease the tolerance for entropy, and add patterns to check for
certain token formats.

### node-version-audit | Checks node's version for CVEs

[npm](https://www.npmjs.com/package/node-version-audit) | [GitHub](https://github.com/lightswitch05/node-version-audit)

**Checker | NodeJS**

Node Version Audit is a tool to check Node.js version against a regularly updated list of CVE
exploits, new releases, and end of life dates.

```bash
node-version-audit --fail-security
```

Check their documentation for more options, or just append `--help`.

### yarn-audit-fix | Fixes issues found while yarn auditing

[npm](https://www.npmjs.com/package/yarn-audit-fix) | [GitHub](https://github.com/antongolub/yarn-audit-fix)

**audit | NodeJS**

The missing yarn audit fix.

```bash
yarn-audit-fix --opts
```

For a better understanding of the options, checkout their repo.

## GitHub actions

### List of secure measures for your repo

[GitHub](https://github.com/step-security/secure-repo) | [Live](https://app.stepsecurity.io/)

**List | Measures**

Orchestrate GitHub Actions Security. A catalog of fixes and proactive measures to harden you
repository. Creators of the harden-runner below.

### harden-runner | Prevent exfiltration, tampering, backdoors

[GitHub](https://github.com/step-security/harden-runner) | [Action](https://github.com/marketplace/actions/harden-runner)

**Runners | Multi-purpose**

Network egress filtering and runtime security for GitHub-hosted and self-hosted runners.

There are two main threats from compromised workflows, dependencies, and build tools in a CI/CD
environment:

- Exfiltration of CI/CD credentials and source code
- Tampering of source code, dependencies, or artifacts during the build to inject a backdoor

Harden-Runner monitors process, file, and network activity to:

|     | Countermeasure                                                                                                                                                    | Prevent Security Breach                                                                                                                                                                                                                                                                                                                                       |
| --- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1.  | Monitor and block outbound network traffic at the DNS, HTTPS (Layer 7), and network layers (Layers 3 and 4) to prevent exfiltration of code and CI/CD credentials | To prevent the [Codecov breach](https://github.com/step-security/github-actions-goat/blob/main/docs/Vulnerabilities/ExfiltratingCICDSecrets.md) scenario                                                                                                                                                                                                      |
| 2.  | Detect if source code is being tampered during the build process to inject a backdoor                                                                             | To detect the [XZ Utils](https://www.stepsecurity.io/blog/analysis-of-backdoored-xz-utils-build-process-with-harden-runner) and [SolarWinds incident](https://github.com/step-security/github-actions-goat/blob/main/docs/Vulnerabilities/TamperingDuringBuild.md) scenarios                                                                                  |
| 3.  | Detect poisoned workflows and compromised dependencies that exhibit suspicious behavior                                                                           | To detect [Dependency confusion](https://github.com/step-security/github-actions-goat/blob/main/docs/Vulnerabilities/ExfiltratingCICDSecrets.md#dependency-confusion-attacks) and [Malicious dependencies](https://github.com/step-security/github-actions-goat/blob/main/docs/Vulnerabilities/ExfiltratingCICDSecrets.md#compromised-dependencies) scenarios |
| 4.  | Determine minimum GITHUB_TOKEN permissions by monitoring HTTPS calls to GitHub APIs                                                                               | To set [minimum GITHUB_TOKEN permissions](https://www.stepsecurity.io/blog/determine-minimum-github-token-permissions-using-ebpf-with-stepsecurity-harden-runner) to reduce the impact of exfiltration                                                                                                                                                                                                                                                                                  |

### wait-for-secrets | MFA for GHA

[GitHub](https://github.com/step-security/wait-for-secrets) | [Action](https://github.com/marketplace/actions/wait-for-secrets)

**Access control | MFA**

Publish from GitHub Actions using multi-factor authentication. It's like 2fa for GHA.

### Snyk Actions | Snyk's set of actions to check for vulns and more

[GitHub](https://github.com/snyk/actions) | [Action](https://github.com/marketplace/actions/snyk)

**Checker | Vulns | Code**

A set of GitHub Action for using Snyk to check for vulnerabilities in your GitHub projects. A
different action is required depending on which language or build tool you are using.

### KICS Action | Static code analysis for IaC

[Action](https://github.com/marketplace/actions/kics-github-action)

**Static Analysis | IaC**

Keeping Infrastructure as Code Secure (in short KICS) is a must-have for any cloud native project.
With KICS, finding security vulnerabilities, compliance issues, and infrastructure misconfigurations
happens early in the development cycle, when fixing these is straightforward and cheap.

### Legitify Action | Analyze your repo for misconfigs & compliance issues

[Action](https://github.com/marketplace/actions/legitify-analyze)

**Scan | Misconfigs | Compliance**

Strengthen the security posture of your source-code management! Detect and remediate
misconfigurations, security and compliance issues across all your GitHub and GitLab assets with
ease.

### Trivy Action | Add a thorough vuln scan to your CI/CD

[Action](https://github.com/aquasecurity/trivy-action)

**Scan | Multi-purpose**

Runs Trivy as GitHub action to scan your Docker container image for vulnerabilities.

### 2ms Action | Apply too many secrets to your workflow

[Workflow](https://github.com/Checkmarx/2ms/blob/master/.github/workflows/release.yml)

**Scan | Secrets**

### GitLeaks Action | Add gitleaks as a github action

[Action](https://github.com/gitleaks/gitleaks-action)

**Scan | Secrets**

### Trufflehog Action | Continuously scan for secrets

[Action](https://github.com/marketplace/actions/trufflehog-oss)

**Scan | Secrets**

### Dockle action | Cointinuously scan for security issues in Docker files

[Action](https://github.com/marketplace/actions/dockle-container-image-linter)

## Online version of some tools

- [Scan a repo with **KICS**](https://kics.checkmarx.net/) - upt to 4mb
- [Scan your Dockerfile with **Hadolint**](https://hadolint.github.io/hadolint)
- [Scan your GitHub Actions](https://app.stepsecurity.io/) with StepSecurity