@echo off
setlocal enabledelayedexpansion

:: Obtener directorio del script
set "SCRIPT_DIR=C:\GitHub\open-interpreter\"
set "ENV_DIR=%SCRIPT_DIR%venv"

:: Activar entorno virtual
call "%ENV_DIR%\Scripts\activate.bat"

:: Configuración
set "MODEL=gpt-4.1-nano"
set "AUTO_RUN=-y"
set "VERBOSE=-v"

:: Verificar si se proporcionó un comando
if "%~1"=="" (
    :: Sin comando, iniciar en modo interactivo
    echo Iniciando Open Interpreter en modo interactivo...
    python -c "from interpreter import interpreter; interpreter.llm.model = '%MODEL%'; interpreter.auto_run = True; interpreter.verbose = True; interpreter.chat()"
) else (
    :: Con comando, ejecutar el comando
    echo Ejecutando Open Interpreter con el comando: %*
    python -c "from interpreter import interpreter; interpreter.llm.model = '%MODEL%'; interpreter.auto_run = True; interpreter.verbose = True; interpreter.run('python', '%*')"
)

:: Desactivar entorno virtual al salir
deactivate
