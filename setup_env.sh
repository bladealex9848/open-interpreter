#!/bin/bash

# Script para configurar un entorno virtual para Open Interpreter
# con todas las dependencias correctas

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Directorio base
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ENV_DIR="$BASE_DIR/venv"

echo -e "${YELLOW}Configurando entorno virtual para Open Interpreter...${NC}"

# Verificar si Python está instalado
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Error: Python 3 no está instalado. Por favor, instálalo primero.${NC}"
    exit 1
fi

# Crear entorno virtual si no existe
if [ ! -d "$ENV_DIR" ]; then
    echo -e "${YELLOW}Creando entorno virtual en $ENV_DIR...${NC}"
    python3 -m venv "$ENV_DIR"
    if [ $? -ne 0 ]; then
        echo -e "${RED}Error al crear el entorno virtual.${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}El entorno virtual ya existe en $ENV_DIR${NC}"
fi

# Activar entorno virtual
echo -e "${YELLOW}Activando entorno virtual...${NC}"
source "$ENV_DIR/bin/activate"

# Actualizar pip
echo -e "${YELLOW}Actualizando pip...${NC}"
pip install --upgrade pip

# Instalar dependencias específicas para resolver conflictos
echo -e "${YELLOW}Instalando dependencias específicas...${NC}"
pip install "pillow>=10.3.0,<11.0.0" "typer>=0.12.5,<0.13.0" "pydantic>=2.8.2,<2.9.0"

# Instalar Open Interpreter
echo -e "${YELLOW}Instalando Open Interpreter...${NC}"
pip install open-interpreter

# Crear script de inicio
echo -e "${YELLOW}Creando script de inicio...${NC}"
cat > "$BASE_DIR/start_oi.sh" << 'EOF'
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
EOF

# Hacer ejecutable el script de inicio
chmod +x "$BASE_DIR/start_oi.sh"

# Crear alias en .zshrc si no existe
if ! grep -q "alias oi-fixed=" ~/.zshrc; then
    echo -e "${YELLOW}Añadiendo alias 'oi-fixed' a ~/.zshrc...${NC}"
    echo "alias oi-fixed=\"$BASE_DIR/start_oi.sh\"" >> ~/.zshrc
    echo -e "${GREEN}Alias añadido. Usa 'oi-fixed' para iniciar Open Interpreter con las dependencias correctas.${NC}"
    echo -e "${YELLOW}Ejecuta 'source ~/.zshrc' para cargar el nuevo alias.${NC}"
else
    echo -e "${YELLOW}El alias 'oi-fixed' ya existe en ~/.zshrc${NC}"
fi

# Crear archivo .command para ejecutar desde Finder
cat > "$BASE_DIR/Open_Interpreter.command" << 'EOF'
#!/bin/bash

# Obtener directorio del script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ejecutar script de inicio
"$SCRIPT_DIR/start_oi.sh"

# Mantener la terminal abierta
echo ""
echo "Presiona Enter para cerrar esta ventana..."
read
EOF

# Hacer ejecutable el archivo .command
chmod +x "$BASE_DIR/Open_Interpreter.command"

echo -e "${GREEN}¡Configuración completada!${NC}"
echo -e "${GREEN}Puedes iniciar Open Interpreter de tres formas:${NC}"
echo -e "${GREEN}1. Ejecutando '$BASE_DIR/start_oi.sh' desde la terminal${NC}"
echo -e "${GREEN}2. Usando el alias 'oi-fixed' después de ejecutar 'source ~/.zshrc'${NC}"
echo -e "${GREEN}3. Haciendo doble clic en 'Open_Interpreter.command' desde el Finder${NC}"

# Desactivar entorno virtual
deactivate
