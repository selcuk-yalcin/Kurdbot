# Kurdish Chatbot (Kurmancî)

A Kurdish-only (Kurmancî) chatbot built on **LibreChat**, powered by a local or cloud LLM via **Ollama**, with optional **Tavily** web search for up-to-date answers.

---

## Architecture

```
User → LibreChat (Web UI) → Backend API Server → LLM (local/cloud)
                                              ↘ Tavily Search API (when needed)
```

| Component | Choice | Notes |
|-----------|--------|-------|
| Web UI | LibreChat | Open-source ChatGPT-style interface |
| LLM | Ollama / vLLM / OpenAI-compatible | Ollama recommended for getting started |
| Model | Llama 3.1 8B / Qwen2.5 / Mistral | Llama 3.1 recommended for Kurdish |
| Web Search | Tavily API | Used when the model needs current information |
| Database | MongoDB | Required by LibreChat |
| Cache | Redis | Required by LibreChat |
| Containers | Docker Compose | Orchestrates all services |

---

## System Requirements

### Server (for running the model)

| Resource | Minimum | Recommended |
|----------|---------|-------------|
| RAM | 16 GB (8B model) | 32 GB |
| GPU | Optional | NVIDIA with CUDA 12+ for speed |
| Disk | 20–50 GB | For model weights |
| OS | Ubuntu 22.04 | LTS |

### Local development

- Docker & Docker Compose
- Node.js 18+
- Git

---

## Repository Structure (planned)

```
kurdish-chatbot/
├── docker-compose.yml
├── .env.example
├── .gitignore
├── README.md
├── SPEC.md
├── TODO.md
├── librechat/
│   └── librechat.yaml          # LibreChat config
├── model-server/
│   └── Modelfile               # Ollama custom model
└── scripts/
    └── setup.sh
```

---

## Quick Start (overview)

Detailed steps live in [SPEC.md](./SPEC.md). At a high level:

1. **Rent a GPU/CPU server** ([Vast.ai](https://vast.ai) or similar) and install [Ollama](https://ollama.com/download); pull `llama3.1:8b`.
2. **Create the custom model** `kurdish-bot` from `model-server/Modelfile` (Kurdish-only system prompt).
3. **Configure [LibreChat](https://www.librechat.ai)** via Docker; set `.env` (MongoDB, Redis, Ollama URL, Tavily key, JWT secrets).
4. **Configure** `librechat/librechat.yaml` (Kurdish model preset + Tavily tool).
5. **Run** `docker compose up` (LibreChat, MongoDB, Redis).
6. **Register** at [Tavily](https://www.tavily.com) and add `TAVILY_API_KEY` to `.env`.
7. **Test** at `http://localhost:3080`.

---

## Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `MONGO_URI` | MongoDB connection string | `mongodb://mongodb:27017/LibreChat` |
| `REDIS_URI` | Redis connection string | `redis://redis:6379` |
| `OLLAMA_BASE_URL` | Ollama API base URL | `http://YOUR_SERVER_IP:11434` |
| `TAVILY_API_KEY` | Tavily search API key | `tvly-...` |
| `JWT_SECRET` | JWT signing secret | Long random string |
| `JWT_REFRESH_SECRET` | JWT refresh secret | Another long random string |
| `CREDS_KEY` | Encryption key (32 chars) | 32-character key |
| `CREDS_IV` | Encryption IV (16 chars) | 16-character IV |

Copy `.env.example` to `.env` and fill in real values. Never commit `.env`.

---

## Testing Checklist

| # | Check | Command / URL |
|---|--------|----------------|
| 1 | Ollama running | `curl http://SERVER:11434/api/tags` |
| 2 | `kurdish-bot` model exists | `ollama list` |
| 3 | MongoDB healthy | `docker compose logs mongodb` |
| 4 | LibreChat UI loads | `http://localhost:3080` |
| 5 | Replies in Kurdish only | Ask in any language via UI |
| 6 | Tavily web search | Ask a current-events question (e.g. weather) |

---

## Behavior

- The assistant **only responds in Kurmancî (Northern Kurdish)**, regardless of the user's input language.
- When fresh information is needed, the model may call **Tavily**; results are summarized in Kurdish.
- Model preset and system prompts enforce Kurdish-only output (see [SPEC.md](./SPEC.md)).

---

## Documentation

- **[RESOURCES.md](./RESOURCES.md)** — Verified links: Ollama, LibreChat, Tavily, Vast.ai, and other tools
- **[STRUCTURE.md](./STRUCTURE.md)** — What each file and directory is for (repository map)
- **[SPEC.md](./SPEC.md)** — Full technical specification, configs, and setup steps
- **[TODO.md](./TODO.md)** — Implementation checklist

Config files (`docker-compose.yml`, `librechat.yaml`, `Modelfile`, etc.) exist as **placeholders** — they describe what will go where but contain no runnable config yet.

---

## License

TBD — align with LibreChat and upstream dependencies when implementing.
