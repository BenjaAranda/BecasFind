param(
    [switch]$Reboot,
    [string]$KeyPath = (Join-Path $env:USERPROFILE '.ssh\becasfind')
)

$ErrorActionPreference = 'Stop'
$sshOptions = @('-T', '-o', 'BatchMode=yes', '-o', 'ConnectTimeout=5',
    '-o', 'StrictHostKeyChecking=yes', '-o', 'IdentitiesOnly=yes',
    '-i', $KeyPath, 'ubuntu@155.181.41.231')

function Invoke-ServerCommand([string]$Command) {
    $commandOutput = @(& ssh.exe @sshOptions $Command)
    if ($LASTEXITCODE -ne 0) { throw 'Fallo la conexión o el comando remoto.' }
    return $commandOutput
}

$databaseCheck = 'sudo -n docker exec becasfind-db psql -AtX -U postgres -d becasfind -v ON_ERROR_STOP=1 -c "SELECT system_identifier FROM pg_control_system();"'
$previousDatabase = ((Invoke-ServerCommand $databaseCheck) -join "`n").Trim()
if ($previousDatabase -notmatch '^\d+$') { throw 'No se pudo verificar el identificador de PostgreSQL.' }
Write-Host "PostgreSQL antes: $previousDatabase"

if ($Reboot) {
    $previousBoot = ((Invoke-ServerCommand 'cat /proc/sys/kernel/random/boot_id') -join '').Trim()
    Write-Host 'Reiniciando la instancia existente. Esperando su regreso...'
    & ssh.exe @sshOptions 'sudo -n reboot'
    if ($LASTEXITCODE -notin @(0, 255)) { throw 'El servidor rechazó el reinicio.' }

    $restartDeadline = [DateTime]::UtcNow.AddMinutes(4)
    $newBootDetected = $false
    do {
        Start-Sleep -Seconds 5
        $bootOutput = @(& ssh.exe @sshOptions 'cat /proc/sys/kernel/random/boot_id' 2>$null)
        $bootExitCode = $LASTEXITCODE
        $currentBoot = ($bootOutput -join '').Trim()
        if ($bootExitCode -eq 0 -and $currentBoot -match '^[0-9a-f-]{36}$' -and $currentBoot -ne $previousBoot) {
            $newBootDetected = $true
            break
        }
    } while ([DateTime]::UtcNow -lt $restartDeadline)
    if (-not $newBootDetected) { throw 'No se confirmó un nuevo arranque en cuatro minutos. No se repetira el reinicio.' }
}

$serviceDeadline = [DateTime]::UtcNow.AddMinutes(2)
$servicesReady = $false
do {
    $probeOutput = @(& ssh.exe @sshOptions 'curl -fsS --max-time 10 -o /dev/null https://155-181-41-231.sslip.io/api/regiones' 2>$null)
    if ($LASTEXITCODE -eq 0) { $servicesReady = $true; break }
    Start-Sleep -Seconds 5
} while ([DateTime]::UtcNow -lt $serviceDeadline)
if (-not $servicesReady) { throw 'La API no respondio correctamente. Revisar contenedores, Nginx y firewall.' }

$currentDatabase = ((Invoke-ServerCommand $databaseCheck) -join "`n").Trim()
Write-Host "PostgreSQL despues: $currentDatabase"
if ($currentDatabase -ne $previousDatabase) { throw 'El identificador PostgreSQL cambio. Detener la carga de datos e investigar.' }

Invoke-ServerCommand 'sudo -n docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
Invoke-ServerCommand 'systemctl is-active nginx becasfind-web-firewall.service certbot.timer'
Invoke-ServerCommand 'sudo -n docker exec becasfind-db psql -X -U postgres -d becasfind -v ON_ERROR_STOP=1 -c "SELECT count(*) AS regiones FROM regiones; SELECT count(*) AS usuarios FROM usuarios; SELECT count(*) AS becas FROM becas;"'
Write-Host 'HTTPS 200; mismo cluster PostgreSQL; servicios activos.'
