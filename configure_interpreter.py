#!/usr/bin/env python3
"""
Script para configurar Open Interpreter con los parámetros por defecto.
"""

import os
import json
import sys

def configure_interpreter():
    """
    Configura Open Interpreter con los parámetros por defecto.
    """
    # Obtener la ruta del directorio de configuración
    config_dir = os.path.expanduser("~/.config/interpreter")
    
    # Crear el directorio si no existe
    os.makedirs(config_dir, exist_ok=True)
    
    # Ruta del archivo de configuración
    config_file = os.path.join(config_dir, "config.json")
    
    # Configuración por defecto
    config = {
        "model": "gpt-4.1-nano",
        "auto_run": True,
        "verbose": True,
        "system_message": "Eres Open Interpreter, un asistente de IA que puede ejecutar código en la computadora del usuario para ayudarle con sus tareas.",
        "display_streamed_output": True,
        "disable_telemetry": False,
        "safe_mode": "off"
    }
    
    # Guardar la configuración
    with open(config_file, "w") as f:
        json.dump(config, f, indent=4)
    
    print(f"Configuración guardada en {config_file}")
    print("Open Interpreter ahora usará el modelo gpt-4.1-nano por defecto")
    print("con las opciones auto_run y verbose activadas.")

if __name__ == "__main__":
    configure_interpreter()
