#!/usr/bin/env pwsh
# Script para corregir completamente el perfil de PowerShell

# Obtener la ruta del perfil
$profilePath = $PROFILE

# Verificar que el perfil existe
if (-not (Test-Path $profilePath)) {
    Write-Host "Error: No se encontró el perfil de PowerShell en $profilePath" -ForegroundColor Red
    exit 1
}

# Crear una copia de seguridad del perfil existente
$backupPath = "$profilePath.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
Copy-Item -Path $profilePath -Destination $backupPath -Force
Write-Host "Se ha creado una copia de seguridad del perfil en: $backupPath" -ForegroundColor Green

# Crear un nuevo perfil con solo el alias de Open Interpreter
$newProfile = @"
# Perfil de PowerShell creado por Open Interpreter
# Fecha: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

# Alias para Open Interpreter en Mac
function Invoke-OpenInterpreter {
    param(
        [Parameter(ValueFromRemainingArguments=`$true)]
        [string[]]`$Arguments
    )
    
    # Ejecutar Open Interpreter directamente a través de bash
    bash -c "interpreter `$(`$Arguments -join ' ')"
}

Set-Alias -Name oi -Value Invoke-OpenInterpreter

# Mensaje de bienvenida
Write-Host "Perfil de PowerShell cargado correctamente." -ForegroundColor Green
Write-Host "Puedes usar el comando 'oi' para ejecutar Open Interpreter." -ForegroundColor Yellow
Write-Host "Ejemplo: oi `"¿Qué día es hoy?`"" -ForegroundColor Yellow
"@

# Guardar el nuevo perfil
Set-Content -Path $profilePath -Value $newProfile

Write-Host "Se ha creado un nuevo perfil de PowerShell." -ForegroundColor Green
Write-Host "Ahora puedes cargar el perfil con: . `$PROFILE" -ForegroundColor Yellow
