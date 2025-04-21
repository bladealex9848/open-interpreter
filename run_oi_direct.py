#!/usr/bin/env python
"""
Script para ejecutar Open Interpreter directamente.
"""

try:
    from interpreter import interpreter
    import platform
    import sys

    # Configurar Open Interpreter
    interpreter.llm.model = 'gpt-4.1-nano'
    interpreter.auto_run = True
    interpreter.verbose = True

    # Mostrar información de configuración
    print("\n" + "=" * 50)
    print("OPEN INTERPRETER - CONFIGURACIÓN ACTUAL")
    print("=" * 50)
    print(f"Modelo: {interpreter.llm.model}")
    print(f"Auto-run: {interpreter.auto_run}")
    print(f"Verbose: {interpreter.verbose}")
    print(f"Sistema: {platform.system()} {platform.release()}")
    print(f"Python: {sys.version.split()[0]}")
    print("\nComandos útiles:")
    print("  /help   - Muestra todos los comandos disponibles")
    print("  /config - Muestra la configuración actual")
    print("  /exit   - Sale de Open Interpreter")
    print("  Ctrl+C  - Interrumpe la ejecución")
    print("=" * 50 + "\n")

    # Iniciar Open Interpreter
    print("Iniciando Open Interpreter...")
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
