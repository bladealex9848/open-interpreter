@echo off
setlocal enabledelayedexpansion

:: Script para ejecutar Open Interpreter con configuraciones predeterminadas
:: Creado para evitar problemas de compatibilidad entre versiones de Python

:: Configuración de variables
set "MODEL=gpt-4.1-nano"
set "AUTO_RUN=-y"
set "VERBOSE=-v"
set "HELP_FILE=%~dp0interpreter_help.md"

:: Verificar si se solicita ayuda
if "%1"=="--help" (
    type "%HELP_FILE%"
    exit /b 0
)
if "%1"=="-h" (
    type "%HELP_FILE%"
    exit /b 0
)

:: Mensaje informativo
echo Iniciando Open Interpreter con:
echo - Modelo: %MODEL%
echo - Auto-ejecución: Activada
echo - Modo verbose: Activado
echo.
echo Usa 'oi --help' para ver los comandos mágicos y más información.
echo Presiona Ctrl+C para salir en cualquier momento.
echo -------------------------------------------

:: Ejecutar Open Interpreter con las configuraciones especificadas
:: Usamos el path completo para evitar problemas con entornos virtuales
python -m interpreter.cli --model %MODEL% %AUTO_RUN% %VERBOSE%

:: Si hay algún error, mostrar mensaje
if %ERRORLEVEL% NEQ 0 (
    echo Error al ejecutar Open Interpreter. Intenta actualizar con:
    echo pip install --upgrade open-interpreter
)
