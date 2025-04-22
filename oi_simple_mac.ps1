#!/usr/bin/env pwsh
# Script simple para ejecutar Open Interpreter desde PowerShell en Mac

# Parámetros
param (
    [Parameter(Position=0, ValueFromRemainingArguments=$true)]
    [string]$Command
)

# Verificar si hay un comando
if ($Command) {
    # Crear archivo temporal para el comando
    $tempFile = New-TemporaryFile
    $Command | Out-File -FilePath $tempFile -Encoding utf8
    
    # Ejecutar Open Interpreter con el comando
    Write-Host "Ejecutando: $Command" -ForegroundColor Yellow
    bash -c "interpreter --model gpt-4.1-nano -y -v < '$tempFile'"
    
    # Eliminar el archivo temporal
    Remove-Item -Path $tempFile
} else {
    # Modo interactivo
    Write-Host "Iniciando Open Interpreter en modo interactivo..." -ForegroundColor Yellow
    bash -c "interpreter --model gpt-4.1-nano -y -v"
}
