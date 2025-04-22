@echo off
echo Instalando todas las dependencias necesarias...

:: Instalar send2trash en el entorno virtual
echo Activando entorno virtual...
call "C:\GitHub\open-interpreter\.venv\Scripts\activate.bat"
echo Instalando send2trash en el entorno virtual...
pip install send2trash
deactivate

:: Instalar send2trash globalmente
echo Instalando send2trash globalmente...
pip install send2trash

:: Instalar otras dependencias
echo Instalando otras dependencias...
pip install shortuuid pydantic starlette inquirer psutil wget html2image litellm jupyter_client ipykernel tokentrim matplotlib pillow ipython selenium webdriver-manager

echo Instalación completada.
pause
