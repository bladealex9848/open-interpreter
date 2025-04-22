#!/usr/bin/env pwsh
# Script para corregir el perfil de PowerShell

# Obtener la ruta del perfil
$profilePath = $PROFILE

# Verificar que el perfil existe
if (-not (Test-Path $profilePath)) {
    Write-Host "Error: No se encontró el perfil de PowerShell en $profilePath" -ForegroundColor Red
    exit 1
}

# Leer el contenido actual del perfil
$profileContent = Get-Content $profilePath -Raw

# Corregir el error en el parámetro ValueFromRemainingArguments
$correctedContent = $profileContent -replace 'ValueFromRemainingArguments=True', 'ValueFromRemainingArguments=$true'
$correctedContent = $correctedContent -replace 'ValueFromRemainingArguments=`True', 'ValueFromRemainingArguments=$true'

# Guardar el perfil corregido
Set-Content -Path $profilePath -Value $correctedContent

Write-Host "Perfil de PowerShell corregido correctamente." -ForegroundColor Green
Write-Host "Ahora puedes cargar el perfil con: . `$PROFILE" -ForegroundColor Yellow
