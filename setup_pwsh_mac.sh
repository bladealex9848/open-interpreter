#!/bin/bash
# Script para configurar Open Interpreter en PowerShell para Mac

# Obtener la ruta del script actual
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BRIDGE_SCRIPT="$SCRIPT_DIR/oi_bridge.ps1"
BASH_SCRIPT="$SCRIPT_DIR/oi_pwsh.sh"

# Verificar que los scripts existen
if [ ! -f "$BRIDGE_SCRIPT" ]; then
    echo "Error: No se encontró el script oi_bridge.ps1 en $SCRIPT_DIR"
    exit 1
fi

if [ ! -f "$BASH_SCRIPT" ]; then
    echo "Error: No se encontró el script oi_pwsh.sh en $SCRIPT_DIR"
    exit 1
fi

# Hacer los scripts ejecutables
chmod +x "$BRIDGE_SCRIPT" "$BASH_SCRIPT"

# Verificar si Open Interpreter está instalado
if ! command -v interpreter &> /dev/null; then
    echo "Open Interpreter no está instalado globalmente."
    read -p "¿Deseas instalar Open Interpreter globalmente? (s/n): " INSTALL
    if [ "$INSTALL" = "s" ]; then
        echo "Instalando Open Interpreter..."
        python3 -m pip install open-interpreter || pip3 install open-interpreter || python -m pip install open-interpreter
    fi
fi

# Crear el contenido para el perfil de PowerShell
PROFILE_CONTENT="# Alias para Open Interpreter en Mac
function Invoke-OpenInterpreter {
    param(
        [Parameter(ValueFromRemainingArguments=\$true)]
        [string[]]\$Arguments
    )

    & '$BRIDGE_SCRIPT' \$Arguments
}

Set-Alias -Name oi -Value Invoke-OpenInterpreter"

# Ejecutar PowerShell para configurar el perfil
pwsh -Command "
    # Verificar si existe el perfil de PowerShell
    \$profilePath = \$PROFILE
    \$profileDir = Split-Path -Parent \$profilePath

    # Crear el directorio del perfil si no existe
    if (-not (Test-Path \$profileDir)) {
        New-Item -ItemType Directory -Path \$profileDir -Force | Out-Null
        Write-Host \"Creado directorio para el perfil de PowerShell: \$profileDir\" -ForegroundColor Green
    }

    # Verificar si el perfil ya existe
    if (Test-Path \$profilePath) {
        # Verificar si el alias ya está configurado
        \$currentProfile = Get-Content \$profilePath -Raw
        if (\$currentProfile -match \"Set-Alias -Name oi -Value Invoke-OpenInterpreter\") {
            Write-Host \"El alias 'oi' ya está configurado en el perfil de PowerShell.\" -ForegroundColor Yellow
        } else {
            # Añadir el alias al perfil existente
            Add-Content -Path \$profilePath -Value \"\n$PROFILE_CONTENT\"
            Write-Host \"Alias 'oi' añadido al perfil de PowerShell existente.\" -ForegroundColor Green
        }
    } else {
        # Crear un nuevo perfil con el alias
        Set-Content -Path \$profilePath -Value \"$PROFILE_CONTENT\"
        Write-Host \"Creado nuevo perfil de PowerShell con el alias 'oi'.\" -ForegroundColor Green
    }
"

echo ""
echo "Configuración completada. Para activar el alias en la sesión actual, ejecuta:"
echo "pwsh -Command \". \$PROFILE\""
echo ""
echo "O simplemente reinicia PowerShell."
echo ""
echo "Después podrás usar el comando 'oi' para ejecutar Open Interpreter:"
echo "oi \"¿Qué día es hoy?\""
