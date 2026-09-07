# Who Does What (avoid confusion)

Two lanes. Do not mix them.

---

## Lane A — App stack (Selçuk) ✅

**File:** [`docker-compose.yml`](./docker-compose.yml) (repo root)

| Service | Role |
|---------|------|
| `librechat` | Web UI + API |
| `mongodb` | Database |
| `redis` | Cache |

**No Ollama here.** LibreChat talks to Ollama via `OLLAMA_BASE_URL` in `.env`.

Also owned by Selçuk: `.env.example`, `librechat/librechat.yaml`

```bash
cp .env.example .env
# After Cem's Ollama is up:
# OLLAMA_BASE_URL=http://host.docker.internal:11434
docker compose up -d
# http://localhost:3080
```

Closed: [#3](https://github.com/selcuk-yalcin/Kurdbot/issues/3), [#4](https://github.com/selcuk-yalcin/Kurdbot/issues/4), [#5](https://github.com/selcuk-yalcin/Kurdbot/issues/5).

---

## Lane B — Ollama / model (Cem only) 👤

**File:** [`model-server/docker-compose.yml`](./model-server/docker-compose.yml)  
**Guide:** [`model-server/README.md`](./model-server/README.md)

Cem owns this Compose file and runs it himself.

| Priority | Issue | Task |
|----------|-------|------|
| **1 — today** | [#21](https://github.com/selcuk-yalcin/Kurdbot/issues/21) | Start Ollama compose + pull `llama3.2:3b` + prove API works |
| **2 — easy** | [#6](https://github.com/selcuk-yalcin/Kurdbot/issues/6) | Tavily API key |
| **3 — later** | [#1](https://github.com/selcuk-yalcin/Kurdbot/issues/1) | Bigger/GPU server |
| **4 — later** | [#7](https://github.com/selcuk-yalcin/Kurdbot/issues/7) | Production `kurdish-bot` |
| **5 — later** | [#8](https://github.com/selcuk-yalcin/Kurdbot/issues/8) | Firewall / expose Ollama |

**Cem today:**

```bash
cd model-server
docker compose up -d
docker compose exec ollama ollama pull llama3.2:3b
curl http://localhost:11434/api/tags
```

Then tell Selçuk that Ollama is on `http://localhost:11434` (LibreChat uses `host.docker.internal:11434`).

---

## Lane C — Still Selçuk

| Issue | Task |
|-------|------|
| [#2](https://github.com/selcuk-yalcin/Kurdbot/issues/2) | Real `Modelfile` |
| [#9](https://github.com/selcuk-yalcin/Kurdbot/issues/9) | `setup.sh` |
| [#19](https://github.com/selcuk-yalcin/Kurdbot/issues/19) | LICENSE |
| [#13](https://github.com/selcuk-yalcin/Kurdbot/issues/13) / [#15](https://github.com/selcuk-yalcin/Kurdbot/issues/15) | Kurdish QA |

---

## Rule of thumb

| Question | Answer |
|----------|--------|
| “Where is the chat app?” | Root `docker-compose.yml` (Selçuk) |
| “Where is the LLM?” | `model-server/docker-compose.yml` (**Cem**) |
| “What does Cem do today?” | **#21** (his Ollama compose) + optional **#6** |
| “One command for everything?” | No — **two** composes on purpose |

[ASSIGNMENTS.md](./ASSIGNMENTS.md) · [ISSUES.md](./ISSUES.md)
