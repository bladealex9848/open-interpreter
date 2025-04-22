#!/bin/bash
# Script para ejecutar Open Interpreter desde PowerShell en Mac

# Verificar si se proporcionó un comando
if [ $# -eq 0 ]; then
    COMMAND=""
else
    COMMAND="$*"
fi

# Verificar si Open Interpreter está instalado
if ! command -v interpreter &> /dev/null; then
    echo "Error: Open Interpreter no está instalado globalmente."
    echo "Instalando Open Interpreter..."
    pip install open-interpreter
fi

# Ejecutar Open Interpreter
if [ -n "$COMMAND" ]; then
    # Crear archivo temporal para el comando
    TEMP_CMD=$(mktemp)
    echo "$COMMAND" > $TEMP_CMD
    
    # Ejecutar con el comando
    echo "Ejecutando: $COMMAND"
    interpreter --model gpt-4.1-nano -y -v < $TEMP_CMD
    
    # Limpiar
    rm $TEMP_CMD
else
    # Modo interactivo
    echo "Iniciando Open Interpreter en modo interactivo..."
    interpreter --model gpt-4.1-nano -y -v
fi
