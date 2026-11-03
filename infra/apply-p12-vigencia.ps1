param([string]$KeyPath = (Join-Path $env:USERPROFILE '.ssh\becasfind'))

$ErrorActionPreference = 'Stop'
$files = @('import-p12-catalog.py', 'apply-p12-vigencia.py', 'apply-p12-vigencia.sql') |
    ForEach-Object { Join-Path $PSScriptRoot $_ }
foreach ($path in @($KeyPath) + $files) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Falta un archivo: $path" }
}
Write-Host 'Se corregirá el calendario UDD y se activara solo la ficha UChile revisada, con respaldo previo.'
& scp.exe -o ConnectTimeout=15 -o StrictHostKeyChecking=yes -o IdentitiesOnly=yes `
    -i $KeyPath @files 'ubuntu@155.181.41.231:~/becasfind-p12/'
if ($LASTEXITCODE -ne 0) { throw 'Falló la transferencia; no se inició el cambio.' }
& ssh.exe -t -o ConnectTimeout=15 -o StrictHostKeyChecking=yes -o IdentitiesOnly=yes `
    -i $KeyPath ubuntu@155.181.41.231 'python3 ~/becasfind-p12/apply-p12-vigencia.py'
if ($LASTEXITCODE -ne 0) { throw 'El cambio se detuvo. Revisar la salida antes de repetir.' }
