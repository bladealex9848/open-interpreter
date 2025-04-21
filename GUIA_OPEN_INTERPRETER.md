# Guía para usar Open Interpreter en Windows

Esta guía explica cómo instalar y usar Open Interpreter en Windows, solucionando los problemas comunes.

## Problemas conocidos

1. **Error con tiktoken**: Open Interpreter depende de `tiktoken`, que requiere un compilador de Rust para instalarse.
2. **Error con send2trash**: A veces falta el módulo `send2trash` en el entorno virtual.
3. **Problemas con el comando `interpreter`**: El comando puede no estar disponible o no funcionar correctamente.

## Soluciones

### 1. Instalar Rust

Para instalar Rust, ejecuta el script `install_rust.bat`:

```
install_rust.bat
```

Después de instalar Rust, reinicia tu terminal para que los cambios surtan efecto.

### 2. Instalar send2trash

Para instalar `send2trash` en el entorno virtual, ejecuta el script `install_send2trash.bat`:

```
install_send2trash.bat
```

### 3. Instalar todas las dependencias

Para instalar todas las dependencias necesarias, ejecuta el script `install_all_dependencies.bat`:

```
install_all_dependencies.bat
```

### 4. Instalar Open Interpreter sin tiktoken

Si tienes problemas con `tiktoken`, puedes instalar Open Interpreter sin esta dependencia usando el script `install_oi_no_tiktoken.bat`:

```
install_oi_no_tiktoken.bat
```

### 5. Ejecutar Open Interpreter directamente

Puedes ejecutar Open Interpreter directamente con Python usando el script `direct_oi.bat`:

```
direct_oi.bat
```

### 6. Agregar Open Interpreter al PATH

Para poder ejecutar Open Interpreter desde cualquier ubicación, ejecuta el script `add_oi_to_path.bat`:

```
add_oi_to_path.bat
```

Después de ejecutar este script, podrás usar el comando `oi` desde cualquier ubicación.

## Uso básico

### Iniciar Open Interpreter

Para iniciar Open Interpreter con el modelo gpt-4.1-nano, auto_run=True y verbose=True, simplemente escribe:

```
oi
```

## Solución de problemas

### Error: No module named 'send2trash'

Si recibes un error indicando que no se encuentra el módulo send2trash, ejecuta el siguiente comando:

```
pip install send2trash
```

### Error: No module named 'tiktoken'

Si recibes un error indicando que no se encuentra el módulo tiktoken, tienes dos opciones:

1. Instalar Rust y luego instalar tiktoken:
   ```
   install_rust.bat
   pip install tiktoken
   ```

2. Usar Open Interpreter sin tiktoken:
   ```
   install_oi_no_tiktoken.bat
   ```

### Error: 'interpreter' no se reconoce como un comando interno o externo

Si recibes un error indicando que 'interpreter' no se reconoce como un comando, usa el comando `oi` en su lugar:

```
oi
```

## Notas adicionales

- Los scripts están configurados para usar el modelo gpt-4.1-nano, auto_run=True y verbose=True.
- Si deseas cambiar estas configuraciones, edita el archivo `run_interpreter.py` o `direct_oi.py`.
- Para una experiencia óptima, considera usar Open Interpreter en Git Bash o Windows Terminal.
