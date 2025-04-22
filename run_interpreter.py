#!/usr/bin/env python
"""
Script para ejecutar Open Interpreter directamente.
"""

try:
    from interpreter import interpreter
    
    # Configurar Open Interpreter
    interpreter.llm.model = 'gpt-4.1-nano'
    interpreter.auto_run = True
    interpreter.verbose = True
    
    # Iniciar Open Interpreter
    interpreter.chat()
except ImportError as e:
    print(f"Error al importar: {e}")
    print("\nAsegúrate de tener Open Interpreter instalado correctamente:")
    print("pip install open-interpreter")
    print("\nSi el problema persiste, intenta instalar las dependencias faltantes:")
    print("pip install send2trash shortuuid pydantic starlette")
    input("\nPresiona Enter para salir...")
except Exception as e:
    print(f"Error al ejecutar Open Interpreter: {e}")
    input("\nPresiona Enter para salir...")
