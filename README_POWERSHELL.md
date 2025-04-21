# Configuración de Open Interpreter para PowerShell

Este documento explica cómo configurar y usar Open Interpreter en PowerShell.

## Requisitos previos

- **Python 3.8 o superior** instalado y disponible en el PATH
- **PowerShell 5.1 o superior** (preferiblemente PowerShell 7.x)
- **Permisos de administrador** para la instalación inicial

## Instalación

1. **Abre PowerShell** (preferiblemente como administrador) y navega al directorio de Open Interpreter:

   ```powershell
   cd "X:\Ruta\A\open-interpreter"  # Reemplaza con la ruta correcta
   ```

2. **Ejecuta el script de configuración**:

   ```powershell
   .\setup_powershell.ps1
   ```

   Este script realizará las siguientes acciones:
   - Creará un entorno virtual de Python si no existe
   - Instalará Open Interpreter en el entorno virtual
   - Configurará el perfil de PowerShell para que puedas usar el comando `oi`

3. **Carga el perfil actualizado**:

   ```powershell
   . $PROFILE
   ```

   O simplemente reinicia PowerShell.

4. **Verifica que las variables de entorno estén configuradas**:

   El script detectará automáticamente las siguientes variables de entorno:
   - `OPENAI_API_KEY` - Necesaria para usar modelos de OpenAI
   - `GROQ_API_KEY` - Opcional, para usar modelos de Groq

   Si necesitas configurar estas variables, puedes hacerlo así:

   ```powershell
   $env:OPENAI_API_KEY = "tu-clave-api-aqui"
   $env:GROQ_API_KEY = "tu-clave-api-aqui"  # Opcional
   ```

## Uso

Una vez configurado, puedes usar Open Interpreter con el comando `oi`:

### Modo interactivo

```powershell
oi
```

### Ejecutar un comando específico

```powershell
oi "¿Qué día es hoy?"
```

### Usar un modelo diferente

```powershell
oi -model gpt-4o "Crea un script que calcule números primos"
```

### Opciones adicionales

```powershell
oi -noAuto "Tu instrucción"  # Desactiva la ejecución automática
oi -noVerbose "Tu instrucción"  # Desactiva el modo verbose
oi -file instrucciones.txt  # Ejecuta instrucciones desde un archivo
oi -help  # Muestra la ayuda
```

## Solución de problemas

Si encuentras algún problema:

### Error: "No se encontró ninguna herramienta de línea de comandos para OpenAI"

Este error ocurre cuando Open Interpreter no puede encontrar las variables de entorno necesarias. Asegúrate de que:

1. **La variable OPENAI_API_KEY está configurada**:

   ```powershell
   echo $env:OPENAI_API_KEY
   ```

   Si no muestra tu clave API, configúrala:

   ```powershell
   $env:OPENAI_API_KEY = "tu-clave-api-aqui"
   ```

2. **Ejecuta el script con las variables de entorno correctas**:

   ```powershell
   .\oi.ps1 "Tu instrucción"
   ```

### Otros problemas comunes

1. **Verifica que el entorno virtual existe**:

   ```powershell
   Test-Path "X:\Ruta\A\open-interpreter\venv"
   ```

2. **Verifica que el script oi.ps1 es accesible**:

   ```powershell
   Test-Path "X:\Ruta\A\open-interpreter\oi.ps1"
   ```

3. **Verifica que el alias está configurado**:

   ```powershell
   Get-Alias oi
   ```

4. **Si el alias no funciona**, puedes ejecutar el script directamente:

   ```powershell
   .\oi.ps1 "Tu instrucción"
   ```

5. **Reinstalar Open Interpreter** en el entorno virtual:

   ```powershell
   # Activar el entorno virtual
   .\venv\Scripts\Activate.ps1

   # Reinstalar Open Interpreter
   pip uninstall -y open-interpreter
   pip install open-interpreter

   # Desactivar el entorno virtual
   deactivate
   ```

## Notas

- Este script está diseñado para funcionar con el entorno virtual creado por el script `setup_env.sh`.
- Si cambias la ubicación de los archivos, deberás volver a ejecutar `setup_powershell.ps1`.
- Para tareas complejas, es mejor proporcionar instrucciones detalladas.
