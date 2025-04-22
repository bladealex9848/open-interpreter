@echo off
setlocal enabledelayedexpansion

:: Obtener directorio del script
set "SCRIPT_DIR=%~dp0"
set "ENV_DIR=%SCRIPT_DIR%venv"

:: Activar entorno virtual
call "%ENV_DIR%\Scripts\activate.bat"

:: Instalar dependencias
echo Instalando dependencias...
pip install send2trash shortuuid pydantic starlette inquirer psutil wget html2image litellm jupyter_client ipykernel tokentrim matplotlib pillow ipython selenium webdriver-manager

:: Desactivar entorno virtual al salir
deactivate

echo.
echo Dependencias instaladas correctamente.
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
