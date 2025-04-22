#!/usr/bin/env python3
"""
Script simple para ejecutar Open Interpreter y manejar la interacción.
"""

import sys
import os
import subprocess
import signal

# Manejar la señal SIGINT (Ctrl+C)
def signal_handler(sig, frame):
    print("\nSaliendo de Open Interpreter...")
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)

def run_interpreter(command=None):
    """
    Ejecuta Open Interpreter con el comando proporcionado.

    Args:
        command (str, optional): El comando a ejecutar. Si es None, se inicia en modo interactivo.
    """
    try:
        # Preparar el comando base
        cmd = ["interpreter", "--model", "gpt-4.1-nano", "-y", "-v"]

        # Si estamos en modo interactivo, ejecutar directamente
        if not command:
            print("Iniciando Open Interpreter en modo interactivo...")
            print("Presiona Ctrl+C para salir.")

            # Ejecutar Open Interpreter en modo interactivo
            # Usamos os.execvp para reemplazar el proceso actual con Open Interpreter
            os.execvp("interpreter", cmd)
            # Esta línea nunca se ejecutará si os.execvp tiene éxito
            return 0

        # Si hay un comando, crear un proceso para Open Interpreter
        process = subprocess.Popen(
            cmd,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            bufsize=1,
            universal_newlines=True
        )

        # Enviar el comando
        print(f"Ejecutando: {command}")
        process.stdin.write(f"{command}\n")
        process.stdin.flush()

        # Leer la salida línea por línea
        for line in iter(process.stdout.readline, ''):
            print(line, end='')
            sys.stdout.flush()

            # Si aparece la pregunta de feedback, responder automáticamente
            if "Was Open Interpreter helpful? (y/n):" in line:
                process.stdin.write("y\n")
                process.stdin.flush()
                break

        # Esperar a que termine el proceso
        process.wait()

        return process.returncode

    except Exception as e:
        print(f"Error al ejecutar Open Interpreter: {e}")
        return 1

if __name__ == "__main__":
    # Obtener el comando de los argumentos
    command = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else None

    # Ejecutar Open Interpreter
    sys.exit(run_interpreter(command))
