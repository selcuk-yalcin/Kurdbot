#!/usr/bin/env bash
# Pull the local chatbot model into the Compose Ollama service.
# Run after: docker compose up -d
set -euo pipefail

MODEL="${1:-llama3.2:3b}"

echo "Pulling ${MODEL} into kurdbot-ollama..."
docker compose exec ollama ollama pull "${MODEL}"
echo "Models:"
docker compose exec ollama ollama list
echo "Done. Open http://localhost:3080"
