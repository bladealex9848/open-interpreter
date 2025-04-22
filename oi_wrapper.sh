#!/bin/bash
# Script para ejecutar Open Interpreter y manejar la salida

# Verificar si se proporcionó un comando
if [ $# -eq 0 ]; then
    COMMAND=""
else
    COMMAND="$*"
fi

# Exportar variables de entorno si existen
if [ -n "$OPENAI_API_KEY" ]; then
    echo "Usando variable de entorno: OPENAI_API_KEY"
    export OPENAI_API_KEY="$OPENAI_API_KEY"
fi

if [ -n "$GROQ_API_KEY" ]; then
    echo "Usando variable de entorno: GROQ_API_KEY"
    export GROQ_API_KEY="$GROQ_API_KEY"
fi

# Función para ejecutar Open Interpreter y manejar la salida
run_interpreter() {
    # Crear un archivo temporal para la salida
    TEMP_OUTPUT=$(mktemp)
    
    # Ejecutar Open Interpreter y redirigir la salida al archivo temporal
    if [ -n "$COMMAND" ]; then
        echo "Ejecutando: $COMMAND"
        echo "$COMMAND" | interpreter --model gpt-4.1-nano -y -v > "$TEMP_OUTPUT" 2>&1
    else
        echo "Iniciando Open Interpreter en modo interactivo..."
        interpreter --model gpt-4.1-nano -y -v > "$TEMP_OUTPUT" 2>&1
    fi
    
    # Capturar el código de salida
    EXIT_CODE=$?
    
    # Filtrar la salida para eliminar la pregunta de feedback
    cat "$TEMP_OUTPUT" | grep -v "Was Open Interpreter helpful? (y/n):"
    
    # Limpiar
    rm "$TEMP_OUTPUT"
    
    # Devolver el código de salida
    return $EXIT_CODE
}

# Ejecutar la función
run_interpreter
exit $?
