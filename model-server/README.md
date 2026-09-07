# OWNER: @cem-acun
#
# Ollama model server — separate from the LibreChat app stack.
# App stack (Selçuk): ../docker-compose.yml
# This folder (Cem):   docker-compose.yml + Modelfile (#2 later)
#
# === Today (#21) — local laptop ===
#
#   cd model-server
#   docker compose up -d
#   docker compose exec ollama ollama pull llama3.2:3b
#   curl http://localhost:11434/api/tags
#   docker compose exec ollama ollama run llama3.2:3b "Hello"
#
# Then in repo root `.env` (LibreChat):
#   OLLAMA_BASE_URL=http://host.docker.internal:11434
#   docker compose up -d   # from repo root — Selçuk's stack
#
# === Later (#7) — production kurdish-bot ===
#
#   After Modelfile is ready (#2):
#   docker compose exec ollama ollama create kurdish-bot -f /modelfile/Modelfile
#
# Links: https://ollama.com/download · https://github.com/selcuk-yalcin/Kurdbot/issues/21
