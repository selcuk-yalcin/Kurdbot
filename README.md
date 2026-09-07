# Kurdish Chatbot (Kurmancî)

LibreChat + Ollama + optional Tavily. **Two Compose files** — do not mix owners.

**Clarity:** [WHO-DOES-WHAT.md](./WHO-DOES-WHAT.md)

---

## Split

| File | Owner | Services |
|------|-------|----------|
| [`docker-compose.yml`](./docker-compose.yml) | **Selçuk** | LibreChat + MongoDB + Redis |
| [`model-server/docker-compose.yml`](./model-server/docker-compose.yml) | **Cem** | Ollama only |

**Local model (Cem pulls):** `llama3.2:3b`

### Cem (#21)

```bash
cd model-server
docker compose up -d
docker compose exec ollama ollama pull llama3.2:3b
curl http://localhost:11434/api/tags
```

### App (after Ollama is up)

```bash
cp .env.example .env
# OLLAMA_BASE_URL=http://host.docker.internal:11434
docker compose up -d
# → http://localhost:3080
```

---

## Architecture

```
User → LibreChat (root compose) → Ollama (model-server compose, Cem)
                                ↘ Tavily (optional, Cem #6)
```

---

## Documentation

- [WHO-DOES-WHAT.md](./WHO-DOES-WHAT.md)
- [model-server/README.md](./model-server/README.md) — Cem’s Ollama guide
- [ISSUES.md](./ISSUES.md) · [ASSIGNMENTS.md](./ASSIGNMENTS.md)
- [SPEC.md](./SPEC.md) · [RESOURCES.md](./RESOURCES.md)

---

## License

TBD — [#19](https://github.com/selcuk-yalcin/Kurdbot/issues/19).
