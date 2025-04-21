@echo off
echo Instalando Open Interpreter sin tiktoken...
pip install open-interpreter --no-deps

echo Instalando dependencias excepto tiktoken...
pip install anthropic astor git-python google-generativeai html2image html2text inquirer ipykernel jupyter-client litellm matplotlib nltk platformdirs psutil pydantic pyperclip pyreadline3 pyyaml rich selenium send2trash setuptools shortuuid six starlette tokentrim toml typer webdriver-manager wget yaspin

echo Instalación completada.
pause
