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
