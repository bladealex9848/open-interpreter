# Ejecutar Open Interpreter sin archivos .bat en Windows

Esta guía explica cómo ejecutar Open Interpreter directamente desde la línea de comandos en Windows 11, sin necesidad de utilizar los archivos .bat.

## Requisitos previos

- Python 3.8 o superior instalado
- Open Interpreter instalado en el entorno virtual

## Método 1: Usando el módulo Python con configuración por defecto

Para ejecutar Open Interpreter con el modelo gpt-4.1-nano, auto_run=True y verbose=True, puedes usar el siguiente comando:

```bash
# Activar el entorno virtual
cd C:\GitHub\open-interpreter
.\venv\Scripts\activate

# Ejecutar Open Interpreter con la configuración deseada
python -c "from interpreter import interpreter; interpreter.llm.model = 'gpt-4.1-nano'; interpreter.auto_run = True; interpreter.verbose = True; interpreter.chat()"
```

## Método 2: Usando un archivo de configuración

Puedes crear un archivo de configuración personalizado (por ejemplo, `config_default.py`) con el siguiente contenido:

```python
from interpreter import interpreter

# Configuración del modelo LLM
interpreter.llm.model = "gpt-4.1-nano"
interpreter.llm.context_window = 100000
interpreter.llm.max_tokens = 4096

# Configuración general
interpreter.auto_run = True
interpreter.verbose = True

# Mensaje final
interpreter.display_message(
    "> Modelo configurado: `gpt-4.1-nano`\n\n**Open Interpreter** ejecutará código automáticamente sin pedir confirmación.\n\nPresiona `CTRL-C` para salir.\n"
)
```

Y luego ejecutarlo con:

```bash
# Activar el entorno virtual
cd C:\GitHub\open-interpreter
.\venv\Scripts\activate

# Ejecutar Open Interpreter con la configuración personalizada
python -c "from interpreter import interpreter; exec(open('config_default.py').read()); interpreter.chat()"
```

## Método 3: Usando un alias en PowerShell

Puedes crear un alias en PowerShell para ejecutar Open Interpreter con la configuración deseada. Para ello, edita tu perfil de PowerShell:

```powershell
# Abrir el perfil de PowerShell
notepad $PROFILE
```

Y agrega la siguiente línea:

```powershell
function oi { cd C:\GitHub\open-interpreter; .\venv\Scripts\activate; python -c "from interpreter import interpreter; interpreter.llm.model = 'gpt-4.1-nano'; interpreter.auto_run = True; interpreter.verbose = True; interpreter.chat()" }
```

Guarda el archivo y reinicia PowerShell. Ahora puedes ejecutar Open Interpreter simplemente escribiendo `oi` en cualquier ubicación.

## Método 4: Usando un script Python

Puedes crear un script Python (por ejemplo, `run_oi.py`) con el siguiente contenido:

```python
from interpreter import interpreter

# Configuración del modelo LLM
interpreter.llm.model = "gpt-4.1-nano"
interpreter.llm.context_window = 100000
interpreter.llm.max_tokens = 4096

# Configuración general
interpreter.auto_run = True
interpreter.verbose = True

# Iniciar Open Interpreter
interpreter.chat()
```

Y luego ejecutarlo con:

```bash
# Activar el entorno virtual
cd C:\GitHub\open-interpreter
.\venv\Scripts\activate

# Ejecutar Open Interpreter con la configuración personalizada
python run_oi.py
```

## Notas adicionales

- Para una experiencia óptima, considera usar Open Interpreter en Windows Terminal o PowerShell.
- Si estás usando VSCode, puedes abrir una terminal integrada y ejecutar Open Interpreter directamente desde allí.
- Recuerda que siempre debes activar el entorno virtual antes de ejecutar Open Interpreter.
- Si prefieres no usar los scripts .bat, asegúrate de activar siempre el entorno virtual antes de ejecutar Open Interpreter.

## Recursos adicionales

- [Documentación oficial de Open Interpreter](https://docs.openinterpreter.com/)
- [Repositorio de GitHub](https://github.com/OpenInterpreter/open-interpreter)
- [Ejemplos de uso](https://github.com/OpenInterpreter/examples)
