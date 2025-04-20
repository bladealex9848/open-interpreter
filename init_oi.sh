#!/bin/bash

# Script para inicializar Open Interpreter al inicio del sistema
# Este script verifica que todo esté configurado correctamente

# Directorio base donde se encuentra Open Interpreter
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VENV_DIR="$BASE_DIR/venv"
OI_SCRIPT="$BASE_DIR/oi.sh"

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar que el entorno virtual existe
if [ ! -d "$VENV_DIR" ]; then
    echo -e "${RED}Error: El entorno virtual no existe.${NC}"
    echo -e "Ejecuta ${YELLOW}$BASE_DIR/setup_env.sh${NC} primero."
    exit 1
fi

# Verificar que el script oi.sh existe
if [ ! -f "$OI_SCRIPT" ]; then
    echo -e "${RED}Error: El script oi.sh no existe.${NC}"
    exit 1
fi

# Verificar que el alias está configurado en .zshrc
if ! grep -q "alias oi=" ~/.zshrc; then
    echo -e "${YELLOW}Configurando alias 'oi' en ~/.zshrc...${NC}"
    echo -e '\n# Alias para Open Interpreter (versión simplificada)\nalias oi="'$OI_SCRIPT'"\n' >> ~/.zshrc
    echo -e "${GREEN}Alias configurado correctamente.${NC}"
    echo -e "Ejecuta ${YELLOW}source ~/.zshrc${NC} para activar el alias en la sesión actual."
fi

# Verificar que el script oi.sh es ejecutable
if [ ! -x "$OI_SCRIPT" ]; then
    echo -e "${YELLOW}Haciendo ejecutable el script oi.sh...${NC}"
    chmod +x "$OI_SCRIPT"
    echo -e "${GREEN}Script oi.sh ahora es ejecutable.${NC}"
fi

# Verificar que los scripts de Python son ejecutables
for script in "$BASE_DIR"/*.py; do
    if [ -f "$script" ]; then
        if [ ! -x "$script" ]; then
            echo -e "${YELLOW}Haciendo ejecutable el script $(basename "$script")...${NC}"
            chmod +x "$script"
        fi
    fi
done

echo -e "${GREEN}Open Interpreter está configurado correctamente.${NC}"
echo -e "Puedes usar el comando ${YELLOW}oi${NC} para ejecutar Open Interpreter."
echo -e "Ejemplo: ${YELLOW}oi \"¿Qué día es hoy?\"${NC}"
