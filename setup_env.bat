@echo off
setlocal enabledelayedexpansion

:: Script para configurar un entorno virtual para Open Interpreter
:: con todas las dependencias correctas para Windows 11

:: Colores para mensajes
set "GREEN=[92m"
set "YELLOW=[93m"
set "RED=[91m"
set "NC=[0m"

:: Directorio base
set "BASE_DIR=%~dp0"
set "ENV_DIR=%BASE_DIR%venv"

echo %YELLOW%Configurando entorno virtual para Open Interpreter...%NC%

:: Verificar si Python está instalado
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo %RED%Error: Python no está instalado o no está en el PATH. Por favor, instálalo primero.%NC%
    exit /b 1
)

:: Crear entorno virtual si no existe
if not exist "%ENV_DIR%" (
    echo %YELLOW%Creando entorno virtual en %ENV_DIR%...%NC%
    python -m venv "%ENV_DIR%"
    if %ERRORLEVEL% NEQ 0 (
        echo %RED%Error al crear el entorno virtual.%NC%
        exit /b 1
    )
) else (
    echo %YELLOW%El entorno virtual ya existe en %ENV_DIR%%NC%
)

:: Activar entorno virtual
echo %YELLOW%Activando entorno virtual...%NC%
call "%ENV_DIR%\Scripts\activate.bat"

:: Actualizar pip
echo %YELLOW%Actualizando pip...%NC%
python -m pip install --upgrade pip

:: Instalar dependencias específicas para resolver conflictos
echo %YELLOW%Instalando dependencias específicas...%NC%
pip install "pillow>=10.3.0,<11.0.0" "typer>=0.12.5,<0.13.0" "pydantic>=2.8.2,<2.9.0"

:: Instalar Open Interpreter
echo %YELLOW%Instalando Open Interpreter...%NC%
pip install open-interpreter

:: Crear script de inicio
echo %YELLOW%Creando script de inicio...%NC%
(
echo @echo off
echo setlocal enabledelayedexpansion
echo.
echo :: Obtener directorio del script
echo set "SCRIPT_DIR=%%~dp0"
echo set "ENV_DIR=%%SCRIPT_DIR%%venv"
echo.
echo :: Activar entorno virtual
echo call "%%ENV_DIR%%\Scripts\activate.bat"
echo.
echo :: Configuración
echo set "MODEL=gpt-4.1-nano"
echo set "AUTO_RUN=-y"
echo set "VERBOSE=-v"
echo.
echo :: Mensaje informativo
echo echo Iniciando Open Interpreter con:
echo echo - Modelo: %%MODEL%%
echo echo - Auto-ejecución: Activada
echo echo - Modo verbose: Activado
echo echo.
echo echo Presiona Ctrl+C para salir en cualquier momento.
echo echo -------------------------------------------
echo.
echo :: Ejecutar Open Interpreter
echo interpreter --model %%MODEL%% %%AUTO_RUN%% %%VERBOSE%%
echo.
echo :: Desactivar entorno virtual al salir
echo deactivate
) > "%BASE_DIR%start_oi.bat"

:: Crear acceso directo en el escritorio
echo %YELLOW%Creando acceso directo en el escritorio...%NC%
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut([Environment]::GetFolderPath('Desktop') + '\Open Interpreter.lnk'); $Shortcut.TargetPath = '%BASE_DIR%start_oi.bat'; $Shortcut.Save()"

:: Crear script para agregar al PATH
echo %YELLOW%Creando script para agregar al PATH...%NC%
(
echo @echo off
echo setlocal enabledelayedexpansion
echo.
echo :: Agregar el directorio de scripts al PATH del usuario
echo setx PATH "%%PATH%%;%BASE_DIR%"
echo.
echo echo Open Interpreter ha sido agregado al PATH.
echo echo Ahora puedes usar 'oi.bat' desde cualquier ubicación.
echo.
echo pause
) > "%BASE_DIR%add_to_path.bat"

:: Crear script oi.bat para ejecutar Open Interpreter desde cualquier ubicación
echo %YELLOW%Creando script oi.bat...%NC%
(
echo @echo off
echo setlocal enabledelayedexpansion
echo.
echo :: Obtener directorio del script
echo set "SCRIPT_DIR=%BASE_DIR%"
echo set "ENV_DIR=%%SCRIPT_DIR%%venv"
echo.
echo :: Activar entorno virtual
echo call "%%ENV_DIR%%\Scripts\activate.bat"
echo.
echo :: Configuración
echo set "MODEL=gpt-4.1-nano"
echo set "AUTO_RUN=-y"
echo set "VERBOSE=-v"
echo.
echo :: Verificar si se proporcionó un comando
echo if "%%~1"=="" ^(
echo     :: Sin comando, iniciar en modo interactivo
echo     echo Iniciando Open Interpreter en modo interactivo...
echo     interpreter --model %%MODEL%% %%AUTO_RUN%% %%VERBOSE%%
echo ^) else ^(
echo     :: Con comando, ejecutar el comando
echo     echo Ejecutando Open Interpreter con el comando: %%*
echo     interpreter --model %%MODEL%% %%AUTO_RUN%% %%VERBOSE%% -c "%%*"
echo ^)
echo.
echo :: Desactivar entorno virtual al salir
echo deactivate
) > "%BASE_DIR%oi.bat"

echo %GREEN%¡Configuración completada!%NC%
echo %GREEN%Puedes iniciar Open Interpreter de tres formas:%NC%
echo %GREEN%1. Ejecutando '%BASE_DIR%start_oi.bat' desde la terminal%NC%
echo %GREEN%2. Haciendo doble clic en el acceso directo 'Open Interpreter' en el escritorio%NC%
echo %GREEN%3. Ejecutando 'add_to_path.bat' para agregar Open Interpreter al PATH y luego usar 'oi' desde cualquier ubicación%NC%

:: Desactivar entorno virtual
deactivate

pause
