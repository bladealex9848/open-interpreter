#!/usr/bin/env pwsh
# Script para corregir completamente el perfil de PowerShell

# Obtener la ruta del perfil
$profilePath = $PROFILE

# Verificar que el perfil existe
if (-not (Test-Path $profilePath)) {
    Write-Host "Error: No se encontró el perfil de PowerShell en $profilePath" -ForegroundColor Red
    exit 1
}

# Leer el contenido actual del perfil
$profileContent = Get-Content $profilePath -Raw

# Buscar la sección problemática
$pattern = '\[Parameter\(ValueFromRemainingArguments=True\)\][\s\n]+\[string\[\]\]'
if ($profileContent -match $pattern) {
    Write-Host "Se encontró la sección problemática en el perfil." -ForegroundColor Yellow
    
    # Corregir el formato del parámetro
    $correctedContent = $profileContent -replace '\[Parameter\(ValueFromRemainingArguments=True\)\][\s\n]+\[string\[\]\]', '[Parameter(ValueFromRemainingArguments=$true)][string[]]'
    
    # Guardar el perfil corregido
    Set-Content -Path $profilePath -Value $correctedContent
    
    Write-Host "Perfil de PowerShell corregido correctamente." -ForegroundColor Green
} else {
    # Si no encontramos el patrón exacto, intentamos corregir otros problemas comunes
    $correctedContent = $profileContent
    
    # Corregir ValueFromRemainingArguments=True
    $correctedContent = $correctedContent -replace 'ValueFromRemainingArguments=True', 'ValueFromRemainingArguments=$true'
    $correctedContent = $correctedContent -replace 'ValueFromRemainingArguments=`True', 'ValueFromRemainingArguments=$true'
    
    # Corregir formato de parámetros
    $correctedContent = $correctedContent -replace '\[Parameter\([^\)]+\)\][\s\n]+\[string\[\]\]', '[Parameter(ValueFromRemainingArguments=$true)][string[]]'
    
    # Guardar el perfil corregido
    Set-Content -Path $profilePath -Value $correctedContent
    
    Write-Host "Se han aplicado correcciones generales al perfil de PowerShell." -ForegroundColor Green
}

# Crear un perfil mínimo para probar
$backupPath = "$profilePath.backup"
Copy-Item -Path $profilePath -Destination $backupPath -Force
Write-Host "Se ha creado una copia de seguridad del perfil en: $backupPath" -ForegroundColor Green

# Crear un perfil mínimo con solo el alias de Open Interpreter
$minimalProfile = @"
# Alias para Open Interpreter en Mac
function Invoke-OpenInterpreter {
    param(
        [Parameter(ValueFromRemainingArguments=`$true)]
        [string[]]`$Arguments
    )
    
    `$scriptPath = "/Volumes/NVMe1TB/GitHub/open-interpreter/oi_bridge.ps1"
    & `$scriptPath `$Arguments
}

Set-Alias -Name oi -Value Invoke-OpenInterpreter
"@

# Preguntar si desea usar el perfil mínimo
Write-Host ""
Write-Host "¿Deseas usar un perfil mínimo que solo contenga el alias de Open Interpreter?" -ForegroundColor Yellow
Write-Host "Esto reemplazará temporalmente tu perfil actual, pero se ha creado una copia de seguridad." -ForegroundColor Yellow
$useMinimal = Read-Host "Usar perfil mínimo (s/n)"

if ($useMinimal -eq "s") {
    Set-Content -Path $profilePath -Value $minimalProfile
    Write-Host "Se ha creado un perfil mínimo. Para restaurar tu perfil original, ejecuta:" -ForegroundColor Green
    Write-Host "Copy-Item -Path '$backupPath' -Destination '$profilePath' -Force" -ForegroundColor Yellow
} else {
    Write-Host "Se mantiene el perfil corregido." -ForegroundColor Green
}

Write-Host ""
Write-Host "Ahora puedes cargar el perfil con: . `$PROFILE" -ForegroundColor Yellow
