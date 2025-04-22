# Solución para problemas de terminal en Augment Code

Este documento explica cómo solucionar problemas con la terminal en Augment Code, específicamente cómo hacer que use Git Bash en lugar de PowerShell.

## Problema

Augment Code abre PowerShell como terminal por defecto, a pesar de que Git Bash está configurado como terminal predeterminada en VS Code.

## Solución

Hemos creado varios scripts para solucionar este problema:

1. **force_git_bash.bat**: Aplica una configuración agresiva para forzar el uso de Git Bash como terminal predeterminada.
2. **disable_powershell_startup.bat**: Deshabilita PowerShell en el inicio de Windows.
3. **modify_powershell_profile.bat**: Modifica el perfil de PowerShell para que no haga nada.
4. **check_terminal_config.bat**: Verifica si la configuración se ha aplicado correctamente.
5. **fix_all_terminal_issues.bat**: Aplica todas las soluciones anteriores de una vez.

## Cómo aplicar la solución

1. Ejecuta el script `fix_all_terminal_issues.bat`:
   ```
   fix_all_terminal_issues.bat
   ```

2. Reinicia VS Code y Augment Code para que los cambios surtan efecto.

## Verificación

Para verificar si la configuración se ha aplicado correctamente, ejecuta el script `check_terminal_config.bat`:
```
check_terminal_config.bat
```

Si ves `"terminal.integrated.defaultProfile.windows": "Git Bash"` y `"augment.terminal.defaultProfile": "Git Bash"`, la configuración se ha aplicado correctamente.

## Solución de problemas

Si después de aplicar la solución Augment Code sigue abriendo PowerShell, prueba lo siguiente:

1. **Desinstala y reinstala Augment Code**: Desinstala la extensión de Augment Code en VS Code y vuelve a instalarla.

2. **Elimina la configuración de Augment Code**: Elimina la carpeta `%APPDATA%\Code\User\globalStorage\augment.vscode-augment` y reinicia VS Code.

3. **Reinstala VS Code**: Desinstala VS Code y vuelve a instalarlo. Luego, instala Augment Code y aplica la solución nuevamente.

4. **Contacta con soporte**: Si ninguna de las soluciones anteriores funciona, contacta con el soporte de Augment Code para obtener ayuda adicional.
