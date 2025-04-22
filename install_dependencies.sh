#!/bin/bash
# Script para instalar las dependencias faltantes de Open Interpreter

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Instalando dependencias faltantes de Open Interpreter${NC}"
echo ""

# Lista de dependencias comunes que pueden faltar
DEPENDENCIES=(
    "shortuuid"
    "anthropic"
    "astor"
    "git-python"
    "google-generativeai"
    "html2image"
    "html2text"
    "inquirer"
    "ipykernel"
    "jupyter-client"
    "litellm"
    "matplotlib"
    "nltk"
    "platformdirs"
    "psutil"
    "pydantic"
    "pyperclip"
    "pyyaml"
    "rich"
    "selenium"
    "send2trash"
    "six"
    "starlette"
    "tokentrim"
    "toml"
    "typer"
    "webdriver-manager"
    "wget"
    "yaspin"
)

# Instalar cada dependencia
for dep in "${DEPENDENCIES[@]}"; do
    echo -e "${YELLOW}Instalando $dep...${NC}"
    python3 -m pip install $dep
done

echo ""
echo -e "${GREEN}Instalación de dependencias completada.${NC}"
echo ""
echo "Ahora puedes probar Open Interpreter con:"
echo "interpreter"
echo ""
echo "O desde PowerShell (después de cargar el perfil):"
echo "oi \"¿Qué día es hoy?\""
