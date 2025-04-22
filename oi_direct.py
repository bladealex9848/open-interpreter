#!/usr/bin/env python3
"""
Script para ejecutar Open Interpreter directamente usando su API.
"""

import sys
import os
import interpreter

def run_interpreter(command=None):
    """
    Ejecuta Open Interpreter con el comando proporcionado.
    
    Args:
        command (str, optional): El comando a ejecutar. Si es None, se inicia en modo interactivo.
    """
    try:
        # Configurar Open Interpreter
        interpreter.model = "gpt-4.1-nano"
        interpreter.auto_run = True
        interpreter.verbose = True
        interpreter.system_message = "Eres Open Interpreter, un asistente de IA que puede ejecutar código en la computadora del usuario para ayudarle con sus tareas."
        interpreter.display_streamed_output = True
        interpreter.disable_telemetry = False
        interpreter.safe_mode = "off"
        
        # Ejecutar Open Interpreter con el comando
        if command:
            print(f"Ejecutando: {command}")
            # Ejecutar el comando y capturar la respuesta
            response = interpreter.chat(command, display=True)
            return 0
        else:
            # Modo interactivo modificado
            print("Iniciando Open Interpreter en modo interactivo...")
            print("Escribe 'exit' o 'quit' para salir.")
            
            while True:
                try:
                    # Solicitar entrada al usuario
                    user_input = input("> ")
                    
                    # Verificar si el usuario quiere salir
                    if user_input.lower() in ["exit", "quit"]:
                        print("Saliendo de Open Interpreter...")
                        break
                    
                    # Ejecutar el comando
                    response = interpreter.chat(user_input, display=True)
                except KeyboardInterrupt:
                    print("\nSaliendo de Open Interpreter...")
                    break
                except EOFError:
                    print("\nSaliendo de Open Interpreter...")
                    break
            
            return 0
    
    except Exception as e:
        print(f"Error al ejecutar Open Interpreter: {e}")
        return 1

if __name__ == "__main__":
    # Obtener el comando de los argumentos
    command = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else None
    
    # Ejecutar Open Interpreter
    sys.exit(run_interpreter(command))
