@echo off
echo Deshabilitando PowerShell en el inicio de Windows...

:: Deshabilitar PowerShell en el inicio de Windows
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Windows PowerShell" /t REG_BINARY /d 0300000000000000000000000000000000000000 /f

echo.
echo PowerShell ha sido deshabilitado en el inicio de Windows.
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
