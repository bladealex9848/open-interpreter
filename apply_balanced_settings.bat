@echo off
echo Aplicando configuración equilibrada...

:: Copiar la configuración a VS Code
copy /Y "%~dp0balanced_settings.json" "%APPDATA%\Code\User\settings.json"

:: Eliminar archivos de configuración agresiva si existen
if exist "%APPDATA%\Code\User\globalStorage\augment.vscode-augment\powershell-disabled.json" del "%APPDATA%\Code\User\globalStorage\augment.vscode-augment\powershell-disabled.json"

echo.
echo Configuración equilibrada aplicada correctamente.
echo Por favor, reinicia VS Code y Augment Code para que los cambios surtan efecto.
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
