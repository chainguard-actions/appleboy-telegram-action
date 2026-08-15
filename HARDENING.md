<!-- markdownlint-disable -->

# Hardening Report: appleboy--telegram-action/v0.1.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **appleboy--telegram-action/v0.1.1** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow uses `actions/checkout@master` — a mutable branch ref instead of a pinned 40-character commit SHA. This means the action could be silently updated to a different (potentially malicious) version without any change to the workflow file.

Locations:

- `.github/workflows/ci.yml:8`

### missing-permissions (severity: medium)

The workflow file has no top-level `permissions:` key and the `build` job also has no job-level `permissions:` key. Without explicit permissions, the workflow inherits the repository's default token permissions, which may be broader than necessary (e.g., write access to contents). A minimal permissions block such as `permissions: {}` or specific scopes should be added.

Locations:

- `.github/workflows/ci.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

In hardened/action/.github/workflows/ci.yml: (1) Pinned `actions/checkout@master` to the full commit SHA `61b9e3751b92087fd0b06925ba6dd6314e06f089` (keeping `# master` comment for readability). (2) Added `permissions: {}` at the top level of the workflow to enforce least-privilege — the workflow only uses local action references (`./`) and secrets, so no GitHub token permissions are required.

