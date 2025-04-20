#!/bin/bash

# Ruta al script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Desactivar la inicialización automática de conda para evitar errores
export CONDA_AUTO_ACTIVATE_BASE=false

# Ejecutar el script de Open Interpreter
"$SCRIPT_DIR/run_interpreter.sh" "$@"
