# Script PowerShell para Open Interpreter
# Este script permite usar Open Interpreter de forma simplificada en PowerShell

# Directorio base donde se encuentra Open Interpreter
$BASE_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition
$VENV_DIR = Join-Path $BASE_DIR "venv"

# Detectar si estamos en Windows o Unix
$isWindows = $PSVersionTable.Platform -eq "Win32NT" -or ($null -eq $PSVersionTable.Platform -and $env:OS -like "*Windows*")

if ($isWindows) {
    $SCRIPTS_DIR = Join-Path $VENV_DIR "Scripts"
    $VENV_PYTHON = Join-Path $SCRIPTS_DIR "python.exe"
    $INTERPRETER_PATH = Join-Path $SCRIPTS_DIR "interpreter.exe"
} else {
    $SCRIPTS_DIR = Join-Path $VENV_DIR "bin"
    $VENV_PYTHON = Join-Path $SCRIPTS_DIR "python"
    $INTERPRETER_PATH = Join-Path $SCRIPTS_DIR "interpreter"
}

# Función para mostrar ayuda
function Show-Help {
    Write-Host "Open Interpreter - Interfaz simplificada" -ForegroundColor Blue
    Write-Host ""
    Write-Host "Uso:"
    Write-Host "  oi                           Inicia Open Interpreter en modo interactivo"
    Write-Host "  oi <comando>                 Ejecuta un comando en Open Interpreter"
    Write-Host "  oi -file <archivo>           Ejecuta los comandos del archivo en Open Interpreter"
    Write-Host "  oi -model <modelo>           Especifica el modelo a utilizar (default: gpt-4.1-nano)"
    Write-Host "  oi -noAuto                   Desactiva la ejecución automática"
    Write-Host "  oi -noVerbose                Desactiva el modo verbose"
    Write-Host "  oi -help                     Muestra esta ayuda"
    Write-Host ""
    Write-Host "Ejemplos:"
    Write-Host "  oi                                      # Inicia Open Interpreter interactivo"
    Write-Host "  oi ""Crea un script que calcule primos""  # Ejecuta un comando específico"
    Write-Host "  oi -model gpt-4o                        # Usa un modelo diferente"
    Write-Host ""
}

# Verificar que el entorno virtual existe
function Test-VirtualEnv {
    if (-not (Test-Path $VENV_DIR)) {
        Write-Host "Error: El entorno virtual no existe." -ForegroundColor Red
        if ($isWindows) {
            Write-Host "Ejecuta $BASE_DIR\setup_powershell.ps1 primero." -ForegroundColor Yellow
        } else {
            Write-Host "Ejecuta $BASE_DIR/setup_env.sh primero." -ForegroundColor Yellow
        }
        exit 1
    }

    # Verificar que Python existe en el entorno virtual
    if (-not (Test-Path $VENV_PYTHON)) {
        Write-Host "Error: No se encontró Python en el entorno virtual." -ForegroundColor Red
        Write-Host "El entorno virtual parece estar corrupto." -ForegroundColor Red
        if ($isWindows) {
            Write-Host "Ejecuta $BASE_DIR\setup_powershell.ps1 primero." -ForegroundColor Yellow
        } else {
            Write-Host "Ejecuta $BASE_DIR/setup_env.sh primero." -ForegroundColor Yellow
        }
        exit 1
    }

    # Verificar que Open Interpreter está instalado
    if (-not (Test-Path $INTERPRETER_PATH)) {
        Write-Host "Error: Open Interpreter no está instalado en el entorno virtual." -ForegroundColor Red
        Write-Host "Instalando Open Interpreter..." -ForegroundColor Yellow

        # Activar el entorno virtual
        if ($isWindows) {
            $activateScript = Join-Path $VENV_DIR "Scripts" "Activate.ps1"
        } else {
            $activateScript = Join-Path $VENV_DIR "bin" "Activate.ps1"
        }

        if (Test-Path $activateScript) {
            . $activateScript
            pip install open-interpreter
            deactivate

            # Verificar nuevamente
            if (-not (Test-Path $INTERPRETER_PATH)) {
                Write-Host "Error: No se pudo instalar Open Interpreter." -ForegroundColor Red
                exit 1
            }

            Write-Host "Open Interpreter instalado correctamente." -ForegroundColor Green
        } else {
            Write-Host "Error: No se encontró el script de activación." -ForegroundColor Red
            exit 1
        }
    }
}

# Función para filtrar la salida y mostrar solo lo relevante
function Filter-Output {
    param (
        [Parameter(ValueFromPipeline=$true)]
        [string]$InputObject
    )

    begin {
        $tempFile = [System.IO.Path]::GetTempFileName()
        $sw = New-Object System.IO.StreamWriter $tempFile
        Write-Host "=== Resultado de Open Interpreter ===" -ForegroundColor Green
    }

    process {
        $sw.WriteLine($InputObject)
    }

    end {
        $sw.Close()

        # Extraer y mostrar solo las partes importantes
        $content = Get-Content $tempFile
        $inCodeBlock = $false
        $result = @()

        foreach ($line in $content) {
            # Ignorar líneas con errores conocidos
            if ($line -match "EOFError|KeyboardInterrupt|Traceback|Exception|Error:|Was Open Interpreter helpful|^  File |During handling|^             |^    |^<|^>|^Exiting...") {
                continue
            }

            # Capturar líneas después del prompt ">"
            if ($line -match "^>") {
                $inCodeBlock = $true
                continue
            }

            if ($inCodeBlock -and $line.Trim() -ne "") {
                $result += $line
            }
        }

        # Mostrar el resultado
        $result | ForEach-Object { Write-Host $_ }

        # Eliminar el archivo temporal
        Remove-Item $tempFile
    }
}

# Función principal para ejecutar Open Interpreter
function Invoke-OpenInterpreter {
    param (
        [string]$Command,
        [string]$Model = "gpt-4.1-nano",
        [switch]$NoAuto,
        [switch]$NoVerbose,
        [string]$File,
        [switch]$Help
    )

    # Mostrar ayuda si se solicita
    if ($Help) {
        Show-Help
        return
    }

    # Verificar el entorno virtual
    Test-VirtualEnv

    # Verificar y pasar las variables de entorno necesarias
    $envVars = @{}

    # Verificar si las variables de API están configuradas
    if (Test-Path env:OPENAI_API_KEY) {
        $envVars["OPENAI_API_KEY"] = $env:OPENAI_API_KEY
        Write-Host "Variable OPENAI_API_KEY encontrada y será utilizada." -ForegroundColor Green
    } else {
        Write-Host "Advertencia: No se encontró la variable OPENAI_API_KEY." -ForegroundColor Yellow
    }

    if (Test-Path env:GROQ_API_KEY) {
        $envVars["GROQ_API_KEY"] = $env:GROQ_API_KEY
        Write-Host "Variable GROQ_API_KEY encontrada y será utilizada." -ForegroundColor Green
    }

    # Activar el entorno virtual (en PowerShell es diferente)
    if ($isWindows) {
        $activateScript = Join-Path $VENV_DIR "Scripts" "Activate.ps1"
    } else {
        $activateScript = Join-Path $VENV_DIR "bin" "Activate.ps1"
    }

    if (Test-Path $activateScript) {
        . $activateScript
        Write-Host "Entorno virtual activado correctamente." -ForegroundColor Green
    } else {
        Write-Host "Advertencia: No se pudo encontrar el script de activación para PowerShell." -ForegroundColor Yellow
        Write-Host "Usando rutas absolutas en su lugar." -ForegroundColor Yellow
    }

    # Construir argumentos
    $args = @($INTERPRETER_PATH, "--model", $Model)

    if (-not $NoAuto) {
        $args += "-y"
    }

    if (-not $NoVerbose) {
        $args += "-v"
    }

    # Ejecutar según el modo
    if ($File) {
        if (-not (Test-Path $File)) {
            Write-Host "Error: El archivo $File no existe." -ForegroundColor Red
            return
        }

        Write-Host "Ejecutando comandos del archivo: $File" -ForegroundColor Yellow
        $args += "run"
        $args += $File

        # Ejecutar y filtrar salida
        if ($Command -or $File) {
            # Crear un nuevo proceso con las variables de entorno configuradas
            $psi = New-Object System.Diagnostics.ProcessStartInfo
            $psi.FileName = $VENV_PYTHON
            $psi.Arguments = $args -join " "
            $psi.UseShellExecute = $false
            $psi.RedirectStandardOutput = $true
            $psi.RedirectStandardError = $true

            # Agregar las variables de entorno al proceso
            foreach ($key in $envVars.Keys) {
                $psi.EnvironmentVariables[$key] = $envVars[$key]
            }

            $process = [System.Diagnostics.Process]::Start($psi)
            $output = $process.StandardOutput.ReadToEnd()
            $error = $process.StandardError.ReadToEnd()
            $process.WaitForExit()

            # Filtrar y mostrar la salida
            $output | Filter-Output

            # Mostrar errores si hay alguno (excepto los que queremos filtrar)
            if ($error -and -not ($error -match "EOFError|KeyboardInterrupt|Traceback")) {
                Write-Host "Errores:" -ForegroundColor Red
                Write-Host $error -ForegroundColor Red
            }
        } else {
            # Crear un nuevo proceso con las variables de entorno configuradas
            $psi = New-Object System.Diagnostics.ProcessStartInfo
            $psi.FileName = $VENV_PYTHON
            $psi.Arguments = $args -join " "
            $psi.UseShellExecute = $false

            # Agregar las variables de entorno al proceso
            foreach ($key in $envVars.Keys) {
                $psi.EnvironmentVariables[$key] = $envVars[$key]
            }

            # Iniciar el proceso sin redirección para modo interactivo
            [System.Diagnostics.Process]::Start($psi).WaitForExit()
        }
    }
    elseif ($Command) {
        Write-Host "Ejecutando comando: $Command" -ForegroundColor Yellow

        # Crear archivo temporal para el comando
        $tempFile = [System.IO.Path]::GetTempFileName()
        Set-Content -Path $tempFile -Value $Command

        $args += "run"
        $args += $tempFile

        # Crear un nuevo proceso con las variables de entorno configuradas
        $psi = New-Object System.Diagnostics.ProcessStartInfo
        $psi.FileName = $VENV_PYTHON
        $psi.Arguments = $args -join " "
        $psi.UseShellExecute = $false
        $psi.RedirectStandardOutput = $true
        $psi.RedirectStandardError = $true

        # Agregar las variables de entorno al proceso
        foreach ($key in $envVars.Keys) {
            $psi.EnvironmentVariables[$key] = $envVars[$key]
        }

        $process = [System.Diagnostics.Process]::Start($psi)
        $output = $process.StandardOutput.ReadToEnd()
        $error = $process.StandardError.ReadToEnd()
        $process.WaitForExit()

        # Filtrar y mostrar la salida
        $output | Filter-Output

        # Mostrar errores si hay alguno (excepto los que queremos filtrar)
        if ($error -and -not ($error -match "EOFError|KeyboardInterrupt|Traceback")) {
            Write-Host "Errores:" -ForegroundColor Red
            Write-Host $error -ForegroundColor Red
        }

        # Eliminar archivo temporal
        Remove-Item $tempFile
    }
    else {
        # Modo interactivo
        Write-Host "Iniciando Open Interpreter en modo interactivo..." -ForegroundColor Yellow
        $args += "interactive"

        # Crear un nuevo proceso con las variables de entorno configuradas
        $psi = New-Object System.Diagnostics.ProcessStartInfo
        $psi.FileName = $VENV_PYTHON
        $psi.Arguments = $args -join " "
        $psi.UseShellExecute = $false

        # Agregar las variables de entorno al proceso
        foreach ($key in $envVars.Keys) {
            $psi.EnvironmentVariables[$key] = $envVars[$key]
        }

        # Iniciar el proceso sin redirección para modo interactivo
        [System.Diagnostics.Process]::Start($psi).WaitForExit()
    }

    # Desactivar el entorno virtual si fue activado
    if (Test-Path Function:\deactivate) {
        deactivate
    }
}

# Procesar argumentos
$params = @{}
$command = $null
$i = 0

while ($i -lt $args.Count) {
    $arg = $args[$i]

    switch -regex ($arg) {
        "-model" {
            $params["Model"] = $args[$i+1]
            $i += 2
            continue
        }
        "-file" {
            $params["File"] = $args[$i+1]
            $i += 2
            continue
        }
        "-noAuto" {
            $params["NoAuto"] = $true
            $i++
            continue
        }
        "-noVerbose" {
            $params["NoVerbose"] = $true
            $i++
            continue
        }
        "-help" {
            $params["Help"] = $true
            $i++
            continue
        }
        default {
            if (-not $command) {
                $command = $arg
            }
            $i++
        }
    }
}

if ($command) {
    $params["Command"] = $command
}

# Ejecutar Open Interpreter con los parámetros procesados
Invoke-OpenInterpreter @params
