#!/bin/bash

# Obtener directorio del script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ENV_DIR="$SCRIPT_DIR/venv"

# Activar entorno virtual
source "$ENV_DIR/bin/activate"

# Configuración
MODEL="gpt-4.1-nano"
AUTO_RUN="-y"
VERBOSE="-v"

# Mensaje informativo
echo "Iniciando Open Interpreter con:"
echo "- Modelo: $MODEL"
echo "- Auto-ejecución: Activada"
echo "- Modo verbose: Activado"
echo ""
echo "Presiona Ctrl+C para salir en cualquier momento."
echo "-------------------------------------------"

# Ejecutar Open Interpreter
interpreter --model $MODEL $AUTO_RUN $VERBOSE

# Desactivar entorno virtual al salir
deactivate
