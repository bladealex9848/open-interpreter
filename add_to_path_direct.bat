@echo off
setlocal enabledelayedexpansion

:: Agregar el directorio de scripts al PATH del usuario
setx PATH "%PATH%;C:\GitHub\open-interpreter"

echo Open Interpreter ha sido agregado al PATH.
echo Ahora puedes usar 'interpreter.bat' o 'oi.bat' desde cualquier ubicación.
echo.
echo Para usar Open Interpreter, simplemente escribe:
echo   interpreter
echo o
echo   oi
echo.
echo Para ejecutar un comando específico:
echo   oi "print('Hola desde Open Interpreter')"
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
