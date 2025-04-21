# Script para ejecutar Open Interpreter con configuración personalizada
# Activar el entorno virtual
$env:PATH = "C:\GitHub\open-interpreter\venv\Scripts;$env:PATH"

# Configurar y ejecutar Open Interpreter
python -c "
from interpreter import interpreter
interpreter.llm.model = 'gpt-4.1-nano'
interpreter.auto_run = True
interpreter.verbose = True
interpreter.chat()
"
