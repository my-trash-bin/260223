$ErrorActionPreference = "Stop"

Set-Location $PSScriptRoot

Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File run-client.ps1" -WindowStyle Hidden
