# Open Interpreter para PowerShell en Mac

Este documento explica cómo configurar y usar Open Interpreter en PowerShell en macOS.

## Solución simplificada

Hemos creado una solución simplificada que utiliza bash como puente para ejecutar Open Interpreter desde PowerShell en Mac. Esta solución es más robusta y evita los problemas con las herramientas de línea de comandos de OpenAI.

## Instalación

1. **Abre Terminal** (no PowerShell) y navega al directorio de Open Interpreter:

   ```bash
   cd /Volumes/NVMe1TB/GitHub/open-interpreter
   ```

2. **Ejecuta el script de configuración**:

   ```bash
   ./setup_pwsh_mac.sh
   ```

   Este script:
   - Verifica que los scripts necesarios existen
   - Instala Open Interpreter globalmente si es necesario
   - Configura el perfil de PowerShell para que puedas usar el comando `oi`

3. **Reinicia PowerShell** o carga el perfil actualizado:

   ```powershell
   . $PROFILE
   ```

## Uso

Una vez configurado, puedes usar Open Interpreter en PowerShell con el comando `oi`:

### Modo interactivo

```powershell
oi
```

### Ejecutar un comando específico

```powershell
oi "¿Qué día es hoy?"
```

### Ejemplos de uso

```powershell
# Crear una aplicación web simple
oi "Crea una aplicación web simple que muestre el clima"

# Analizar datos
oi "Analiza este archivo CSV y crea un gráfico de tendencias"

# Automatizar tareas
oi "Crea un script que organice mis fotos por fecha"
```

## Cómo funciona

Esta solución utiliza un enfoque de múltiples capas:

1. **oi_pwsh.sh**: Script bash que ejecuta Open Interpreter directamente
2. **oi_bridge.ps1**: Script PowerShell que actúa como puente hacia el script bash
3. **Alias en PowerShell**: Configurado en tu perfil para facilitar el uso

Este enfoque evita los problemas con las herramientas de línea de comandos de OpenAI y asegura que las variables de entorno se pasen correctamente.

## Solución de problemas

Si encuentras algún problema:

### El comando `oi` no funciona

1. **Verifica que el perfil de PowerShell está cargado**:

   ```powershell
   . $PROFILE
   ```

2. **Ejecuta el script bridge directamente**:

   ```powershell
   /Volumes/NVMe1TB/GitHub/open-interpreter/oi_bridge.ps1 "Tu instrucción"
   ```

3. **Ejecuta el script bash directamente**:

   ```powershell
   bash /Volumes/NVMe1TB/GitHub/open-interpreter/oi_pwsh.sh "Tu instrucción"
   ```

### Error: "Open Interpreter no está instalado globalmente"

Instala Open Interpreter globalmente:

```bash
pip install open-interpreter
```

## Notas

- Esta solución está diseñada específicamente para PowerShell en macOS
- Utiliza la instalación global de Open Interpreter
- No depende de herramientas de línea de comandos de OpenAI
