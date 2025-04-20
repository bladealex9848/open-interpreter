#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
AI Bridge para Open Interpreter
Este script permite que un asistente de IA pueda enviar comandos a Open Interpreter
y recibir los resultados.
"""

import sys
import os
import argparse
import subprocess
import tempfile
import json
from pathlib import Path

# Directorio base donde se encuentra Open Interpreter
BASE_DIR = Path(__file__).parent.absolute()
VENV_DIR = BASE_DIR / "venv"
VENV_PYTHON = VENV_DIR / "bin" / "python"


def activate_venv():
    """Activa el entorno virtual para Open Interpreter"""
    if not VENV_DIR.exists():
        print("Error: El entorno virtual no existe. Ejecuta setup_env.sh primero.")
        sys.exit(1)

    # Configurar variables de entorno para el entorno virtual
    os.environ["VIRTUAL_ENV"] = str(VENV_DIR)
    os.environ["PATH"] = f"{VENV_DIR}/bin:{os.environ['PATH']}"

    # Verificar que estamos usando el Python del entorno virtual
    python_path = subprocess.check_output(["which", "python"]).decode().strip()
    if not python_path.startswith(str(VENV_DIR)):
        print(
            f"Advertencia: No se pudo activar el entorno virtual. Usando Python de: {python_path}"
        )


def run_interpreter_with_command(
    command, model="gpt-4.1-nano", auto_run=True, verbose=True
):
    """Ejecuta Open Interpreter con un comando específico"""
    # Crear un archivo temporal para el comando
    with tempfile.NamedTemporaryFile(mode="w", suffix=".txt", delete=False) as temp:
        temp.write(command)
        temp_path = temp.name

    try:
        # Activar el entorno virtual
        activate_venv()

        # Construir los argumentos para Open Interpreter
        interpreter_path = VENV_DIR / "bin" / "interpreter"
        args = [str(interpreter_path)]

        if model:
            args.extend(["--model", model])

        if auto_run:
            args.append("-y")

        if verbose:
            args.append("-v")

        # Ejecutar Open Interpreter con el comando
        print(f"Ejecutando Open Interpreter con el comando...")

        # No añadimos --quiet porque no es compatible

        # Abrir el archivo de entrada
        with open(temp_path, "r") as input_file:
            # Ejecutar el proceso con la entrada del archivo
            process = subprocess.Popen(
                args, stdin=input_file, stdout=subprocess.PIPE, stderr=subprocess.PIPE
            )
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


def run_interpreter_interactive(model="gpt-4.1-nano", auto_run=True, verbose=True):
    """Inicia Open Interpreter en modo interactivo"""
    # Activar el entorno virtual
    activate_venv()

    # Construir los argumentos para Open Interpreter
    interpreter_path = VENV_DIR / "bin" / "interpreter"
    args = [str(interpreter_path)]

    if model:
        args.extend(["--model", model])

    if auto_run:
        args.append("-y")

    if verbose:
        args.append("-v")

    # No añadimos --quiet porque no es compatible

    # Ejecutar Open Interpreter interactivamente
    print(f"Iniciando Open Interpreter con modelo {model}...")
    os.execvp(args[0], args)


def main():
    """Función principal"""
    parser = argparse.ArgumentParser(
        description="Puente entre asistentes de IA y Open Interpreter"
    )

    # Argumentos generales
    parser.add_argument(
        "--model",
        default="gpt-4.1-nano",
        help="Modelo a utilizar (default: gpt-4.1-nano)",
    )
    parser.add_argument(
        "--no-auto",
        action="store_false",
        dest="auto_run",
        help="Desactivar ejecución automática",
    )
    parser.add_argument(
        "--no-verbose",
        action="store_false",
        dest="verbose",
        help="Desactivar modo verbose",
    )

    # Subcomandos
    subparsers = parser.add_subparsers(dest="command", help="Comando a ejecutar")

    # Comando 'run' para ejecutar un comando específico
    run_parser = subparsers.add_parser("run", help="Ejecutar un comando específico")
    run_parser.add_argument("input", help="Comando a ejecutar o archivo con el comando")

    # Comando 'interactive' para iniciar en modo interactivo
    subparsers.add_parser("interactive", help="Iniciar en modo interactivo")

    # Parsear argumentos
    args = parser.parse_args()

    # Ejecutar el comando correspondiente
    if args.command == "run":
        # Verificar si el input es un archivo o un comando directo
        if os.path.isfile(args.input):
            with open(args.input, "r") as f:
                command = f.read()
        else:
            command = args.input

        return run_interpreter_with_command(
            command, args.model, args.auto_run, args.verbose
        )

    elif args.command == "interactive" or not args.command:
        # Modo interactivo (default)
        run_interpreter_interactive(args.model, args.auto_run, args.verbose)

    else:
        parser.print_help()
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
