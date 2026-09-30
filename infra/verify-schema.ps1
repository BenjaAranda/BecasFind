param(
    [string]$PostgresBin = 'C:\Program Files\PostgreSQL\17\bin',
    [string]$Java = 'C:\Program Files\Java\jdk-17\bin\java.exe',
    [string]$BackupToRestore,
    [string]$ConcurrencyTestMaven
)
$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path $PSScriptRoot -Parent
$jar = Join-Path $repoRoot 'backend\target\becasfind-api-1.0.0-SNAPSHOT.jar'
if (-not (Test-Path $jar)) { throw 'Empaquetar el backend antes de verificar el esquema.' }
$work = Join-Path ([IO.Path]::GetTempPath()) ('becasfind-schema-' + [guid]::NewGuid().ToString('N'))
[IO.Directory]::CreateDirectory($work) | Out-Null
$data = Join-Path $work 'postgres'
$passwordFile = Join-Path $work 'password.txt'
$password = [guid]::NewGuid().ToString('N')
[IO.File]::WriteAllText($passwordFile, $password, [Text.UTF8Encoding]::new($false))
$listener = [Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback, 0)
$listener.Start()
$port = $listener.LocalEndpoint.Port
$listener.Stop()
$savedEnv = @{}
foreach ($key in @('PGPASSWORD','PGCLIENTENCODING','DB_URL','DB_USERNAME','DB_PASSWORD','JWT_SECRET','SPRING_PROFILES_ACTIVE','PORT','SPRING_DATASOURCE_PASSWORD')) {
    $savedEnv[$key] = [Environment]::GetEnvironmentVariable($key, 'Process')
}
$started = $false
$app = $null
try {
    & "$PostgresBin\initdb.exe" -D $data -U schema_check --encoding=UTF8 --locale=C --auth=scram-sha-256 --pwfile=$passwordFile *> (Join-Path $work 'init.log')
    if ($LASTEXITCODE -ne 0) { throw "No se pudo inicializar PostgreSQL. Revisar $work" }
    Remove-Item -LiteralPath $passwordFile
    $pgStart = Start-Process -FilePath "$PostgresBin\pg_ctl.exe" -ArgumentList @('-D', ('"' + $data + '"'), '-l', ('"' + (Join-Path $work 'postgres.log') + '"'), '-o', ('"-h 127.0.0.1 -p ' + $port + '"'), '-w', 'start') -WindowStyle Hidden -PassThru -RedirectStandardOutput (Join-Path $work 'start.log') -RedirectStandardError (Join-Path $work 'start-error.log')
    $pgStart.WaitForExit()
    if ($pgStart.ExitCode -ne 0) { throw "No se pudo iniciar PostgreSQL. Revisar $work" }
    $started = $true
    $env:PGPASSWORD = $password
    $env:PGCLIENTENCODING = 'UTF8'
    $psqlArgs = @('-h','127.0.0.1','-p',"$port",'-U','schema_check','-d','postgres','-v','ON_ERROR_STOP=1')
    foreach ($file in @('infra\ddl.sql','backend\src\main\resources\data.sql','infra\ddl.sql')) {
        & "$PostgresBin\psql.exe" @psqlArgs -f (Join-Path $repoRoot $file) *> (Join-Path $work 'schema.log')
        if ($LASTEXITCODE -ne 0) { throw "Falló el esquema o su repetición. Revisar $work" }
    }
    $counts = & "$PostgresBin\psql.exe" @psqlArgs -At -c "SELECT (SELECT count(*) FROM regiones), (SELECT count(*) FROM roles WHERE nombre_rol IN ('ADMIN','STUDENT')), (SELECT count(*) FROM usuarios);"
    if ($counts -ne '16|2|0') { throw 'Los catálogos no son idempotentes o se crearon cuentas inesperadas.' }
    $validationDb = 'postgres'
    if ($BackupToRestore) {
        & "$PostgresBin\createdb.exe" -h 127.0.0.1 -p $port -U schema_check existing_copy
        if ($LASTEXITCODE -ne 0) { throw 'No se pudo crear la base de restauración.' }
        & "$PostgresBin\pg_restore.exe" -h 127.0.0.1 -p $port -U schema_check -d existing_copy --no-owner --no-privileges --exit-on-error $BackupToRestore *> (Join-Path $work 'restore.log')
        if ($LASTEXITCODE -ne 0) { throw "Falló la restauración. Revisar $work" }
        $psqlArgs = @('-h','127.0.0.1','-p',"$port",'-U','schema_check','-d','existing_copy','-v','ON_ERROR_STOP=1')
        for ($repeat = 0; $repeat -lt 2; $repeat++) {
            & "$PostgresBin\psql.exe" @psqlArgs -f (Join-Path $repoRoot 'infra\migrations\001_align_schema.sql') *> (Join-Path $work 'migration.log')
            if ($LASTEXITCODE -ne 0) { throw "Falló la migración de la copia. Revisar $work" }
        }
        $validationDb = 'existing_copy'
    }
    $usersBefore = & "$PostgresBin\psql.exe" @psqlArgs -At -c 'SELECT count(*) FROM usuarios;'
    $userFingerprintSql = "SELECT md5(COALESCE(string_agg(row_to_json(t)::text, '' ORDER BY row_to_json(t)::text), '')) FROM usuarios t;"
    $userFingerprintBefore = & "$PostgresBin\psql.exe" @psqlArgs -At -c $userFingerprintSql
    $env:DB_URL = "jdbc:postgresql://127.0.0.1:$port/$validationDb"
    $env:DB_USERNAME = 'schema_check'
    $env:DB_PASSWORD = $password
    $env:JWT_SECRET = [guid]::NewGuid().ToString('N') + [guid]::NewGuid().ToString('N')
    # El arranque de producción debe excluir el seeder por sí mismo.
    $env:SPRING_PROFILES_ACTIVE = 'prod'
    $env:PORT = '0'
    $stdout = Join-Path $work 'app.log'
    $app = Start-Process -FilePath $Java -ArgumentList @('-jar', ('"' + $jar + '"')) -WindowStyle Hidden -PassThru -RedirectStandardOutput $stdout -RedirectStandardError (Join-Path $work 'app-error.log')
    $deadline = (Get-Date).AddSeconds(45)
    $ready = $false
    while ((Get-Date) -lt $deadline) {
        if (Test-Path $stdout) {
            $log = Get-Content -LiteralPath $stdout -Raw
            if ($log -match 'Started BecasFindApplication') { $ready = $true; break }
        }
        if ($app.HasExited) { break }
        Start-Sleep -Milliseconds 250
    }
    if (-not $ready) { throw "Falló la validación JPA sobre PostgreSQL real. Revisar $work" }
    $users = & "$PostgresBin\psql.exe" @psqlArgs -At -c 'SELECT count(*) FROM usuarios;'
    if ($users -ne $usersBefore) { throw 'El arranque de verificación cambió el número de usuarios.' }
    $userFingerprintAfter = & "$PostgresBin\psql.exe" @psqlArgs -At -c $userFingerprintSql
    if ($userFingerprintAfter -ne $userFingerprintBefore) { throw 'El arranque cambió contraseñas o datos de usuarios.' }
    if ($ConcurrencyTestMaven) {
        & "$PostgresBin\createdb.exe" -h 127.0.0.1 -p $port -U schema_check concurrency_check
        if ($LASTEXITCODE -ne 0) { throw 'No se pudo crear la base aislada de concurrencia.' }
        $env:SPRING_DATASOURCE_PASSWORD = $password
        $env:SPRING_PROFILES_ACTIVE = 'test'
        $reportsDir = Join-Path $repoRoot 'backend\target\surefire-reports'
        $savedReportsDir = Join-Path $work 'previous-reports'
        $pgReportsDir = Join-Path $work 'concurrency-reports'
        [IO.Directory]::CreateDirectory($savedReportsDir) | Out-Null
        [IO.Directory]::CreateDirectory($pgReportsDir) | Out-Null
        $savedReports = @(Get-ChildItem -LiteralPath $reportsDir -Filter '*AccountSecurityTest*' -ErrorAction SilentlyContinue)
        foreach ($report in $savedReports) { Copy-Item -LiteralPath $report.FullName -Destination $savedReportsDir }
        $testArgs = @('-q', '-f', (Join-Path $repoRoot 'backend\pom.xml'),
            '-Dtest=AccountSecurityTest#concurrentRecoveryHasExactlyOneWinner',
            "-Dspring.datasource.url=jdbc:postgresql://127.0.0.1:$port/concurrency_check",
            '-Dspring.datasource.username=schema_check', '-Dspring.datasource.driver-class-name=org.postgresql.Driver',
            '-Dspring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect',
            'test')
        try {
            & $ConcurrencyTestMaven @testArgs *> (Join-Path $work 'concurrency.log')
            $concurrencyExit = $LASTEXITCODE
            Get-ChildItem -LiteralPath $reportsDir -Filter '*AccountSecurityTest*' | ForEach-Object { Copy-Item -LiteralPath $_.FullName -Destination $pgReportsDir }
        } finally {
            foreach ($report in $savedReports) { Copy-Item -LiteralPath (Join-Path $savedReportsDir $report.Name) -Destination $report.FullName }
        }
        if ($concurrencyExit -ne 0) { throw "Falló concurrencia en PostgreSQL. Revisar $work" }
        Write-Output 'Consumo simultáneo de token verificado en PostgreSQL real: exactamente una solicitud exitosa.'
    }
    Write-Output 'Esquema PostgreSQL 17 validado por Hibernate; instalación repetible; 16 regiones, roles correctos y cero cuentas de demostración.'
    if ($BackupToRestore) { Write-Output 'Respaldo restaurado y migrado dos veces; esquema existente validado y usuarios conservados.' }
    Write-Output "Registros de verificación: $work"
} finally {
    if ($null -ne $app -and -not $app.HasExited) { Stop-Process -Id $app.Id; $app.WaitForExit() }
    if ($started) { & "$PostgresBin\pg_ctl.exe" -D $data -m fast -w stop *> (Join-Path $work 'stop.log') }
    if (Test-Path $passwordFile) { Remove-Item -LiteralPath $passwordFile }
    foreach ($key in $savedEnv.Keys) { [Environment]::SetEnvironmentVariable($key, $savedEnv[$key], 'Process') }
}
