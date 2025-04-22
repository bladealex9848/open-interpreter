#!/usr/bin/expect -f
# Script para ejecutar Open Interpreter y manejar automáticamente la pregunta de feedback

# Obtener el comando de los argumentos
set command [lindex $argv 0]

# Configurar timeout
set timeout -1

# Iniciar Open Interpreter
spawn interpreter --model gpt-4.1-nano -y -v

# Si hay un comando, enviarlo
if {$command ne ""} {
    # Esperar al prompt
    expect ">"

    # Enviar el comando
    send "$command\r"
}

# Esperar a que aparezca la pregunta de feedback y responder automáticamente
expect {
    "Was Open Interpreter helpful? (y/n):" {
        send "y\r"
        exp_continue
    }
    eof
}

# Salir con el código de salida del proceso
exit
