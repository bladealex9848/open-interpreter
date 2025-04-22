#!/bin/bash
# Script para ejecutar Open Interpreter a través del script expect

# Exportar variables de entorno si existen
if [ -n "$OPENAI_API_KEY" ]; then
    echo "Usando variable de entorno: OPENAI_API_KEY"
    export OPENAI_API_KEY="$OPENAI_API_KEY"
fi

if [ -n "$GROQ_API_KEY" ]; then
    echo "Usando variable de entorno: GROQ_API_KEY"
    export GROQ_API_KEY="$GROQ_API_KEY"
fi

# Verificar si se proporcionó un comando
if [ $# -eq 0 ]; then
    # Modo interactivo
    /Volumes/NVMe1TB/GitHub/open-interpreter/oi_expect.sh ""
else
    # Modo con comando
    /Volumes/NVMe1TB/GitHub/open-interpreter/oi_expect.sh "$*"
fi
