param([switch]$Apply, [string]$PostgresBin = 'C:\Program Files\PostgreSQL\17\bin')
$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path $PSScriptRoot -Parent
$localVars = @{}
foreach ($line in [IO.File]::ReadAllLines((Join-Path $repoRoot 'backend\.env'))) {
    if ($line -match '^\s*([A-Z_]+)\s*=\s*(.*)$') { $localVars[$matches[1]] = $matches[2].Trim().Trim('"').Trim("'") }
}
if ($localVars.DB_URL -notmatch '^jdbc:postgresql://([^/:]+)(?::(\d+))?/([^?]+)') { throw 'DB_URL local no reconocida.' }
$dbHost = $matches[1]
$dbPort = if ($matches[2]) { $matches[2] } else { '5432' }
$dbName = $matches[3]
if ($dbHost -notin @('localhost','127.0.0.1')) { throw 'Este procedimiento solo permite la base local.' }
$savedPassword = $env:PGPASSWORD
$savedEncoding = $env:PGCLIENTENCODING
$backupDir = Join-Path ([Environment]::GetFolderPath('LocalApplicationData')) ('BecasFind\backups\' + [guid]::NewGuid().ToString('N'))
[IO.Directory]::CreateDirectory($backupDir) | Out-Null
$backupFile = Join-Path $backupDir 'before-migration.dump'
$tables = @('regiones','comunas','roles','usuarios','tipos_institucion','instituciones','tipos_beca','becas','becas_regiones','requisitos_perfil','documentos_requeridos','password_reset_tokens','perfiles_estudiante','becas_favoritas')
try {
    $env:PGPASSWORD = $localVars.DB_PASSWORD
    $env:PGCLIENTENCODING = 'UTF8'
    $conn = @('-h',$dbHost,'-p',$dbPort,'-U',$localVars.DB_USERNAME,'-d',$dbName)
    $before = @{}
    foreach ($table in $tables) {
        $before[$table] = & "$PostgresBin\psql.exe" @conn -At -v ON_ERROR_STOP=1 -c "SELECT md5(COALESCE(string_agg(row_to_json(t)::text, '' ORDER BY row_to_json(t)::text), '')) FROM $table t;"
        if ($LASTEXITCODE -ne 0) { throw "No se pudo verificar $table" }
    }
    & "$PostgresBin\pg_dump.exe" @conn --format=custom --file=$backupFile
    if ($LASTEXITCODE -ne 0) { throw 'No se pudo respaldar la base.' }
    & (Join-Path $PSScriptRoot 'verify-schema.ps1') -PostgresBin $PostgresBin -BackupToRestore $backupFile
    if ($Apply) {
        & "$PostgresBin\psql.exe" @conn -v ON_ERROR_STOP=1 -f (Join-Path $PSScriptRoot 'migrations\001_align_schema.sql') *> (Join-Path $backupDir 'apply.log')
        if ($LASTEXITCODE -ne 0) { throw "Migración revertida. Revisar $backupDir" }
        foreach ($table in $tables) {
            $after = & "$PostgresBin\psql.exe" @conn -At -v ON_ERROR_STOP=1 -c "SELECT md5(COALESCE(string_agg(row_to_json(t)::text, '' ORDER BY row_to_json(t)::text), '')) FROM $table t;"
            if ($LASTEXITCODE -ne 0 -or $after -ne $before[$table]) { throw "Los datos de $table cambiaron durante la verificación; revisar antes de continuar." }
        }
        Write-Output 'Migración local aplicada; las filas de las 14 tablas permanecen idénticas.'
    } else { Write-Output 'Respaldo y ensayo completos; la base original no se modificó.' }
    Write-Output "Respaldo previo conservado: $backupFile"
} finally {
    $env:PGPASSWORD = $savedPassword
    $env:PGCLIENTENCODING = $savedEncoding
}
