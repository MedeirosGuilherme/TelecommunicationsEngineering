from cmath import log
from multiprocessing.connection import wait
import poller
from enum import Enum
from Subcamada import Subcamada
from serial import Serial
import crc
from Quadro import Quadro
import logging  # https://realpython.com/python-logging/


# Definição dos estados da MEF em uma classe State
class State(Enum):
    idle = 0
    wait = 1
    rx = 2
    esc = 3


# Definição das flags recebíveis nos blocos
class Flag:
    ESC = b'\x7d'  # 7D
    FLAG = b'\x7e'  # 7E
    ESCXOR20 = b'\x5d'  # 7D XOR 20
    FLAGXOR20 = b'\x5e'  # 7E XOR 20


class Enquadramento(Subcamada):

    # Construtor da classe enquadramento
        # Recebe:
            # porta serial
            # timeout
        # Retorna:
            # sem retorno
    def __init__(self, serial_port, tout):
        self.serial_port = serial_port
        self.tout = tout
        self.buffer = bytearray()   # Inicia o buffer
        self.state = State.idle     # Inicia a máquina de estados no idle
        Subcamada.__init__(self, self.serial_port, self.tout)
        self.dealers = {
            State.idle: self.idle,
            State.wait: self.wait,
            State.rx: self.rx,
            State.esc: self.esc
        }
        logging.basicConfig(level=logging.DEBUG)  # DEBUG, INFO, WARNING, ERROR, CRITICAL

    # Implementação do handle pela camada de enquadramento, sem retorno, faz a leitura da porta serial e manda dá o controle do programa para a MEF
    def handle(self):
        b = self.serial_port.read(1)
        #logging.debug('Recebeu: ', b.decode('ascii'))
        self.handle_mef(b)

    # Implementação do handle timeout da camada de Enquadramento, limpa o buffer e volta a máquina de estados para o idle
    def handle_timeout(self):
        self.buffer.clear()
        self.state = State.idle

    # Implementação da handle mef da camada de Enquadramento
    def handle_mef(self, b):
        current_dealer = self.dealers[self.state]
        return current_dealer(b)

    # Implementando os métodos da Subcamada
    # Implementação do método envia da Subcamada pela camada de Enquadramento, responsável por entregar os dados já enquadrados para a transmissão
    def envia(self, quadro):
        msg = quadro.serialize()            # Serializa os dados
        fcs = crc.CRC16(msg)                # Faz o uso do CRC16 para adicionar o controle de erros ao quadro
        msg_crc = fcs.gen_crc()
        quadro = self.enquadra(msg_crc)
        self.serial_port.write(quadro)      # Escreve na porta serial e transmite o dado

    # Implementação do método recebe da Subcamada pela camada de Enquadramento, que, como é uma camada de extreminadade de envio, não o implementa
    def recebe(self, quadro):
        pass

    # Conexão das subcamadas
    def conecta(self, uplayer):
        self.upper = uplayer
        self.upper.lower = self

    # Definindo os estados da MEF:
    # Estado idle, sem retorno
    def idle(self, b):
        # Limpa o buffer
        # MEF: Inicia-se:
        # Vai para o estado WAIT caso receba uma FLAG 7E

        self.buffer.clear()

        if b == Flag.FLAG:
            self.state = State.wait

    # Estado wait, sem retorno
    def wait(self, b):
        # MEF:
        # Vai para o estado IDLE caso receba uma FLAG 7E
        # Vai para o estado ESC caso receba um ESC 7D
        # Trata e vai para o estado RX caso receba um byte comum

        if b == Flag.FLAG:
            self.state = State.idle

        elif b == Flag.ESC:
            self.state = State.esc

        else:
            self.buffer += b
            self.state = State.rx

    # Estado rx, sem retorno
    def rx(self, b):
        # MEF:
        # Trata e continua em RX se receber byte comum
        # Vai para ESC se receber ESC 7D
        # Vai para idle se receber FLAG 7E
        if b == Flag.FLAG:
            self.state = State.idle
            if self.crc_check():
                quadro = Quadro.create_from_bytes(self.buffer)
                logging.debug(self.buffer)
                self.upper.recebe(quadro)
            elif log:
                print("Erro de CRC")

        elif b == Flag.ESC:
            self.state = State.esc

        else:
            self.buffer += b

    # Estado esc, sem retorno
    def esc(self, b):
        # MEF:
        # Trata e vai para o estado RX caso receba um byte comum
        # Vai para o estado idle caso receba um ESC 7D ou uma FLAG 7E, loga o erro.

        if b == Flag.FLAG or b == Flag.ESC:
            self.state = State.idle

        # Trata o byte recebido desfazendo o XOR 
        else:
            if b == Flag.FLAGXOR20:
                self.buffer += Flag.FLAG
            elif b == Flag.ESCXOR20:
                self.buffer += Flag.ESC

    # Método enquadra, responsável por realmente enquadrar os dados recebidos da camada ARQ para serem transmitidos. Retorna o frame de dados com as flags de começo e fim de quadro.
    def enquadra(self, msg):
        # Função de enquadramento:
        # Monta o bloco de acordo com cada byte recebido.

        frame = bytearray()
        for i in msg:
            if i in (126, 125):
                frame.append(125)
                frame.append(i ^ 32)
            else:
                frame.append(i)
        return b'~' + frame + b'~'

    # Método de checagem CRC, retorna verdadeiro ou falso considerando a verificação da autenticidade do frame
    def crc_check(self):
        fcs = crc.CRC16(self.buffer)
        return fcs.check_crc()
