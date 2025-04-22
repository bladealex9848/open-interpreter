@echo off
setlocal enabledelayedexpansion

:: Obtener directorio del script
set "SCRIPT_DIR=%~dp0"
set "ENV_DIR=%SCRIPT_DIR%venv"

:: Activar entorno virtual
call "%ENV_DIR%\Scripts\activate.bat"

:: Ejecutar el script Python
python "%SCRIPT_DIR%interpreter_cli.py"

:: Desactivar entorno virtual al salir
deactivate
