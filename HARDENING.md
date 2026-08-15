<!-- markdownlint-disable -->

# Hardening Report: appleboy--telegram-action/v1.0.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **appleboy--telegram-action/v1.0.1** was hardened automatically. 4 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

ci.yml uses actions/checkout@master (branch ref, not a pinned SHA). All uses: references must be pinned to a full 40-character commit SHA to prevent supply-chain attacks.

Locations:

- `.github/workflows/ci.yml:8`

### unpinned-uses (severity: high)

goreleaser.yml uses three unpinned action references: actions/checkout@v4 (line 16), actions/setup-go@v5 (line 21), and goreleaser/goreleaser-action@v6 (line 26). Version tags are mutable and must be replaced with full 40-character commit SHAs.

Locations:

- `.github/workflows/goreleaser.yml:16`
- `.github/workflows/goreleaser.yml:21`
- `.github/workflows/goreleaser.yml:26`

### unpinned-uses (severity: high)

The Dockerfile (referenced by action.yml's `image: 'Dockerfile'`) pulls a mutable image tag: `FROM ghcr.io/appleboy/drone-telegram:1.4.0`. This tag can be silently updated to point to a different image. It must be replaced with a SHA digest reference, e.g. `ghcr.io/appleboy/drone-telegram@sha256:<64-hex-char-digest>`.

Locations:

- `Dockerfile:1`

### missing-permissions (severity: medium)

ci.yml has no top-level `permissions:` key and the single job (`build`) also has no `permissions:` key. Without explicit permissions, the workflow inherits the default (potentially write-all) token permissions. A minimal permissions block (e.g. `permissions: {}` or specific scopes) should be added.

Locations:

- `.github/workflows/ci.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all four findings:
1. ci.yml: Pinned `actions/checkout@master` to full SHA `61b9e3751b92087fd0b06925ba6dd6314e06f089` and added top-level `permissions: {}` block.
2. goreleaser.yml: Pinned `actions/checkout@v4` → `11d5960a326750d5838078e36cf38b85af677262`, `actions/setup-go@v5` → `40f1582b2485089dde7abd97c1529aa768e1baff`, and `goreleaser/goreleaser-action@v6` → `e435ccd777264be153ace6237001ef4d979d3a7a`. goreleaser.yml already had a `permissions: contents: write` block.
3. Dockerfile: Pinned base image `ghcr.io/appleboy/drone-telegram:1.4.0` with SHA digest `sha256:c026c8f95b925c4771fb44fee1ead2235b5b8f84abc47d09465f599c16808557`, keeping the tag inline.

