#!/bin/bash
# Script para configurar Open Interpreter con el modelo gpt-4.1-nano y las variables de entorno

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Configurando Open Interpreter${NC}"
echo ""

# Verificar si Open Interpreter está instalado
if ! command -v interpreter &> /dev/null; then
    echo -e "${RED}Error: Open Interpreter no está instalado globalmente.${NC}"
    echo "Por favor, instala Open Interpreter primero."
    exit 1
fi

# Crear directorio de configuración si no existe
CONFIG_DIR="$HOME/.config/interpreter"
mkdir -p "$CONFIG_DIR"

# Crear archivo de configuración
CONFIG_FILE="$CONFIG_DIR/config.json"
cat > "$CONFIG_FILE" << EOF
{
    "model": "gpt-4.1-nano",
    "auto_run": true,
    "verbose": true,
    "system_message": "Eres Open Interpreter, un asistente de IA que puede ejecutar código en la computadora del usuario para ayudarle con sus tareas."
}
EOF

echo -e "${GREEN}Configuración guardada en $CONFIG_FILE${NC}"
echo ""

# Verificar variables de entorno
echo -e "${YELLOW}Verificando variables de entorno...${NC}"

# Verificar OPENAI_API_KEY
if [ -z "$OPENAI_API_KEY" ]; then
    echo -e "${RED}Variable OPENAI_API_KEY no encontrada en el entorno.${NC}"
    read -p "¿Deseas configurar OPENAI_API_KEY ahora? (s/n): " SET_OPENAI
    if [ "$SET_OPENAI" = "s" ]; then
        read -p "Introduce tu clave API de OpenAI: " OPENAI_KEY
        echo "export OPENAI_API_KEY=\"$OPENAI_KEY\"" >> ~/.zshrc
        echo "export OPENAI_API_KEY=\"$OPENAI_KEY\"" >> ~/.bash_profile
        export OPENAI_API_KEY="$OPENAI_KEY"
        echo -e "${GREEN}Variable OPENAI_API_KEY configurada.${NC}"
    fi
else
    echo -e "${GREEN}Variable OPENAI_API_KEY encontrada.${NC}"
fi

# Verificar GROQ_API_KEY
if [ -z "$GROQ_API_KEY" ]; then
    echo -e "${RED}Variable GROQ_API_KEY no encontrada en el entorno.${NC}"
    read -p "¿Deseas configurar GROQ_API_KEY ahora? (s/n): " SET_GROQ
    if [ "$SET_GROQ" = "s" ]; then
        read -p "Introduce tu clave API de Groq: " GROQ_KEY
        echo "export GROQ_API_KEY=\"$GROQ_KEY\"" >> ~/.zshrc
        echo "export GROQ_API_KEY=\"$GROQ_KEY\"" >> ~/.bash_profile
        export GROQ_API_KEY="$GROQ_KEY"
        echo -e "${GREEN}Variable GROQ_API_KEY configurada.${NC}"
    fi
else
    echo -e "${GREEN}Variable GROQ_API_KEY encontrada.${NC}"
fi

# Actualizar el script oi_pwsh.sh para usar las variables de entorno
OI_PWSH_SCRIPT="$SCRIPT_DIR/oi_pwsh.sh"
cat > "$OI_PWSH_SCRIPT" << 'EOF'
#!/bin/bash
# Script para ejecutar Open Interpreter desde PowerShell en Mac

# Obtener el comando de los argumentos
if [ $# -eq 0 ]; then
    COMMAND=""
else
    COMMAND="$*"
fi

# Exportar variables de entorno si existen
if [ -n "$OPENAI_API_KEY" ]; then
    echo "Variable de entorno importada: OPENAI_API_KEY"
    export OPENAI_API_KEY="$OPENAI_API_KEY"
fi

if [ -n "$GROQ_API_KEY" ]; then
    echo "Variable de entorno importada: GROQ_API_KEY"
    export GROQ_API_KEY="$GROQ_API_KEY"
fi

# Verificar si Open Interpreter está instalado
if ! command -v interpreter &> /dev/null; then
    echo "Error: Open Interpreter no está instalado globalmente."
    echo "Ejecutando Open Interpreter usando python -m interpreter..."
    
    # Intentar ejecutar usando python -m interpreter
    if [ -n "$COMMAND" ]; then
        # Crear archivo temporal para el comando
        TEMP_CMD=$(mktemp)
        echo "$COMMAND" > $TEMP_CMD
        
        # Ejecutar con el comando
        echo "Ejecutando: $COMMAND"
        if command -v python3 &> /dev/null; then
            python3 -m interpreter --model gpt-4.1-nano -y -v < $TEMP_CMD
        elif command -v python &> /dev/null; then
            python -m interpreter --model gpt-4.1-nano -y -v < $TEMP_CMD
        else
            echo "Error: No se encontró python. Por favor, instala Python primero."
            exit 1
        fi
        
        # Limpiar
        rm $TEMP_CMD
        
        # Salir del script
        exit 0
    else
        # Modo interactivo
        echo "Iniciando Open Interpreter en modo interactivo..."
        if command -v python3 &> /dev/null; then
            python3 -m interpreter --model gpt-4.1-nano -y -v
        elif command -v python &> /dev/null; then
            python -m interpreter --model gpt-4.1-nano -y -v
        else
            echo "Error: No se encontró python. Por favor, instala Python primero."
            exit 1
        fi
        
        # Salir del script
        exit 0
    fi
fi

# Ejecutar Open Interpreter
if [ -n "$COMMAND" ]; then
    # Crear archivo temporal para el comando
    TEMP_CMD=$(mktemp)
    echo "$COMMAND" > $TEMP_CMD
    
    # Ejecutar con el comando
    echo "Ejecutando: $COMMAND"
    interpreter --model gpt-4.1-nano -y -v < $TEMP_CMD
    
    # Limpiar
    rm $TEMP_CMD
else
    # Modo interactivo
    echo "Iniciando Open Interpreter en modo interactivo..."
    interpreter --model gpt-4.1-nano -y -v
fi
EOF

# Hacer el script ejecutable
chmod +x "$OI_PWSH_SCRIPT"

echo ""
echo -e "${GREEN}Configuración completada.${NC}"
echo ""
echo "Para usar Open Interpreter:"
echo ""
echo "1. En Terminal (bash/zsh):"
echo "   interpreter"
echo ""
echo "2. En PowerShell:"
echo "   oi \"¿Qué día es hoy?\""
echo ""
echo "Las variables de entorno se cargarán automáticamente en la próxima sesión."
echo "Para cargarlas en la sesión actual, ejecuta:"
echo "   source ~/.zshrc  # Si usas zsh"
echo "   source ~/.bash_profile  # Si usas bash"
