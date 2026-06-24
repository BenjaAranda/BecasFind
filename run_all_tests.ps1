# BecasFind - Test Suite Runner
# Ejecuta todos los tests automatizados y muestra resultados

$ErrorActionPreference = "Continue"
$OutputEncoding = [Console]::OutputEncoding = [Text.Encoding]::UTF8
$base = Split-Path -Parent $MyInvocation.MyCommand.Path

# Locate Maven
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
    Write-Host "ERROR: No se encontro Maven. Instalalo o ajusta la variable mvnCmd en este script." -ForegroundColor Red
    exit 1
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  BECASFIND | TEST SUITE AUTOMATIZADA" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Phase 1: Backend Tests (JUnit 5 + H2)
Write-Host "[1/2] Backend Tests (JUnit 5 + H2 en memoria)..." -ForegroundColor Yellow

$targetDir = "$base\backend\target"
if (Test-Path $targetDir) { Remove-Item -Recurse -Force $targetDir -ErrorAction SilentlyContinue }

Push-Location "$base\backend"
$mvnOutput = & $mvnCmd test 2>&1
Pop-Location

$totalBack = 0; $passedBack = 0; $failedBack = 0; $errorsBack = 0
if (Test-Path "$base\backend\target\surefire-reports") {
    Get-ChildItem "$base\backend\target\surefire-reports" -Filter "*.txt" | ForEach-Object {
        $c = Get-Content $_.FullName -Raw
        if ($c -match 'Tests run: (\d+), Failures: (\d+), Errors: (\d+)') {
            $totalBack += [int]$Matches[1]
            $passedBack += [int]$Matches[1] - [int]$Matches[2] - [int]$Matches[3]
            $failedBack += [int]$Matches[2]
            $errorsBack += [int]$Matches[3]
        }
    }
}

if ($totalBack -eq 0) {
    Write-Host "  Backend: No se encontraron resultados. Revisa la salida de Maven arriba." -ForegroundColor Yellow
    $mvnOutput | Select-Object -Last 20 | ForEach-Object { Write-Host "    $_" }
} else {
    Write-Host "  Backend: $totalBack ejecutados | " -NoNewline
    Write-Host "$passedBack PASADOS " -NoNewline -ForegroundColor Green
    if ($failedBack -gt 0) { Write-Host "$failedBack fallidos " -NoNewline -ForegroundColor Red }
    if ($errorsBack -gt 0) { Write-Host "$errorsBack errores " -NoNewline -ForegroundColor Red }
    Write-Host ""
}

# Phase 2: Frontend E2E Tests (Playwright)
Write-Host "`n[2/2] Frontend E2E Tests (Playwright)..." -ForegroundColor Yellow

$frontendOk = $false
try {
    $r = Invoke-RestMethod -Uri "http://localhost:5173" -Method GET -TimeoutSec 3 -ErrorAction Stop
    $frontendOk = $true
} catch { }

if (-not $frontendOk) {
    Write-Host "  Frontend no detectado en :5173, iniciando..." -ForegroundColor Yellow
    Start-Process -FilePath "npm" -ArgumentList "run dev" -WorkingDirectory "$base\frontend" -WindowStyle Minimized
    Start-Sleep -Seconds 12
}

$totalE2E = 0; $passedE2E = 0; $failedE2E = 0

if (Test-Path "$base\frontend\playwright.config.ts") {
    Push-Location "$base\frontend"

    # Clean old report and test-results
    Remove-Item -Recurse -Force "playwright-report" -ErrorAction SilentlyContinue
    Remove-Item -Recurse -Force "test-results" -ErrorAction SilentlyContinue

    $pwOutput = npx playwright test 2>&1

    # Show Playwright output (filter out npm noise)
    $pwOutput | ForEach-Object {
        $line = $_.ToString()
        if ($line -match '^\s+(ok|✘)') {
            if ($line -match '^\s+ok') {
                Write-Host "    PASS  $($line -replace '^\s+ok\s+\d+\s+','')" -ForegroundColor Green
            } else {
                Write-Host "    FAIL  $($line -replace '^\s+✘\s+\d+\s+','')" -ForegroundColor Red
            }
        }
    }

    # Extract results from Playwright output (join to string for -match)
    $pwText = $pwOutput -join "`n"
    if ($pwText -match '(\d+) passed') { $passedE2E = [int]$Matches[1] }
    if ($pwText -match '(\d+) failed') { $failedE2E = [int]$Matches[1] }
    $totalE2E = $passedE2E + $failedE2E

    Pop-Location

    if ($totalE2E -gt 0) {
        Write-Host "  Frontend E2E: $totalE2E ejecutados | " -NoNewline
        Write-Host "$passedE2E PASADOS " -NoNewline -ForegroundColor Green
        if ($failedE2E -gt 0) { Write-Host "$failedE2E fallidos " -NoNewline -ForegroundColor Red }
        Write-Host ""
    } else {
        Write-Host "  Frontend E2E: No se detectaron resultados." -ForegroundColor Yellow
    }
} else {
    Write-Host "  Playwright no instalado." -ForegroundColor Yellow
}

# Summary
$grandTotal = $totalBack + $totalE2E
$grandPassed = $passedBack + $passedE2E
$grandFailed = $failedBack + $failedE2E

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  RESULTADO FINAL" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Backend :  $passedBack / $totalBack pasados"
Write-Host "  E2E     :  $passedE2E / $totalE2E pasados"
Write-Host "  TOTAL   :  $grandPassed / $grandTotal pasados"
if ($grandFailed -gt 0) {
    Write-Host "  FALLOS  :  $grandFailed" -ForegroundColor Red
}
Write-Host "  Reportes:  backend/target/surefire-reports/"
if (Test-Path "$base\frontend\playwright-report\index.html") {
    Write-Host "             frontend/playwright-report/index.html"
}
Write-Host "========================================`n" -ForegroundColor Cyan
