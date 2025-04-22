#!/bin/bash
# Script para instalar Rust en macOS

echo "Instalando Rust usando rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Añadir Rust al PATH para la sesión actual
source "$HOME/.cargo/env"

# Verificar la instalación
if command -v rustc &> /dev/null; then
    echo "Rust instalado correctamente."
    echo "Versión de Rust: $(rustc --version)"
else
    echo "Error: No se pudo instalar Rust o no está en el PATH."
    echo "Por favor, instala Rust manualmente desde https://rustup.rs/"
fi
