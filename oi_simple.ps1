#!/usr/bin/env pwsh
# Script simple para ejecutar Open Interpreter desde PowerShell en Mac

# Parámetros
param (
    [Parameter(Position=0, ValueFromRemainingArguments=$true)]
    [string]$Command
)

# Verificar que las variables de entorno estén configuradas
if (-not $env:OPENAI_API_KEY) {
    Write-Host "Error: La variable OPENAI_API_KEY no está configurada." -ForegroundColor Red
    exit 1
}

Write-Host "Variable OPENAI_API_KEY encontrada." -ForegroundColor Green

if ($env:GROQ_API_KEY) {
    Write-Host "Variable GROQ_API_KEY encontrada." -ForegroundColor Green
}

# Crear un script bash temporal
$tempScript = New-TemporaryFile
$tempScript = Rename-Item -Path $tempScript -NewName "$($tempScript.BaseName).sh" -PassThru -Force

# Contenido del script bash
$bashContent = @"
#!/bin/bash
export OPENAI_API_KEY='$env:OPENAI_API_KEY'
"@

if ($env:GROQ_API_KEY) {
    $bashContent += @"

export GROQ_API_KEY='$env:GROQ_API_KEY'
"@
}

if ($Command) {
    # Escapar comillas en el comando
    $escapedCommand = $Command -replace '"', '\"'
    
    $bashContent += @"

# Crear archivo temporal para el comando
TEMP_CMD=\$(mktemp)
echo "$escapedCommand" > \$TEMP_CMD

# Ejecutar Open Interpreter con el comando
echo "Ejecutando: $escapedCommand"
python -m interpreter --model gpt-4.1-nano -y -v < \$TEMP_CMD

# Limpiar
rm \$TEMP_CMD
"@
} else {
    $bashContent += @"

# Ejecutar Open Interpreter en modo interactivo
echo "Iniciando Open Interpreter en modo interactivo..."
python -m interpreter --model gpt-4.1-nano -y -v
"@
}

# Guardar el script bash
Set-Content -Path $tempScript -Value $bashContent

# Hacer el script ejecutable
chmod +x $tempScript

# Ejecutar el script
if ($Command) {
    Write-Host "Ejecutando: $Command" -ForegroundColor Yellow
}

bash $tempScript

# Limpiar
Remove-Item -Path $tempScript
