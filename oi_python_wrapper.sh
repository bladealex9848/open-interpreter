#!/bin/bash
# Script para ejecutar Open Interpreter a través del script Python

# Exportar variables de entorno si existen
if [ -n "$OPENAI_API_KEY" ]; then
    echo "Usando variable de entorno: OPENAI_API_KEY"
    export OPENAI_API_KEY="$OPENAI_API_KEY"
fi

if [ -n "$GROQ_API_KEY" ]; then
    echo "Usando variable de entorno: GROQ_API_KEY"
    export GROQ_API_KEY="$GROQ_API_KEY"
fi

# Ejecutar el script Python
python3 /Volumes/NVMe1TB/GitHub/open-interpreter/oi_runner.py "$@"
