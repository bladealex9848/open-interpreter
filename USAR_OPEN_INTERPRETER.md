# Guía para usar Open Interpreter directamente desde la línea de comandos

Esta guía explica cómo usar Open Interpreter directamente desde la línea de comandos en Windows, sin necesidad de usar entornos virtuales o activar scripts manualmente.

## Configuración inicial

1. Ejecuta el script `install_dependencies.bat` para instalar todas las dependencias necesarias:
   ```
   C:\GitHub\open-interpreter\install_dependencies.bat
   ```

2. Ejecuta el script `add_to_path_direct.bat` para agregar Open Interpreter al PATH del sistema:
   ```
   C:\GitHub\open-interpreter\add_to_path_direct.bat
   ```

3. Reinicia la terminal para que los cambios surtan efecto.

## Uso básico

### Iniciar Open Interpreter en modo interactivo

Para iniciar Open Interpreter en modo interactivo con el modelo gpt-4.1-nano, auto_run=True y verbose=True, simplemente escribe:

```
interpreter
```

o

```
oi
```

### Ejecutar un comando específico

Para ejecutar un comando específico con Open Interpreter:

```
oi "print('Hola desde Open Interpreter')"
```

## Solución de problemas

### Error: No module named 'send2trash'

Si recibes un error indicando que no se encuentra el módulo send2trash, ejecuta el siguiente comando:

```
C:\GitHub\open-interpreter\install_dependencies.bat
```

### Error: 'interpreter' no se reconoce como un comando interno o externo

Si recibes un error indicando que 'interpreter' no se reconoce como un comando, asegúrate de haber ejecutado el script `add_to_path_direct.bat` y de haber reiniciado la terminal.

### Error: No se puede activar el entorno virtual

Si recibes un error relacionado con la activación del entorno virtual, asegúrate de que el entorno virtual existe y está correctamente configurado:

```
cd C:\GitHub\open-interpreter
python -m venv venv
```

## Notas adicionales

- Los scripts `interpreter.bat` y `oi.bat` están configurados para usar el modelo gpt-4.1-nano, auto_run=True y verbose=True.
- Si deseas cambiar estas configuraciones, edita los archivos `interpreter.bat` y `oi.bat` en el directorio `C:\GitHub\open-interpreter`.
- Para una experiencia óptima, considera usar Open Interpreter en Windows Terminal o Git Bash.

## Recursos adicionales

- [Documentación oficial de Open Interpreter](https://docs.openinterpreter.com/)
- [Repositorio de GitHub](https://github.com/OpenInterpreter/open-interpreter)
- [Ejemplos de uso](https://github.com/OpenInterpreter/examples)
