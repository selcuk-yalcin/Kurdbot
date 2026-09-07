# Task Assignments by Person

**Read first:** [WHO-DOES-WHAT.md](./WHO-DOES-WHAT.md)

---

## Cem (`@cem-acun`) — owns Ollama

**His Compose file:** [`model-server/docker-compose.yml`](./model-server/docker-compose.yml)

| Priority | Issue | Task |
|----------|-------|------|
| Today | [#21](https://github.com/selcuk-yalcin/Kurdbot/issues/21) | Run **his** Ollama compose + pull `llama3.2:3b` |
| Easy | [#6](https://github.com/selcuk-yalcin/Kurdbot/issues/6) | Tavily API key |
| Later | [#1](https://github.com/selcuk-yalcin/Kurdbot/issues/1) | Bigger/GPU server |
| Later | [#7](https://github.com/selcuk-yalcin/Kurdbot/issues/7) | `kurdish-bot` production model |
| Later | [#8](https://github.com/selcuk-yalcin/Kurdbot/issues/8) | Expose Ollama safely |
| Later | #11–#14, #16–#18 | Integration + production |

### Checklist (Cem)

- [ ] #21 Own Ollama compose + `llama3.2:3b`
- [ ] #6 Tavily key
- [ ] #1 Server
- [ ] #7 / #8 Production Ollama
- [ ] #11–#14, #16–#18

---

## Selçuk (`@selcuk-yalcin`) — owns app stack

**His Compose file:** [`docker-compose.yml`](./docker-compose.yml) (no Ollama)

### Done

- [x] #3 App `docker-compose.yml`
- [x] #4 `librechat.yaml`
- [x] #5 `.env.example`

### Open

- [ ] #2 Modelfile
- [ ] #9 setup.sh
- [ ] #10 Real `.env`
- [ ] #13 / #15 Kurdish QA
- [ ] #19 LICENSE

---

## Hand-offs

| From | To | What |
|------|-----|------|
| Cem #21 | Selçuk / `.env` | Ollama reachable at `localhost:11434` |
| Cem #6 | Selçuk #10 | Tavily key |
| Selçuk #2 | Cem #7 | Modelfile ready for `kurdish-bot` |
