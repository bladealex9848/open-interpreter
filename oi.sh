#!/bin/bash

# Script para facilitar el uso de Open Interpreter
# Permite tanto el uso tradicional como condensado

# Directorio base donde se encuentra Open Interpreter
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VENV_DIR="$BASE_DIR/venv"
AI_BRIDGE="$BASE_DIR/ai_bridge.py"
ASSISTANT_COMMAND="$BASE_DIR/assistant_command.py"

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}Open Interpreter - Interfaz simplificada${NC}"
    echo ""
    echo "Uso:"
    echo "  oi                           Inicia Open Interpreter en modo interactivo"
    echo "  oi <comando>                 Ejecuta un comando en Open Interpreter"
    echo "  oi --file <archivo>          Ejecuta los comandos del archivo en Open Interpreter"
    echo "  oi --model <modelo>          Especifica el modelo a utilizar (default: gpt-4.1-nano)"
    echo "  oi --no-auto                 Desactiva la ejecución automática"
    echo "  oi --no-verbose              Desactiva el modo verbose"
    echo "  oi --assistant \"<comando>\"   Permite que un asistente de IA envíe comandos"
    echo "  oi --help                    Muestra esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  oi                                      # Inicia Open Interpreter interactivo"
    echo "  oi \"Crea un script que calcule primos\"  # Ejecuta un comando específico"
    echo "  oi --model gpt-4o                       # Usa un modelo diferente"
    echo "  oi --assistant \"Analiza este CSV: data.csv\" # El asistente envía un comando"
    echo ""
}

# Verificar que el entorno virtual existe
check_venv() {
    if [ ! -d "$VENV_DIR" ]; then
        echo -e "${RED}Error: El entorno virtual no existe.${NC}"
        echo -e "Ejecuta ${YELLOW}$BASE_DIR/setup_env.sh${NC} primero."
        exit 1
    fi
}

# Verificar que el puente AI existe
check_ai_bridge() {
    if [ ! -f "$AI_BRIDGE" ]; then
        echo -e "${RED}Error: No se encontró el puente AI.${NC}"
        exit 1
    fi
}

# Función para ejecutar Open Interpreter
run_interpreter() {
    local model="gpt-4.1-nano"
    local auto_run=true
    local verbose=true
    local command=""
    local file=""
    local assistant_mode=false

    # Parsear argumentos
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --model)
                model="$2"
                shift 2
                ;;
            --no-auto)
                auto_run=false
                shift
                ;;
            --no-verbose)
                verbose=false
                shift
                ;;
            --file)
                file="$2"
                shift 2
                ;;
            --assistant)
                assistant_mode=true
                command="$2"
                shift 2
                ;;
            --help)
                show_help
                exit 0
                ;;
            *)
                if [ -z "$command" ]; then
                    command="$1"
                fi
                shift
                ;;
        esac
    done

    # Verificar el entorno virtual
    check_venv

    # Activar el entorno virtual
    source "$VENV_DIR/bin/activate"

    # Ejecutar según el modo
    if [ "$assistant_mode" = true ]; then
        # Modo asistente
        check_ai_bridge
        echo -e "${YELLOW}Ejecutando comando del asistente: ${NC}$command"

        # Construir argumentos
        args=("$ASSISTANT_COMMAND" "$command" "--model" "$model")
        if [ "$auto_run" = false ]; then
            args+=("--no-auto")
        fi
        if [ "$verbose" = false ]; then
            args+=("--no-verbose")
        fi

        # Ejecutar comando
        python "${args[@]}"
    elif [ -n "$file" ]; then
        # Modo archivo
        if [ ! -f "$file" ]; then
            echo -e "${RED}Error: El archivo $file no existe.${NC}"
            exit 1
        fi
        echo -e "${YELLOW}Ejecutando comandos del archivo: ${NC}$file"

        # Construir argumentos
        args=("$AI_BRIDGE" "--model" "$model")
        if [ "$auto_run" = false ]; then
            args+=("--no-auto")
        fi
        if [ "$verbose" = false ]; then
            args+=("--no-verbose")
        fi
        args+=("run" "$file")

        # Ejecutar comando
        python "${args[@]}"
    elif [ -n "$command" ]; then
        # Modo comando
        echo -e "${YELLOW}Ejecutando comando: ${NC}$command"

        # Construir argumentos
        args=("$AI_BRIDGE" "--model" "$model")
        if [ "$auto_run" = false ]; then
            args+=("--no-auto")
        fi
        if [ "$verbose" = false ]; then
            args+=("--no-verbose")
        fi
        args+=("run" "$command")

        # Ejecutar comando
        python "${args[@]}"
    else
        # Modo interactivo
        echo -e "${YELLOW}Iniciando Open Interpreter en modo interactivo...${NC}"

        # Construir argumentos
        args=("$AI_BRIDGE" "--model" "$model")
        if [ "$auto_run" = false ]; then
            args+=("--no-auto")
        fi
        if [ "$verbose" = false ]; then
            args+=("--no-verbose")
        fi
        args+=("interactive")

        # Ejecutar comando
        python "${args[@]}"
    fi

    # Desactivar el entorno virtual
    deactivate
}

# Ejecutar Open Interpreter con los argumentos proporcionados
run_interpreter "$@"
