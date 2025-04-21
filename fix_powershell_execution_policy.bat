@echo off
echo Cambiando la política de ejecución de PowerShell...

:: Ejecutar PowerShell como administrador para cambiar la política de ejecución
powershell -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force\"' -Verb RunAs"

echo.
echo La política de ejecución de PowerShell ha sido cambiada a RemoteSigned para el usuario actual.
echo Ahora deberías poder ejecutar scripts de PowerShell sin problemas.
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
