#!/usr/bin/env pwsh
# Script para configurar el perfil de PowerShell

# Obtener la ruta del perfil
$profilePath = $PROFILE
$profileDir = Split-Path -Parent $profilePath

# Crear el directorio del perfil si no existe
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    Write-Host "Creado directorio para el perfil de PowerShell: $profileDir" -ForegroundColor Green
}

# Crear una copia de seguridad del perfil existente si existe
if (Test-Path $profilePath) {
    $backupPath = "$profilePath.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    Copy-Item -Path $profilePath -Destination $backupPath -Force
    Write-Host "Se ha creado una copia de seguridad del perfil en: $backupPath" -ForegroundColor Green
}

# Crear un nuevo perfil con solo el alias de Open Interpreter
$newProfile = @"
# Perfil de PowerShell creado por Open Interpreter
# Fecha: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

# Alias para Open Interpreter en Mac
function Invoke-OpenInterpreter {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Arguments
    )
    
    $scriptPath = "/Volumes/NVMe1TB/GitHub/open-interpreter/oi_simple_mac.ps1"
    if (Test-Path $scriptPath) {
        & $scriptPath $Arguments
    } else {
        Write-Host "Error: No se encontró el script oi_simple_mac.ps1" -ForegroundColor Red
    }
}

Set-Alias -Name oi -Value Invoke-OpenInterpreter

# Mensaje de bienvenida
Write-Host "Perfil de PowerShell cargado correctamente." -ForegroundColor Green
Write-Host "Puedes usar el comando 'oi' para ejecutar Open Interpreter." -ForegroundColor Yellow
Write-Host "Ejemplo: oi \"¿Qué día es hoy?\"" -ForegroundColor Yellow
"@

# Guardar el nuevo perfil
Set-Content -Path $profilePath -Value $newProfile

Write-Host "Se ha creado un nuevo perfil de PowerShell." -ForegroundColor Green
Write-Host "Ahora puedes cargar el perfil con: . \$PROFILE" -ForegroundColor Yellow
