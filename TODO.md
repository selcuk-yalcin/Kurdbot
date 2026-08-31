# Kurdish Chatbot — Implementation Checklist

Track progress for the Kurdish-only LibreChat + Ollama + Tavily stack.

**Legend:** `[ ]` not started · `[~]` in progress · `[x]` done

---

## Phase 1 — Model server (Ollama)

- [ ] **1.1** Install Ollama on the target server (Ubuntu 22.04)
- [ ] **1.2** Pull base model: `ollama pull llama3.1:8b`
- [ ] **1.3** Add `model-server/Modelfile` with Kurdish-only system prompt
- [ ] **1.4** Create custom model: `ollama create kurdish-bot -f model-server/Modelfile`
- [ ] **1.5** Run Ollama with `OLLAMA_HOST=0.0.0.0 ollama serve` (or systemd unit)
- [ ] **1.6** Verify: `curl http://SERVER:11434/api/tags` and `ollama list`

---

## Phase 2 — LibreChat setup

- [ ] **2.1** Set up [LibreChat](https://www.librechat.ai) via Docker (see [RESOURCES.md](./RESOURCES.md))
- [ ] **2.2** Create `.env` from `.env.example` with all required variables
- [ ] **2.3** Set `MONGO_URI`, `REDIS_URI`, `OLLAMA_BASE_URL`
- [ ] **2.4** Generate and set `JWT_SECRET`, `JWT_REFRESH_SECRET`, `CREDS_KEY`, `CREDS_IV`
- [ ] **2.5** Add `librechat/librechat.yaml` (Ollama endpoint, modelSpecs, Tavily tool)

---

## Phase 3 — Docker Compose

- [ ] **3.1** Add `docker-compose.yml` (librechat, mongodb, redis)
- [ ] **3.2** Mount `librechat/librechat.yaml` into the LibreChat container
- [ ] **3.3** Add `.gitignore` (`.env`, logs, volume data)
- [ ] **3.4** Add `.env.example` with documented placeholders (no real secrets)
- [ ] **3.5** Run `docker compose up -d` and confirm all services healthy

---

## Phase 4 — Tavily web search

- [ ] **4.1** Register at [Tavily](https://www.tavily.com) and obtain API key
- [ ] **4.2** Set `TAVILY_API_KEY` in `.env`
- [ ] **4.3** Confirm `tavily_search_results_json` tool in `librechat.yaml`
- [ ] **4.4** Test with a current-events / weather question in the UI

---

## Phase 5 — Testing & quality

- [ ] **5.1** LibreChat loads at `http://localhost:3080`
- [ ] **5.2** User can register/login
- [ ] **5.3** Bot responds **only in Kurmancî** when user writes in English/Turkish/other
- [ ] **5.4** Web search returns Kurdish summaries for time-sensitive queries
- [ ] **5.5** Document any model quality issues (hallucinations, wrong dialect)

---

## Phase 6 — Repository & documentation

- [x] **6.1** README.md (architecture, requirements, env table, test checklist)
- [x] **6.2** SPEC.md (full technical specification)
- [x] **6.3** TODO.md (this file)
- [x] **6.4** Repo skeleton + placeholders: `STRUCTURE.md`, `docker-compose.yml`, `.env.example`, `.gitignore`, `librechat/librechat.yaml`, `model-server/Modelfile`, `scripts/setup.sh`
- [ ] **6.4b** Fill placeholders with real config (Compose, YAML, Modelfile, setup script)
- [ ] **6.5** Initial commit and push to GitHub
- [ ] **6.6** Add LICENSE aligned with upstream dependencies

---

## Phase 7 — Production deploy (optional)

- [ ] **7.1** Provision server (16–32 GB RAM, optional GPU)
- [ ] **7.2** Firewall: expose 443 (proxy) only; keep Ollama internal
- [ ] **7.3** nginx or Caddy reverse proxy + SSL (Let's Encrypt)
- [ ] **7.4** systemd or Docker for Ollama persistence
- [ ] **7.5** MongoDB backup strategy
- [ ] **7.6** Monitoring / log rotation

---

## Quick reference — ordered milestones

| # | Milestone |
|---|-----------|
| 1 | Ollama installed; `llama3.1:8b` pulled |
| 2 | `kurdish-bot` model created from Modelfile |
| 3 | LibreChat cloned; `.env` configured |
| 4 | `librechat.yaml` written and mounted |
| 5 | Docker Compose stack running |
| 6 | Tavily API key integrated |
| 7 | End-to-end tests passed |
| 8 | GitHub repo complete with docs |
| 9 | Production deploy (nginx + SSL, optional) |

---

## Notes

_Add dated notes below as work progresses._

| Date | Note |
|------|------|
| 2026-08-28 | Project initialized; documentation draft (README, SPEC, TODO) |
| 2026-08-28 | Repo skeleton created; placeholder files only (see STRUCTURE.md) |
