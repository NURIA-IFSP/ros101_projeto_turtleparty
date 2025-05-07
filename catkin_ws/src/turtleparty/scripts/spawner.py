#/bin/python

### Requisitos:
#  - O script spawner.py deve:

#     - A cada 10 segundos, criar uma nova tartaruga na arena (usando o serviço /spawn);

#     - Atribuir nomes únicos (turtle2, turtle3, etc.), até o máximo de 6 tartarugas no total (1 guia + 5 seguidoras);

#     - Fazer com que cada nova tartaruga siga a tartaruga guia usando controle proporcional sobre a diferença de posição (exemplo: cmd_vel proporcional à distância para turtle1).