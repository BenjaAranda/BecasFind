param(
    [Parameter(Mandatory = $true)][string]$MavenPath,
    [string]$PostgresBin = 'C:\Program Files\PostgreSQL\17\bin'
)
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path $PSScriptRoot -Parent
$verificationRoot = Join-Path ([IO.Path]::GetTempPath()) ('becasfind-profile-pg-' + [guid]::NewGuid().ToString('N'))
[IO.Directory]::CreateDirectory($verificationRoot) | Out-Null
$verificationData = Join-Path $verificationRoot 'data'
$listener = [Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback, 0)
$listener.Start()
$verificationPort = $listener.LocalEndpoint.Port
$listener.Stop()
$savedEnvironment = @{}
$settings = @('SPRING_DATASOURCE_URL','SPRING_DATASOURCE_USERNAME','SPRING_DATASOURCE_PASSWORD',
    'SPRING_DATASOURCE_DRIVER_CLASS_NAME','SPRING_JPA_PROPERTIES_HIBERNATE_DIALECT',
    'SPRING_JPA_HIBERNATE_DDL_AUTO')
foreach ($key in $settings) { $savedEnvironment[$key] = [Environment]::GetEnvironmentVariable($key, 'Process') }
$started = $false
try {
    & "$PostgresBin\initdb.exe" -D $verificationData -U profile_verify --encoding=UTF8 --locale=C --auth=trust *> (Join-Path $verificationRoot 'init.log')
    if ($LASTEXITCODE -ne 0) { throw 'Temporary PostgreSQL initialization failed.' }
    $startProcess = Start-Process -FilePath "$PostgresBin\pg_ctl.exe" -ArgumentList @('-D', ('"' + $verificationData + '"'),
        '-l', ('"' + (Join-Path $verificationRoot 'postgres.log') + '"'), '-o', ('"-h 127.0.0.1 -p ' + $verificationPort + '"'),
        '-w', 'start') -WindowStyle Hidden -PassThru -RedirectStandardOutput (Join-Path $verificationRoot 'start.log')
    $startProcess.WaitForExit()
    if ($startProcess.ExitCode -ne 0) { throw 'Temporary PostgreSQL start failed.' }
    $started = $true
    $env:SPRING_DATASOURCE_USERNAME = 'profile_verify'
    $env:SPRING_DATASOURCE_PASSWORD = ''
    $env:SPRING_DATASOURCE_DRIVER_CLASS_NAME = 'org.postgresql.Driver'
    $env:SPRING_JPA_PROPERTIES_HIBERNATE_DIALECT = 'org.hibernate.dialect.PostgreSQLDialect'
    $env:SPRING_JPA_HIBERNATE_DDL_AUTO = 'validate'
    foreach ($testClass in @('ProfilePersistenceTest', 'CoreServiceIntegrityTest')) {
        $databaseName = $testClass.ToLowerInvariant()
        & "$PostgresBin\createdb.exe" -h 127.0.0.1 -p $verificationPort -U profile_verify $databaseName
        if ($LASTEXITCODE -ne 0) { throw 'Temporary database creation failed.' }
        & "$PostgresBin\psql.exe" -h 127.0.0.1 -p $verificationPort -U profile_verify -d $databaseName -v ON_ERROR_STOP=1 -f (Join-Path $PSScriptRoot 'ddl.sql') *> (Join-Path $verificationRoot "$testClass-schema.log")
        if ($LASTEXITCODE -ne 0) { throw 'Schema installation failed.' }
        # Replace DDL catalog seeds only in this newly created disposable database.
        & "$PostgresBin\psql.exe" -h 127.0.0.1 -p $verificationPort -U profile_verify -d $databaseName -v ON_ERROR_STOP=1 -c 'TRUNCATE roles, tipos_institucion, tipos_beca, regiones RESTART IDENTITY CASCADE' *> (Join-Path $verificationRoot "$testClass-fixtures.log")
        if ($LASTEXITCODE -ne 0) { throw 'Temporary fixture reset failed.' }
        $env:SPRING_DATASOURCE_URL = "jdbc:postgresql://127.0.0.1:$verificationPort/$databaseName"
        & $MavenPath -q -f (Join-Path $projectRoot 'backend\pom.xml') "-Dtest=$testClass" test *> (Join-Path $verificationRoot "$testClass.log")
        $testExit = $LASTEXITCODE
        Get-Content (Join-Path $verificationRoot "$testClass.log") -Tail 8
        if ($testExit -ne 0) { throw "$testClass failed. Evidence: $verificationRoot" }
    }
    Write-Output "PostgreSQL verification passed. Evidence: $verificationRoot"
} finally {
    if ($started) { & "$PostgresBin\pg_ctl.exe" -D $verificationData -m fast -w stop *> (Join-Path $verificationRoot 'stop.log') }
    foreach ($key in $savedEnvironment.Keys) { [Environment]::SetEnvironmentVariable($key, $savedEnvironment[$key], 'Process') }
}
