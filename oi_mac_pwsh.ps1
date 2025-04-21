#!/usr/bin/env pwsh
# Script para ejecutar Open Interpreter desde PowerShell en Mac

# Verificar que las variables de entorno estén configuradas
if (-not $env:OPENAI_API_KEY) {
    Write-Host "Error: La variable OPENAI_API_KEY no está configurada." -ForegroundColor Red
    exit 1
}

Write-Host "Variable OPENAI_API_KEY encontrada: $($env:OPENAI_API_KEY.Substring(0, 3))..." -ForegroundColor Green

if ($env:GROQ_API_KEY) {
    Write-Host "Variable GROQ_API_KEY encontrada: $($env:GROQ_API_KEY.Substring(0, 3))..." -ForegroundColor Green
}

# Función para ejecutar Open Interpreter
function Invoke-OpenInterpreter {
    param (
        [Parameter(Position=0, ValueFromRemainingArguments=$true)]
        [string]$Command,
        [string]$Model = "gpt-4.1-nano"
    )

    # Construir el comando para bash
    $bashCommand = "OPENAI_API_KEY='$env:OPENAI_API_KEY'"
    
    if ($env:GROQ_API_KEY) {
        $bashCommand += " GROQ_API_KEY='$env:GROQ_API_KEY'"
    }
    
    $bashCommand += " interpreter"
    
    if ($Model) {
        $bashCommand += " --model $Model"
    }
    
    $bashCommand += " -y -v"
    
    if ($Command) {
        # Escapar comillas en el comando
        $escapedCommand = $Command -replace '"', '\"'
        $tempFile = New-TemporaryFile
        $escapedCommand | Out-File -FilePath $tempFile -Encoding utf8
        $bashCommand += " < `"$tempFile`""
        
        Write-Host "Ejecutando: $Command" -ForegroundColor Yellow
        
        # Ejecutar el comando a través de bash
        bash -c "$bashCommand"
        
        # Eliminar el archivo temporal
        Remove-Item -Path $tempFile
    } else {
        # Modo interactivo
        Write-Host "Iniciando Open Interpreter en modo interactivo..." -ForegroundColor Yellow
        bash -c "$bashCommand"
    }
}

# Crear un alias para la función
Set-Alias -Name oi -Value Invoke-OpenInterpreter -Scope Global

# Si se llama directamente al script con argumentos, ejecutar Open Interpreter
if ($args.Count -gt 0) {
    Invoke-OpenInterpreter $args
} else {
    Write-Host "Script configurado. Ahora puedes usar el comando 'oi' en esta sesión de PowerShell." -ForegroundColor Green
    Write-Host "Ejemplo: oi 'Crea una aplicación web simple que muestre el clima'" -ForegroundColor Yellow
}
