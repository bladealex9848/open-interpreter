#!/usr/bin/env pwsh
# Script para corregir el perfil de PowerShell y añadir variables de entorno

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

# Preguntar por las claves API
$openaiKey = ""
$groqKey = ""

$setOpenAI = Read-Host "¿Deseas configurar la variable OPENAI_API_KEY? (s/n)"
if ($setOpenAI -eq "s") {
    $openaiKey = Read-Host "Introduce tu clave API de OpenAI"
}

$setGroq = Read-Host "¿Deseas configurar la variable GROQ_API_KEY? (s/n)"
if ($setGroq -eq "s") {
    $groqKey = Read-Host "Introduce tu clave API de Groq"
}

# Crear un nuevo perfil con el alias para Open Interpreter y las variables de entorno
$newProfile = @"
# Perfil de PowerShell creado por Open Interpreter
# Fecha: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

# Variables de entorno para Open Interpreter
"@

if ($openaiKey) {
    $newProfile += @"

# OpenAI API Key
`$env:OPENAI_API_KEY = "$openaiKey"
"@
}

if ($groqKey) {
    $newProfile += @"

# Groq API Key
`$env:GROQ_API_KEY = "$groqKey"
"@
}

$newProfile += @"

# Alias para Open Interpreter en Mac
function Invoke-OpenInterpreter {
    param(
        [Parameter(ValueFromRemainingArguments=`$true)]
        [string[]]`$Arguments
    )
    
    # Ejecutar Open Interpreter directamente a través de bash
    bash -c "/Volumes/NVMe1TB/GitHub/open-interpreter/oi_pwsh.sh `$(`$Arguments -join ' ')"
}

Set-Alias -Name oi -Value Invoke-OpenInterpreter

# Mensaje de bienvenida
Write-Host "Perfil de PowerShell cargado correctamente." -ForegroundColor Green
Write-Host "Puedes usar el comando 'oi' para ejecutar Open Interpreter." -ForegroundColor Yellow
Write-Host "Ejemplo: oi `"¿Qué día es hoy?`"" -ForegroundColor Yellow
"@

# Guardar el nuevo perfil
Set-Content -Path $profilePath -Value $newProfile

Write-Host "Se ha creado un nuevo perfil de PowerShell con las variables de entorno." -ForegroundColor Green
Write-Host "Ahora puedes cargar el perfil con: . `$PROFILE" -ForegroundColor Yellow
