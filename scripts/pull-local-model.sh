#!/usr/bin/env bash
# OWNER: @cem-acun — pull model into Cem's Ollama compose (model-server/)
# Usage (from repo root):
#   ./scripts/pull-local-model.sh
#   ./scripts/pull-local-model.sh llama3.2:1b
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MODEL="${1:-llama3.2:3b}"

echo "Pulling ${MODEL} via model-server/docker-compose.yml (Cem's Ollama)..."
docker compose -f "${ROOT}/model-server/docker-compose.yml" exec ollama ollama pull "${MODEL}"
docker compose -f "${ROOT}/model-server/docker-compose.yml" exec ollama ollama list
echo "Done. LibreChat .env should use: OLLAMA_BASE_URL=http://host.docker.internal:11434"
