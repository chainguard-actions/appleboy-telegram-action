<!-- markdownlint-disable -->

# Hardening Report: appleboy--telegram-action/v1.1.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **appleboy--telegram-action/v1.1.2** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

action.yml runs.image points to a mutable tag instead of a SHA digest: `image: 'docker://ghcr.io/appleboy/telegram-action:1.1.2'`. Pin it to a digest, e.g. ghcr.io/appleboy/telegram-action@sha256:<digest> # 1.1.2.

Locations:

- `action.yml:44`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses

**Notes:**

Pinned runs.image in action.yml to docker://ghcr.io/appleboy/telegram-action:1.1.2@sha256:64d32cc2b1fe4c7792c849fa84d42f959cc95041d73d605ff92585fda8ddb2b0.

