#!/usr/bin/env pwsh
# Script para actualizar el perfil de PowerShell para usar el wrapper expect

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

# Leer el contenido actual del perfil
$profileContent = Get-Content -Path $profilePath -Raw

# Reemplazar la función Invoke-OpenInterpreter
$newFunction = @'
# Alias para Open Interpreter en Mac
function Invoke-OpenInterpreter {
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$Arguments
    )
    
    # Ejecutar Open Interpreter a través del wrapper expect
    bash -c "/Volumes/NVMe1TB/GitHub/open-interpreter/oi_expect_wrapper.sh $($Arguments -join ' ')"
}

Set-Alias -Name oi -Value Invoke-OpenInterpreter
'@

# Buscar y reemplazar la función existente
$pattern = '(?s)# Alias para Open Interpreter en Mac.*?Set-Alias -Name oi -Value Invoke-OpenInterpreter'
$profileContent = $profileContent -replace $pattern, $newFunction

# Guardar el perfil actualizado
Set-Content -Path $profilePath -Value $profileContent

Write-Host "Se ha actualizado el perfil de PowerShell para usar el wrapper expect." -ForegroundColor Green
Write-Host "Ahora puedes cargar el perfil con: . `$PROFILE" -ForegroundColor Yellow
