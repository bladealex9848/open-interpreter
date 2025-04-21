@echo off
echo Creando un perfil de PowerShell vacío...

:: Crear el directorio si no existe
powershell -Command "if (-not (Test-Path -Path $PROFILE.CurrentUserAllHosts)) { New-Item -ItemType File -Path $PROFILE.CurrentUserAllHosts -Force | Out-Null }"

echo.
echo Perfil de PowerShell creado correctamente.
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
