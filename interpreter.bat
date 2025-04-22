@echo off
setlocal enabledelayedexpansion

:: Obtener directorio del script
set "SCRIPT_DIR=C:\GitHub\open-interpreter"
set "ENV_DIR=%SCRIPT_DIR%\venv"

:: Activar entorno virtual
call "%ENV_DIR%\Scripts\activate.bat"

:: Ejecutar Open Interpreter con la configuración personalizada
python -c "from interpreter import interpreter; interpreter.llm.model = 'gpt-4.1-nano'; interpreter.auto_run = True; interpreter.verbose = True; interpreter.chat()"

:: Desactivar entorno virtual al salir
deactivate
