#!/bin/bash
# Script para ejecutar Open Interpreter usando AppleScript para manejar la interacción

# Verificar si se proporcionó un comando
if [ $# -eq 0 ]; then
    COMMAND=""
else
    COMMAND="$*"
fi

# Exportar variables de entorno si existen
if [ -n "$OPENAI_API_KEY" ]; then
    echo "Usando variable de entorno: OPENAI_API_KEY"
    export OPENAI_API_KEY="$OPENAI_API_KEY"
fi

if [ -n "$GROQ_API_KEY" ]; then
    echo "Usando variable de entorno: GROQ_API_KEY"
    export GROQ_API_KEY="$GROQ_API_KEY"
fi

# Crear un script AppleScript temporal
TEMP_SCRIPT=$(mktemp)
cat > "$TEMP_SCRIPT" << EOL
on run
    tell application "Terminal"
        activate
        set newTab to do script "cd \\"$(pwd)\\"; interpreter --model gpt-4.1-nano -y -v"
        
        # Si hay un comando, enviarlo
        if "$COMMAND" is not "" then
            delay 2
            do script "$COMMAND" in newTab
            delay 1
            do script "" in newTab
        end if
        
        # Esperar a que aparezca la pregunta de feedback
        repeat
            delay 1
            set tabContent to (do script "echo \$?" in newTab)
            if tabContent contains "Was Open Interpreter helpful? (y/n):" then
                do script "y" in newTab
                exit repeat
            end if
        end repeat
    end tell
end run
EOL

# Ejecutar el script AppleScript
osascript "$TEMP_SCRIPT"

# Limpiar
rm "$TEMP_SCRIPT"
