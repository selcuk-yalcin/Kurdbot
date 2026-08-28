# Kurdish Chatbot — Technical Specification

**Version:** 0.1 (draft)  
**Status:** Planning  
**Language of assistant:** Kurmancî (Northern Kurdish) only

---

## 1. Purpose

Build a production-ready Kurdish chatbot that:

- Presents a familiar web chat UI (LibreChat).
- Uses a local or remote LLM (Ollama-first) tuned for Kurdish-only replies.
- Optionally searches the web via Tavily when the model needs current information.
- Runs in Docker with MongoDB and Redis as required by LibreChat.

---

## 2. Architecture

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
4. If the model requests web search, LibreChat invokes Tavily and injects results into the context.
5. The model summarizes search results in Kurmancî and returns the reply to the user.

---

## 3. Technology Stack

| Layer | Technology | Role |
|-------|------------|------|
| Frontend | LibreChat | Chat UI, auth, conversation history |
| API | LibreChat backend | Routing, tool execution, persistence |
| LLM | Ollama (primary) | Inference; OpenAI-compatible `/v1/` API |
| Base model | `llama3.1:8b` | Starting weights; good Kurdish baseline |
| Custom model | `kurdish-bot` | Ollama Modelfile with Kurdish system prompt |
| Search | Tavily API | JSON search results for tool calling |
| Database | MongoDB 7 | Users, chats, settings |
| Cache | Redis 7 | Sessions and caching |
| Orchestration | Docker Compose | Multi-service deployment |

**Alternatives (future):** vLLM, other OpenAI-compatible hosts; Qwen2.5 or Mistral if Llama underperforms for Kurdish.

---

## 4. System Requirements

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

## 5. Repository Layout

```
kurdish-chatbot/
├── docker-compose.yml      # librechat, mongodb, redis
├── .env.example            # Documented placeholders (no secrets)
├── .gitignore
├── README.md
├── SPEC.md
├── TODO.md
├── librechat/
│   └── librechat.yaml      # Endpoints, modelSpecs, Tavily tool
├── model-server/
│   └── Modelfile           # Ollama custom model definition
└── scripts/
    └── setup.sh            # Optional bootstrap script
```

---

## 6. Ollama Model Server

### 6.1 Installation (server)

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama pull llama3.1:8b
```

### 6.2 Custom Modelfile (`model-server/Modelfile`)

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

### 6.3 Create and expose model

```bash
ollama create kurdish-bot -f model-server/Modelfile
OLLAMA_HOST=0.0.0.0 ollama serve
```

**Verification:** `curl http://SERVER:11434/api/tags` and `ollama list` must show `kurdish-bot`.

---

## 7. LibreChat Configuration

### 7.1 Clone and environment

```bash
git clone https://github.com/danny-avila/LibreChat.git
cd LibreChat
cp .env.example .env
```

### 7.2 Required `.env` variables

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

Generate cryptographically secure values for all secrets in production.

### 7.3 `librechat/librechat.yaml`

```yaml
version: 1.1.4

endpoints:
  ollama:
    baseURL: "${OLLAMA_BASE_URL}/v1/"
    models:
      default: ["kurdish-bot"]
      fetch: false
    titleConvo: true
    titleModel: "kurdish-bot"

modelSpecs:
  enforce: true
  list:
    - name: "Kurdish Bot"
      label: "Kurd Bot — Tenê Kurdî"
      preset:
        model: "kurdish-bot"
        endpoint: "ollama"
        system: |
          Tu asîstentek Kurmancî yî. Tenê bi Kurmancî bersiv dide.
          Eger agahiya nû lazim be, ji înternetê lêkolîn bike û bi Kurmancî rave bike.
        tools:
          - type: tavily_search_results_json
            name: web_search

tools:
  tavily:
    apiKey: "${TAVILY_API_KEY}"
```

**Behavior:**

- `modelSpecs.enforce: true` locks users to the Kurdish preset where supported.
- Default model list is fixed (`fetch: false`) so only `kurdish-bot` is offered.
- Tavily is registered as a tool the model can invoke for web search.

---

## 8. Docker Compose

```yaml
version: "3.8"

services:
  librechat:
    image: ghcr.io/danny-avila/librechat:latest
    ports:
      - "3080:3080"
    volumes:
      - ./librechat/librechat.yaml:/app/librechat.yaml
    env_file: .env
    depends_on:
      - mongodb
      - redis

  mongodb:
    image: mongo:7
    volumes:
      - mongo_data:/data/db

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data

volumes:
  mongo_data:
  redis_data:
```

---

## 9. Tavily Integration

1. Register at [https://tavily.com](https://tavily.com).
2. Create an API key and set `TAVILY_API_KEY` in `.env`.
3. Define the tool in `librechat.yaml` (see §7.3).
4. LibreChat executes Tavily when the model emits a tool call for `web_search`.

**Test prompt (Kurdish):** e.g. ask about today's weather or news; the reply should be in Kurmancî and reflect retrieved data.

---

## 10. Security Considerations

| Area | Requirement |
|------|-------------|
| Secrets | Never commit `.env`; use `.env.example` with placeholders only |
| Ollama | Do not expose `11434` publicly without firewall/VPN |
| LibreChat | Use strong `JWT_*`, `CREDS_KEY`, `CREDS_IV` |
| Production | Terminate TLS at nginx/Caddy; restrict admin registration |
| Tavily | Rotate API keys; monitor usage quotas |

---

## 11. Testing Procedure

| Step | Action | Expected result |
|------|--------|-----------------|
| 1 | `curl http://SERVER:11434/api/tags` | JSON listing models including `kurdish-bot` |
| 2 | `ollama list` | `kurdish-bot` present |
| 3 | `docker compose logs mongodb` | No connection errors |
| 4 | Open `http://localhost:3080` | LibreChat login/register UI |
| 5 | Chat in English/Turkish | Reply **only** in Kurmancî |
| 6 | Ask time-sensitive question | Tavily used; answer in Kurdish |

---

## 12. Deployment (optional phase)

- Host Ollama on GPU server; LibreChat stack on same or separate VM.
- Reverse proxy (nginx) with SSL (Let's Encrypt) on port 443 → `3080`.
- Persistent volumes for MongoDB and Redis.
- Backups for `mongo_data` and LibreChat uploads if enabled.

---

## 13. Out of Scope (v0.1)

- Multi-dialect support (Sorani, Pehlewani, etc.)
- Fine-tuning or LoRA on Kurdish corpora
- Mobile apps
- Custom auth providers (SSO)

These may be added in later versions per [TODO.md](./TODO.md).

---

## 14. References

- [LibreChat](https://github.com/danny-avila/LibreChat)
- [Ollama](https://ollama.com)
- [Tavily API](https://tavily.com)
- [LibreChat librechat.yaml docs](https://docs.librechat.ai)
