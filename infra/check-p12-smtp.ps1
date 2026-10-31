param(
    [string]$KeyPath = (Join-Path $env:USERPROFILE '.ssh\becasfind')
)

$ErrorActionPreference = 'Stop'
$helperPath = Join-Path $PSScriptRoot 'check-p12-smtp.py'
foreach ($requiredPath in @($KeyPath, $helperPath)) {
    if (-not (Test-Path -LiteralPath $requiredPath -PathType Leaf)) {
        throw "Falta un archivo necesario: $requiredPath"
    }
}

Write-Host 'Se comprobará STARTTLS desde Oracle. No se autentica ni se envían correos.'
Get-Content -LiteralPath $helperPath -Raw -Encoding UTF8 | & ssh.exe -T `
    -o ConnectTimeout=15 -o StrictHostKeyChecking=yes -o IdentitiesOnly=yes `
    -i $KeyPath ubuntu@155.181.41.231 'python3 -'
if ($LASTEXITCODE -ne 0) {
    throw 'La comprobación no terminó correctamente. El backend no se ha modificado.'
}
