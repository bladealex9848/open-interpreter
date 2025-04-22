#!/usr/bin/env pwsh
# Script puente para ejecutar Open Interpreter desde PowerShell en Mac

# Obtener la ruta del script actual
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$bashScript = Join-Path $scriptPath "oi_pwsh.sh"

# Verificar que el script bash existe
if (-not (Test-Path $bashScript)) {
    Write-Host "Error: No se encontró el script oi_pwsh.sh en $scriptPath" -ForegroundColor Red
    exit 1
}

# Pasar todos los argumentos al script bash
$arguments = $args -join " "
bash $bashScript $arguments
