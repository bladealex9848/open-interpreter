#!/usr/bin/env pwsh
# Script para ejecutar Open Interpreter desde PowerShell en Mac

# Parámetros
param (
    [Parameter(Position=0, ValueFromRemainingArguments=$true)]
    [string]$Command,
    [string]$Model = "gpt-4.1-nano"
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

# Crear un script temporal para ejecutar en bash
$tempScript = New-TemporaryFile
$tempScript = Rename-Item -Path $tempScript -NewName "$($tempScript.BaseName).sh" -PassThru -Force

# Escribir el script bash
$bashScript = @"
#!/bin/bash
export OPENAI_API_KEY='$env:OPENAI_API_KEY'
"@

if ($env:GROQ_API_KEY) {
    $bashScript += @"

export GROQ_API_KEY='$env:GROQ_API_KEY'
"@
}

$bashScript += @"

# Verificar si interpreter está instalado
if ! command -v interpreter &> /dev/null; then
    echo "Error: Open Interpreter no está instalado globalmente."
    echo "Instalando Open Interpreter..."
    pip install open-interpreter
fi

# Ejecutar Open Interpreter
"@

if ($Command) {
    # Escapar comillas en el comando
    $escapedCommand = $Command -replace '"', '\"'
    
    $bashScript += @"
TEMP_CMD=\$(mktemp)
echo "$escapedCommand" > \$TEMP_CMD

# Ejecutar con el comando
interpreter --model $Model -y -v < \$TEMP_CMD

# Limpiar
rm \$TEMP_CMD
"@
} else {
    # Modo interactivo
    $bashScript += @"
# Modo interactivo
interpreter --model $Model -y -v
"@
}

# Guardar el script
Set-Content -Path $tempScript -Value $bashScript

# Hacer el script ejecutable
chmod +x $tempScript

# Ejecutar el script
if ($Command) {
    Write-Host "Ejecutando: $Command" -ForegroundColor Yellow
} else {
    Write-Host "Iniciando Open Interpreter en modo interactivo..." -ForegroundColor Yellow
}

bash $tempScript

# Limpiar
Remove-Item -Path $tempScript

# Función para usar como alias
function Invoke-OpenInterpreter {
    param (
        [Parameter(Position=0, ValueFromRemainingArguments=$true)]
        [string]$Command,
        [string]$Model = "gpt-4.1-nano"
    )
    
    $scriptPath = $MyInvocation.MyCommand.Definition
    
    if ($Command) {
        & $scriptPath -Command $Command -Model $Model
    } else {
        & $scriptPath -Model $Model
    }
}

# Crear un alias para la función si se está ejecutando como script principal
if ($MyInvocation.InvocationName -eq "&") {
    Set-Alias -Name oi -Value Invoke-OpenInterpreter -Scope Global
    Write-Host "Alias 'oi' configurado. Puedes usar 'oi' para ejecutar Open Interpreter." -ForegroundColor Green
}
