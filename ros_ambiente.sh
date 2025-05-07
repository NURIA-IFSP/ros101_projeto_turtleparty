#!/bin/bash

# Configurações de ambiente
export DISPLAY=$(echo $DISPLAY)
export HOME=/home/${USER:-ubuntu}

# Abre o VSCode no workspace 1 em tela cheia e sem a tela inicial
wmctrl -s 0
code --no-sandbox --disable-extensions --fullscreen --skip-welcome --disable-telemetry /template-atividade-ros &

# Aguarda o VSCode iniciar
sleep 2

# Abre o XFCE Terminal com duas abas no workspace 2
wmctrl -s 1
xfce4-terminal \
  --tab --title="Aba 1" --command="bash -c 'echo \"Bem-vindo à Aba 1\"; exec bash'" \
  --tab --title="Aba 2" --command="bash -c 'echo \"Bem-vindo à Aba 2\"; exec bash'" &