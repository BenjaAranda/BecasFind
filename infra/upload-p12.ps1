param(
    [string]$KeyPath = (Join-Path $env:USERPROFILE '.ssh\becasfind'),
    [string]$Destination = 'ubuntu@155.181.41.231'
)

$ErrorActionPreference = 'Stop'
$repoPath = Split-Path -Parent $PSScriptRoot
$packagePath = Join-Path ([System.IO.Path]::GetTempPath()) 'becasfind-p12.tar.gz'

if (-not (Test-Path -LiteralPath $KeyPath -PathType Leaf)) {
    throw 'No se encuentra la clave SSH indicada.'
}

$sourcePaths = @(
    'backend/pom.xml', 'backend/Dockerfile', 'backend/.dockerignore',
    'backend/src/main', 'infra/ddl.sql', 'infra/migrations'
)
& tar.exe -czf $packagePath -C $repoPath @sourcePaths
if ($LASTEXITCODE -ne 0) { throw 'No se pudo preparar el paquete.' }

$entries = @(& tar.exe -tzf $packagePath)
if ($LASTEXITCODE -ne 0) { throw 'No se pudo verificar el paquete.' }
if ($entries | Where-Object { $_ -match '(^|/)\.env($|\.)|\.(key|pem)$|(^|/)(target|\.git)/' }) {
    throw 'El paquete contiene un archivo excluido. No se ha transferido.'
}

& scp.exe -o ConnectTimeout=20 -o IdentitiesOnly=yes -o StrictHostKeyChecking=yes -i $KeyPath $packagePath "${Destination}:~/becasfind-p12.tar.gz"
if ($LASTEXITCODE -ne 0) { throw 'Falló al subir el paquete por SSH.' }

$remoteCommand = 'mkdir -p ~/becasfind-p12 && tar -xzf ~/becasfind-p12.tar.gz -C ~/becasfind-p12 && cd ~/becasfind-p12 && sudo docker build -t becasfind-backend:p12 ./backend'
& ssh.exe -t -o ConnectTimeout=20 -o IdentitiesOnly=yes -o StrictHostKeyChecking=yes -i $KeyPath $Destination $remoteCommand
if ($LASTEXITCODE -ne 0) { throw 'La compilación remota no finalizo correctamente.' }

Write-Host 'Imagen p12 compilada. La aplicación y la base de datos aún no se han iniciado.'
