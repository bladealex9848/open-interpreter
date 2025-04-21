@echo off
echo Aplicando todas las soluciones para problemas de terminal...

:: Aplicar configuración de Git Bash
call "%~dp0force_git_bash.bat"

:: Deshabilitar PowerShell en el inicio de Windows
call "%~dp0disable_powershell_startup.bat"

:: Modificar perfil de PowerShell
call "%~dp0modify_powershell_profile.bat"

:: Verificar configuración
call "%~dp0check_terminal_config.bat"

echo.
echo Todas las soluciones han sido aplicadas correctamente.
echo Por favor, reinicia VS Code y Augment Code para que los cambios surtan efecto.
echo.
echo Presiona cualquier tecla para continuar...
pause > nul
