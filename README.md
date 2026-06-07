# Portal Bazan

Portal local dos sistemas internos da Usina Bazan.

Entrada publica principal:

- `http://portalbazan:8090`
- porta publica fixa: `8090`

Rotas publicas preservadas:

- `/`
- `/notas`
- `/colaboradores`
- `/balanca`
- `/balanca-api`
- `/analises`

Cadastro central dos sistemas:

- `launcher_web/config/systems.json`

Comandos principais:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/windows/start-all.ps1
powershell -ExecutionPolicy Bypass -File scripts/windows/stop-all.ps1
powershell -ExecutionPolicy Bypass -File scripts/windows/restart-all.ps1
powershell -ExecutionPolicy Bypass -File scripts/windows/health-check.ps1
```

Health do portal:

```text
http://portalbazan:8090/health
```

O portal continua usando SQLite. Nao apague arquivos `.db`; migrations do `launcher_auth.db` criam backup pre-migracao em `backups_portal_bazan/`.
