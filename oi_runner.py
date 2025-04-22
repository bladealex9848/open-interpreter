#!/usr/bin/env python3
"""
Script para ejecutar Open Interpreter y manejar la entrada/salida de manera controlada.
"""

import sys
import os
import subprocess
import tempfile
import signal

def signal_handler(sig, frame):
    """Manejador de señales para salir limpiamente."""
    print("\nSaliendo de Open Interpreter...")
    sys.exit(0)

def run_interpreter(command=None):
    """
    Ejecuta Open Interpreter con el comando proporcionado.
    
    Args:
        command (str, optional): El comando a ejecutar. Si es None, se inicia en modo interactivo.
    """
    # Configurar el manejador de señales para SIGINT (Ctrl+C)
    signal.signal(signal.SIGINT, signal_handler)
    
    # Preparar el comando base
    base_cmd = ["interpreter", "--model", "gpt-4.1-nano", "-y", "-v"]
    
    try:
        if command:
            print(f"Ejecutando: {command}")
            
            # Crear un archivo temporal para el comando
            with tempfile.NamedTemporaryFile(mode='w+', delete=False) as temp:
                temp.write(command)
                temp_path = temp.name
            
            # Ejecutar Open Interpreter con el comando
            process = subprocess.Popen(
                base_cmd,
                stdin=open(temp_path, 'r'),
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                bufsize=1
            )
            
            # Leer y mostrar la salida línea por línea, omitiendo la pregunta de feedback
            for line in process.stdout:
                if "Was Open Interpreter helpful? (y/n):" not in line:
                    sys.stdout.write(line)
                    sys.stdout.flush()
            
            # Esperar a que termine el proceso
            process.wait()
            
            # Limpiar
            os.unlink(temp_path)
            
            return process.returncode
        else:
            # Modo interactivo
            print("Iniciando Open Interpreter en modo interactivo...")
            
            # Ejecutar Open Interpreter en modo interactivo
            return subprocess.call(base_cmd)
    
    except Exception as e:
        print(f"Error al ejecutar Open Interpreter: {e}")
        return 1

if __name__ == "__main__":
    # Obtener el comando de los argumentos
    command = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else None
    
    # Ejecutar Open Interpreter
    sys.exit(run_interpreter(command))
