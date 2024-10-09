# Container OSS DevOps Security Tools
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

<details>
<summary><strong>Tools included in this container</strong></summary>

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

- [x] Vulnerability scanners:
    - [x] trivy: Find vulnerabilities, misconfigurations, secrets, SBOM in containers, Kubernetes,
      code repositories, clouds and more. (https://github.com/aquasecurity/trivy)
    - [x] clair: Vulnerability Static Analysis for Containers. (https://github.com/quay/clair)
    - [x] snyk: Snyk CLI scans and monitors your projects for security vulnerabilities.
      (https://github.com/snyk/cli)
    - [x] grype: A vulnerability scanner for container images and filesystems.
      (https://github.com/anchore/grype/)
    - [x] falco: Cloud Native Runtime Security. (https://github.com/falcosecurity/falco)

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

- [x] Misconfigurations:
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

</details>

# How to use the tools inside

## GitXray
[GitHub](https://github.com/kulkansecurity/gitxray) | [Website](https://www.gitxray.com/)
OSINT | Forensics | GitHub

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

**Documentation**
- [https://kulkansecurity.github.io/gitxray/](https://kulkansecurity.github.io/gitxray/)
- [https://www.gitxray.com/](https://www.gitxray.com/)

## GitHub fake analyzer

[GitHub](https://github.com/shortdoom/gh-fake-analyzer)
OSINT | GitHub | Script

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


## git-secrets

[GitHub](https://github.com/awslabs/git-secrets)
Secrets | git | git-hook

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

## Trufflehog

[GitHub](https://github.com/trufflesecurity/trufflehog) | [Action](https://github.com/marketplace/actions/trufflehog-oss)
Secrets | Analysis | Various


Find, verify, and analyze leaked credentials.

To start with the wizardm you can run `sudo trufflehog` and follow the steps! But if you want a
specific command, you can run each of them manually. Check `--help` to see them all. You can scan
from git, to s3/gcs buckets; docker images, CIs, and even your filesystem.

```
trufflehog --no-update git https://github.com/trufflesecurity/test_keys --only-verified
```

## Gitleaks

[GitHub](https://github.com/gitleaks/gitleaks) | [Action](https://github.com/gitleaks/gitleaks-action)
Secrets | git

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


## 2ms

[GitHub](https://github.com/Checkmarx/2ms) | [Action](https://github.com/Checkmarx/2ms/blob/master/.github/workflows/release.yml) | [Azure](https://learn.microsoft.com/en-us/azure/devops/pipelines/create-first-pipeline)
Secrets | Various

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

## detect-secrets

[GitHub](https://github.com/Yelp/detect-secrets)
Secrets | Various

detect-secrets is an aptly named module for (surprise, surprise) detecting secrets within a code base.

However, unlike other similar packages that solely focus on finding secrets, this package is designed with the enterprise client in mind: providing a backwards compatible, systematic means of:
- Preventing new secrets from entering the code base,
- Detecting if such preventions are explicitly bypassed, and
- Providing a checklist of secrets to roll, and migrate off to a more secure storage.

**Quickstart:**

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

## Trivy

[GitHub](https://github.com/aquasecurity/trivy) | [Action](https://github.com/aquasecurity/trivy-action) | [VSCode](https://github.com/aquasecurity/trivy-vscode-extension)
Scanner | Vulns | Secrets | Misconfigs | Code | IaC

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

## Clair (WIP - NOT WORKING)

[GitHub](https://github.com/quay/clair)
Static Analysis | Containers

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

## Snyk

[GitHub](https://github.com/snyk/cli) | [Website](https://snyk.io/)
Monitor | Scanner | Cloud | IaC

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


## Grype

[GitHub](https://github.com/anchore/grype/)
Scanner | Containers | Fs

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


## Falco (WIP)

[GitHub](https://github.com/falcosecurity/falco) | [Website](https://falco.org/)
Monitor | Monitor | Containers

Falco is a cloud native runtime security tool for Linux operating systems. It is designed to detect
and alert on abnormal behavior and potential security threats in real-time.

At its core, Falco is a kernel monitoring and detection agent that observes events, such as
syscalls, based on custom rules. Falco can enhance these events by integrating metadata from the
container runtime and Kubernetes. The collected events can be analyzed off-host in SIEM or data lake
systems.

Falco comes with its own container. Current instructions on how to run it are incomplete. Come back
later dear wanderer!

## Semgrep

[GitHub](https://github.com/semgrep/semgrep) | [Website](https://semgrep.dev)
Static Analysis | General purpose

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

**More information**

Semgrep has an entire ecosystem which consists of the following: Code, Supply Chain, Secrets, Appsec Platform, OSS Engine. They provide a range of resources for you to run analysis and scan from vulnerabilities to secrets.

To learn more about Semgrep, visit:

- [Semgrep Playground](https://semgrep.dev/editor) - An online interactive tool for writing and sharing rules.
- [Semgrep Registry](https://semgrep.dev/explore) - 2,000+ community-driven rules covering security, correctness, and dependency vulnerabilities.

## sast-scan (WIP)

[GitHub](https://github.com/marksarka/sast-scan)
Static Analysis | General purpose

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

## Legitify

[GitHub](https://github.com/Legit-Labs/legitify) | [Action](https://github.com/marketplace/actions/legitify-analyze)
Scanner | Misconfig | GitHub | GitLab

Detect and remediate misconfigurations and security risks across all your GitHub and GitLab assets.

```bash
legitify -t <your_token> analyze
SCM_TOKEN=<your_token> legitify analyze
```

1. To get the most out of legitify, you need to be an owner of at least one GitHub organization. Otherwise, you can still use the tool if you're an admin of at least one repository inside an organization, in which case you'll be able to see only repository-related policies results.
2. legitify requires a GitHub personal access token (PAT) to analyze your resources successfully, which can be either provided as an argument (`-t`) or as an environment variable (`SCM_TOKEN`).
   The PAT needs the following scopes for full analysis:

```
admin:org, read:enterprise, admin:org_hook, read:org, repo, read:repo_hook
```

See [Creating a Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) for more information.  
Fine-grained personal access tokens are currently not supported.


By default, legitify will check the policies against all your resources (organizations, repositories, members, actions). Archived repositories are skipped.

You can control which resources will be analyzed with command-line flags namespace and org:

- `--namespace (-n)`: will analyze policies that relate to the specified resources
- `--org`: will limit the analysis to the specified GitHub organizations or GitLab group, excluding archived repositories
- `--repo`: will limit the analysis to the specified GitHub repositories or GitLab projects
- `--scm`: specify the source code management platform. Possible values are: `github` or `gitlab`. Defaults to `github`. Please note: when running on GitLab, `--scm gitlab` is required.
- `--enterprise`: will specify which enterprises should be analyzed. Please note: in order to analyze an enterprise, an enterprise slug must be provided.

```bash
legitify -t <your_token> analyze --org org1,org2 --namespace organization,member
```

The above command will test organization and member policies against org1 and org2.

## KICS

[GitHub](https://github.com/Checkmarx/kics) | [Action](https://github.com/marketplace/actions/kics-github-action) | [Scan](https://kics.checkmarx.net/)
Scanner | Vulns | Misconfig | IaC

Find security vulnerabilities, compliance issues, and infrastructure misconfigurations early in the
development cycle of your infrastructure-as-code.

Using kics out of the box is really easy, just run:

```bash
kics scan -p path/to/project
```

To obtain the best out of this tool, you should go on reading:
-   [Understand how to configure KICS](configuration-file.md) so you can have a better KICS experience.
-   [Explore KICS commands](commands.md) to see what you can do with KICS.
-   [Explore supported platforms](platforms.md) to see which files you can scan with KICS.
-   [Explore the queries internals](queries.md) for better understanding how KICS works.
-   [Create a new query](creating-queries.md) to learn how to create your own custom queries.
-   [Explore the output results format](results.md) and quickly fix the issues detected.
-   [Contribute](CONTRIBUTING.md) if you want to go the extra mile.

## checkov

[GitHub](https://github.com/bridgecrewio/checkov)
Static Analysis | IaC | SCA

**Checkov** is a static code analysis tool for infrastructure as code (IaC) and also a software composition analysis (SCA) tool for images and open source packages.

It scans cloud infrastructure provisioned using [Terraform](https://terraform.io/), [Terraform plan](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Terraform%20Plan%20Scanning.md), [Cloudformation](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Cloudformation.md), [AWS SAM](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/AWS%20SAM.md), [Kubernetes](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Kubernetes.md), [Helm charts](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Helm.md), [Kustomize](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Kustomize.md), [Dockerfile](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Dockerfile.md),  [Serverless](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Serverless%20Framework.md), [Bicep](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Bicep.md), [OpenAPI](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/OpenAPI.md), [ARM Templates](https://github.com/bridgecrewio/checkov/blob/main/docs/7.Scan%20Examples/Azure%20ARM%20templates.md), or [OpenTofu](https://opentofu.org/) and detects security and compliance misconfigurations using graph-based scanning.

It performs [Software Composition Analysis (SCA) scanning](docs/7.Scan%20Examples/Sca.md) which is a scan of open source packages and images for Common Vulnerabilities and Exposures (CVEs).

**Configure an input folder or file**

```sh
checkov --directory /user/path/to/iac/code
```

Or a specific file or files

```sh
checkov --file /user/tf/example.tf
```
Or
```sh
checkov -f /user/cloudformation/example1.yml -f /user/cloudformation/example2.yml
```

For more examples take a look at the official repository.


## ScoutSuite

[GitHub](https://github.com/nccgroup/ScoutSuite)
Scanner | Risk Analysis | Cloud | Various

Scout Suite is an open source multi-cloud security-auditing tool, which enables security posture assessment of cloud environments. Using the APIs exposed by cloud providers, Scout Suite gathers configuration data for manual inspection and highlights risk areas. Rather than going through dozens of pages on the web consoles, Scout Suite presents a clear view of the attack surface automatically.

Scout Suite was designed by security consultants/auditors. It is meant to provide a point-in-time security-oriented view of the cloud account it was run in. Once the data has been gathered, all usage may be performed offline.

As such, it needs access to each one of the cloud services you want it to take a look.

Usage is really simple once you´ve configured credentials. Refer to the section of the wiki [Configuration and usage](https://github.com/nccgroup/ScoutSuite/wiki).

The command `scout` will return the list of available providers, although **Digital Ocean**` wasn't available to me when I last tried. Nevertheless, you can ask for help using `scout PROVIDER --help`

```bash
scout aws --help
# returns help on aws
scout aws --profile PROFILE
scout gcp --user-account
scout azure --cli
```


## Cloudsplaining

[GitHub](https://github.com/salesforce/cloudsplaining) | [ReadTheDocs](https://cloudsplaining.readthedocs.io/en/latest/)
Scanner | AWS IAM

Cloudsplaining is an AWS IAM Security Assessment tool that identifies violations of least privilege
and generates a risk-prioritized HTML report.

You must have AWS credentials configured that can be used by the CLI.

You must have the privileges to run `iam:GetAccountAuthorizationDetails`. The `arn:aws:iam::aws:policy/SecurityAudit` policy includes this, as do many others that allow Read access to the IAM Service.

To download the account authorization details, ensure you are authenticated to AWS, then run cloudsplaining's download command:

```bash
cloudsplaining download
```

If you prefer to use your `~/.aws/credentials` file instead of environment variables, you can specify the profile name:
```bash
cloudsplaining download --profile myprofile
```
It will download a JSON file in your current directory that contains your account authorization detail information.

Now that we've downloaded the account authorization file, we can scan all of the AWS IAM policies.

```bash
cloudsplaining scan --exclusions-file exclusions.yml --input-file examples/files/example.json --output examples/files/
```


## Hadolint

[GitHub](https://github.com/hadolint/hadolint) | [Scan](https://hadolint.github.io/hadolint)
Static Analysis | Dockerfile

A smarter Dockerfile linter that helps you build [best practice][] Docker images. The linter parses
the Dockerfile into an AST and performs rules on top of the AST. It stands on the shoulders of
[ShellCheck][] to lint the Bash code inside `RUN` instructions.

Usage is very simple, to quickstart you can just feed a Dockerfile to it!

```
wanderer@trg $ hadolint Dockerfile
Dockerfile:5 DL3009 info: Delete the apt-get lists after installing something
Dockerfile:8 DL3015 info: Avoid additional packages by specifying `--no-install-recommends`
Dockerfile:8 DL3008 warning: Pin versions in apt get install. Instead of `apt-get install <package>` use `apt-get install <package>=<version>`
Dockerfile:8 DL3059 info: Multiple consecutive `RUN` instructions. Consider consolidation.
```


## DependencyCheck

[GitHub](https://github.com/jeremylong/DependencyCheck)
Scanner | Dependencies | Generic

OWASP dependency-check is a software composition analysis utility that detects publicly disclosed
vulnerabilities in application dependencies.

```bash
dependency-check --out . --scan [path to jar files to be scanned]
```

**NVD API Key Highly Recommended**
Dependency-check has moved from using the NVD data-feed to the NVD API. Users of dependency-check are highly encouraged to obtain an NVD API Key; see https://nvd.nist.gov/developers/request-an-api-key Without an NVD API Key dependency-check's updates will be extremely slow. Please see the documentation for the cli, maven, gradle, or ant integrations on how to set the NVD API key.

## nodejsscan

[GitHub](https://github.com/ajinabraham/NodeJsScan)
Static Analyzer | NodeJS

A static security code scanner for Node.js applications.

```bash
nodejssscan -d path/to/nodejs/project/
```

## Lavamoat

[GitHub](https://github.com/LavaMoat/lavamoat)
Framework | Dependency | NodeJS

Tools for sandboxing your dependency graph. 

## NPM JS small packages

### retirejs

[GitHub](https://github.com/RetireJS/retire.js)
Scanner | Vulns | JavaScript

Scanner detecting the use of JavaScript libraries with known vulnerabilities.

Just run `retire` inside any project.

### npm audit

npm (by default)
Scanner | General purpose

This built-in npm command checks for vulnerabilities in your installed packages.

### installed-check

[npm](https://www.npmjs.com/package/installed-check)

Verifies that installed modules comply with the requirements specified in package.json.


### better-npm-audit

[npm](https://www.npmjs.com/package/better-npm-audit)

Provides additional features on top of the existing npm audit options.


### eslint-plugin-security

[npm](https://www.npmjs.com/package/eslint-plugin-security)

ESLint rules for Node Security. 

### eslint-plugin-no-unsanitized

[npm](https://www.npmjs.com/package/eslint-plugin-no-unsanitized)

Custom ESLint rule to disallow unsafe innerHTML, outerHTML, insertAdjacentHTML and alike.


### eslint-plugin-no-secrets

[npm](https://www.npmjs.com/package/eslint-plugin-no-secrets)

An ESLint plugin to find strings that might be secrets/credentials.


### node-version-audit

[npm](https://www.npmjs.com/package/node-version-audit

Node Version Audit is a tool to check Node.js version against a regularly updated list of CVE
exploits, new releases, and end of life dates.
)

### yarn-audit-fix

[npm](https://www.npmjs.com/package/yarn-audit-fix)

The missing yarn audit fix. 

### better-npm-audit

[npm](https://www.npmjs.com/package/better-npm-audit)

Additional features on top of the existing npm audit options.

## GitHub actions

### harden-runner

[GitHub](https://github.com/step-security/harden-runner)

Network egress filtering and runtime security for GitHub-hosted and self-hosted runners.

### secure-repo

[GitHub](https://github.com/step-security/secure-repo)

Orchestrate GitHub Actions Security. 


### wait-for-secrets

[GitHub](https://github.com/step-security/wait-for-secrets)

2fa for GHA. 

### Snyk Actions

[GitHub](https://github.com/snyk/actions)

A set of GitHub actions for checking your projects for vulnerabilities.


