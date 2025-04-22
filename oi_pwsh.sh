#!/bin/bash
# Script para ejecutar Open Interpreter desde PowerShell en Mac

# Verificar si se proporcionó un comando
if [ $# -eq 0 ]; then
    COMMAND=""
else
    COMMAND="$*"
fi

# Exportar variables de entorno si existen en PowerShell
if [ -n "$OPENAI_API_KEY" ]; then
    echo "Usando variable de entorno: OPENAI_API_KEY"
    export OPENAI_API_KEY="$OPENAI_API_KEY"
fi

if [ -n "$GROQ_API_KEY" ]; then
    echo "Usando variable de entorno: GROQ_API_KEY"
    export GROQ_API_KEY="$GROQ_API_KEY"
fi

# Verificar si Open Interpreter está instalado
if ! command -v interpreter &> /dev/null; then
    echo "Error: Open Interpreter no está instalado globalmente."
    echo "Ejecutando Open Interpreter usando python -m interpreter..."

    # Intentar ejecutar usando python -m interpreter
    if [ -n "$COMMAND" ]; then
        # Crear archivo temporal para el comando
        TEMP_CMD=$(mktemp)
        echo "$COMMAND" > $TEMP_CMD

        # Ejecutar con el comando
        echo "Ejecutando: $COMMAND"
        if command -v python3 &> /dev/null; then
            python3 -m interpreter --model gpt-4.1-nano -y -v < $TEMP_CMD
            EXIT_CODE=$?
        elif command -v python &> /dev/null; then
            python -m interpreter --model gpt-4.1-nano -y -v < $TEMP_CMD
            EXIT_CODE=$?
        else
            echo "Error: No se encontró python. Por favor, instala Python primero."
            exit 1
        fi

        # Limpiar
        rm $TEMP_CMD

        # Salir del script
        exit 0
    else
        # Modo interactivo
        echo "Iniciando Open Interpreter en modo interactivo..."
        if command -v python3 &> /dev/null; then
            python3 -m interpreter --model gpt-4.1-nano -y -v
            EXIT_CODE=$?
        elif command -v python &> /dev/null; then
            python -m interpreter --model gpt-4.1-nano -y -v
            EXIT_CODE=$?
        else
            echo "Error: No se encontró python. Por favor, instala Python primero."
            exit 1
        fi

        # Salir del script
        exit 0
    fi
fi

# Ejecutar Open Interpreter
if [ -n "$COMMAND" ]; then
    # Crear archivo temporal para el comando
    TEMP_CMD=$(mktemp)
    echo "$COMMAND" > $TEMP_CMD

    # Ejecutar con el comando
    echo "Ejecutando: $COMMAND"
    # Ejecutar Open Interpreter
    interpreter --model gpt-4.1-nano -y -v < $TEMP_CMD

    # Capturar el código de salida
    EXIT_CODE=$?

    # Limpiar
    rm $TEMP_CMD

    # Salir con el mismo código de salida
    exit $EXIT_CODE
else
    # Modo interactivo
    echo "Iniciando Open Interpreter en modo interactivo..."
    # Ejecutar Open Interpreter
    interpreter --model gpt-4.1-nano -y -v

    # Capturar el código de salida
    EXIT_CODE=$?

    # Salir con el mismo código de salida
    exit $EXIT_CODE
fi
