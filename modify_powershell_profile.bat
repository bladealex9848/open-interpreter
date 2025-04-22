@echo off
echo Modificando perfil de PowerShell...

:: Crear directorio si no existe
if not exist "%USERPROFILE%\Documents\WindowsPowerShell" mkdir "%USERPROFILE%\Documents\WindowsPowerShell"

:: Crear un perfil de PowerShell que no haga nada
echo # Este perfil está vacío para evitar errores > "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

:: Crear directorio si no existe
if not exist "%USERPROFILE%\Documents\PowerShell" mkdir "%USERPROFILE%\Documents\PowerShell"

:: Crear un perfil de PowerShell que no haga nada
echo # Este perfil está vacío para evitar errores > "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

echo.
echo Perfil de PowerShell modificado correctamente.
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
