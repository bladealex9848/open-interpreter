# Configuración para Augment Code

Para configurar Bash como terminal por defecto en Augment Code, sigue estos pasos:

1. Abre VS Code
2. Ve a Configuración (Ctrl+,)
3. Busca "terminal.integrated.defaultProfile.windows"
4. Cambia el valor a "Git Bash"
5. Busca "terminal.integrated.profiles.windows"
6. Asegúrate de que "Git Bash" esté configurado con la ruta correcta:
   ```json
   "Git Bash": {
       "path": "C:\\Program Files\\Git\\bin\\bash.exe",
       "args": []
   }
   ```
7. Guarda la configuración

## Configuración manual de VS Code

Si la configuración automática no funciona, puedes modificar manualmente el archivo de configuración de VS Code:

1. Abre VS Code
2. Ve a Archivo > Preferencias > Configuración
3. Haz clic en el icono "Abrir configuración (JSON)" en la esquina superior derecha
4. Agrega o modifica las siguientes líneas:
   ```json
   "terminal.integrated.defaultProfile.windows": "Git Bash",
   "terminal.integrated.profiles.windows": {
       "Git Bash": {
           "path": "C:\\Program Files\\Git\\bin\\bash.exe",
           "args": []
       }
   }
   ```
5. Guarda el archivo

## Verificación

Para verificar que Bash es el terminal por defecto:

1. Abre una nueva terminal en VS Code (Ctrl+`)
2. Deberías ver "bash" en la esquina superior derecha de la terminal
3. Ejecuta el comando `echo $SHELL` para verificar que estás usando Bash
