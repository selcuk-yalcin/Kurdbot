#!/usr/bin/env bash
# PLACEHOLDER — bootstrap script (not implemented yet)
#
# Purpose: Optional one-command setup helper for local/dev environments.
#
# Planned steps (manual equivalent in SPEC.md):
#
#   1. Check prerequisites (docker, docker compose, git)
#   2. Copy .env.example → .env if .env missing; warn to fill secrets
#   3. Print reminders for Ollama (install, pull llama3.1:8b, create kurdish-bot)
#   4. docker compose up -d
#   5. Print test URLs and checklist (localhost:3080, curl Ollama tags)
#
# Ollama setup stays on the model server — this script does not install Ollama.
