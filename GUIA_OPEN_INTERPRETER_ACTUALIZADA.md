# Guía para usar Open Interpreter en Windows

Esta guía explica cómo usar Open Interpreter en Windows, incluyendo cómo cambiar la configuración y salir correctamente.

## Comandos básicos

### Iniciar Open Interpreter

Para iniciar Open Interpreter con la configuración actual, simplemente escribe:

```
oi
```

### Salir de Open Interpreter

Para salir de Open Interpreter, puedes usar cualquiera de estos comandos:

- `/exit` - Comando oficial para salir
- `/quit` - Alternativa para salir
- `Ctrl+C` - Interrumpe la ejecución
- `Ctrl+D` - Envía una señal de fin de archivo (EOF)

### Comandos útiles dentro de Open Interpreter

- `/help` - Muestra todos los comandos disponibles
- `/config` - Muestra la configuración actual
- `/system` - Muestra el mensaje del sistema y otra información
- `/clear` - Limpia la pantalla
- `/tokens` - Muestra el recuento de tokens
- `/undo` - Deshace la última acción

## Cambiar la configuración

### Cambiar el modelo

Para cambiar el modelo que usa Open Interpreter, ejecuta:

```
oi-model
```

Este comando te mostrará una lista de modelos disponibles y te permitirá seleccionar uno.

### Cambiar otras configuraciones

Para cambiar otras configuraciones, como `auto_run` y `verbose`, ejecuta:

```
oi-config
```

Este comando te mostrará la configuración actual y te permitirá cambiarla.

## Solución de problemas

### Error: No module named 'send2trash'

Si recibes un error indicando que no se encuentra el módulo send2trash, ejecuta:

```
pip install send2trash
```

### Error: No module named 'tiktoken'

Si recibes un error indicando que no se encuentra el módulo tiktoken, ejecuta:

```
pip install tiktoken
```

Si tienes problemas para instalar tiktoken, asegúrate de tener Rust instalado:

```
install_rust.bat
```

### Error: KeyboardInterrupt

Este error es normal cuando usas `Ctrl+C` para salir de Open Interpreter. No es un problema real.

## Notas adicionales

- La configuración actual se muestra al inicio cuando ejecutas `oi`.
- Puedes cambiar la configuración en cualquier momento usando `oi-model` o `oi-config`.
- Para una experiencia óptima, considera usar Open Interpreter en Git Bash o Windows Terminal.

## Recursos adicionales

- [Documentación oficial de Open Interpreter](https://docs.openinterpreter.com/)
- [Repositorio de GitHub](https://github.com/OpenInterpreter/open-interpreter)
- [Ejemplos de uso](https://github.com/OpenInterpreter/examples)
