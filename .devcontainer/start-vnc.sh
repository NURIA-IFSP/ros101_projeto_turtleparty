#!/bin/bash

# Configurações de ambiente
export USER=${USER:-ubuntu}
export HOME=/home/$USER
export DISPLAY=:1

# Mata instâncias antigas
vncserver -kill $DISPLAY &> /dev/null || true

# Limpa locks e arquivos antigos
rm -rf /tmp/.X*-lock /tmp/.X11-unix/X* $HOME/.vnc/*

# Cria um xstartup básico se não existir
if [ ! -f "$HOME/.vnc/xstartup" ]; then
    mkdir -p "$HOME/.vnc"
    cat <<EOF > "$HOME/.vnc/xstartup"
#!/bin/sh
exec startxfce4 &
sleep 5 &
bash /template-atividade-ros/ros_ambiente.sh
EOF
    chmod +x "$HOME/.vnc/xstartup"
fi

# Cria um ícone no desktop para o script ros_ambiente.sh
DESKTOP_FILE="$HOME/Desktop/ros_ambiente.desktop"
mkdir -p "$HOME/Desktop"
cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Type=Application
Name=ROS Ambiente
Comment=Inicia o ambiente ROS
Exec=/template-atividade-ros/ros_ambiente.sh
Icon=utilities-terminal
Terminal=true
EOF
chmod +x "$DESKTOP_FILE"

# Inicia o servidor VNC com TurboVNC sem senha
vncserver $DISPLAY -geometry 1920x900 -depth 24 -randr 1920x900 -securitytypes None

# Aguarda o ambiente gráfico inicializar
sleep 3

# Detecta a resolução automaticamente e ajusta
RESOLUTION=$(xdpyinfo | awk '/dimensions:/ {print $2}')
if [ -n "$RESOLUTION" ]; then
    xrandr --fb $RESOLUTION || echo "[Aviso] Não foi possível ajustar a resolução para $RESOLUTION"
else
    echo "[Aviso] Não foi possível detectar a resolução automaticamente."
fi

# Garante que a porta 6080 esteja livre
sudo fuser -k 6080/tcp || true

# Inicia o noVNC na porta 6080 apontando para o VNC (5901)
websockify --web=/usr/share/novnc --wrap-mode=ignore 6080 localhost:5901 &

# Mantém o container rodando
tail -f /dev/null
