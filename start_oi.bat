@echo off
setlocal enabledelayedexpansion

:: Obtener directorio del script
set "SCRIPT_DIR=%~dp0"
set "ENV_DIR=%SCRIPT_DIR%venv"

:: Activar entorno virtual
call "%ENV_DIR%\Scripts\activate.bat"

:: Configuración
set "MODEL=gpt-4.1-nano"
set "AUTO_RUN=-y"
set "VERBOSE=-v"

:: Mensaje informativo
echo Iniciando Open Interpreter con:
echo - Modelo: %MODEL%
echo - Auto-ejecución: Activada
echo - Modo verbose: Activado
echo.
echo Presiona Ctrl+C para salir en cualquier momento.
echo -------------------------------------------

:: Ejecutar Open Interpreter
interpreter --model %MODEL% %AUTO_RUN% %VERBOSE%

:: Desactivar entorno virtual al salir
deactivate
