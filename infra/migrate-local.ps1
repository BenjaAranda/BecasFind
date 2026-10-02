param([switch]$Apply, [string]$BackendJarPath, [string]$PostgresBin = 'C:\Program Files\PostgreSQL\17\bin')
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
    $active = & "$PostgresBin\psql.exe" @conn -At -v ON_ERROR_STOP=1 -c "SELECT count(*) FROM pg_stat_activity WHERE datname=current_database() AND pid<>pg_backend_pid();"
    if ($LASTEXITCODE -ne 0 -or "$active".Trim() -ne '0') { throw 'Cierra las conexiones a la base local antes de respaldar y migrar.' }
    $before = @{}
    $projections = @{}
    foreach ($table in $tables) {
        $columns = & "$PostgresBin\psql.exe" @conn -At -v ON_ERROR_STOP=1 -c "SELECT string_agg(quote_ident(column_name), ',' ORDER BY ordinal_position) FROM information_schema.columns WHERE table_schema='public' AND table_name='$table';"
        if ($LASTEXITCODE -ne 0 -or !$columns) { throw "No se pudo leer esquema de $table" }
        $projections[$table] = "SELECT $columns FROM $table"
        $before[$table] = & "$PostgresBin\psql.exe" @conn -At -v ON_ERROR_STOP=1 -c "SELECT md5(COALESCE(string_agg(row_to_json(t)::text, '' ORDER BY row_to_json(t)::text), '')) FROM ($($projections[$table])) t;"
        if ($LASTEXITCODE -ne 0) { throw "No se pudo verificar $table" }
    }
    & "$PostgresBin\pg_dump.exe" @conn --format=custom --file=$backupFile
    if ($LASTEXITCODE -ne 0) { throw 'No se pudo respaldar la base.' }
    & (Join-Path $PSScriptRoot 'verify-schema.ps1') -PostgresBin $PostgresBin -BackupToRestore $backupFile -BackendJarPath $BackendJarPath
    if ($Apply) {
        foreach ($migration in Get-ChildItem -LiteralPath (Join-Path $PSScriptRoot 'migrations') -Filter '*.sql' | Sort-Object Name) {
            & "$PostgresBin\psql.exe" @conn -v ON_ERROR_STOP=1 -f $migration.FullName *> (Join-Path $backupDir ($migration.BaseName + '.log'))
            if ($LASTEXITCODE -ne 0) { throw "Migración fallida. Revisar $backupDir; no arrancar aplicación." }
        }
        foreach ($table in $tables) {
            $after = & "$PostgresBin\psql.exe" @conn -At -v ON_ERROR_STOP=1 -c "SELECT md5(COALESCE(string_agg(row_to_json(t)::text, '' ORDER BY row_to_json(t)::text), '')) FROM ($($projections[$table])) t;"
            if ($LASTEXITCODE -ne 0 -or $after -ne $before[$table]) { throw "Los datos de $table cambiaron durante la verificación; revisar antes de continuar." }
        }
        Write-Output 'Migración local aplicada; los campos originales de las 14 tablas permanecen idénticos; migraciones 001–005 aplicadas.'
    } else { Write-Output 'Respaldo y ensayo completos; la base original no se modificó.' }
    Write-Output "Respaldo previo conservado: $backupFile"
} finally {
    $env:PGPASSWORD = $savedPassword
    $env:PGCLIENTENCODING = $savedEncoding
}
