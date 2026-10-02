param(
    [string]$PostgresBin = 'C:\Program Files\PostgreSQL\17\bin',
    [string]$BackendJarPath
)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$work = Join-Path ([IO.Path]::GetTempPath()) ('becasfind-browser-pg-' + [guid]::NewGuid().ToString('N'))
[IO.Directory]::CreateDirectory($work) | Out-Null
$data = Join-Path $work 'data'
function Get-FreePort {
    $socket = [Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback, 0)
    $socket.Start(); $port = $socket.LocalEndpoint.Port; $socket.Stop(); return $port
}
function Wait-Http([string]$url) {
    $deadline = [DateTime]::UtcNow.AddSeconds(60)
    while ([DateTime]::UtcNow -lt $deadline) {
        try { Invoke-WebRequest $url -TimeoutSec 2 | Out-Null; return } catch { Start-Sleep -Milliseconds 500 }
    }
    throw "Service did not become ready: $url. Logs: $work"
}
$pgPort = Get-FreePort
$apiPort = Get-FreePort
$webPort = Get-FreePort
$saved = @{}
$keys = @('DB_URL','DB_USERNAME','DB_PASSWORD','JWT_SECRET','SPRING_PROFILES_ACTIVE','PORT',
    'CORS_ALLOWED_ORIGINS','VITE_API_URL','LIVE_API_URL','LIVE_FRONTEND_URL',
    'SPRING_DATASOURCE_URL','SPRING_DATASOURCE_USERNAME','SPRING_DATASOURCE_PASSWORD',
    'SPRING_DATASOURCE_DRIVER_CLASS_NAME','SPRING_JPA_PROPERTIES_HIBERNATE_DIALECT',
    'SPRING_JPA_HIBERNATE_DDL_AUTO','SPRING_SQL_INIT_MODE','SERVER_ADDRESS',
    'LIVE_POSTGRES_PORT','LIVE_POSTGRES_BIN')
foreach ($key in $keys) { $saved[$key] = [Environment]::GetEnvironmentVariable($key, 'Process') }
$started = $false
$backend = $null
$frontend = $null
try {
    & "$PostgresBin\initdb.exe" -D $data -U browser_verify --encoding=UTF8 --locale=C --locale-provider=icu --icu-locale=es-CL --auth=trust *> (Join-Path $work 'init.log')
    if ($LASTEXITCODE -ne 0) { throw 'initdb failed' }
    $launch = Start-Process "$PostgresBin\pg_ctl.exe" -ArgumentList @('-D', ('"' + $data + '"'), '-l', ('"' + (Join-Path $work 'postgres.log') + '"'), '-o', ('"-h 127.0.0.1 -p ' + $pgPort + '"'), '-w', 'start') -WindowStyle Hidden -PassThru -RedirectStandardOutput (Join-Path $work 'start.log')
    $launch.WaitForExit()
    if ($launch.ExitCode -ne 0) { throw 'PostgreSQL start failed' }
    $started = $true
    & "$PostgresBin\createdb.exe" -h 127.0.0.1 -p $pgPort -U browser_verify browser_profile
    if ($LASTEXITCODE -ne 0) { throw 'createdb failed' }
    foreach ($script in @((Join-Path $PSScriptRoot 'ddl.sql'))) {
        & "$PostgresBin\psql.exe" -h 127.0.0.1 -p $pgPort -U browser_verify -d browser_profile -v ON_ERROR_STOP=1 -f $script *> (Join-Path $work 'schema.log')
        if ($LASTEXITCODE -ne 0) { throw 'DDL failed' }
    }
    & "$PostgresBin\psql.exe" -h 127.0.0.1 -p $pgPort -U browser_verify -d browser_profile -v ON_ERROR_STOP=1 -c 'TRUNCATE roles, tipos_institucion, tipos_beca, regiones RESTART IDENTITY CASCADE' *> (Join-Path $work 'reset.log')
    if ($LASTEXITCODE -ne 0) { throw 'Temporary fixture reset failed' }
    & "$PostgresBin\psql.exe" -h 127.0.0.1 -p $pgPort -U browser_verify -d browser_profile -v ON_ERROR_STOP=1 -f (Join-Path $root 'backend/src/test/resources/data-test.sql') *> (Join-Path $work 'seed.log')
    if ($LASTEXITCODE -ne 0) { throw 'Fixture installation failed' }
    $env:DB_URL = "jdbc:postgresql://127.0.0.1:$pgPort/browser_profile"
    $env:DB_USERNAME = 'browser_verify'
    $env:DB_PASSWORD = ''
    $env:SPRING_DATASOURCE_URL = $env:DB_URL
    $env:SPRING_DATASOURCE_USERNAME = $env:DB_USERNAME
    $env:SPRING_DATASOURCE_PASSWORD = ''
    $env:SPRING_DATASOURCE_DRIVER_CLASS_NAME = 'org.postgresql.Driver'
    $env:SPRING_JPA_PROPERTIES_HIBERNATE_DIALECT = 'org.hibernate.dialect.PostgreSQLDialect'
    $env:SPRING_JPA_HIBERNATE_DDL_AUTO = 'validate'
    $env:SPRING_SQL_INIT_MODE = 'never'
    $env:SERVER_ADDRESS = '127.0.0.1'
    $env:JWT_SECRET = [guid]::NewGuid().ToString('N') + [guid]::NewGuid().ToString('N')
    $env:SPRING_PROFILES_ACTIVE = 'prod'
    $env:PORT = "$apiPort"
    $env:CORS_ALLOWED_ORIGINS = "http://127.0.0.1:$webPort"
    $env:VITE_API_URL = "http://127.0.0.1:$apiPort"
    $env:LIVE_API_URL = $env:VITE_API_URL
    $env:LIVE_FRONTEND_URL = "http://127.0.0.1:$webPort"
    $env:LIVE_POSTGRES_PORT = "$pgPort"
    $env:LIVE_POSTGRES_BIN = $PostgresBin
    $java = if ($env:JAVA_HOME) { Join-Path $env:JAVA_HOME 'bin/java.exe' } else { (Get-Command java).Source }
    $jar = if ($BackendJarPath) { (Resolve-Path -LiteralPath $BackendJarPath).Path } else {
        Join-Path $root 'backend/target/becasfind-api-1.0.0-SNAPSHOT.jar'
    }
    $backend = Start-Process $java -ArgumentList @('-jar', ('"' + $jar + '"')) -WindowStyle Hidden -PassThru -RedirectStandardOutput (Join-Path $work 'backend.log') -RedirectStandardError (Join-Path $work 'backend-error.log')
    Wait-Http "$env:LIVE_API_URL/api/regiones"
    $node = (Get-Command node).Source
    $frontend = Start-Process $node -WorkingDirectory (Join-Path $root 'frontend') -ArgumentList @('node_modules/vite/bin/vite.js', '--host', '127.0.0.1', '--port', "$webPort", '--strictPort') -WindowStyle Hidden -PassThru -RedirectStandardOutput (Join-Path $work 'frontend.log') -RedirectStandardError (Join-Path $work 'frontend-error.log')
    Wait-Http $env:LIVE_FRONTEND_URL
    Push-Location (Join-Path $root 'frontend')
    try {
        & $node node_modules/@playwright/test/cli.js test -c playwright.live.config.ts *> (Join-Path $work 'browser.log')
        $result = $LASTEXITCODE
        Get-Content (Join-Path $work 'browser.log') -Tail 20
        if ($result -ne 0) { throw "Browser verification failed. Logs: $work" }
    } finally { Pop-Location }
    $inactive = & "$PostgresBin\psql.exe" -h 127.0.0.1 -p $pgPort -U browser_verify -d browser_profile -v ON_ERROR_STOP=1 -t -A -c "SELECT CASE WHEN count(*)=1 AND bool_and(NOT activo) THEN 1 ELSE 0 END FROM usuarios WHERE email='crud-real@example.com'"
    if ($LASTEXITCODE -ne 0 -or "$inactive".Trim() -ne '1') { throw 'Deactivated account was not preserved in PostgreSQL.' }
    Write-Output "Live browser verification passed. Evidence: $work"
} finally {
    foreach ($process in @($frontend, $backend)) { if ($process -and !$process.HasExited) { Stop-Process -Id $process.Id } }
    if ($started) { & "$PostgresBin\pg_ctl.exe" -D $data -m fast -w stop *> (Join-Path $work 'stop.log') }
    foreach ($key in $saved.Keys) { [Environment]::SetEnvironmentVariable($key, $saved[$key], 'Process') }
}
