#!/bin/bash
# Script para instalar expect si no está instalado

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Verificando si expect está instalado...${NC}"

# Verificar si expect está instalado
if ! command -v expect &> /dev/null; then
    echo -e "${RED}expect no está instalado.${NC}"
    echo -e "${YELLOW}Instalando expect...${NC}"
    
    # Verificar si Homebrew está instalado
    if command -v brew &> /dev/null; then
        # Instalar expect con Homebrew
        brew install expect
    else
        echo -e "${RED}Homebrew no está instalado.${NC}"
        echo -e "${YELLOW}Puedes instalar expect manualmente con:${NC}"
        echo "  1. Instalar Homebrew: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        echo "  2. Instalar expect: brew install expect"
        exit 1
    fi
else
    echo -e "${GREEN}expect ya está instalado.${NC}"
fi

echo -e "${GREEN}Configuración completada.${NC}"
