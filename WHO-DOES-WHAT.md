# Who Does What (avoid confusion)

Two lanes. Do not mix them.

---

## Lane A — Ready in the repo (Selçuk)

**One file runs the local chatbot stack:**

[`docker-compose.yml`](./docker-compose.yml)

| Service | Role |
|---------|------|
| `librechat` | Web UI + API |
| `mongodb` | Database |
| `redis` | Cache |
| `ollama` | Local LLM |

**Related config (already written):**

| File | Role |
|------|------|
| `.env.example` | Copy → `.env` |
| `librechat/librechat.yaml` | Ollama + Kurdish prompt + Tavily |
| `scripts/pull-local-model.sh` | Pull `llama3.2:3b` |

**Local model:** `llama3.2:3b` (laptop-friendly)

**How to run (anyone):**

```bash
git pull
cp .env.example .env
docker compose up -d
docker compose exec ollama ollama pull llama3.2:3b
# open http://localhost:3080
```

Closed issues for this lane: [#3](https://github.com/selcuk-yalcin/Kurdbot/issues/3), [#4](https://github.com/selcuk-yalcin/Kurdbot/issues/4), [#5](https://github.com/selcuk-yalcin/Kurdbot/issues/5).

---

## Lane B — Cem’s tasks only (issues)

Cem does **not** need to redesign Compose. He **runs** Lane A and then does these jobs:

| Priority | Issue | Task | Needs |
|----------|-------|------|-------|
| **1 — today** | [#21](https://github.com/selcuk-yalcin/Kurdbot/issues/21) | Run Lane A on his PC; confirm chat works | Docker, ~8 GB RAM |
| **2 — easy** | [#6](https://github.com/selcuk-yalcin/Kurdbot/issues/6) | Get Tavily API key; share securely | Browser only |
| **3 — later** | [#1](https://github.com/selcuk-yalcin/Kurdbot/issues/1) | Rent/provision GPU or bigger server | Cloud account |
| **4 — later** | [#7](https://github.com/selcuk-yalcin/Kurdbot/issues/7) | Install production model `kurdish-bot` | #1 + Modelfile #2 |
| **5 — later** | [#8](https://github.com/selcuk-yalcin/Kurdbot/issues/8) | Expose Ollama safely | After #7 |
| Later | #11–#14, #16–#18 | Integration QA + production | After local works |

---

## Lane C — Still Selçuk (not blocking Cem’s #21)

| Issue | Task |
|-------|------|
| [#2](https://github.com/selcuk-yalcin/Kurdbot/issues/2) | Real `Modelfile` for production `kurdish-bot` |
| [#9](https://github.com/selcuk-yalcin/Kurdbot/issues/9) | `setup.sh` wrapper |
| [#19](https://github.com/selcuk-yalcin/Kurdbot/issues/19) | LICENSE |
| [#13](https://github.com/selcuk-yalcin/Kurdbot/issues/13) / [#15](https://github.com/selcuk-yalcin/Kurdbot/issues/15) | Kurdish QA after stack works |

---

## Rule of thumb

| Question | Answer |
|----------|--------|
| “Where is the app?” | `docker-compose.yml` |
| “What does Cem do today?” | Issue **#21** (run it) + optional **#6** |
| “Do we need Vast.ai today?” | **No** |
| “When is `llama3.1:8b`?” | After #2 Modelfile + #1/#7 server |

Full assignment detail: [ASSIGNMENTS.md](./ASSIGNMENTS.md)  
Issue list: [ISSUES.md](./ISSUES.md)
