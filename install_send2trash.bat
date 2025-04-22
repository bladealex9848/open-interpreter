@echo off
echo Activando entorno virtual...
call "C:\GitHub\open-interpreter\.venv\Scripts\activate.bat"

echo Instalando send2trash...
pip install send2trash

echo Instalación completada.
pause
