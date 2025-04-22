#!/usr/bin/env python
"""
Script para ejecutar Open Interpreter directamente desde la línea de comandos.
"""

from interpreter import interpreter

def main():
    # Configurar Open Interpreter
    interpreter.llm.model = 'gpt-4.1-nano'
    interpreter.auto_run = True
    interpreter.verbose = True
    
    # Iniciar Open Interpreter
    interpreter.chat()

if __name__ == "__main__":
    main()
