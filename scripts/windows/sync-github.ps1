param(
    [string]$RepositoryUrl = "https://github.com/gabrisantoss/SisUsina.git",
    [string]$BranchName = "codex/portal-bazan-modernization",
    [string]$CommitMessage = "Moderniza Portal Bazan"
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = (Resolve-Path (Join-Path $ScriptDir "..\..")).Path

function Require-Command {
    param([string]$Name)
    $command = Get-Command $Name -ErrorAction SilentlyContinue
    if (-not $command) {
        throw "Comando obrigatorio nao encontrado: $Name"
    }
    return $command.Source
}

$git = Require-Command "git"
$gh = Require-Command "gh"

Push-Location $RootDir
try {
    & $gh auth status | Out-Host

    if (-not (Test-Path -LiteralPath ".git")) {
        & $git init
    }

    $origin = (& $git remote get-url origin 2>$null)
    if (-not $origin) {
        & $git remote add origin $RepositoryUrl
    } elseif ($origin -ne $RepositoryUrl) {
        & $git remote set-url origin $RepositoryUrl
    }

    & $git fetch origin --prune 2>$null

    $currentBranch = (& $git branch --show-current)
    if (-not $currentBranch) {
        & $git checkout -b $BranchName
    } elseif ($currentBranch -in @("main", "master")) {
        & $git checkout -b $BranchName
    }

    & $git status -sb | Out-Host

    Write-Host ""
    Write-Host "Revise o status acima. Pressione ENTER para commitar e enviar, ou Ctrl+C para cancelar."
    [void][System.Console]::ReadLine()

    & $git add -A
    & $git commit -m $CommitMessage
    $pushBranch = (& $git branch --show-current)
    & $git push -u origin $pushBranch

    Write-Host "Sincronizado em $RepositoryUrl branch $pushBranch"
} finally {
    Pop-Location
}
