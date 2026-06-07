# Sincronizacao GitHub

Repositorio remoto:

```text
https://github.com/gabrisantoss/SisUsina
```

Este workspace contem dados operacionais locais. O GitHub deve receber codigo, scripts e documentacao, mas nao deve receber:

- bancos SQLite;
- logs;
- backups;
- PDFs, planilhas e anexos de producao;
- arquivos `.env`;
- uploads da Balanca;
- relatorios gerados.

Use o script:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/windows/sync-github.ps1
```

Pre-requisitos:

- Git for Windows instalado;
- GitHub CLI instalado;
- `gh auth login` ja executado na conta com acesso a `gabrisantoss/SisUsina`.

O script:

1. valida `git` e `gh`;
2. valida autenticacao do GitHub CLI;
3. inicializa `.git` se necessario;
4. configura `origin`;
5. cria branch `codex/portal-bazan-modernization`;
6. mostra o status antes de commitar;
7. commita e faz push para o GitHub.

Se houver arquivos inesperados no status, revise antes de confirmar o commit.
