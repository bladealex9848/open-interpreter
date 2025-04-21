@echo off
echo Aplicando configuración para Augment Code...

:: Copiar la configuración a VS Code
copy /Y "%~dp0augment_settings.json" "%APPDATA%\Code\User\settings.json"

:: Verificar si existe el directorio de Augment Code
if exist "%APPDATA%\Augment Code\User\" (
    echo Copiando configuración a Augment Code...
    copy /Y "%~dp0augment_settings.json" "%APPDATA%\Augment Code\User\settings.json"
) else (
    echo No se encontró el directorio de Augment Code.
    echo Si estás usando Augment Code, es posible que esté instalado en una ubicación diferente.
)

echo.
echo Configuración aplicada correctamente.
echo Por favor, reinicia VS Code y Augment Code para que los cambios surtan efecto.
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
