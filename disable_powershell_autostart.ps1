# Script para deshabilitar el inicio automático de la extensión de PowerShell
$settingsPath = "$env:APPDATA\Code\User\settings.json"

# Verificar si el archivo existe
if (Test-Path $settingsPath) {
    # Leer el contenido actual
    $settings = Get-Content -Path $settingsPath -Raw | ConvertFrom-Json

    # Agregar o actualizar la configuración para deshabilitar el inicio automático de PowerShell
    $settings | Add-Member -NotePropertyName "powershell.integratedConsole.showOnStartup" -NotePropertyValue $false -Force
    $settings | Add-Member -NotePropertyName "powershell.promptToUpdatePowerShell" -NotePropertyValue $false -Force
    $settings | Add-Member -NotePropertyName "powershell.startAutomatically" -NotePropertyValue $false -Force
    
    # Guardar los cambios
    $settings | ConvertTo-Json -Depth 10 | Set-Content -Path $settingsPath

    Write-Host "Configuración de PowerShell actualizada correctamente."
}
else {
    Write-Host "No se encontró el archivo de configuración de VS Code."
}
