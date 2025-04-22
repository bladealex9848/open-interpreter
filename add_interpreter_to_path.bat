@echo off
echo Agregando Open Interpreter al PATH...

:: Crear directorio en %USERPROFILE%\bin si no existe
if not exist "%USERPROFILE%\bin" mkdir "%USERPROFILE%\bin"

:: Copiar scripts a %USERPROFILE%\bin
copy "%~dp0run_oi_direct.py" "%USERPROFILE%\bin\"
copy "%~dp0run_interpreter_direct.bat" "%USERPROFILE%\bin\oi.bat"

:: Agregar %USERPROFILE%\bin al PATH
setx PATH "%PATH%;%USERPROFILE%\bin"

echo.
echo Open Interpreter ha sido agregado al PATH.
echo Ahora puedes ejecutar Open Interpreter desde cualquier ubicación usando el comando 'oi'.
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
