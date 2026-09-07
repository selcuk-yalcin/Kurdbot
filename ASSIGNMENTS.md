# Task Assignments by Person

Open GitHub issues grouped by assignee. All work is tracked on GitHub; this file is the local summary.

**Repo issues:** https://github.com/selcuk-yalcin/Kurdbot/issues  
**Full list (this repo):** [ISSUES.md](./ISSUES.md)  
**Roadmap:** [#20](https://github.com/selcuk-yalcin/Kurdbot/issues/20)

**Legend:** `[ ]` open · start Wave 1 items in parallel where noted

---

## Selçuk Yalçın (`@selcuk-yalcin`)

Focus: repo config, prompts, Kurdish QA, docs, LICENSE

### Start now (Wave 1 — parallel)

| Issue | Task | Depends on |
|-------|------|------------|
| [#2](https://github.com/selcuk-yalcin/Kurdbot/issues/2) | Implement `model-server/Modelfile` (Kurdish-only prompt) | — |
| [#3](https://github.com/selcuk-yalcin/Kurdbot/issues/3) | Implement `docker-compose.yml` (LibreChat stack) | — |
| [#4](https://github.com/selcuk-yalcin/Kurdbot/issues/4) | Implement `librechat/librechat.yaml` (Ollama + Tavily) | — |
| [#5](https://github.com/selcuk-yalcin/Kurdbot/issues/5) | Complete `.env.example` with all required variables | — |
| [#19](https://github.com/selcuk-yalcin/Kurdbot/issues/19) | Add LICENSE file aligned with upstream dependencies | — |

### Wave 2

| Issue | Task | Depends on |
|-------|------|------------|
| [#9](https://github.com/selcuk-yalcin/Kurdbot/issues/9) | Implement `scripts/setup.sh` bootstrap script | #3, #5 |
| [#10](https://github.com/selcuk-yalcin/Kurdbot/issues/10) | Generate secrets and configure local `.env` | #5, #6, #8 |

### Wave 4 (QA)

| Issue | Task | Depends on |
|-------|------|------------|
| [#13](https://github.com/selcuk-yalcin/Kurdbot/issues/13) | QA: Kurdish-only responses (all input languages) | #12 |
| [#15](https://github.com/selcuk-yalcin/Kurdbot/issues/15) | Document model quality findings and tune prompts | #13, #14 |

### Checklist (Selçuk)

- [ ] #2 Modelfile
- [x] #3 docker-compose.yml — implemented in repo
- [x] #4 librechat.yaml — implemented in repo
- [x] #5 .env.example — implemented in repo
- [ ] #19 LICENSE
- [ ] #9 setup.sh
- [ ] #10 local .env
- [ ] #13 Kurdish-only QA
- [ ] #15 Quality docs / prompt tuning

---

## Cem Acun (`@cem-acun`)

Focus: servers, Ollama, Docker runtime, Tavily account, production infra

### Start now (Wave 1 — parallel)

| Issue | Task | Depends on |
|-------|------|------------|
| [#21](https://github.com/selcuk-yalcin/Kurdbot/issues/21) | **Local PC:** Docker stack + Ollama + `llama3.2:3b` chatbot | — (do today) |
| [#1](https://github.com/selcuk-yalcin/Kurdbot/issues/1) | Provision model server (Ubuntu 22.04) | — |
| [#6](https://github.com/selcuk-yalcin/Kurdbot/issues/6) | Register Tavily account and obtain API key | — |

### Wave 2

| Issue | Task | Depends on |
|-------|------|------------|
| [#7](https://github.com/selcuk-yalcin/Kurdbot/issues/7) | Install Ollama, pull model, create `kurdish-bot` | #1, #2 |
| [#8](https://github.com/selcuk-yalcin/Kurdbot/issues/8) | Expose Ollama API (`OLLAMA_HOST` + firewall) | #7 |

### Wave 3 (integration)

| Issue | Task | Depends on |
|-------|------|------------|
| [#11](https://github.com/selcuk-yalcin/Kurdbot/issues/11) | Start Docker Compose stack and verify services | #3, #4, #10 |
| [#12](https://github.com/selcuk-yalcin/Kurdbot/issues/12) | Verify Ollama ↔ LibreChat connection | #8, #11 |

### Wave 4 (QA)

| Issue | Task | Depends on |
|-------|------|------------|
| [#14](https://github.com/selcuk-yalcin/Kurdbot/issues/14) | QA: Tavily web search returns Kurdish summaries | #4, #6, #12 |

### Wave 5 (production — optional)

| Issue | Task | Depends on |
|-------|------|------------|
| [#16](https://github.com/selcuk-yalcin/Kurdbot/issues/16) | Production deploy: nginx/Caddy reverse proxy + SSL | #15 |
| [#17](https://github.com/selcuk-yalcin/Kurdbot/issues/17) | Production: MongoDB backup strategy | #11, #15 |
| [#18](https://github.com/selcuk-yalcin/Kurdbot/issues/18) | Production: monitoring and log rotation | #15 |

### Checklist (Cem)

- [ ] #21 Local Docker stack + `llama3.2:3b` (start today)
- [ ] #1 Provision model server
- [ ] #6 Tavily API key
- [ ] #7 Install Ollama + `kurdish-bot`
- [ ] #8 Expose Ollama API
- [ ] #11 Start Docker Compose stack
- [ ] #12 Verify Ollama ↔ LibreChat
- [ ] #14 Tavily QA
- [ ] #16 nginx/Caddy + SSL
- [ ] #17 MongoDB backups
- [ ] #18 Monitoring + log rotation

---

## Shared

| Issue | Task | Assignees |
|-------|------|-----------|
| [#20](https://github.com/selcuk-yalcin/Kurdbot/issues/20) | Implementation roadmap — waves, owners, and parallel work | @selcuk-yalcin, @cem-acun |

Close #20 when all other issues are done.

---

## Wave overview (who starts when)

```
Wave 1 (now, parallel)
  Selçuk: #2 #3 #4 #5 #19
  Cem:    #1 #6

Wave 2
  Cem:    #7 → #8
  Selçuk: #9 ; #10 (needs #6 + #8 from Cem)

Wave 3
  Cem:    #11 → #12

Wave 4 (parallel after #12)
  Selçuk: #13
  Cem:    #14
  Selçuk: #15 (after #13 + #14)

Wave 5 (optional, after #15)
  Cem:    #16 #17 #18 (can run in parallel)
```

---

## Hand-offs between people

| From | To | What |
|------|-----|------|
| Selçuk (#2) | Cem (#7) | Modelfile merged on `main` |
| Cem (#6) | Selçuk (#10) | Tavily API key (secure channel only) |
| Cem (#8) | Selçuk (#10) | Model server IP for `OLLAMA_BASE_URL` |
| Selçuk (#10) | Cem (#11) | `.env` ready on app host (never commit secrets) |
| Selçuk (#15) | Cem (#16–#18) | QA sign-off before production |

---

## Related docs

- [TODO.md](./TODO.md) — phased checklist
- [RESOURCES.md](./RESOURCES.md) — verified external links
- [SPEC.md](./SPEC.md) — technical specification
- [STRUCTURE.md](./STRUCTURE.md) — repository layout
