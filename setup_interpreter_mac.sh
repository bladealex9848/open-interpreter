#!/bin/bash
# Script para configurar Open Interpreter en macOS

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Configuración de Open Interpreter para macOS${NC}"
echo ""
echo "Este script te ayudará a instalar Open Interpreter en tu Mac."
echo ""

# Verificar si Open Interpreter ya está instalado
if command -v interpreter &> /dev/null; then
    echo -e "${GREEN}Open Interpreter ya está instalado.${NC}"
    echo "Versión: $(interpreter --version 2>/dev/null || echo 'No se pudo determinar la versión')"
    echo ""
    echo "¿Qué deseas hacer?"
    echo "1. Reinstalar Open Interpreter con todas las dependencias (requiere Rust)"
    echo "2. Reinstalar Open Interpreter sin tiktoken (no requiere Rust)"
    echo "3. Salir"
    read -p "Selecciona una opción (1-3): " OPTION
else
    echo -e "${YELLOW}Open Interpreter no está instalado.${NC}"
    echo ""
    echo "¿Cómo deseas instalar Open Interpreter?"
    echo "1. Instalar Open Interpreter con todas las dependencias (requiere Rust)"
    echo "2. Instalar Open Interpreter sin tiktoken (no requiere Rust)"
    echo "3. Salir"
    read -p "Selecciona una opción (1-3): " OPTION
fi

case $OPTION in
    1)
        echo -e "${YELLOW}Instalando Open Interpreter con todas las dependencias...${NC}"
        
        # Verificar si Rust está instalado
        if ! command -v rustc &> /dev/null; then
            echo -e "${YELLOW}Rust no está instalado. Se requiere para instalar tiktoken.${NC}"
            echo "¿Deseas instalar Rust ahora?"
            read -p "Instalar Rust (s/n): " INSTALL_RUST
            
            if [ "$INSTALL_RUST" = "s" ]; then
                # Instalar Rust
                echo -e "${YELLOW}Instalando Rust...${NC}"
                bash "$(dirname "$0")/install_rust.sh"
                
                # Verificar si la instalación fue exitosa
                if ! command -v rustc &> /dev/null; then
                    echo -e "${RED}Error: No se pudo instalar Rust.${NC}"
                    echo "Por favor, instala Rust manualmente desde https://rustup.rs/"
                    exit 1
                fi
            else
                echo -e "${YELLOW}No se instalará Rust. Cambiando a instalación sin tiktoken.${NC}"
                bash "$(dirname "$0")/install_interpreter_no_tiktoken.sh"
                exit 0
            fi
        fi
        
        # Instalar Open Interpreter con todas las dependencias
        echo -e "${YELLOW}Instalando Open Interpreter con todas las dependencias...${NC}"
        
        if command -v python3 &> /dev/null; then
            python3 -m pip install --upgrade pip
            python3 -m pip install open-interpreter
        elif command -v python &> /dev/null; then
            python -m pip install --upgrade pip
            python -m pip install open-interpreter
        else
            echo -e "${RED}Error: No se encontró python. Por favor, instala Python primero.${NC}"
            exit 1
        fi
        ;;
    2)
        echo -e "${YELLOW}Instalando Open Interpreter sin tiktoken...${NC}"
        bash "$(dirname "$0")/install_interpreter_no_tiktoken.sh"
        ;;
    3)
        echo -e "${YELLOW}Saliendo...${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}Opción no válida.${NC}"
        exit 1
        ;;
esac

# Verificar la instalación
if command -v interpreter &> /dev/null; then
    echo -e "${GREEN}Open Interpreter instalado correctamente.${NC}"
    echo "Versión: $(interpreter --version 2>/dev/null || echo 'No se pudo determinar la versión')"
    
    # Configurar el perfil de PowerShell
    echo ""
    echo -e "${YELLOW}¿Deseas configurar Open Interpreter para PowerShell?${NC}"
    read -p "Configurar para PowerShell (s/n): " CONFIGURE_POWERSHELL
    
    if [ "$CONFIGURE_POWERSHELL" = "s" ]; then
        echo -e "${YELLOW}Configurando Open Interpreter para PowerShell...${NC}"
        bash "$(dirname "$0")/setup_pwsh_mac.sh"
    fi
else
    echo -e "${RED}Error: No se pudo instalar Open Interpreter o no está en el PATH.${NC}"
    echo "Intenta instalarlo manualmente."
fi

echo ""
echo -e "${GREEN}Configuración completada.${NC}"
echo "Puedes usar Open Interpreter con el comando: interpreter"
echo "O si configuraste PowerShell, con el comando: oi"
