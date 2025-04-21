# Script para configurar Open Interpreter en PowerShell
# Este script configura el perfil de PowerShell para que puedas usar el comando 'oi'

# Obtener la ruta del script actual
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$oiScriptPath = Join-Path $scriptPath "oi.ps1"

# Verificar la estructura de directorios para Windows
$venvDir = Join-Path $scriptPath "venv"
if (-not (Test-Path $venvDir)) {
    Write-Host "Creando entorno virtual para Open Interpreter..." -ForegroundColor Yellow

    # Verificar si Python está instalado
    try {
        $pythonVersion = python --version
        Write-Host "Python encontrado: $pythonVersion" -ForegroundColor Green
    } catch {
        Write-Host "Error: Python no está instalado o no está en el PATH." -ForegroundColor Red
        Write-Host "Por favor, instala Python desde https://www.python.org/downloads/" -ForegroundColor Red
        exit 1
    }

    # Crear entorno virtual
    Write-Host "Creando entorno virtual en $venvDir..." -ForegroundColor Yellow
    python -m venv $venvDir

    # Verificar si se creó correctamente
    if (-not (Test-Path $venvDir)) {
        Write-Host "Error: No se pudo crear el entorno virtual." -ForegroundColor Red
        exit 1
    }

    # Activar el entorno virtual
    $activateScript = Join-Path $venvDir "Scripts" "Activate.ps1"
    if (Test-Path $activateScript) {
        . $activateScript
    } else {
        Write-Host "Error: No se encontró el script de activación." -ForegroundColor Red
        exit 1
    }

    # Instalar Open Interpreter
    Write-Host "Instalando Open Interpreter..." -ForegroundColor Yellow
    pip install open-interpreter

    Write-Host "Entorno virtual creado e inicializado correctamente." -ForegroundColor Green
} else {
    Write-Host "Entorno virtual encontrado en $venvDir" -ForegroundColor Green
}

# Verificar que el script oi.ps1 existe
if (-not (Test-Path $oiScriptPath)) {
    Write-Host "Error: No se encontró el script oi.ps1 en $scriptPath" -ForegroundColor Red
    exit 1
}

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
# Alias para Open Interpreter
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
Write-Host "O reinicia PowerShell." -ForegroundColor Cyan
Write-Host ""
Write-Host "Después podrás usar el comando 'oi' para ejecutar Open Interpreter:" -ForegroundColor Cyan
Write-Host "oi ""¿Qué día es hoy?""" -ForegroundColor Yellow
