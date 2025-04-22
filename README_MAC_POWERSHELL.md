# Configuración de Open Interpreter para PowerShell en Mac

Este documento explica cómo configurar y usar Open Interpreter en PowerShell específicamente en macOS.

## Requisitos previos

- **PowerShell 7.x** instalado en macOS
- **Open Interpreter** instalado globalmente en macOS
- **Variables de entorno** OPENAI_API_KEY (y opcionalmente GROQ_API_KEY) configuradas

## Instalación

1. **Abre PowerShell** en tu Mac y navega al directorio de Open Interpreter:

   ```powershell
   cd /Volumes/NVMe1TB/GitHub/open-interpreter
   ```

2. **Ejecuta el script de configuración**:

   ```powershell
   ./setup_mac_pwsh.ps1
   ```

   Este script realizará las siguientes acciones:
   - Verificará que el script `oi_mac_pwsh.ps1` existe
   - Configurará el perfil de PowerShell para que puedas usar el comando `oi`
   - Verificará si Open Interpreter está instalado globalmente y lo instalará si es necesario

3. **Carga el perfil actualizado**:

   ```powershell
   . $PROFILE
   ```

   O simplemente reinicia PowerShell.

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
oi -Model gpt-4o "Crea un script que calcule números primos"
```

## Cómo funciona

Este script es un puente entre PowerShell en Mac y Open Interpreter. A diferencia de la versión para Windows, esta versión:

1. Utiliza la instalación global de Open Interpreter en macOS
2. Pasa las variables de entorno de PowerShell a bash para ejecutar Open Interpreter
3. Crea un alias `oi` que funciona de manera similar al comando en Terminal

## Solución de problemas

Si encuentras algún problema:

### Error: "No se encontró ninguna herramienta de línea de comandos para OpenAI"

Este error ocurre cuando Open Interpreter no puede encontrar las variables de entorno necesarias o cuando hay un problema con la instalación. Para solucionarlo:

1. **Verifica que las variables de entorno están configuradas**:

   ```powershell
   echo $env:OPENAI_API_KEY
   ```

   Si no muestra tu clave API, configúrala:

   ```powershell
   $env:OPENAI_API_KEY = "tu-clave-api-aqui"
   ```

2. **Verifica que Open Interpreter está instalado globalmente**:

   ```powershell
   bash -c "interpreter --version"
   ```

   Si no está instalado, instálalo:

   ```powershell
   bash -c "pip install open-interpreter"
   ```

3. **Ejecuta el script directamente**:

   ```powershell
   ./oi_mac_pwsh.ps1 "Tu instrucción"
   ```

4. **Reinstala el script**:

   ```powershell
   ./setup_mac_pwsh.ps1
   ```

## Notas

- Este script está diseñado específicamente para PowerShell en macOS
- Utiliza bash como puente para ejecutar Open Interpreter
- Las variables de entorno se pasan correctamente de PowerShell a bash
