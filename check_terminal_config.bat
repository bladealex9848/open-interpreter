@echo off
echo Verificando configuración de terminal...

:: Verificar la configuración de VS Code
echo Configuración de VS Code:
powershell -Command "Get-Content '%APPDATA%\Code\User\settings.json' | Select-String -Pattern 'terminal.integrated.defaultProfile|augment.terminal.defaultProfile|powershell'"

echo.
echo Si ves "terminal.integrated.defaultProfile.windows": "Git Bash" y "augment.terminal.defaultProfile": "Git Bash",
echo la configuración se ha aplicado correctamente.
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
