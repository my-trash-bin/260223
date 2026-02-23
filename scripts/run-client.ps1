$ErrorActionPreference = "Stop"

Get-Process |
    Where-Object { $_.Name -like "*FiveM*" } |
    Stop-Process -Force -ErrorAction SilentlyContinue

Set-Location (Join-Path $PSScriptRoot "..")

New-Item -ItemType Directory -Path "logs" -Force | Out-Null

$connectTo = if ($args.Count -gt 0) { $args[0] } else { "localhost" }

$exePath = Join-Path $HOME "AppData/Local/FiveM/FiveM.exe"
& $exePath "+set" "moo" "31337" "+connect" "$connectTo"
