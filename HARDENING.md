<!-- markdownlint-disable -->

# Hardening Report: appleboy--telegram-action/v1.1.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **appleboy--telegram-action/v1.1.1** was hardened automatically. 3 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple unpinned action/image references found. In action.yml, the Docker image is referenced by a mutable tag (`docker://ghcr.io/appleboy/telegram-action:1.1.1`) instead of a SHA digest. In workflow files, all `uses:` references use version tags instead of full 40-character commit SHAs: `actions/checkout@v7` (ci.yml, docker.yml, goreleaser.yml, trivy.yml), `docker/setup-qemu-action@v4`, `docker/setup-buildx-action@v4`, `docker/login-action@v4`, `docker/metadata-action@v6`, `docker/build-push-action@v7` (docker.yml), `goreleaser/goreleaser-action@v7` (goreleaser.yml), `aquasecurity/trivy-action@v0.36.0` (trivy.yml, multiple steps), `github/codeql-action/upload-sarif@v4` (trivy.yml, multiple steps). None are pinned to immutable SHA digests, making them vulnerable to supply-chain attacks.

Locations:

- `action.yml:40`
- `.github/workflows/ci.yml:10`
- `.github/workflows/docker.yml:20`
- `.github/workflows/goreleaser.yml:14`
- `.github/workflows/trivy.yml:22`

### permissions (severity: medium)

missing-permissions: `.github/workflows/ci.yml` has no top-level `permissions:` key and none of its jobs (local-image, build) define a `permissions:` block. Without explicit permissions, the workflow inherits the default repository permissions, which may be overly broad.

Locations:

- `.github/workflows/ci.yml:1`

### script-injection (severity: high)

Sub-rule (a) violation: A GitHub Actions expression is directly interpolated inside a `run:` shell command string. In `.github/workflows/ci.yml`, the `run:` block of the 'send message via local image' step contains: `-e INPUT_MESSAGE="ci: local image smoke test for ${{ github.sha }}"`. The `${{ github.sha }}` expression is expanded by the Actions template engine before the shell sees it, allowing an attacker who can influence the SHA context (or similar expressions) to inject shell metacharacters. The value should be passed via an `env:` variable and referenced as `"$ENV_VAR"` in the shell script instead.

Locations:

- `.github/workflows/ci.yml:24`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, permissions, script-injection

**Notes:**

Fixed all three findings:

1. **unpinned-uses**: Pinned all action references to full 40-character commit SHAs:
   - action.yml: Docker image `ghcr.io/appleboy/telegram-action:1.1.1` pinned with SHA digest (preserving `docker://` scheme and tag)
   - ci.yml: `actions/checkout@v7` → SHA `3d3c42e5...`
   - docker.yml: `actions/checkout@v7`, `docker/setup-qemu-action@v4`, `docker/setup-buildx-action@v4`, `docker/login-action@v4`, `docker/metadata-action@v6`, `docker/build-push-action@v7` all pinned
   - goreleaser.yml: `actions/checkout@v7`, `goreleaser/goreleaser-action@v7` pinned
   - trivy.yml: `actions/checkout@v7` (×2), `aquasecurity/trivy-action@v0.36.0` (×3), `github/codeql-action/upload-sarif@v4` (×2) all pinned

2. **permissions**: Added `permissions: contents: read` top-level block to ci.yml.

3. **script-injection**: In ci.yml's 'send message via local image' step, moved `${{ github.sha }}` from the `run:` shell string into the `env:` block as `GITHUB_SHA`, then referenced it as `$GITHUB_SHA` in the shell script to prevent template injection.

