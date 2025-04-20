#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Script para que un asistente de IA pueda enviar comandos a Open Interpreter.
"""

import sys
import os
import argparse
import json
import tempfile
import subprocess
from pathlib import Path

# Directorio base donde se encuentra Open Interpreter
BASE_DIR = Path(__file__).parent.absolute()
AI_BRIDGE = BASE_DIR / "ai_bridge.py"

def execute_command(command, model="gpt-4.1-nano", auto_run=True, verbose=True):
    """Ejecuta un comando en Open Interpreter a través del puente AI"""
    # Verificar que el puente AI existe
    if not AI_BRIDGE.exists():
        print(f"Error: No se encontró el puente AI en {AI_BRIDGE}")
        return 1
    
    # Crear un archivo temporal para el comando
    with tempfile.NamedTemporaryFile(mode='w', suffix='.txt', delete=False) as temp:
        temp.write(command)
        temp_path = temp.name
    
    try:
        # Construir el comando para ejecutar el puente AI
        args = [
            "python", 
            str(AI_BRIDGE), 
            "--model", model
        ]
        
        if auto_run:
            pass  # Es el comportamiento por defecto
        else:
            args.append("--no-auto")
        
        if verbose:
            pass  # Es el comportamiento por defecto
        else:
            args.append("--no-verbose")
        
        args.extend(["run", temp_path])
        
        # Ejecutar el comando
        print(f"Ejecutando comando a través del puente AI...")
        process = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout, stderr = process.communicate()
        
        # Imprimir la salida
        if stdout:
            print(stdout.decode())
        
        if stderr:
            print(stderr.decode())
        
        return process.returncode
    
    finally:
        # Eliminar el archivo temporal
        os.unlink(temp_path)

def main():
    """Función principal"""
    parser = argparse.ArgumentParser(description="Enviar comandos a Open Interpreter desde un asistente de IA")
    
    # Argumentos
    parser.add_argument("command", help="Comando a ejecutar en Open Interpreter")
    parser.add_argument("--model", default="gpt-4.1-nano", help="Modelo a utilizar (default: gpt-4.1-nano)")
    parser.add_argument("--no-auto", action="store_false", dest="auto_run", help="Desactivar ejecución automática")
    parser.add_argument("--no-verbose", action="store_false", dest="verbose", help="Desactivar modo verbose")
    
    # Parsear argumentos
    args = parser.parse_args()
    
    # Ejecutar el comando
    return execute_command(args.command, args.model, args.auto_run, args.verbose)

if __name__ == "__main__":
    sys.exit(main())
