# Repository Structure

Map of every file and directory in this project — what it is, where it lives, and when it gets used.

```
Kurdbot/
│
├── README.md                 # Project overview, quick start, env table, test checklist
├── SPEC.md                   # Full technical specification (architecture, configs, security)
├── TODO.md                   # Phased implementation checklist
├── ISSUES.md                 # Full GitHub issues list (snapshot from GitHub)
├── ASSIGNMENTS.md            # Open issues grouped by assignee (Selçuk / Cem)
├── STRUCTURE.md              # This file — directory map and file responsibilities
│
├── docker-compose.yml        # ✅ Single stack: LibreChat + MongoDB + Redis + Ollama
├── .env.example              # Template for secrets (copy → .env)
├── .gitignore
├── WHO-DOES-WHAT.md          # Ready Compose vs Cem’s issue tasks
├── ASSIGNMENTS.md
├── ISSUES.md
├── README.md
├── SPEC.md
├── TODO.md
├── STRUCTURE.md
├── RESOURCES.md
│
├── model-server/
│   └── Modelfile             # [TODO] Ollama custom model (kurdish-bot from llama3.1:8b)
│
└── scripts/
    └── setup.sh              # [TODO] Optional bootstrap: checks, pulls model, starts stack
```

---

## Root files

| File | Role | Used by | Status |
|------|------|---------|--------|
| `README.md` | Entry point for humans: architecture, requirements, links | Developers, deployers | Done |
| `SPEC.md` | Authoritative design doc; config shapes and setup order | Implementers | Done |
| `TODO.md` | Track what is built vs pending | Project owner | Done |
| `ISSUES.md` | Full list of GitHub issues (#1–#20) | Anyone tracking work | Done |
| `ASSIGNMENTS.md` | Issues by person + hand-offs | Selçuk, Cem | Done |
| `STRUCTURE.md` | Explains layout before code lands | Anyone onboarding | Done |
| `docker-compose.yml` | **Single** stack: librechat, mongodb, redis, ollama | `docker compose up` | Done |
| `WHO-DOES-WHAT.md` | Ready work vs Cem’s tasks | Team | Done |
| `.env.example` | Documents required env vars with safe placeholders | Copied to `.env` locally | Done |
| `.gitignore` | Excludes secrets, logs, Docker volume data | Git | Done |

---

## `librechat/`

LibreChat-specific configuration mounted into the container.

| File | Role | Details |
|------|------|---------|
| `librechat.yaml` | LibreChat runtime config | Ollama custom endpoint → `kurdish-bot`; enforce Kurdish-only model spec; Tavily via `webSearch` |

**Mount path in container:** `./librechat/librechat.yaml` → `/app/librechat.yaml`

**Depends on:** `.env` values `OLLAMA_BASE_URL`, `TAVILY_API_KEY`

---

## `model-server/`

Everything related to the LLM on the Ollama host (usually a separate machine or GPU server).

| File | Role | Details |
|------|------|---------|
| `Modelfile` | Ollama model recipe | Base: `llama3.1:8b`; system prompt: Kurmancî-only; params: temperature, top_p |

**Used on model server (not inside Docker Compose stack):**

```text
ollama pull llama3.1:8b
ollama create kurdish-bot -f model-server/Modelfile
OLLAMA_HOST=0.0.0.0 ollama serve
```

**LibreChat connects via:** `OLLAMA_BASE_URL` in `.env` (e.g. `http://SERVER_IP:11434`)

---

## `scripts/`

Optional automation; not required if you follow manual steps in SPEC.md.

| File | Role | Details |
|------|------|---------|
| `setup.sh` | Bootstrap helper | May verify Docker, copy `.env.example` → `.env`, remind Ollama steps, run `docker compose up` |

---

## Local-only files (never committed)

| Path | Why |
|------|-----|
| `.env` | Real secrets: JWT, Tavily key, encryption keys |
| `*.log` | Runtime logs |
| `mongo_data/` | MongoDB persistent volume (if bind-mounted locally) |
| `redis_data/` | Redis persistent volume (if bind-mounted locally) |

---

## External dependencies (not in this repo)

| Component | Location | Notes |
|-----------|----------|-------|
| LibreChat image | `ghcr.io/danny-avila/librechat:latest` | Pulled by Docker Compose |
| Ollama + models | Model server host | Installed separately; not a Compose service in v0.1 |
| Tavily API | Cloud | API key in `.env` only |
| MongoDB / Redis | Docker Compose services | Defined in `docker-compose.yml` |

---

## Implementation order

1. `model-server/Modelfile` → create `kurdish-bot` on Ollama host  
2. `.env.example` → copy to `.env`, fill values  
3. `librechat/librechat.yaml` → point at Ollama + Tavily  
4. `docker-compose.yml` → start UI stack  
5. `scripts/setup.sh` → optional convenience wrapper  

See [TODO.md](./TODO.md) for the full checklist.
