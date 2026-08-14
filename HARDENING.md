<!-- markdownlint-disable -->

# Hardening Report: appleboy--telegram-action/v1.0.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **appleboy--telegram-action/v1.0.2** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple workflow files use tag-based (mutable) `uses:` references instead of pinned 40-character SHA commit digests. This exposes the workflow to supply-chain attacks if the referenced action tag is moved or compromised.

Failing references in ci.yml: `actions/checkout@v7`
Failing references in goreleaser.yml: `actions/checkout@v7`, `actions/setup-go@v7`, `goreleaser/goreleaser-action@v7`
Failing references in trivy.yml: `actions/checkout@v7`, `aquasecurity/trivy-action@v0.36.0` (×4), `github/codeql-action/upload-sarif@v4` (×2)

Locations:

- `.github/workflows/ci.yml:7`
- `.github/workflows/goreleaser.yml:14`
- `.github/workflows/goreleaser.yml:19`
- `.github/workflows/goreleaser.yml:23`
- `.github/workflows/trivy.yml:21`
- `.github/workflows/trivy.yml:26`
- `.github/workflows/trivy.yml:33`
- `.github/workflows/trivy.yml:38`
- `.github/workflows/trivy.yml:52`
- `.github/workflows/trivy.yml:57`
- `.github/workflows/trivy.yml:64`
- `.github/workflows/trivy.yml:72`

### missing-permissions (severity: medium)

The workflow file ci.yml has no top-level `permissions:` key and its only job (`build`) also has no job-level `permissions:` key. Without explicit permissions, the workflow runs with the default (potentially broad) token permissions, which may include write access to repository contents.

Locations:

- `.github/workflows/ci.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all unpinned `uses:` references by resolving real commit SHAs via lookup_action_sha and replacing mutable tags with pinned SHA@commit references (keeping original tag as a comment). Specifically: actions/checkout@v7 → @3d3c42e5aac5ba805825da76410c181273ba90b1, actions/setup-go@v7 → @b7ad1dad31e06c5925ef5d2fc7ad053ef454303e, goreleaser/goreleaser-action@v7 → @f06c13b6b1a9625abc9e6e439d9c05a8f2190e94, aquasecurity/trivy-action@v0.36.0 → @ed142fd0673e97e23eac54620cfb913e5ce36c25, github/codeql-action/upload-sarif@v4 → @ff2f1c621b7f889edc0d3c761ac2e6a3f8cdb0dd. Also added `permissions: {}` top-level block to ci.yml which had no permissions key (goreleaser.yml and trivy.yml already had appropriate permissions blocks).

