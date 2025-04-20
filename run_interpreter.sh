#!/bin/bash

# Script para ejecutar Open Interpreter con configuraciones predeterminadas
# Creado para evitar problemas de compatibilidad entre versiones de Python

# Configuración de variables
MODEL="gpt-4.1-nano"
AUTO_RUN="-y"
VERBOSE="-v"
HELP_FILE="/Volumes/NVMe1TB/GitHub/open-interpreter/interpreter_help.md"

# Verificar si se solicita ayuda
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    cat "$HELP_FILE"
    exit 0
fi

# Mensaje informativo
echo "Iniciando Open Interpreter con:"
echo "- Modelo: $MODEL"
echo "- Auto-ejecución: Activada"
echo "- Modo verbose: Activado"
echo ""
echo "Usa 'oi --help' para ver los comandos mágicos y más información."
echo "Presiona Ctrl+C para salir en cualquier momento."
echo "-------------------------------------------"

# Desactivar la inicialización automática de conda para evitar errores
export CONDA_AUTO_ACTIVATE_BASE=false

# Ejecutar Open Interpreter con las configuraciones especificadas
# Usamos el path completo para evitar problemas con conda
/opt/anaconda3/bin/python -m interpreter.cli --model $MODEL $AUTO_RUN $VERBOSE

# Si hay algún error, mostrar mensaje
if [ $? -ne 0 ]; then
    echo "Error al ejecutar Open Interpreter. Intenta actualizar con:"
    echo "pip install --upgrade open-interpreter"
fi
