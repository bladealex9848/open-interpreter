#!/bin/bash
# Script para instalar Open Interpreter sin tiktoken

echo "Instalando Open Interpreter sin tiktoken..."

# Intentar instalar sin tiktoken
if command -v python3 &> /dev/null; then
    echo "Usando python3..."
    python3 -m pip install open-interpreter --no-deps
    python3 -m pip install -r <(python3 -c "
import pkg_resources
reqs = [str(r) for r in pkg_resources.get_distribution('open-interpreter').requires() if r.name != 'tiktoken']
for req in reqs:
    print(req)
")
elif command -v python &> /dev/null; then
    echo "Usando python..."
    python -m pip install open-interpreter --no-deps
    python -m pip install -r <(python -c "
import pkg_resources
reqs = [str(r) for r in pkg_resources.get_distribution('open-interpreter').requires() if r.name != 'tiktoken']
for req in reqs:
    print(req)
")
else
    echo "Error: No se encontró python. Por favor, instala Python primero."
    exit 1
fi

# Verificar la instalación
if command -v interpreter &> /dev/null; then
    echo "Open Interpreter instalado correctamente."
    echo "Puedes verificar la versión con: interpreter --version"
else
    echo "Error: No se pudo instalar Open Interpreter o no está en el PATH."
    echo "Intenta instalarlo manualmente."
fi
