# Kurdish Chatbot — Technical Specification

**Version:** 0.2  
**Status:** In progress (config in repo; runtime not deployed yet)  
**Language of assistant:** Kurmancî (Northern Kurdish) only

---

## Implementation status

| Spec section | Item | Status |
|--------------|------|--------|
| §1–§4 | Purpose, architecture, stack, requirements | ✅ Documented |
| §5 | Repository layout | ✅ Done |
| §6.1 | Ollama install on server | ❌ Pending (#1, #7) |
| §6.2 | `model-server/Modelfile` | ❌ Pending (#2 — still placeholder) |
| §6.3 | Create/expose `kurdish-bot` | ❌ Pending (#7, #8) |
| §7.1 | Use this repo + Docker (not clone LibreChat separately) | ✅ Done |
| §7.2 | `.env.example` template | ✅ Done (#5 closed) |
| §7.2 | Real `.env` with secrets | ❌ Pending (#10) |
| §7.3 | `librechat/librechat.yaml` | ✅ Done (#4 closed) |
| §8 | Root `docker-compose.yml` (LibreChat + Mongo + Redis only) | ✅ Done (#3) — Ollama removed (Cem owns it) |
| §8 Cem | `model-server/docker-compose.yml` (Ollama) | 👤 Cem task [#21](https://github.com/selcuk-yalcin/Kurdbot/issues/21) |
| §8 local | Local model `llama3.2:3b` | 👤 Cem pulls in #21 |
| §9 | Tavily in `librechat.yaml` | ✅ Done |
| §9 | Tavily API key + live search test | ❌ Pending (#6, #14) |
| §10 | Security practices documented | ✅ Done |
| §11 | End-to-end testing | ❌ Pending (#11–#15) |
| §12 | Production deploy | ❌ Pending (#16–#18) |
| Docs | README, TODO, STRUCTURE, RESOURCES, ISSUES, ASSIGNMENTS | ✅ Done |

**Closed GitHub issues:** [#3](https://github.com/selcuk-yalcin/Kurdbot/issues/3), [#4](https://github.com/selcuk-yalcin/Kurdbot/issues/4), [#5](https://github.com/selcuk-yalcin/Kurdbot/issues/5)  
**Commit:** `dd5201f`

---

## 1. Purpose ✅

Build a production-ready Kurdish chatbot that:

- Presents a familiar web chat UI (LibreChat).
- Uses a local or remote LLM (Ollama-first) tuned for Kurdish-only replies.
- Optionally searches the web via Tavily when the model needs current information.
- Runs in Docker with MongoDB and Redis as required by LibreChat.

---

## 2. Architecture ✅

```
┌──────────┐     ┌─────────────┐     ┌──────────────────┐     ┌─────────────┐
│   User   │────▶│  LibreChat  │────▶│  Backend API     │────▶│ LLM Server  │
│ (Browser)│     │  (Web UI)   │     │  (LibreChat)     │     │ (Ollama)    │
└──────────┘     └─────────────┘     └────────┬─────────┘     └─────────────┘
                                              │
                                              │ tool call (when needed)
                                              ▼
                                     ┌──────────────────┐
                                     │  Tavily Search   │
                                     │  API             │
                                     └──────────────────┘

Supporting services: MongoDB (persistence), Redis (cache/sessions)
```

### Data flow

1. User sends a message in any language via LibreChat.
2. LibreChat forwards the conversation to the configured Ollama endpoint (`kurdish-bot`).
3. System and model specs enforce Kurdish-only responses.
4. If the model needs web search, LibreChat uses Tavily (`webSearch`) and injects results into the context.
5. The model summarizes search results in Kurmancî and returns the reply to the user.

---

## 3. Technology Stack ✅

| Layer | Technology | Role |
|-------|------------|------|
| Frontend | LibreChat | Chat UI, auth, conversation history |
| API | LibreChat backend | Routing, tool execution, persistence |
| LLM | Ollama (primary) | Inference; OpenAI-compatible `/v1/` API |
| Base model | `llama3.1:8b` | Starting weights; good Kurdish baseline |
| Custom model | `kurdish-bot` | Ollama Modelfile with Kurdish system prompt |
| Search | Tavily API | Web search via LibreChat `webSearch` |
| Database | MongoDB 7 | Users, chats, settings |
| Cache | Redis 7 | Sessions and caching |
| Orchestration | Docker Compose | Multi-service deployment |

**Alternatives (future):** vLLM, other OpenAI-compatible hosts; Qwen2.5 or Mistral if Llama underperforms for Kurdish.

---

## 4. System Requirements ✅

### Model server

| Resource | Minimum | Recommended |
|----------|---------|-------------|
| RAM | 16 GB | 32 GB |
| GPU | Optional | NVIDIA, CUDA 12+ |
| Disk | 20 GB | 50 GB (models + logs) |
| OS | Ubuntu 22.04 LTS | Same |

### Development machine

- Docker Engine + Docker Compose v2
- Node.js 18+ (for LibreChat local dev, optional)
- Git

### Network

- Ollama: port `11434` (restrict to internal/VPN in production)
- LibreChat: port `3080` (behind reverse proxy in production)
- Outbound HTTPS for Tavily API

---

## 5. Repository Layout ✅

```
Kurdbot/
├── docker-compose.yml      # ✅ librechat, mongodb, redis
├── .env.example            # ✅ documented placeholders (no secrets)
├── .gitignore              # ✅
├── README.md               # ✅
├── SPEC.md                 # ✅ (this file)
├── TODO.md                 # ✅
├── ISSUES.md               # ✅
├── ASSIGNMENTS.md          # ✅
├── STRUCTURE.md            # ✅
├── RESOURCES.md            # ✅
├── librechat/
│   └── librechat.yaml      # ✅ Ollama + Kurdish preset + Tavily
├── model-server/
│   └── Modelfile           # ❌ still placeholder (#2)
└── scripts/
    └── setup.sh            # ❌ still placeholder (#9)
```

---

## 6. Ollama Model Server ❌ Pending

### 6.1 Installation (server) ❌

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama pull llama3.1:8b
```

Tracked in issues [#1](https://github.com/selcuk-yalcin/Kurdbot/issues/1), [#7](https://github.com/selcuk-yalcin/Kurdbot/issues/7).

### 6.2 Custom Modelfile (`model-server/Modelfile`) ❌

**Target content** (not yet written to disk — issue [#2](https://github.com/selcuk-yalcin/Kurdbot/issues/2)):

```
FROM llama3.1:8b

SYSTEM """
You are an assistant that speaks only Kurmancî (Northern Kurdish).
Regardless of the language the user writes in, you respond ONLY in Kurdish (Kurmancî).
If you do not understand something, say so in Kurdish.
When information from the internet is needed, summarize search results in Kurdish.
"""

PARAMETER temperature 0.7
PARAMETER top_p 0.9
```

### 6.3 Create and expose model ❌

```bash
ollama create kurdish-bot -f model-server/Modelfile
OLLAMA_HOST=0.0.0.0 ollama serve
```

**Verification:** `curl http://SERVER:11434/api/tags` and `ollama list` must show `kurdish-bot`.  
Tracked in [#7](https://github.com/selcuk-yalcin/Kurdbot/issues/7), [#8](https://github.com/selcuk-yalcin/Kurdbot/issues/8).

---

## 7. LibreChat Configuration

### 7.1 Environment ✅

This project uses **Docker Compose in this repo** (not a separate LibreChat clone).

```bash
cp .env.example .env
# fill secrets, then:
docker compose up -d
```

### 7.2 Required `.env` variables ✅ Template · ❌ Real `.env`

**Template:** [`.env.example`](./.env.example) — done (#5).

```env
MONGO_URI=mongodb://mongodb:27017/LibreChat
REDIS_URI=redis://redis:6379
OLLAMA_BASE_URL=http://YOUR_SERVER_IP:11434
TAVILY_API_KEY=your_tavily_key
JWT_SECRET=<long_random_string>
JWT_REFRESH_SECRET=<another_long_random_string>
CREDS_KEY=<32_character_key>
CREDS_IV=<16_character_iv>
```

Generate cryptographically secure values for all secrets before first start.  
Real `.env` is local-only — issue [#10](https://github.com/selcuk-yalcin/Kurdbot/issues/10).

### 7.3 `librechat/librechat.yaml` ✅

**Implemented** in [`librechat/librechat.yaml`](./librechat/librechat.yaml) (#4 closed). Summary:

- Custom Ollama endpoint → model `kurdish-bot`
- `modelSpecs.enforce: true` with Kurmancî-only system prompt
- Tavily via `webSearch` (`searchProvider` / `scraperProvider: tavily`)

See the file in the repo for the full YAML (LibreChat `endpoints.custom` format).

**Behavior:**

- `modelSpecs.enforce: true` locks users to the Kurdish preset where supported.
- Default model list is fixed (`fetch: false`) so only `kurdish-bot` is offered.
- Tavily is configured for LibreChat web search.

---

## 8. Docker Compose ✅

**Implemented** in [`docker-compose.yml`](./docker-compose.yml) (#3 closed).

Services: `librechat` (`ghcr.io/danny-avila/librechat-dev:latest`), `mongodb:7`, `redis:7-alpine`.  
Ollama is **not** in Compose — set `OLLAMA_BASE_URL` in `.env`.

```bash
docker compose up -d
# UI: http://localhost:3080
```

---

## 9. Tavily Integration 🟨 Partial

| Step | Status |
|------|--------|
| 1. Register at [https://www.tavily.com](https://www.tavily.com) | ❌ Pending (#6) |
| 2. Set `TAVILY_API_KEY` in `.env` | ❌ Pending (#10) |
| 3. Define Tavily in `librechat.yaml` (`webSearch`) | ✅ Done (#4) |
| 4. Live search QA | ❌ Pending (#14) |

**Test prompt (Kurdish):** e.g. ask about today's weather or news; the reply should be in Kurmancî and reflect retrieved data.

---

## 10. Security Considerations ✅ Documented

| Area | Requirement |
|------|-------------|
| Secrets | Never commit `.env`; use `.env.example` with placeholders only ✅ |
| Ollama | Do not expose `11434` publicly without firewall/VPN ❌ pending (#8) |
| LibreChat | Use strong `JWT_*`, `CREDS_KEY`, `CREDS_IV` ❌ pending (#10) |
| Production | Terminate TLS at nginx/Caddy; restrict admin registration ❌ pending (#16) |
| Tavily | Rotate API keys; monitor usage quotas ❌ pending (#6) |

---

## 11. Testing Procedure ❌ Pending

| Step | Action | Expected result | Status |
|------|--------|-----------------|--------|
| 1 | `curl http://SERVER:11434/api/tags` | JSON listing models including `kurdish-bot` | ❌ |
| 2 | `ollama list` | `kurdish-bot` present | ❌ |
| 3 | `docker compose logs mongodb` | No connection errors | ❌ (#11) |
| 4 | Open `http://localhost:3080` | LibreChat login/register UI | ❌ (#11) |
| 5 | Chat in English/Turkish | Reply **only** in Kurmancî | ❌ (#13) |
| 6 | Ask time-sensitive question | Tavily used; answer in Kurdish | ❌ (#14) |

---

## 12. Deployment (optional phase) ❌ Pending

- Host Ollama on GPU server; LibreChat stack on same or separate VM.
- Reverse proxy (nginx) with SSL (Let's Encrypt) on port 443 → `3080`.
- Persistent volumes for MongoDB and Redis.
- Backups for `mongo_data` and LibreChat uploads if enabled.

Tracked in [#16](https://github.com/selcuk-yalcin/Kurdbot/issues/16)–[#18](https://github.com/selcuk-yalcin/Kurdbot/issues/18).

---

## 13. Out of Scope (v0.1)

- Multi-dialect support (Sorani, Pehlewani, etc.)
- Fine-tuning or LoRA on Kurdish corpora
- Mobile apps
- Custom auth providers (SSO)

These may be added in later versions per [TODO.md](./TODO.md).

---

## 14. References ✅

See **[RESOURCES.md](./RESOURCES.md)** for the full tool list. Key links:

- [LibreChat](https://www.librechat.ai) · [Docs](https://www.librechat.ai/docs) · [GitHub](https://github.com/danny-avila/LibreChat)
- [Ollama Download](https://ollama.com/download)
- [Tavily](https://www.tavily.com)
- [Vast.ai](https://vast.ai) — GPU server rental (model host)
- [ISSUES.md](./ISSUES.md) · [ASSIGNMENTS.md](./ASSIGNMENTS.md)
