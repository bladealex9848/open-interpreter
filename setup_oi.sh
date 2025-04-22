#!/bin/bash
# Script para configurar Open Interpreter

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Configurando Open Interpreter${NC}"
echo ""

# Configurar Open Interpreter
echo -e "${YELLOW}Configurando parámetros por defecto...${NC}"
python3 /Volumes/NVMe1TB/GitHub/open-interpreter/configure_interpreter.py
echo ""

# Actualizar el perfil de PowerShell
echo -e "${YELLOW}Actualizando el perfil de PowerShell...${NC}"
pwsh -File /Volumes/NVMe1TB/GitHub/open-interpreter/update_profile_simple.ps1
echo ""

echo -e "${GREEN}Configuración completada.${NC}"
echo ""
echo "Para usar Open Interpreter:"
echo ""
echo "1. En Terminal (bash/zsh):"
echo "   interpreter"
echo ""
echo "2. En PowerShell:"
echo "   . \$PROFILE  # Cargar el perfil actualizado"
echo "   oi          # Modo interactivo"
echo "   oi \"¿Qué día es hoy?\"  # Modo con comando"
echo ""
echo "Las variables de entorno se cargarán automáticamente desde el perfil de PowerShell."
