<!-- markdownlint-disable -->

# Hardening Report: appleboy--telegram-action/v0.0.9

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **appleboy--telegram-action/v0.0.9** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow file uses mutable branch refs (@master) instead of pinned 40-character commit SHAs. This means the action could be silently updated to run malicious code. Failing references: `actions/checkout@master` (line 7) and `appleboy/telegram-action@master` (lines 9, 18, 29, 36, 43, 51, 58, 66, 73).

Locations:

- `.github/workflows/ci.yml:7`
- `.github/workflows/ci.yml:9`
- `.github/workflows/ci.yml:18`
- `.github/workflows/ci.yml:29`
- `.github/workflows/ci.yml:36`
- `.github/workflows/ci.yml:43`
- `.github/workflows/ci.yml:51`
- `.github/workflows/ci.yml:58`
- `.github/workflows/ci.yml:66`
- `.github/workflows/ci.yml:73`

### missing-permissions (severity: medium)

The workflow file `.github/workflows/ci.yml` has no top-level `permissions:` key and the `build` job also has no job-level `permissions:` key. Without explicit permissions, the workflow inherits the default (potentially broad) repository permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/ci.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Pinned all action references to full 40-character commit SHAs: actions/checkout@master → @61b9e3751b92087fd0b06925ba6dd6314e06f089 and appleboy/telegram-action@master → @78c9ef35ffccfe74d3b32e26efcd34c2e283238a (9 occurrences). Added `permissions: {}` at both the top-level workflow and the `build` job level to enforce least-privilege — the workflow only sends Telegram messages via secrets and requires no GitHub token permissions. Commented-out steps were left as-is since they don't execute.

