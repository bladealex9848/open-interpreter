# Script para actualizar la configuración de VS Code para Augment
$settingsPath = "$env:APPDATA\Code\User\settings.json"

# Verificar si el archivo existe
if (Test-Path $settingsPath) {
    # Leer el contenido actual
    $settings = Get-Content -Path $settingsPath -Raw | ConvertFrom-Json

    # Agregar o actualizar la configuración específica de Augment
    $settings | Add-Member -NotePropertyName "augment.terminal.defaultProfile" -NotePropertyValue "Git Bash" -Force
    
    # Guardar los cambios
    $settings | ConvertTo-Json -Depth 10 | Set-Content -Path $settingsPath

    Write-Host "Configuración de Augment actualizada correctamente."
}
else {
    Write-Host "No se encontró el archivo de configuración de VS Code."
}
