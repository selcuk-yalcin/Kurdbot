# Kurdish Chatbot (Kurmancî)

A Kurdish-only (Kurmancî) chatbot built on **LibreChat** + **Ollama** + optional **Tavily**.

**Clarity:** What is already built vs what Cem does → **[WHO-DOES-WHAT.md](./WHO-DOES-WHAT.md)**.

---

## Ready now — one Compose file

Everything for a **local PC** test is in a **single** [`docker-compose.yml`](./docker-compose.yml):

`librechat` + `mongodb` + `redis` + `ollama`

**Local chatbot model:** `llama3.2:3b`

```bash
git pull
cp .env.example .env
docker compose up -d
docker compose exec ollama ollama pull llama3.2:3b
# → http://localhost:3080
```

Cem’s run-and-verify task: **[#21](https://github.com/selcuk-yalcin/Kurdbot/issues/21)**

---

## Architecture

```
User → LibreChat (Web UI) → Backend API → Ollama (in Compose, or remote later)
                                       ↘ Tavily Search API (optional)
```

| Component | Choice | Notes |
|-----------|--------|-------|
| Web UI | LibreChat | In Compose |
| LLM | Ollama | In Compose for local; remote GPU later |
| Local model | `llama3.2:3b` | Laptop-friendly smoke test |
| Production model | `kurdish-bot` (`llama3.1:8b`) | After Modelfile #2 + server #7 |
| Web Search | Tavily | Optional; key from Cem #6 |
| Database | MongoDB 7 | In Compose |
| Cache | Redis 7 | In Compose |

---

## System Requirements

### Local PC (issue #21)

- Docker Desktop or Docker Engine + Compose
- ~8 GB RAM recommended
- ~5 GB disk for images + `llama3.2:3b`

### Later — model server (issues #1, #7)

| Resource | Minimum | Recommended |
|----------|---------|-------------|
| RAM | 16 GB (8B model) | 32 GB |
| GPU | Optional | NVIDIA with CUDA 12+ |
| Disk | 20–50 GB | For model weights |
| OS | Ubuntu 22.04 | LTS |

---

## Repository Structure

```
Kurdbot/
├── docker-compose.yml      # ✅ single stack (LibreChat + Mongo + Redis + Ollama)
├── .env.example
├── WHO-DOES-WHAT.md        # Selçuk ready vs Cem tasks
├── ASSIGNMENTS.md
├── ISSUES.md
├── README.md
├── SPEC.md
├── TODO.md
├── STRUCTURE.md
├── RESOURCES.md
├── librechat/
│   └── librechat.yaml
├── model-server/
│   └── Modelfile           # still placeholder (#2)
└── scripts/
    ├── pull-local-model.sh # ✅
    └── setup.sh            # placeholder (#9)
```

---

## Environment Variables

| Variable | Description | Local example |
|----------|-------------|-----------------|
| `MONGO_URI` | MongoDB | `mongodb://mongodb:27017/LibreChat` |
| `REDIS_URI` | Redis | `redis://redis:6379` |
| `OLLAMA_BASE_URL` | Ollama API | `http://ollama:11434` (in Compose) |
| `TAVILY_API_KEY` | Tavily (optional at first) | from #6 |
| `JWT_SECRET` / `JWT_REFRESH_SECRET` | Auth | `openssl rand -hex 32` |
| `CREDS_KEY` / `CREDS_IV` | Encryption (32 / 16 chars) | openssl |

Copy `.env.example` → `.env`. Never commit `.env`.

---

## Testing Checklist

| # | Check | Command / URL |
|---|--------|----------------|
| 1 | Containers up | `docker compose ps` |
| 2 | Model present | `docker compose exec ollama ollama list` |
| 3 | Ollama API | `curl http://localhost:11434/api/tags` |
| 4 | LibreChat UI | `http://localhost:3080` |
| 5 | Chat reply | Send any message in UI |

---

## Behavior

- System prompt asks for **Kurmancî-only** replies (quality on `llama3.2:3b` may be weak — OK for smoke test).
- Production Kurdish quality comes with `kurdish-bot` / `llama3.1:8b` later.

---

## Documentation

- **[WHO-DOES-WHAT.md](./WHO-DOES-WHAT.md)** — Ready stack vs Cem’s issues (start here)
- **[ISSUES.md](./ISSUES.md)** — Full GitHub issues list
- **[ASSIGNMENTS.md](./ASSIGNMENTS.md)** — Issues by person
- **[RESOURCES.md](./RESOURCES.md)** — External links
- **[STRUCTURE.md](./STRUCTURE.md)** — File map
- **[SPEC.md](./SPEC.md)** — Technical specification
- **[TODO.md](./TODO.md)** — Checklist

---

## License

TBD — issue [#19](https://github.com/selcuk-yalcin/Kurdbot/issues/19).
