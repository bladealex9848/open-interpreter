# Ayuda de Open Interpreter

## Comandos Mágicos
Los comandos mágicos se pueden usar para controlar el comportamiento del intérprete en modo interactivo:

- `%% [comandos shell, como ls o cd]`: Ejecuta comandos en la instancia de shell de Open Interpreter
- `%verbose [true/false]`: Activa/desactiva el modo verbose. Sin argumentos o con 'true', entra en modo verbose. Con 'false', sale del modo verbose.
- `%reset`: Reinicia la sesión actual.
- `%undo`: Elimina mensajes anteriores y su respuesta del historial de mensajes.
- `%save_message [ruta]`: Guarda los mensajes en una ruta JSON especificada. Si no se proporciona una ruta, por defecto es 'messages.json'.
- `%load_message [ruta]`: Carga mensajes desde una ruta JSON especificada. Si no se proporciona una ruta, por defecto es 'messages.json'.
- `%tokens [prompt]`: EXPERIMENTAL: Calcula los tokens utilizados por la próxima solicitud basada en los mensajes de la conversación actual y estima el costo de esa solicitud; opcionalmente proporciona un prompt para calcular también los tokens utilizados por ese prompt y la cantidad total de tokens que se enviarán con la próxima solicitud.
- `%info`: Muestra información del sistema y del intérprete.
- `%help`: Muestra este mensaje de ayuda.
- `%jupyter`: Exporta la sesión actual a un archivo de Jupyter notebook (.ipynb) a la carpeta de Descargas.
- `%markdown [ruta]`: Exporta la conversación a una ruta Markdown especificada. Si no se proporciona una ruta, se guardará en la carpeta de Descargas con un nombre de conversación generado.

## Configuración Actual
- Modelo: gpt-4.1-nano
- Auto-ejecución: Activada (-y)
- Modo verbose: Activado (-v)

## Comandos Útiles
- `oi`: Inicia Open Interpreter con la configuración predeterminada (alias configurado)
- `interpreter --model [modelo]`: Cambia el modelo de lenguaje
- `interpreter --help`: Muestra todas las opciones disponibles
