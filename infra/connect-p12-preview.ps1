param([string]$KeyPath = (Join-Path $env:USERPROFILE '.ssh\becasfind'))
$ErrorActionPreference = 'Stop'
$helperPath = Join-Path $PSScriptRoot 'connect-p12-preview.py'
foreach ($requiredPath in @($KeyPath, $helperPath)) {
    if (-not (Test-Path -LiteralPath $requiredPath -PathType Leaf)) {
        throw "Falta un archivo necesario: $requiredPath"
    }
}
# Transmitir bytes evita la recodificación de stdin en Windows PowerShell 5.1.
$encoded = [Convert]::ToBase64String([IO.File]::ReadAllBytes($helperPath))
$remoteCommand = "printf '%s' '$encoded' | base64 --decode | python3 -"
& ssh.exe -T -o ConnectTimeout=15 -o StrictHostKeyChecking=yes -o IdentitiesOnly=yes `
    -i $KeyPath ubuntu@155.181.41.231 $remoteCommand
if ($LASTEXITCODE -ne 0) { throw 'La transición no terminó correctamente. Revisar antes de repetir.' }
