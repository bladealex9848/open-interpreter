#!/bin/bash
# Script para instalar Open Interpreter globalmente

echo "Instalando Open Interpreter globalmente..."

# Intentar varios métodos de instalación
if command -v python3 &> /dev/null; then
    echo "Usando python3..."
    python3 -m pip install open-interpreter
elif command -v pip3 &> /dev/null; then
    echo "Usando pip3..."
    pip3 install open-interpreter
elif command -v python &> /dev/null; then
    echo "Usando python..."
    python -m pip install open-interpreter
elif command -v pip &> /dev/null; then
    echo "Usando pip..."
    pip install open-interpreter
else
    echo "Error: No se encontró python o pip. Por favor, instala Python primero."
    exit 1
fi

# Verificar la instalación
if command -v interpreter &> /dev/null; then
    echo "Open Interpreter instalado correctamente."
    echo "Puedes verificar la versión con: interpreter --version"
else
    echo "Error: No se pudo instalar Open Interpreter o no está en el PATH."
    echo "Intenta instalarlo manualmente con: python3 -m pip install open-interpreter"
fi
