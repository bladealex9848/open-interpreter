@echo off
setlocal enabledelayedexpansion

:: Agregar el directorio de scripts al PATH del usuario
setx PATH "%PATH%;C:\GitHub\open-interpreter\"

echo Open Interpreter ha sido agregado al PATH.
echo Ahora puedes usar 'oi.bat' desde cualquier ubicación.

pause
