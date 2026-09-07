# Repository Structure

Map of every file and directory — what it is and when it is used.

```
Kurdbot/
├── docker-compose.yml        # ✅ Single stack: LibreChat + Mongo + Redis + Ollama
├── .env.example              # Copy → .env
├── .gitignore
├── WHO-DOES-WHAT.md          # Ready Compose vs Cem’s issue tasks (start here)
├── README.md
├── SPEC.md
├── TODO.md
├── ISSUES.md
├── ASSIGNMENTS.md
├── STRUCTURE.md
├── RESOURCES.md
├── librechat/
│   └── librechat.yaml        # ✅ Ollama + Kurdish prompt + Tavily
├── model-server/
│   └── Modelfile             # ❌ Placeholder (#2)
└── scripts/
    ├── pull-local-model.sh   # ✅ Pull llama3.2:3b
    └── setup.sh              # ❌ Placeholder (#9)
```

---

## Root files

| File | Role | Status |
|------|------|--------|
| `docker-compose.yml` | **One** local stack for the whole app | Done |
| `WHO-DOES-WHAT.md` | Selçuk ready vs Cem tasks | Done |
| `.env.example` | Env template | Done |
| `README.md` | Quick start | Done |
| `SPEC.md` | Full spec + done/pending | Done |
| `ASSIGNMENTS.md` | Issues by person | Done |
| `ISSUES.md` | GitHub issue snapshot | Done |
| `RESOURCES.md` | External links | Done |
| `TODO.md` | Checklist | Done |
| `.gitignore` | Secrets / volumes ignored | Done |

---

## `librechat/`

| File | Role |
|------|------|
| `librechat.yaml` | Ollama endpoint, Kurdish system prompt, Tavily `webSearch` |

Mount: `./librechat/librechat.yaml` → `/app/librechat.yaml`

---

## `model-server/`

| File | Role |
|------|------|
| `Modelfile` | Production `kurdish-bot` recipe — still placeholder (#2) |

Mounted read-only into Ollama container at `/modelfile` for later `ollama create`.

---

## `scripts/`

| File | Role |
|------|------|
| `pull-local-model.sh` | `ollama pull llama3.2:3b` helper |
| `setup.sh` | Optional bootstrap — not implemented (#9) |

---

## Local-only (never commit)

`.env`, `*.log`, Docker named volumes (`mongo_data`, `redis_data`, `ollama_data`, …)

---

## Rule

- **App definition** = one `docker-compose.yml`
- **People’s jobs** = GitHub issues + [WHO-DOES-WHAT.md](./WHO-DOES-WHAT.md)
