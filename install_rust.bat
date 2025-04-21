@echo off
echo Descargando rustup-init.exe...
powershell -Command "Invoke-WebRequest -Uri https://win.rustup.rs/x86_64 -OutFile rustup-init.exe"

echo Instalando Rust...
rustup-init.exe -y

echo Actualizando PATH...
set PATH=%PATH%;%USERPROFILE%\.cargo\bin

echo Instalación de Rust completada.
echo Por favor, reinicia tu terminal para que los cambios surtan efecto.
pause
