$ErrorActionPreference = "Stop"

Set-Location (Join-Path $PSScriptRoot "..")

New-Item -ItemType Directory -Force -Path "logs" | Out-Null

$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$logFile = "logs/server-$timestamp.log"

& "./artifacts/FXServer.exe" "+exec" "server.cfg" 2>&1 | Tee-Object -FilePath $logFile
