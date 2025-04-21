@echo off
setlocal enabledelayedexpansion

:: Script para inicializar Open Interpreter
:: Este script verifica la instalación y configura el entorno

:: Colores para mensajes
set "GREEN=[92m"
set "YELLOW=[93m"
set "RED=[91m"
set "NC=[0m"

:: Directorio base
set "BASE_DIR=%~dp0"
set "ENV_DIR=%BASE_DIR%venv"

echo %YELLOW%Inicializando Open Interpreter...%NC%

:: Verificar si el entorno virtual existe
if not exist "%ENV_DIR%" (
    echo %RED%El entorno virtual no existe. Ejecutando setup_env.bat...%NC%
    call "%BASE_DIR%setup_env.bat"
    exit /b
)

:: Activar entorno virtual
echo %YELLOW%Activando entorno virtual...%NC%
call "%ENV_DIR%\Scripts\activate.bat"

:: Verificar la instalación de Open Interpreter
echo %YELLOW%Verificando la instalación de Open Interpreter...%NC%
python -c "import interpreter" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo %RED%Open Interpreter no está instalado correctamente. Ejecutando setup_env.bat...%NC%
    call "%BASE_DIR%setup_env.bat"
    exit /b
)

:: Verificar la versión de Open Interpreter
echo %YELLOW%Verificando la versión de Open Interpreter...%NC%
for /f "tokens=*" %%a in ('"%ENV_DIR%\Scripts\interpreter.exe" --version') do set "VERSION=%%a"
echo %GREEN%Versión instalada: %VERSION%%NC%

:: Verificar si oi.bat está en el PATH
echo %YELLOW%Verificando si oi.bat está en el PATH...%NC%
where oi.bat >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo %YELLOW%oi.bat no está en el PATH. Puedes ejecutar add_to_path.bat para agregarlo.%NC%
) else (
    echo %GREEN%oi.bat está en el PATH.%NC%
)

:: Crear acceso directo en el escritorio si no existe
echo %YELLOW%Verificando acceso directo en el escritorio...%NC%
if not exist "%USERPROFILE%\Desktop\Open Interpreter.lnk" (
    echo %YELLOW%Creando acceso directo en el escritorio...%NC%
    powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut([Environment]::GetFolderPath('Desktop') + '\Open Interpreter.lnk'); $Shortcut.TargetPath = '%BASE_DIR%start_oi.bat'; $Shortcut.Save()"
    echo %GREEN%Acceso directo creado.%NC%
) else (
    echo %GREEN%El acceso directo ya existe.%NC%
)

echo %GREEN%¡Inicialización completada!%NC%
echo %GREEN%Puedes iniciar Open Interpreter de tres formas:%NC%
echo %GREEN%1. Ejecutando '%BASE_DIR%start_oi.bat' desde la terminal%NC%
echo %GREEN%2. Haciendo doble clic en el acceso directo 'Open Interpreter' en el escritorio%NC%
echo %GREEN%3. Usando el comando 'oi' desde cualquier ubicación (si está en el PATH)%NC%

:: Desactivar entorno virtual
deactivate

pause
