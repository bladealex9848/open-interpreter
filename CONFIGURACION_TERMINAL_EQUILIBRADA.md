# Configuración equilibrada de terminal para VS Code y Augment Code

Este documento explica la configuración equilibrada de terminal para VS Code y Augment Code, que mantiene Git Bash como terminal predeterminada sin deshabilitar PowerShell completamente.

## Configuración actual

La configuración actual establece Git Bash como terminal predeterminada tanto para VS Code como para Augment Code, pero mantiene PowerShell disponible como una opción.

```json
{
    "terminal.integrated.defaultProfile.windows": "Git Bash",
    "augment.terminal.defaultProfile": "Git Bash",
    "terminal.integrated.profiles.windows": {
        "Git Bash": {
            "path": "C:\\Program Files\\Git\\bin\\bash.exe",
            "args": [],
            "icon": "terminal-bash"
        },
        "PowerShell": {
            "source": "PowerShell",
            "icon": "terminal-powershell"
        },
        "Command Prompt": {
            "path": [
                "${env:windir}\\Sysnative\\cmd.exe",
                "${env:windir}\\System32\\cmd.exe"
            ],
            "args": [],
            "icon": "terminal-cmd"
        }
    },
    "terminal.integrated.defaultLocation": "view",
    "terminal.integrated.tabs.enabled": true,
    "terminal.integrated.tabs.showActiveTerminal": "always"
}
```

## Cómo cambiar entre terminales

Para cambiar entre terminales en VS Code o Augment Code:

1. Abre una nueva terminal (Ctrl+`)
2. Haz clic en el menú desplegable en la esquina superior derecha de la terminal
3. Selecciona el tipo de terminal que deseas usar (Git Bash, PowerShell, Command Prompt)

## Cómo cambiar la terminal predeterminada

Si deseas cambiar la terminal predeterminada:

1. Abre la configuración de VS Code (Ctrl+,)
2. Busca "terminal.integrated.defaultProfile.windows"
3. Cambia el valor a "PowerShell", "Git Bash" o "Command Prompt"
4. Para Augment Code, busca "augment.terminal.defaultProfile" y cambia el valor de la misma manera

## Solución de problemas

Si la terminal se abre en una pestaña de código en lugar del espacio de terminal:

1. Abre la configuración de VS Code (Ctrl+,)
2. Busca "terminal.integrated.defaultLocation"
3. Cambia el valor a "view" (para abrir en el espacio de terminal) o "editor" (para abrir en una pestaña de código)

Si los estilos o la configuración personalizada no se aplican:

1. Verifica si hay conflictos en la configuración de VS Code
2. Reinstala las extensiones que proporcionan los estilos
3. Restaura la configuración personalizada desde una copia de seguridad si está disponible
