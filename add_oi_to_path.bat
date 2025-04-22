@echo off
echo Agregando scripts de Open Interpreter al PATH...

:: Crear directorio en %USERPROFILE%\bin si no existe
if not exist "%USERPROFILE%\bin" mkdir "%USERPROFILE%\bin"

:: Copiar scripts a %USERPROFILE%\bin
copy "%~dp0run_interpreter.py" "%USERPROFILE%\bin\"
copy "%~dp0run_oi.bat" "%USERPROFILE%\bin\oi.bat"

:: Agregar %USERPROFILE%\bin al PATH
setx PATH "%PATH%;%USERPROFILE%\bin"

echo Scripts agregados al PATH.
echo Ahora puedes ejecutar Open Interpreter desde cualquier ubicación usando el comando 'oi'.
pause
