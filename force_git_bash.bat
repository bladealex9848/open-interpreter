@echo off
echo Forzando Git Bash como terminal predeterminada...

:: Copiar la configuración a VS Code
copy /Y "%~dp0force_git_bash.json" "%APPDATA%\Code\User\settings.json"

:: Eliminar extensiones de PowerShell si existen
echo Deshabilitando extensiones de PowerShell...
powershell -Command "if (Test-Path -Path '%USERPROFILE%\.vscode\extensions\ms-vscode.powershell*') { Remove-Item -Path '%USERPROFILE%\.vscode\extensions\ms-vscode.powershell*' -Recurse -Force }"

:: Crear un archivo para deshabilitar PowerShell en Augment
echo Creando archivo para deshabilitar PowerShell en Augment...
echo { "disabled": true } > "%APPDATA%\Code\User\globalStorage\augment.vscode-augment\powershell-disabled.json"

echo.
echo Configuración aplicada correctamente.
echo Por favor, reinicia VS Code y Augment Code para que los cambios surtan efecto.
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
