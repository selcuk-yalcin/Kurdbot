# Repository Structure

```
Kurdbot/
├── docker-compose.yml              # ✅ SELÇUK — LibreChat + Mongo + Redis (NO Ollama)
├── .env.example
├── WHO-DOES-WHAT.md
├── README.md
├── SPEC.md
├── TODO.md
├── ISSUES.md
├── ASSIGNMENTS.md
├── STRUCTURE.md
├── RESOURCES.md
├── librechat/
│   └── librechat.yaml              # ✅ SELÇUK
├── model-server/                   # 👤 CEM owns this folder for runtime
│   ├── docker-compose.yml          # 👤 CEM — Ollama only (#21)
│   ├── README.md                   # 👤 CEM guide
│   └── Modelfile                   # ❌ placeholder (#2 Selçuk writes; Cem uses)
└── scripts/
    ├── pull-local-model.sh         # Helper for Cem's Ollama compose
    └── setup.sh                    # placeholder (#9)
```

| File | Owner |
|------|-------|
| Root `docker-compose.yml` | Selçuk |
| `model-server/docker-compose.yml` | **Cem** |
| `librechat/librechat.yaml` | Selçuk |
| `Modelfile` content | Selçuk writes (#2); Cem runs (#7/#21) |
