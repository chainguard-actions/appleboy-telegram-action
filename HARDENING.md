<!-- markdownlint-disable -->

# Hardening Report: appleboy--telegram-action/v1.0.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **appleboy--telegram-action/v1.0.0** was hardened automatically. 2 finding(s) were identified and resolved across 2 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow uses `actions/checkout@master`, which pins to a mutable branch name rather than an immutable 40-character commit SHA. If the upstream action is compromised or the branch is force-pushed, the workflow will silently execute attacker-controlled code.

Locations:

- `.github/workflows/ci.yml:7`

### missing-permissions (severity: medium)

The workflow file has no top-level `permissions:` key and the only job (`build`) also has no `permissions:` key. Without explicit permissions, the workflow inherits the repository's default token permissions, which may be overly broad (e.g., write access to contents). A minimal explicit `permissions:` block should be added.

Locations:

- `.github/workflows/ci.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

1. Pinned `actions/checkout@master` to the full commit SHA `61b9e3751b92087fd0b06925ba6dd6314e06f089` with a `# master` comment for readability. 2. Added a top-level `permissions: contents: read` block to restrict the workflow token to the minimum required permissions (read-only access to repository contents for checkout).

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned the Dockerfile base image `appleboy/drone-telegram:1.4.0` to its immutable SHA256 digest: `FROM appleboy/drone-telegram:1.4.0@sha256:c026c8f95b925c4771fb44fee1ead2235b5b8f84abc47d09465f599c16808557`. The tag is preserved inline for readability while the digest ensures the exact image layer is always used.

