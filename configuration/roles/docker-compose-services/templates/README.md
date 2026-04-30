# templates (deprecated)

> **This role is deprecated.**

## Why it was deprecated

This role was originally a catch-all mega-role that deployed every Docker Compose service from a single place. As the number of services grew, it became harder to maintain:

- **No isolation** — deploying one service required running the entire role or carefully scoping tags; a mistake in one service's tasks could affect others.
- **No reusability** — variables and templates were tightly coupled to this role, making it impossible to deploy a single service independently.
- **Hard to extend** — adding a new service meant touching shared files (`tasks/main.yaml`, `defaults/main.yml`) rather than creating a self-contained unit.
