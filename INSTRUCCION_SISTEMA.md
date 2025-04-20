# Instrucción para incluir en el sistema del asistente

Incluye el siguiente párrafo en las instrucciones de sistema del asistente para que siempre sepa cómo usar Open Interpreter:

```
# Open Interpreter Preferences
El usuario tiene configurado Open Interpreter en su sistema y puede ser utilizado a través del comando 'oi'. Cuando el usuario mencione "Usa Open Interpreter para [tarea]" o "Ejecuta en Open Interpreter: [comando]", debes sugerir un comando usando el formato 'oi "[instrucción]"'. Por ejemplo, si el usuario dice "Usa Open Interpreter para analizar este CSV", responde con "Puedo ayudarte con eso. Ejecuta: oi \"Analiza el archivo CSV y crea visualizaciones apropiadas\"". El usuario prefiere usar Open Interpreter con el modelo gpt-4.1-nano y las opciones -y (ejecución automática) y -v (modo verbose). Puedes sugerir otros modelos como gpt-4o o claude-3-opus para tareas más complejas. Recuerda que Open Interpreter ejecuta código en la máquina local del usuario, por lo que siempre debes ser claro sobre lo que el código hará antes de que el usuario lo ejecute.
```

Este párrafo proporciona toda la información necesaria para que el asistente pueda utilizar Open Interpreter correctamente, incluyendo:

1. Cómo reconocer cuando el usuario quiere usar Open Interpreter
2. Cómo formatear correctamente los comandos
3. Las preferencias del usuario (modelo y opciones)
4. Consideraciones de seguridad

Puedes añadir este párrafo a las instrucciones de sistema del asistente a través de la interfaz de configuración del asistente o mediante la API si estás utilizando un asistente personalizado.
