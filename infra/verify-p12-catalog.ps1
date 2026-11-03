param(
    [string]$KeyPath = (Join-Path $env:USERPROFILE '.ssh\becasfind')
)

$ErrorActionPreference = 'Stop'
$sqlPath = Join-Path $PSScriptRoot 'verify-p12-catalog.sql'
foreach ($requiredPath in @($KeyPath, $sqlPath)) {
    if (-not (Test-Path -LiteralPath $requiredPath -PathType Leaf)) {
        throw "Falta un archivo necesario: $requiredPath"
    }
}

Write-Host 'Comprobacion de solo lectura: no importa, modifica ni activa becas.'
Get-Content -LiteralPath $sqlPath -Raw -Encoding UTF8 | & ssh.exe -T `
    -o ConnectTimeout=15 -o StrictHostKeyChecking=yes -o IdentitiesOnly=yes `
    -i $KeyPath ubuntu@155.181.41.231 `
    'sudo -n docker exec -i becasfind-db psql -X -U postgres -d becasfind -v ON_ERROR_STOP=1'
if ($LASTEXITCODE -ne 0) { throw 'La comprobacion no terminó correctamente; no se han reimportado datos.' }
