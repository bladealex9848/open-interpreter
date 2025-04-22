#!/bin/bash
# Script para solucionar todos los problemas de Open Interpreter en Mac

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Solucionando todos los problemas de Open Interpreter en Mac${NC}"
echo ""

# 1. Instalar setuptools (para pkg_resources)
echo -e "${YELLOW}1. Instalando setuptools...${NC}"
python3 -m pip install setuptools

# 2. Verificar la instalación de Rust
echo -e "${YELLOW}2. Verificando la instalación de Rust...${NC}"
if command -v rustc &> /dev/null; then
    echo -e "${GREEN}Rust ya está instalado: $(rustc --version)${NC}"
else
    echo -e "${YELLOW}Rust no está instalado. Instalando...${NC}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    
    if command -v rustc &> /dev/null; then
        echo -e "${GREEN}Rust instalado correctamente: $(rustc --version)${NC}"
    else
        echo -e "${RED}Error: No se pudo instalar Rust.${NC}"
    fi
fi

# 3. Instalar Open Interpreter
echo -e "${YELLOW}3. Instalando Open Interpreter...${NC}"
python3 -m pip install --upgrade pip
python3 -m pip install open-interpreter

# 4. Añadir Open Interpreter al PATH
echo -e "${YELLOW}4. Añadiendo Open Interpreter al PATH...${NC}"

# Encontrar la ubicación de interpreter
INTERPRETER_PATH=$(python3 -c "import sys; print(sys.prefix)" 2>/dev/null)/bin/interpreter

if [ -f "$INTERPRETER_PATH" ]; then
    echo -e "${GREEN}Open Interpreter encontrado en: $INTERPRETER_PATH${NC}"
    
    # Añadir al PATH en .zshrc si existe
    if [ -f "$HOME/.zshrc" ]; then
        if ! grep -q "# Open Interpreter PATH" "$HOME/.zshrc"; then
            echo "" >> "$HOME/.zshrc"
            echo "# Open Interpreter PATH" >> "$HOME/.zshrc"
            echo "export PATH=\"$(dirname "$INTERPRETER_PATH"):\$PATH\"" >> "$HOME/.zshrc"
            echo -e "${GREEN}Añadido al PATH en .zshrc${NC}"
            echo "Por favor, ejecuta 'source ~/.zshrc' o reinicia tu terminal para aplicar los cambios."
        else
            echo -e "${YELLOW}Ya está configurado en .zshrc${NC}"
        fi
    fi
    
    # Añadir al PATH en .bash_profile si existe
    if [ -f "$HOME/.bash_profile" ]; then
        if ! grep -q "# Open Interpreter PATH" "$HOME/.bash_profile"; then
            echo "" >> "$HOME/.bash_profile"
            echo "# Open Interpreter PATH" >> "$HOME/.bash_profile"
            echo "export PATH=\"$(dirname "$INTERPRETER_PATH"):\$PATH\"" >> "$HOME/.bash_profile"
            echo -e "${GREEN}Añadido al PATH en .bash_profile${NC}"
        else
            echo -e "${YELLOW}Ya está configurado en .bash_profile${NC}"
        fi
    fi
    
    # Crear un enlace simbólico en /usr/local/bin
    echo -e "${YELLOW}Creando enlace simbólico en /usr/local/bin...${NC}"
    if [ ! -d "/usr/local/bin" ]; then
        sudo mkdir -p /usr/local/bin
    fi
    sudo ln -sf "$INTERPRETER_PATH" /usr/local/bin/interpreter
    echo -e "${GREEN}Enlace simbólico creado en /usr/local/bin/interpreter${NC}"
else
    echo -e "${RED}Error: No se pudo encontrar el ejecutable de Open Interpreter.${NC}"
fi

# 5. Crear un script simple para ejecutar Open Interpreter desde PowerShell
echo -e "${YELLOW}5. Creando script para PowerShell...${NC}"

# Crear un script simple
cat > "$(dirname "$0")/oi_simple_mac.ps1" << 'EOF'
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
EOF

# Hacer el script ejecutable
chmod +x "$(dirname "$0")/oi_simple_mac.ps1"

# 6. Configurar el perfil de PowerShell
echo -e "${YELLOW}6. Configurando el perfil de PowerShell...${NC}"

# Crear un script para configurar el perfil de PowerShell
cat > "$(dirname "$0")/setup_simple_profile.ps1" << EOF
#!/usr/bin/env pwsh
# Script para configurar el perfil de PowerShell

# Obtener la ruta del perfil
\$profilePath = \$PROFILE
\$profileDir = Split-Path -Parent \$profilePath

# Crear el directorio del perfil si no existe
if (-not (Test-Path \$profileDir)) {
    New-Item -ItemType Directory -Path \$profileDir -Force | Out-Null
    Write-Host "Creado directorio para el perfil de PowerShell: \$profileDir" -ForegroundColor Green
}

# Crear una copia de seguridad del perfil existente si existe
if (Test-Path \$profilePath) {
    \$backupPath = "\$profilePath.backup.\$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    Copy-Item -Path \$profilePath -Destination \$backupPath -Force
    Write-Host "Se ha creado una copia de seguridad del perfil en: \$backupPath" -ForegroundColor Green
}

# Crear un nuevo perfil con solo el alias de Open Interpreter
\$newProfile = @"
# Perfil de PowerShell creado por Open Interpreter
# Fecha: \$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

# Alias para Open Interpreter en Mac
function Invoke-OpenInterpreter {
    param(
        [Parameter(ValueFromRemainingArguments=\$true)]
        [string[]]\$Arguments
    )
    
    \$scriptPath = "$(dirname "$0")/oi_simple_mac.ps1"
    if (Test-Path \$scriptPath) {
        & \$scriptPath \$Arguments
    } else {
        Write-Host "Error: No se encontró el script oi_simple_mac.ps1" -ForegroundColor Red
    }
}

Set-Alias -Name oi -Value Invoke-OpenInterpreter

# Mensaje de bienvenida
Write-Host "Perfil de PowerShell cargado correctamente." -ForegroundColor Green
Write-Host "Puedes usar el comando 'oi' para ejecutar Open Interpreter." -ForegroundColor Yellow
Write-Host "Ejemplo: oi \\"¿Qué día es hoy?\\"" -ForegroundColor Yellow
"@

# Guardar el nuevo perfil
Set-Content -Path \$profilePath -Value \$newProfile

Write-Host "Se ha creado un nuevo perfil de PowerShell." -ForegroundColor Green
Write-Host "Ahora puedes cargar el perfil con: . \\\$PROFILE" -ForegroundColor Yellow
EOF

# Hacer el script ejecutable
chmod +x "$(dirname "$0")/setup_simple_profile.ps1"

# 7. Ejecutar el script de configuración del perfil de PowerShell
echo -e "${YELLOW}7. Ejecutando el script de configuración del perfil de PowerShell...${NC}"
pwsh -Command "$(dirname "$0")/setup_simple_profile.ps1"

echo ""
echo -e "${GREEN}¡Configuración completada!${NC}"
echo ""
echo "Para usar Open Interpreter:"
echo ""
echo "1. En Terminal (bash/zsh):"
echo "   interpreter"
echo ""
echo "2. En PowerShell:"
echo "   . \$PROFILE  # Cargar el perfil actualizado"
echo "   oi \"¿Qué día es hoy?\""
echo ""
echo "Si sigues teniendo problemas, ejecuta:"
echo "   bash -c \"interpreter\""
