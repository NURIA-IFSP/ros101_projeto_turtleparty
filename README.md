# 🐢 Projeto ROS1: Turtle Party

## Objetivo:

Criar um projeto no ROS1 que simule uma "festa de tartarugas" utilizando o pacote turtlesim. O projeto deve incluir uma tartaruga guia que se movimenta de forma aleatória pela arena, enquanto novas tartarugas são adicionadas gradualmente e tentam alcançá-la, utilizando controle proporcional. O jogo termina se alguma tartaruga "convidada" alcançar a tartaruga guia.

## Estrutura do Projeto:

Crie um pacote chamado turtleparty com a seguinte estrutura mínima:

```
turtleparty/
├── launch/
│   └── party.launch
├── scripts/
│   ├── guide_controller.py
│   └── spawner.py
├── CMakeLists.txt
└── package.xml
```

## Requisitos:

1. Lançamento da Arena e da Tartaruga Guia

- Crie um arquivo party.launch que:

- Inicie o turtlesim_node;

- Inicialize a tartaruga guia (por padrão, turtle1);

- Execute o script guide_controller.py.

2. Movimento Aleatório da Tartaruga Guia

- O script guide_controller.py deve:

- Fazer a turtle1 se mover de forma aleatória pela tela.

- Remover o rastro da tartaruga guia, desabilitando o traço via serviço /turtle1/set_pen.

3. Inclusão de Novas Tartarugas

- O script spawner.py deve:

- A cada 10 segundos, criar uma nova tartaruga na arena (usando o serviço /spawn);

- Atribuir nomes únicos (turtle2, turtle3, etc.), até o máximo de 6 tartarugas no total (1 guia + 5 seguidoras);

- Fazer com que cada nova tartaruga siga a tartaruga guia usando controle proporcional sobre a diferença de posição (exemplo: cmd_vel proporcional à distância para turtle1).

4. Encerramento do Jogo

- O jogo termina automaticamente se qualquer tartaruga seguidora ficar a uma distância menor que 0.5 unidades da tartaruga guia.

- Nesse caso, exiba uma mensagem no terminal como:

<p align="center"><strong>🎉 A festa acabou! A tartaruga X alcançou a tartaruga guia.</strong></p>

- Todos os nós devem ser finalizados (ou o programa encerrado com rospy.signal_shutdown).

## Sugestões Técnicas:

- Utilize rospy e as mensagens Pose, Twist, além dos serviços spawn, kill, set_pen.

- Use rospy.Timer ou rospy.sleep para controle do tempo de spawn.

- Para obter a posição de outras tartarugas, use turtlesim/Pose via tópico /turtleX/pose.

