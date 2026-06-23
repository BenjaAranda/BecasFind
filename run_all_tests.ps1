# BecasFind · Test Suite Runner
# Ejecuta todos los tests automatizados y muestra resultados

$ErrorActionPreference = "Continue"
$base = Split-Path -Parent $MyInvocation.MyCommand.Path

# Locate Maven — try IntelliJ bundled first, then PATH
$mvnCmd = $null
$knownMvnPaths = @(
    "C:\Program Files\JetBrains\IntelliJ IDEA 2025.1\plugins\maven\lib\maven3\bin\mvn.cmd",
    "C:\Program Files\JetBrains\IntelliJ IDEA 2024.3\plugins\maven\lib\maven3\bin\mvn.cmd"
)
foreach ($p in $knownMvnPaths) {
    if (Test-Path $p) { $mvnCmd = $p; break }
}
if (-not $mvnCmd) {
    $mvnCmd = (Get-Command mvn -ErrorAction SilentlyContinue).Source
}
if (-not $mvnCmd) {
    Write-Host "ERROR: No se encontró Maven. Instálalo o ajusta la variable `$mvnCmd en este script." -ForegroundColor Red
    exit 1
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  BECASFIND · TEST SUITE AUTOMATIZADA" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# ── Phase 1: Backend Tests (JUnit 5 + H2) ──
Write-Host "[1/2] Backend Tests (JUnit 5 + H2 en memoria)..." -ForegroundColor Yellow

# Ensure target is clean
$targetDir = "$base\backend\target"
if (Test-Path $targetDir) { Remove-Item -Recurse -Force $targetDir -ErrorAction SilentlyContinue }

Push-Location "$base\backend"
$result = & $mvnCmd test 2>&1
Pop-Location

# Extract results
$total = 0; $passed = 0; $failed = 0; $errors = 0
if (Test-Path "$base\backend\target\surefire-reports") {
    Get-ChildItem "$base\backend\target\surefire-reports" -Filter "*.txt" | ForEach-Object {
        $c = Get-Content $_.FullName -Raw
        if ($c -match 'Tests run: (\d+), Failures: (\d+), Errors: (\d+)') {
            $total += [int]$Matches[1]
            $passed += [int]$Matches[1] - [int]$Matches[2] - [int]$Matches[3]
            $failed += [int]$Matches[2]
            $errors += [int]$Matches[3]
        }
    }
}

if ($total -eq 0) {
    Write-Host "  Backend: No se encontraron resultados. Revisa la salida de Maven arriba." -ForegroundColor Yellow
    Write-Host "  Resultado de Maven (últimas 20 líneas):" -ForegroundColor Yellow
    $result | Select-Object -Last 20 | ForEach-Object { Write-Host "    $_" }
} else {
    Write-Host "  Backend: $total ejecutados | " -NoNewline
    Write-Host "$passed PASADOS " -NoNewline -ForegroundColor Green
    if ($failed -gt 0) { Write-Host "$failed fallidos " -NoNewline -ForegroundColor Red }
    if ($errors -gt 0) { Write-Host "$errors errores " -NoNewline -ForegroundColor Red }
    Write-Host ""
}

# ── Phase 2: Frontend E2E Tests (Playwright) ──
Write-Host "`n[2/2] Frontend E2E Tests (Playwright)..." -ForegroundColor Yellow

$frontendOk = $false
try {
    $r = Invoke-RestMethod -Uri "http://localhost:5173" -Method GET -TimeoutSec 3 -ErrorAction Stop
    $frontendOk = $true
} catch { }

if (-not $frontendOk) {
    Write-Host "  Frontend no detectado en :5173 — iniciando..." -ForegroundColor Yellow
    Start-Process -FilePath "npm" -ArgumentList "run dev" -WorkingDirectory "$base\frontend" -WindowStyle Minimized
    Start-Sleep -Seconds 10
}

if (Test-Path "$base\frontend\playwright.config.ts") {
    Push-Location "$base\frontend"
    npx playwright test 2>&1
    Pop-Location
} else {
    Write-Host "  Playwright no instalado — ejecuta: cd frontend && npm init playwright@latest" -ForegroundColor Yellow
}

# ── Summary ──
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  RESULTADO FINAL" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Backend :  $passed / $total pasados"
Write-Host "  Frontend:  Playwright E2E (ver arriba)"
Write-Host "  Reportes:  backend/target/surefire-reports/"
Write-Host "========================================`n" -ForegroundColor Cyan
