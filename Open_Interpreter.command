#!/bin/bash

# Obtener directorio del script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ejecutar script de inicio
"$SCRIPT_DIR/start_oi.sh"

# Mantener la terminal abierta
echo ""
echo "Presiona Enter para cerrar esta ventana..."
read
