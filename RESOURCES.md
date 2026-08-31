# External Resources & Tools

Verified entry-point links for the Kurdish Chatbot project. Use these URLs in issues, docs, and setup — start from these homepages if sub-pages move.

---

## Core stack (required)

| Service | URL | Used for | Issue |
|---------|-----|----------|-------|
| **Ollama** | https://ollama.com/download | LLM runtime; install: `curl -fsSL https://ollama.com/install.sh \| sh` | #7 |
| **Llama 3.1 (Ollama)** | https://ollama.com/library/llama3.1 | Base model for `kurdish-bot` | #7 |
| **LibreChat** | https://www.librechat.ai | Web UI + API | #3–#5, #11 |
| **LibreChat docs** | https://www.librechat.ai/docs | Configuration, Docker, YAML | #3–#5 |
| **LibreChat (source)** | https://github.com/danny-avila/LibreChat | Upstream repo, `.env.example` | #3 |
| **Tavily** | https://www.tavily.com | Web search API signup | #6 |
| **Tavily dashboard** | https://app.tavily.com | API keys, usage quota | #6, #14 |
| **Tavily docs** | https://docs.tavily.com | API reference, quick start | #6, #14 |

---

## GPU / model server (pick one)

| Provider | URL | Notes | Issue |
|----------|-----|-------|-------|
| **Vast.ai** | https://vast.ai | On-demand GPU; pay per second; good for Ollama 8B | #1 |
| **RunPod** | https://www.runpod.io | GPU cloud; simple templates | #1 |
| **Lambda Labs** | https://lambdalabs.com/service/gpu-cloud | GPU instances; ML-focused | #1 |
| **Hetzner** | https://www.hetzner.com/cloud | EU; cost-effective CPU/GPU | #1 |
| **DigitalOcean** | https://www.digitalocean.com | Simple droplets; 16–32 GB RAM | #1 |
| **AWS EC2** | https://aws.amazon.com/ec2 | g4/g5 GPU instances | #1 |
| **Google Cloud Compute** | https://cloud.google.com/compute | GPU VMs | #1 |
| **Microsoft Azure VMs** | https://azure.microsoft.com/products/virtual-machines | GPU series (NC/NV) | #1 |
| **OVHcloud** | https://www.ovhcloud.com | EU hosting | #1 |
| **Linode (Akamai)** | https://www.linode.com | Simple VPS | #1 |

**OS:** [Ubuntu 22.04 LTS](https://ubuntu.com/download/server)

**Minimum for `llama3.1:8b`:** 16 GB RAM · 20 GB disk · Ubuntu 22.04  
**Recommended:** 32 GB RAM · NVIDIA GPU (CUDA 12+) · 50 GB disk

---

## Runtime & containers

| Tool | URL | Used for | Issue |
|------|-----|----------|-------|
| **Docker** | https://docs.docker.com/get-docker/ | Container engine | #11 |
| **Docker Compose** | https://docs.docker.com/compose/ | LibreChat + MongoDB + Redis | #3, #11 |
| **LibreChat Docker image** | https://github.com/danny-avila/LibreChat/pkgs/container/librechat | `ghcr.io/danny-avila/librechat:latest` | #3 |
| **MongoDB** | https://www.mongodb.com/docs/manual/ | Database (`mongo:7` image) | #3, #11 |
| **MongoDB Atlas** | https://www.mongodb.com/atlas | Managed MongoDB (optional) | #17 |
| **Redis** | https://redis.io/docs/ | Cache (`redis:7-alpine` image) | #3, #11 |
| **Node.js** | https://nodejs.org | Local LibreChat dev (optional) | — |
| **Git** | https://git-scm.com/downloads | Clone repo, PRs | all |

---

## Security & secrets

| Tool | URL | Used for | Issue |
|------|-----|----------|-------|
| **OpenSSL** | https://www.openssl.org | `openssl rand -hex 32` for JWT / CREDS_* | #10 |
| **UFW (Ubuntu firewall)** | https://help.ubuntu.com/community/UFW | Restrict Ollama port 11434 | #8 |
| **systemd** | https://wiki.archlinux.org/title/Systemd | Ollama auto-start on reboot | #8 |
| **1Password** | https://1password.com | Share Tavily key / secrets securely | #6, #10 |
| **Bitwarden** | https://bitwarden.com | Free password manager alternative | #6, #10 |

---

## Production (optional — Wave 5)

| Tool | URL | Used for | Issue |
|------|-----|----------|-------|
| **Caddy** | https://caddyserver.com | HTTPS reverse proxy (easiest) | #16 |
| **Caddy reverse proxy guide** | https://caddyserver.com/docs/quick-starts/reverse-proxy | 443 → localhost:3080 | #16 |
| **nginx** | https://nginx.org | Reverse proxy alternative | #16 |
| **Let's Encrypt** | https://letsencrypt.org | Free SSL certificates | #16 |
| **Certbot** | https://certbot.eff.org | SSL automation for nginx | #16 |
| **Cloudflare** | https://www.cloudflare.com | DNS, proxy, DDoS protection | #16 |
| **Cloudflare DNS docs** | https://developers.cloudflare.com/dns | Point domain to server | #16 |

---

## Backups & monitoring

| Tool | URL | Used for | Issue |
|------|-----|----------|-------|
| **mongodump** | https://www.mongodb.com/docs/database-tools/mongodump/ | MongoDB backup | #17 |
| **mongorestore** | https://www.mongodb.com/docs/database-tools/mongorestore/ | Restore test | #17 |
| **Uptime Kuma** | https://github.com/louislam/uptime-kuma | Self-hosted uptime checks | #18 |
| **Better Stack Uptime** | https://betterstack.com/uptime | Hosted uptime (free tier) | #18 |
| **Prometheus** | https://prometheus.io/docs/introduction/overview/ | Metrics (advanced) | #18 |
| **Grafana** | https://grafana.com/docs/ | Dashboards (advanced) | #18 |
| **Docker log rotation** | https://docs.docker.com/config/containers/logging/json-file/ | Prevent disk fill | #18 |

---

## Developer utilities

| Tool | URL | Used for | Issue |
|------|-----|----------|-------|
| **GitHub (this repo)** | https://github.com/selcuk-yalcin/Kurdbot | Issues, code, PRs | all |
| **GitHub Issues** | https://github.com/selcuk-yalcin/Kurdbot/issues | Task tracking | all |
| **ShellCheck** | https://www.shellcheck.net | Lint `scripts/setup.sh` | #9 |
| **Choose a License (MIT)** | https://choosealicense.com/licenses/mit/ | LICENSE file | #19 |
| **VS Code / Cursor** | https://cursor.com | Edit config files | #2–#5 |

---

## Ollama & model references

| Resource | URL | Used for |
|----------|-----|----------|
| **Ollama GitHub** | https://github.com/ollama/ollama | Source, issues, Linux docs |
| **Ollama Modelfile docs** | https://github.com/ollama/ollama/blob/main/docs/modelfile.md | `kurdish-bot` syntax | #2 |
| **Ollama API** | https://github.com/ollama/ollama/blob/main/docs/api.md | `/api/tags`, health checks | #8, #12 |
| **Ollama GPU setup** | https://github.com/ollama/ollama/blob/main/docs/gpu.md | NVIDIA / CUDA | #7 |
| **Ollama FAQ** | https://github.com/ollama/ollama/blob/main/docs/faq.md | `OLLAMA_HOST`, RAM sizing | #8 |

---

## LibreChat configuration references

| Resource | URL | Used for | Issue |
|----------|-----|----------|-------|
| **Local Docker install** | https://www.librechat.ai/docs/local/docker | Compose setup | #3, #11 |
| **librechat.yaml** | https://www.librechat.ai/docs/configuration/librechat_yaml | Main config file | #4 |
| **Model specs** | https://www.librechat.ai/docs/configuration/librechat_yaml/object_structure/model_specs | Kurdish preset | #4 |
| **Ollama endpoint** | https://www.librechat.ai/docs/configuration/librechat_yaml/object_structure/ollama | `OLLAMA_BASE_URL` | #4, #12 |
| **Tavily tool** | https://www.librechat.ai/docs/configuration/tools/tavily | Web search config | #4, #14 |
| **Environment (.env)** | https://www.librechat.ai/docs/configuration/dotenv | All env vars | #5, #10 |
| **Remote deploy** | https://www.librechat.ai/docs/remote/deploy | Production notes | #16 |

---

## Community support (when stuck)

| Community | URL | Best for |
|-----------|-----|----------|
| **LibreChat Discord** | https://discord.librechat.ai | Docker, YAML, UI errors |
| **Ollama Discord** | https://discord.gg/ollama | Model install, GPU, Modelfile |
| **LibreChat GitHub Issues** | https://github.com/danny-avila/LibreChat/issues | Upstream bugs |
| **Ollama GitHub Issues** | https://github.com/ollama/ollama/issues | Ollama bugs |
| **Tavily support** | https://www.tavily.com | Billing, API quota |

---

## Project docs (this repo)

| Doc | Purpose |
|-----|---------|
| [README.md](./README.md) | Overview, env table, test checklist |
| [SPEC.md](./SPEC.md) | Full technical specification |
| [STRUCTURE.md](./STRUCTURE.md) | File/directory map |
| [TODO.md](./TODO.md) | Implementation checklist |
| [RESOURCES.md](./RESOURCES.md) | This file |

---

## Suggested setup order

| Step | Action | Link | Issue |
|------|--------|------|-------|
| 1 | Rent GPU/CPU server | [Vast.ai](https://vast.ai) or [Hetzner](https://www.hetzner.com/cloud) | #1 |
| 2 | Install Ollama + model | [ollama.com/download](https://ollama.com/download) | #7 |
| 3 | Get Tavily API key | [tavily.com](https://www.tavily.com) | #6 |
| 4 | Configure LibreChat stack | [librechat.ai/docs](https://www.librechat.ai/docs) | #3–#5 |
| 5 | Start Docker Compose | [Docker Compose](https://docs.docker.com/compose/) | #11 |
| 6 | QA Kurdish + Tavily | — | #13, #14 |
| 7 | Production HTTPS | [Caddy](https://caddyserver.com) + [Let's Encrypt](https://letsencrypt.org) | #16 |
| 8 | Backups + monitoring | [mongodump](https://www.mongodb.com/docs/database-tools/mongodump/) + [Uptime Kuma](https://github.com/louislam/uptime-kuma) | #17, #18 |

See [GitHub Issues](https://github.com/selcuk-yalcin/Kurdbot/issues) for the full task list and assignments.
