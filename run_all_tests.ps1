# Verificación local reproducible; Playwright administra su preview aislado.
param([string]$MavenPath)
$ErrorActionPreference = 'Stop'
$repoRoot = $PSScriptRoot
if (!$MavenPath) {
    $command = Get-Command mvn -ErrorAction SilentlyContinue
    if ($command) { $MavenPath = $command.Source }
}
if (!$MavenPath -or !(Test-Path -LiteralPath $MavenPath)) {
    throw 'Indicar -MavenPath con la ruta al ejecutable mvn.cmd o instalar Maven en PATH.'
}
Push-Location $repoRoot
try {
    & $MavenPath -B -ntp -f backend/pom.xml test
    if ($LASTEXITCODE -ne 0) { throw 'Fallaron las pruebas backend.' }
    & npm --prefix frontend ci
    if ($LASTEXITCODE -ne 0) { throw 'Falló la instalación reproducible del frontend.' }
    & npm --prefix frontend run lint
    if ($LASTEXITCODE -ne 0) { throw 'Falló lint.' }
    & npm --prefix frontend audit --audit-level=high
    if ($LASTEXITCODE -ne 0) { throw 'Falló el control de vulnerabilidades.' }
    & npm --prefix frontend run build
    if ($LASTEXITCODE -ne 0) { throw 'Falló el build frontend.' }
    & node frontend/node_modules/@playwright/test/cli.js install chromium firefox
    if ($LASTEXITCODE -ne 0) { throw 'Falló la instalación de navegadores.' }
    & node frontend/node_modules/@playwright/test/cli.js test -c frontend/playwright.config.ts --workers 1
    if ($LASTEXITCODE -ne 0) { throw 'Fallaron las pruebas de navegador.' }
    Write-Output 'Pruebas backend, lint, audit, build y Chromium/Firefox aprobados. PostgreSQL real y rendimiento se ejecutan con los comandos de documentacion/CALIDAD_PRE_DESPLIEGUE.md.'
} finally { Pop-Location }
