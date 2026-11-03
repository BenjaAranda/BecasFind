param(
    [string]$KeyPath = (Join-Path $env:USERPROFILE '.ssh\becasfind')
)

$ErrorActionPreference = 'Stop'
$repoPath = Split-Path -Parent $PSScriptRoot
$csvPath = Join-Path $repoPath 'documentacion\auditoria_corpus\procesados\despliegue_p12\confirmadas_inactivas.csv'
$helperPath = Join-Path $PSScriptRoot 'import-p12-catalog.py'
$expectedHash = '757cec62e2dcb3ac980c65bc4a33c2ea204b6c2eba1b9d536188108400732d16'

foreach ($requiredPath in @($KeyPath, $csvPath, $helperPath)) {
    if (-not (Test-Path -LiteralPath $requiredPath -PathType Leaf)) {
        throw "Falta un archivo necesario: $requiredPath"
    }
}
if ((Get-FileHash -LiteralPath $csvPath -Algorithm SHA256).Hash.ToLowerInvariant() -ne $expectedHash) {
    throw 'El CSV no coincide con el paquete revisado. No se ha transferido.'
}

Write-Host 'Se subirán el CSV inactivo y el importador. SSH puede solicitar la frase de tu clave.'
& scp.exe -o ConnectTimeout=15 -o StrictHostKeyChecking=yes -o IdentitiesOnly=yes `
    -i $KeyPath $csvPath $helperPath 'ubuntu@155.181.41.231:~/becasfind-p12/'
if ($LASTEXITCODE -ne 0) { throw 'Falló la transferencia; no se inició la importación.' }

Write-Host 'La contraseña de BecasFind se introduce en la terminal remota, no en el chat.'
& ssh.exe -t -o ConnectTimeout=15 -o StrictHostKeyChecking=yes -o IdentitiesOnly=yes `
    -i $KeyPath ubuntu@155.181.41.231 `
    'python3 ~/becasfind-p12/import-p12-catalog.py ~/becasfind-p12/confirmadas_inactivas.csv'
if ($LASTEXITCODE -ne 0) { throw 'El importador se detuvo. Revisar el resultado antes de repetir.' }
