@echo off
echo Restaurando PowerShell en el inicio de Windows...

:: Eliminar la entrada del registro que deshabilita PowerShell en el inicio
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Windows PowerShell" /f

echo.
echo PowerShell ha sido restaurado en el inicio de Windows.
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
