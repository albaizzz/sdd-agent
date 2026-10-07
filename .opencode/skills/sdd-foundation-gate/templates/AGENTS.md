# AGENTS.md — Coding SOP

> Project: `<PROJECT_NAME>`
> These rules apply to every AI agent and human contributor working on this repo.

## 1. Tech Stack & Versions
- Language: `<language>` `<version>`
- Framework: `<framework>` `<version>`
- Package manager: `<npm | pnpm | uv | go mod | ...>`

## 2. Project Structure Conventions
- `<folder layout — where what lives>`
- Naming: `<file/component/type naming rules>`

## 3. Code Style
- Lint: `<command>` (e.g. `npm run lint`)
- Formatting: `<formatter>`, config file: `<path>`
- Types: strict mode? explicit types required?
- Error handling: `<pattern, e.g. never swallow errors>`
- No comments unless asked? JSX/DSL conventions?

## 4. Testing
- Unit test command: `<command>`
- E2e/integration command: `<command>`
- Naming: `<test file naming>`
- Coverage requirement: `<threshold or none>`

## 5. Commands
- `dev`: `<command>`
- `build`: `<command>`
- `test`: `<command>`
- `lint`: `<command>`
- `typecheck`: `<command>`

## 6. Git Workflow
- Branch naming: `<e.g. feature/xxx>`
- Commit style: `<conventional commits? subject limit?>`
- PR conventions: `<template, reviewer required?>`

## 7. Do-Not Rules
- Forbidden patterns: `<e.g. no any, no lodash, no raw SQL in services>`
- Never commit: `.env`, secrets, credentials
- No force-push, no skipping tests/lint before merge
- `<other absolute rules>`

## 8. Environment & Secrets
- How env vars are loaded; where documented
- Secrets via `<vault | env | ...>` — never hardcoded