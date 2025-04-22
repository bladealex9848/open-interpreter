#!/usr/bin/env python
"""
Script para ejecutar Open Interpreter directamente con Python.
"""

import sys
import subprocess
import os

def main():
    try:
        # Intentar importar open-interpreter
        import interpreter
        
        # Configurar Open Interpreter
        interpreter.llm.model = 'gpt-4.1-nano'
        interpreter.auto_run = True
        interpreter.verbose = True
        
        # Iniciar Open Interpreter
        interpreter.chat()
    except ImportError:
        print("No se pudo importar Open Interpreter. Intentando instalarlo...")
        try:
            subprocess.check_call([sys.executable, "-m", "pip", "install", "open-interpreter"])
            print("Open Interpreter instalado correctamente. Reiniciando...")
            os.execv(sys.executable, [sys.executable] + sys.argv)
        except Exception as e:
            print(f"Error al instalar Open Interpreter: {e}")
            print("\nIntenta instalar manualmente:")
            print("pip install open-interpreter")
    except Exception as e:
        print(f"Error al ejecutar Open Interpreter: {e}")

if __name__ == "__main__":
    main()
