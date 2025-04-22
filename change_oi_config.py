#!/usr/bin/env python
"""
Script para cambiar la configuración de Open Interpreter.
"""

import os
import sys
import re

def main():
    # Obtener la ruta del script run_oi_direct.py
    script_path = os.path.join(os.path.expanduser("~"), "bin", "run_oi_direct.py")
    
    if not os.path.exists(script_path):
        print(f"Error: No se encontró el archivo {script_path}")
        return
    
    # Leer el contenido del archivo
    with open(script_path, "r", encoding="utf-8") as f:
        content = f.read()
    
    # Obtener la configuración actual
    model_match = re.search(r"interpreter\.llm\.model\s*=\s*['\"]([^'\"]+)['\"]", content)
    auto_run_match = re.search(r"interpreter\.auto_run\s*=\s*(True|False)", content)
    verbose_match = re.search(r"interpreter\.verbose\s*=\s*(True|False)", content)
    
    if not all([model_match, auto_run_match, verbose_match]):
        print("Error: No se pudo encontrar la configuración en el archivo.")
        return
    
    current_model = model_match.group(1)
    current_auto_run = auto_run_match.group(1) == "True"
    current_verbose = verbose_match.group(1) == "True"
    
    print("Configuración actual de Open Interpreter:")
    print(f"1. Modelo: {current_model}")
    print(f"2. Auto-run: {current_auto_run}")
    print(f"3. Verbose: {current_verbose}")
    print("4. Salir")
    
    try:
        choice = input("\n¿Qué configuración deseas cambiar? (1-4): ")
        
        if choice == "1":
            # Cambiar modelo
            from change_oi_model import get_available_models
            models = get_available_models()
            
            print("\nModelos disponibles:")
            for i, model in enumerate(models, 1):
                print(f"{i}. {model}")
            
            model_choice = input("\nSelecciona un modelo (número o nombre): ")
            
            if model_choice.isdigit() and 1 <= int(model_choice) <= len(models):
                new_model = models[int(model_choice) - 1]
            elif model_choice in models:
                new_model = model_choice
            else:
                print("Selección inválida. No se realizaron cambios.")
                return
            
            # Reemplazar el modelo en el archivo
            content = re.sub(
                r"(interpreter\.llm\.model\s*=\s*)['\"][^'\"]+['\"]",
                f"\\1'{new_model}'",
                content
            )
            
            print(f"\nModelo cambiado a: {new_model}")
            
        elif choice == "2":
            # Cambiar auto_run
            new_auto_run = not current_auto_run
            content = re.sub(
                r"(interpreter\.auto_run\s*=\s*)True|False",
                f"\\1{new_auto_run}",
                content
            )
            
            print(f"\nAuto-run cambiado a: {new_auto_run}")
            
        elif choice == "3":
            # Cambiar verbose
            new_verbose = not current_verbose
            content = re.sub(
                r"(interpreter\.verbose\s*=\s*)True|False",
                f"\\1{new_verbose}",
                content
            )
            
            print(f"\nVerbose cambiado a: {new_verbose}")
            
        elif choice == "4":
            print("\nSaliendo sin realizar cambios.")
            return
        
        else:
            print("\nOpción inválida. No se realizaron cambios.")
            return
        
        # Guardar el archivo modificado
        with open(script_path, "w", encoding="utf-8") as f:
            f.write(content)
        
        print("Configuración guardada. Ahora puedes ejecutar 'oi' para usar Open Interpreter con la nueva configuración.")
        
    except KeyboardInterrupt:
        print("\nOperación cancelada.")
    except Exception as e:
        print(f"\nError: {e}")

if __name__ == "__main__":
    main()
