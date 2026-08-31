# External Resources & Tools

Verified entry-point links for the Kurdish Chatbot project. Use these URLs in issues, docs, and setup — sub-pages may change; start from these homepages.

---

## Core stack (required)

| Service | URL | Used for |
|---------|-----|----------|
| **Ollama** | https://ollama.com/download | LLM runtime; Linux install via `curl -fsSL https://ollama.com/install.sh \| sh` |
| **LibreChat** | https://www.librechat.ai | Web UI + API; docs at https://www.librechat.ai/docs |
| **Tavily** | https://www.tavily.com | Web search API for current information |
| **LibreChat (source)** | https://github.com/danny-avila/LibreChat | Upstream repo, `.env.example`, Docker reference |

---

## GPU / model server (pick one)

| Provider | URL | Notes |
|----------|-----|-------|
| **Vast.ai** | https://vast.ai | On-demand GPU rental; good for Ollama + 8B models; pay per second |
| **Hetzner** | https://www.hetzner.com/cloud | CPU/GPU cloud; EU; cost-effective |
| **DigitalOcean** | https://www.digitalocean.com | Simple VMs; 16–32 GB RAM droplets |
| **AWS EC2** | https://aws.amazon.com/ec2 | g4/g5 instances for GPU |

**Minimum for `llama3.1:8b`:** 16 GB RAM · 20 GB disk · Ubuntu 22.04  
**Recommended:** 32 GB RAM · NVIDIA GPU · 50 GB disk

---

## Runtime & containers

| Tool | URL | Used for |
|------|-----|----------|
| **Docker** | https://docs.docker.com/get-docker/ | Container engine |
| **Docker Compose** | https://docs.docker.com/compose/ | LibreChat + MongoDB + Redis stack |
| **MongoDB** | https://www.mongodb.com/docs/manual/ | Database (via `mongo:7` image) |
| **Redis** | https://redis.io/docs/ | Cache (via `redis:7-alpine` image) |

---

## Production (optional — Wave 5)

| Tool | URL | Used for |
|------|-----|----------|
| **Caddy** | https://caddyserver.com/docs/quick-starts/reverse-proxy | HTTPS reverse proxy (easiest) |
| **nginx** | https://nginx.org/en/docs/ | Reverse proxy alternative |
| **Let's Encrypt** | https://letsencrypt.org/getting-started/ | Free SSL certificates |
| **Certbot** | https://certbot.eff.org/ | SSL automation for nginx |
| **Cloudflare** | https://www.cloudflare.com | DNS + optional proxy/CDN |
| **Uptime Kuma** | https://github.com/louislam/uptime-kuma | Self-hosted uptime monitoring |

---

## Developer & ops utilities

| Tool | URL | Used for |
|------|-----|----------|
| **GitHub (this repo)** | https://github.com/selcuk-yalcin/Kurdbot | Issues, code, collaboration |
| **OpenSSL** | `openssl rand -hex 32` | Generate JWT / encryption secrets |
| **ShellCheck** | https://www.shellcheck.net | Lint `scripts/setup.sh` |

---

## Community support (when stuck)

| Community | URL | Best for |
|-----------|-----|----------|
| **LibreChat Discord** | https://discord.librechat.ai | Docker, YAML config, UI errors |
| **Ollama Discord** | https://discord.gg/ollama | Model install, GPU, Modelfile |
| **Tavily docs** | https://docs.tavily.com | API keys, search endpoint |
| **Tavily dashboard** | https://app.tavily.com | Usage quota, API key management |

---

## Suggested setup order

1. [Vast.ai](https://vast.ai) or other host → Ubuntu 22.04 VM (#1)  
2. [Ollama download](https://ollama.com/download) → install + `kurdish-bot` (#7)  
3. [Tavily](https://www.tavily.com) → API key (#6)  
4. [LibreChat docs](https://www.librechat.ai/docs) → Docker + config (#3–#5)  
5. Production: Caddy/nginx + Let's Encrypt (#16)

See [TODO.md](./TODO.md) and [GitHub Issues](https://github.com/selcuk-yalcin/Kurdbot/issues) for the full task list.
