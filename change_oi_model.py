#!/usr/bin/env python
"""
Script para cambiar el modelo de Open Interpreter.
"""

import os
import sys
import re

def get_available_models():
    """Retorna una lista de modelos disponibles."""
    return [
        "gpt-4.1-nano",
        "gpt-4.1-mini",
        "gpt-4.1-turbo",
        "gpt-4.1-preview",
        "gpt-4o",
        "gpt-4-turbo",
        "gpt-3.5-turbo",
        "claude-3-opus-20240229",
        "claude-3-sonnet-20240229",
        "claude-3-haiku-20240307",
        "gemini-pro",
        "gemini-1.5-pro",
        "gemini-1.5-flash",
        "llama-3-8b-instruct",
        "llama-3-70b-instruct",
        "mixtral-8x7b-instruct",
        "mistral-medium",
        "mistral-small",
        "mistral-tiny"
    ]

def main():
    # Obtener la ruta del script run_oi_direct.py
    script_path = os.path.join(os.path.expanduser("~"), "bin", "run_oi_direct.py")
    
    if not os.path.exists(script_path):
        print(f"Error: No se encontró el archivo {script_path}")
        return
    
    # Leer el contenido del archivo
    with open(script_path, "r", encoding="utf-8") as f:
        content = f.read()
    
    # Obtener el modelo actual
    match = re.search(r"interpreter\.llm\.model\s*=\s*['\"]([^'\"]+)['\"]", content)
    if not match:
        print("Error: No se pudo encontrar la configuración del modelo en el archivo.")
        return
    
    current_model = match.group(1)
    print(f"Modelo actual: {current_model}")
    
    # Mostrar modelos disponibles
    models = get_available_models()
    print("\nModelos disponibles:")
    for i, model in enumerate(models, 1):
        print(f"{i}. {model}")
    
    # Solicitar al usuario que elija un modelo
    try:
        choice = input("\nSelecciona un modelo (número o nombre): ")
        
        # Verificar si el usuario ingresó un número
        if choice.isdigit() and 1 <= int(choice) <= len(models):
            new_model = models[int(choice) - 1]
        # Verificar si el usuario ingresó un nombre de modelo
        elif choice in models:
            new_model = choice
        else:
            print("Selección inválida. Usando modelo por defecto: gpt-4.1-nano")
            new_model = "gpt-4.1-nano"
        
        # Reemplazar el modelo en el archivo
        new_content = re.sub(
            r"(interpreter\.llm\.model\s*=\s*)['\"][^'\"]+['\"]",
            f"\\1'{new_model}'",
            content
        )
        
        # Guardar el archivo modificado
        with open(script_path, "w", encoding="utf-8") as f:
            f.write(new_content)
        
        print(f"\nModelo cambiado a: {new_model}")
        print("Ahora puedes ejecutar 'oi' para usar Open Interpreter con el nuevo modelo.")
        
    except KeyboardInterrupt:
        print("\nOperación cancelada.")
    except Exception as e:
        print(f"\nError: {e}")

if __name__ == "__main__":
    main()
