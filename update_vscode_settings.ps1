# Script para actualizar la configuración de VS Code
$settingsPath = "$env:APPDATA\Code\User\settings.json"

# Verificar si el archivo existe
if (Test-Path $settingsPath) {
    # Leer el contenido actual
    $settings = Get-Content -Path $settingsPath -Raw | ConvertFrom-Json

    # Agregar o actualizar la configuración
    $settings | Add-Member -NotePropertyName "terminal.integrated.defaultProfile.windows" -NotePropertyValue "Git Bash" -Force
    $settings | Add-Member -NotePropertyName "augment.terminal.defaultProfile" -NotePropertyValue "Git Bash" -Force

    # Si no existe la propiedad terminal.integrated.profiles.windows, crearla
    if (-not ($settings.PSObject.Properties.Name -contains "terminal.integrated.profiles.windows")) {
        $profiles = @{
            "Git Bash" = @{
                "path" = "C:\Program Files\Git\bin\bash.exe"
                "args" = @()
            }
        }
        $settings | Add-Member -NotePropertyName "terminal.integrated.profiles.windows" -NotePropertyValue $profiles -Force
    }
    else {
        # Si existe, asegurarse de que Git Bash esté configurado correctamente
        $settings."terminal.integrated.profiles.windows" | Add-Member -NotePropertyName "Git Bash" -NotePropertyValue @{
            "path" = "C:\Program Files\Git\bin\bash.exe"
            "args" = @()
        } -Force
    }

    # Guardar los cambios
    $settings | ConvertTo-Json -Depth 10 | Set-Content -Path $settingsPath

    Write-Host "Configuración actualizada correctamente."
}
else {
    # Si el archivo no existe, crearlo con la configuración deseada
    $settings = @{
        "terminal.integrated.defaultProfile.windows" = "Git Bash"
        "augment.terminal.defaultProfile" = "Git Bash"
        "terminal.integrated.profiles.windows" = @{
            "Git Bash" = @{
                "path" = "C:\Program Files\Git\bin\bash.exe"
                "args" = @()
            }
        }
    }

    # Crear el directorio si no existe
    $directory = [System.IO.Path]::GetDirectoryName($settingsPath)
    if (-not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }

    # Guardar la configuración
    $settings | ConvertTo-Json -Depth 10 | Set-Content -Path $settingsPath

    Write-Host "Archivo de configuración creado correctamente."
}
