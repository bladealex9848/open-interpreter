#!/usr/bin/env pwsh
# Script para configurar Open Interpreter en PowerShell para Mac

# Obtener la ruta del script actual
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$oiScriptPath = Join-Path $scriptPath "oi_mac_pwsh.ps1"

# Verificar que el script oi_mac_pwsh.ps1 existe
if (-not (Test-Path $oiScriptPath)) {
    Write-Host "Error: No se encontró el script oi_mac_pwsh.ps1 en $scriptPath" -ForegroundColor Red
    exit 1
}

# Hacer el script ejecutable
chmod +x $oiScriptPath

# Verificar si existe el perfil de PowerShell
$profilePath = $PROFILE
$profileDir = Split-Path -Parent $profilePath

# Crear el directorio del perfil si no existe
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    Write-Host "Creado directorio para el perfil de PowerShell: $profileDir" -ForegroundColor Green
}

# Crear o actualizar el perfil
$profileContent = @"
# Alias para Open Interpreter en Mac
function Invoke-OpenInterpreter {
    param(
        [Parameter(ValueFromRemainingArguments=`$true)]
        [string[]]`$Arguments
    )
    
    & '$oiScriptPath' `$Arguments
}

Set-Alias -Name oi -Value Invoke-OpenInterpreter
"@

# Verificar si el perfil ya existe
if (Test-Path $profilePath) {
    # Verificar si el alias ya está configurado
    $currentProfile = Get-Content $profilePath -Raw
    if ($currentProfile -match "Set-Alias -Name oi -Value Invoke-OpenInterpreter") {
        Write-Host "El alias 'oi' ya está configurado en el perfil de PowerShell." -ForegroundColor Yellow
    } else {
        # Añadir el alias al perfil existente
        Add-Content -Path $profilePath -Value "`n$profileContent"
        Write-Host "Alias 'oi' añadido al perfil de PowerShell existente." -ForegroundColor Green
    }
} else {
    # Crear un nuevo perfil con el alias
    Set-Content -Path $profilePath -Value $profileContent
    Write-Host "Creado nuevo perfil de PowerShell con el alias 'oi'." -ForegroundColor Green
}

Write-Host ""
Write-Host "Configuración completada. Para activar el alias en la sesión actual, ejecuta:" -ForegroundColor Cyan
Write-Host ". `$PROFILE" -ForegroundColor Yellow
Write-Host ""
Write-Host "O simplemente ejecuta:" -ForegroundColor Cyan
Write-Host "$oiScriptPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "Después podrás usar el comando 'oi' para ejecutar Open Interpreter:" -ForegroundColor Cyan
Write-Host "oi \"¿Qué día es hoy?\"" -ForegroundColor Yellow
