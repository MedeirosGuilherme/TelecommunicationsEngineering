from enum import Enum
from operator import truediv
from pickle import TRUE
from Subcamada import Subcamada
from Quadro import Quadro
import logging  # https://realpython.com/python-logging/


# Classe State de Enum, que estabelece os estados da máquina de estados.
class State(Enum):
    idle = 0
    wait = 1

# Classe Tipo de Enum, que representa os tipos que os dados podem ser (data, ack)
class Tipo(Enum):
    data = 0
    ack = 1
    data0 = 2
    data1 = 3
    ack0 = 4
    ack1 = 5

# Classe Trace de Enum, estabelece as subcamadas de cima e de baixo.
class Trace(Enum):
    upper = 0
    lower = 1


class Arq(Subcamada):
    
    # Construtor da camada ARQ, estabelece ambos os números de sequência n e m como zero e o estado da MEF como idle
    def __init__(self, tout):
        Subcamada.__init__(self, None, tout)
        self.n = 0
        self.m = 0
        self.dealers = {
            State.idle: self.idle,
            State.wait: self.wait
        }
        self.state = State.idle
        logging.basicConfig(level=logging.DEBUG)  # DEBUG, INFO, WARNING, ERROR, CRITICAL

    # Não há implementação do handle para a camada ARQ
    def handle(self):
        pass

    # Implementação do handle timeout para a camada ARQ, sem retorno.
    def handle_timeout(self):
        if self.state == State.wait:                            # Caso o timeout tenha acontecido no estado Wait, gera um quadro de dados para reenvio pela camada de baixo (enquadramento).
            quadro = Quadro()
            quadro.generate_controle_byte(Tipo.data, self.n)
            self.lower.envia(quadro)

    # Implementação do handle_mef pela camada ARQ, sem retorno
    def handle_mef(self, quadro, trace):
        current_dealer = self.dealers[self.state]
        return current_dealer(quadro, trace)

    # Abaixo a implementação de cada um dos estados da máquina de estado.
    # Estado idle, sem retorno
    def idle(self, quadro, trace):
        logging.debug("Arq.idle: Recebeu trace: " + str(trace))
        if trace == Trace.upper:                                    # Se o trace vem da camada de cima (Sessão), significa que há algo para transmitir:
            logging.debug('Arq.idle: Quadro veio da app')
            self.state = State.wait                                  # Muda o estado para Wait
            logging.debug('Arq.idle: Gerado byte controle do tipo: ' + str(0) + ' self.n: ' + str(self.n))
            controle = quadro.generate_controle_byte(0, self.n)      # Gera um byte de controle do tipo dados
            logging.debug('Arq.idle: Byte de controle: ')
            logging.debug(controle)
            self.lower.envia(quadro)                                # Envia para a camada de baixo transmitir
            
        else:                                                       # Se o trace vem da camada de baixo, significa que um dado foi recebido:
            logging.debug('Arq.idle: Quadro veio do Enq')
            if quadro.is_data_m(self.m):                             # Se o número de sequência estiver correto e o quadro for um data 
                logging.debug('Arq.idle: é um quadro data_m')
                ack = Quadro()
                ack.generate_ack(self.m)                            # Gera um quadro ack
                self.lower.envia(ack)                               # envia o quadro ack gerado para a camada de baixo transmitir
                self.upper.recebe(quadro)                           # envia o que foi recebido para a camada de cima (Sessão)
                self.change_m()                                     # troca o número de sequência
                
            elif quadro.is_data_m(self.retorna_not_m()):             # Se o número de sequência for o contrário do atual:
                logging.debug('Arq.idle: não é um quadro data_m')
                ack = Quadro()
                ack.generate_ack(self.retorna_not_m())  # Gera um quadro ack com o número de sequência trocado
                self.lower.envia(ack)                   # envia o quadro ack gerado para a camada de baixo transmitir

    # Estado wait, sem retorno
    def wait(self, quadro, trace):
        if trace == Trace.lower:            # Se o trace vem da camada de cima:
            logging.debug('Arq.wait: Recebeu trace: Trace.lower')
            if quadro.is_ack_n(self.n):     # Se o quadro é um ack:
                logging.debug('Arq.wait: O quadro é um ack_n')
                self.state = State.idle     # modifica o estado para idle
                self.change_n()             # troca o número de sequência
                
            elif quadro.is_data_m(self.m):  # Se o quadro for um data com número de sequência correto:
                logging.debug('Arq.wait: O quadro é um data_m')
                ack = Quadro()
                ack.generate_ack(self.m)    # Gera um quadro ack
                self.lower.envia(ack)       # envia para a camada de baixo transmitir
                self.upper.recebe(quadro)   # envia o dado recebido para a camada de cima
                self.change_m()             # faz a troca do número de sequência
                
            elif quadro.is_data_m(self.retorna_not_m()):    # Se o quadro for um data com o número de sequência trocado:
                logging.debug('Arq.wait: O quadro é um not data_m')
                ack = Quadro()
                ack.generate_ack(self.retorna_not_m())      # gera um quadro ack com o número de sequência trocado
                self.lower.envia(ack)                       # envia para a camada de baixo transmitir

    # Método envia que recebe um quadro da camada de Sessão para envio, sem retorno
    def envia(self, quadro):
        logging.debug("Arq.envia: Recebeu quadro da App")
        self.handle_mef(quadro, Trace.upper)    # aciona o handle_mef, avisando que a camada que chamou foi a de cima (Sessão)

    # Método recebe, que recebe um quadro da camada de Enquadramento para transmissão para cima, sem retorno
    def recebe(self, quadro):
        logging.debug("Arq.recebe: Recebeu quadro do Enq")
        logging.debug('Stado atual:' + str(self.state))
        self.handle_mef(quadro, Trace.lower)    # aciona o handle_mef, avisando que a camada que chamou foi a de baixo (Enquadramento)

    # Faz a conexão das camadas
    def conecta(self, uplayer):
        self.upper = uplayer
        self.upper.lower = self

    # Abaixo alguns métodos auxiliares:
    # Change n simplesmente modifica o número de sequência n, sem retorno
    def change_n(self):
        if self.n == 0:
            self.n = 1
        else:
            self.n = 0

    # Change m simplesmente modifica o número de sequência m, sem retorno
    def change_m(self):
        if self.m == 0:
            self.m = 1
        else:
            self.m = 0

    # retorna not_m, retorna (1 ou 0) contrário ao atual número de sequẽncia m
    def retorna_not_m(self):
        if self.m == 0:
            return 1
        else:
            return 0

    # reset arq é utilizado por outras camadas para zerar o número de sequência caso algum problema aconteça. Ele retorna o estado da mef para idle e zera os dois números de sequência.
    def reset_arq(self):
        self.n = 0
        self.m = 0
        self.state = State.idle

'''
________________________________________________________
|____1_____|____ 1_____|____1_____|_______<= 1024_______|
| Controle | Reservado | ID Proto |         Dados       |
                                                       
                                                       
Controle:   |bit7: 0=Data; 1=ack
            |bit3: Sequência (numeração do bloco)
'''
