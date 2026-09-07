# Task Assignments by Person

**Read first:** [WHO-DOES-WHAT.md](./WHO-DOES-WHAT.md) — ready Compose stack vs open tasks.

**Repo issues:** https://github.com/selcuk-yalcin/Kurdbot/issues  
**Full list:** [ISSUES.md](./ISSUES.md)

---

## Split (simple)

| Lane | Owner | What |
|------|-------|------|
| **A — Ready** | Selçuk (done) | One `docker-compose.yml` + yaml + `.env.example` |
| **B — Run & ops** | **Cem** | Run stack (#21), Tavily (#6), later server (#1/#7/#8) |
| **C — Follow-up** | Selçuk | Modelfile (#2), LICENSE (#19), Kurdish QA (#13) |

---

## Cem Acun (`@cem-acun`) — do these

### Today

| Issue | Task |
|-------|------|
| [#21](https://github.com/selcuk-yalcin/Kurdbot/issues/21) | Run `docker compose up` on your PC + pull `llama3.2:3b` + chat works |
| [#6](https://github.com/selcuk-yalcin/Kurdbot/issues/6) | (Optional same day) Tavily API key → share with Selçuk |

### Later (after #21 works)

| Issue | Task |
|-------|------|
| [#1](https://github.com/selcuk-yalcin/Kurdbot/issues/1) | Provision bigger/GPU server |
| [#7](https://github.com/selcuk-yalcin/Kurdbot/issues/7) | Production `kurdish-bot` model |
| [#8](https://github.com/selcuk-yalcin/Kurdbot/issues/8) | Expose Ollama API safely |
| [#11](https://github.com/selcuk-yalcin/Kurdbot/issues/11)–[#12](https://github.com/selcuk-yalcin/Kurdbot/issues/12) | Integration checks |
| [#14](https://github.com/selcuk-yalcin/Kurdbot/issues/14) | Tavily QA |
| [#16](https://github.com/selcuk-yalcin/Kurdbot/issues/16)–[#18](https://github.com/selcuk-yalcin/Kurdbot/issues/18) | Production SSL / backup / monitoring |

### Checklist (Cem)

- [ ] #21 Local Docker stack + `llama3.2:3b`
- [ ] #6 Tavily API key
- [ ] #1 Provision model server
- [ ] #7 Install Ollama + `kurdish-bot`
- [ ] #8 Expose Ollama API
- [ ] #11 / #12 Integration
- [ ] #14 Tavily QA
- [ ] #16–#18 Production

---

## Selçuk Yalçın (`@selcuk-yalcin`)

### Done (Compose lane)

- [x] #3 `docker-compose.yml` (now includes Ollama)
- [x] #4 `librechat.yaml`
- [x] #5 `.env.example`

### Still open

| Issue | Task |
|-------|------|
| [#2](https://github.com/selcuk-yalcin/Kurdbot/issues/2) | `Modelfile` for production `kurdish-bot` |
| [#9](https://github.com/selcuk-yalcin/Kurdbot/issues/9) | `setup.sh` |
| [#10](https://github.com/selcuk-yalcin/Kurdbot/issues/10) | Real `.env` secrets (after #6) |
| [#13](https://github.com/selcuk-yalcin/Kurdbot/issues/13) | Kurdish-only QA |
| [#15](https://github.com/selcuk-yalcin/Kurdbot/issues/15) | Quality notes |
| [#19](https://github.com/selcuk-yalcin/Kurdbot/issues/19) | LICENSE |

---

## Shared

| Issue | Task |
|-------|------|
| [#20](https://github.com/selcuk-yalcin/Kurdbot/issues/20) | Roadmap meta |

---

## Hand-offs

| From | To | What |
|------|-----|------|
| Selçuk (Compose ready) | Cem #21 | Just run the stack — no redesign |
| Cem #6 | Selçuk #10 | Tavily key (secure channel) |
| Selçuk #2 | Cem #7 | Modelfile on `main` before production model |
| Cem #21 OK | Team | Then decide on GPU server (#1) |
