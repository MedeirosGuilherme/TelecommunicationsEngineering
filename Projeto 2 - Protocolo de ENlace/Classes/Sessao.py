from Subcamada import Subcamada
from enum import Enum
from Quadro import Quadro
import ByteUtils
import logging  # https://realpython.com/python-logging/


# classe State de Enum, define os estados da máquina de estado
class State(Enum):
    disconnected = 0
    wait = 1
    connected = 2
    half1 = 3
    half2 = 4

# classe Trace de Enum, define as camadas que podem interagir com a camada de Sessão.
class Trace(Enum):
    upper = 0
    lower = 1
    this = 2


class Sessao(Subcamada):
    
    # Construtor da classe:
        # Define estados da máquina de estado,
        # Define o estado inicial como disconnected
    def __init__(self, tout):
        Subcamada.__init__(self, None, tout)
        self.dealers = {
            State.disconnected: self.disconnected,
            State.wait: self.wait,
            State.connected: self.connected,
            State.half1: self.half1,
            State.half2: self.half2
        }
        self.state = State.disconnected
        logging.basicConfig(level=logging.DEBUG)  # DEBUG, INFO, WARNING, ERROR, CRITICAL

    # Método recebe da subcamada, implementado pela Sessão, recebendo da camada de baixo (ARQ) para levar pra cima (Aplicação), sem retorno
    # Chama o handle mef para começar a máquina de estado passando como parâmetro o trace, sinalizando que quem fez o chamado foi a camada de baixo.
    def recebe(self, quadro):
        logging.debug('Ses.recebe(): chegou: ' + quadro.dados.decode('ascii'))
        self.handle_mef(quadro, Trace.lower)

    # Método envia da subcamada, implementado pela Sessão, recebendo da camada de cima (Aplicação) para levar pra baixo (ARQ), sem retorno
    # Chama o handle mef para começar a máquina de estado passando como parâmetro o trace, sinalizando que quem fez o chamado foi a camada de cima.
    def envia(self, quadro):
        logging.debug('Ses.envia(): chegou: ' + quadro.dados.decode('ascii'))
        self.handle_mef(quadro, Trace.upper)

    # Inicia e gerencia a máquina de estado
    def handle_mef(self, quadro, trace):
        current_dealer = self.dealers[self.state]
        return current_dealer(quadro, trace)

    # Abaixo, métodos de cada estado da MEF, ambos sem retorno
    # Estado disconnected, define uma sessão ainda sem conexão, sem retorno
        # Recebe:
            # quadro
            # trace, sinalizando a camada que invocou
    def disconnected(self, quadro, trace):
        logging.debug('Ses.disconnected(): Chegou aqui')
        if trace == Trace.lower:                                # Verifica se o chamado veio da camada de baixo (ARQ)
            logging.debug('Ses.disconnected(): Trace.lower')
            if quadro.is_cr():                                  # Verifica se o quadro é um CR (connection request)
                logging.debug('Ses.disconnected(): Quadro é CR')
                self.state = State.connected                    # muda o estado para connected
                cc = Quadro()                                   # cria um quadro CC para ser transmitido para quem chamou a conexão
                cc.generate_cc()
                logging.debug('Ses.disconnected(): ' + str(cc.controle))
                self.lower.envia(cc)                            # envia o quadro CC criado para a camada de baixo transmitir para a outra ponta.
                logging.info('------------------------------')
                logging.info('|     Conectado passivo      |')
                logging.info('------------------------------')

    # Estado wait, sem retorno
        # Recebe:
            # quadro
            # trace, sinalizando a camada que invocou
    def wait(self, quadro, trace):
        logging.debug('Ses.wait(): Chegou aqui')
        if trace == Trace.lower:                                # Verifica se o chamado veio da camada de baixo (ARQ)
            logging.debug('Ses.wait(): Trace.lower')
            logging.debug('Ses.wait(): ' + str(quadro.is_cc()))
            if quadro.is_cc():                                  # Verifica se o quadro é um CC (connection confirmed)
                logging.debug('Ses.wait(): Quadro é CC')
                self.state = State.connected                    # Caso seja um CC, muda o estado para connected, e agora permanece conectado
                logging.info('------------------------------')
                logging.info('|      Conectado ativo       |')
                logging.info('------------------------------')

    # Estado connected, sem retorno
        # Recebe:
            # quadro
            # trace, sinalizando a camada que invocou
    def connected(self, quadro, trace):
        logging.debug('Ses.connected():')
        if trace == Trace.lower:                                # Verifica se o chamado veio da camada de baixo (ARQ)
            logging.debug('Ses.connected(): Trace.lower')
            if quadro.is_data():                                # verifica, no quadro, se é um quadro de dados
                logging.debug('Ses.connected(): o quadro é data. Enviado para app')
                self.upper.recebe(quadro)                       # Envia o quadro para ser tratado pela camada de cima (APP)
            elif quadro.is_dr():                                # Verifica se o quadro é um dr (disconnection request)
                logging.debug('Ses.connected(): o quadro é DR. Devolve um DR')
                dr = Quadro()
                dr.generate_dr()                                # gera um outro dr para ser enviado para a outra ponta
                self.state = State.half1                        # muda o estado para half1 (processo de desconexão)
                self.lower.envia(dr)                            # envia o dr para ser transmitido pela camada de baixo (ARQ)
        elif trace == Trace.upper:                              # verifica se o chamado veio da camada de cima (APP)                       
            logging.debug('Ses.connected(): Trace.upper')
            quadro.controle = ByteUtils.clear_bit(quadro.controle, 2)   # limpa o bit 2 do byte de controle do quadro, sinalizando que é um quadro de dados
            self.lower.envia(quadro)                                    # envia para ser transmitido pela camada de baixo

    # Estado half1 (parte da desconexão)
        # Recebe:
            # quadro
            # trace, sinalizando a camada que invocou

    def half1(self, quadro, trace):
        logging.debug('Ses.half1(): Chegou aqui')
        if trace == Trace.lower:                                # Verifica se o chamado veio da camada de baixo (ARQ)
            if quadro.is_dr():                                  # Verifica se o quadro é um disconnection request (dr), caso seja:
                logging.debug('Ses.half1(): O quadro é DR, reenvia outro DR')
                dr = Quadro()
                dr.generate_dr()                                # Gera um quadro dr
                self.lower.envia(dr)                            # envia para a camada de baixo transmitir (ARQ)
            elif quadro.is_dc():                                # Caso o quadro seja um dc (disconnection confirmed):
                logging.debug('Ses.half1(): O quadro é DC, desconecta')
                logging.info('------------------------------')
                logging.info('|     Desconectado passivo   |')
                logging.info('------------------------------')
                self.state = State.disconnected                 # Modifica o estado para disconnected

    # Estado half2 (parte da desconexão)
        # Recebe:
            # quadro
            # trace, sinalizando a camada que invocou
    def half2(self, quadro, trace):
        logging.debug('Ses.half2(): Chegou aqui')
        if trace == Trace.lower:                                # Verifica se o chamado veio da camada de baixo (ARQ)
            if quadro.is_data():                                # Verifica, no quadro, se é um quadro de dados
                logging.warning('Ses.half2(): O quadro é data') 
                self.upper.recebe(quadro)                       # envia para a camada de cima (APP) para ser tratados
            elif quadro.is_dr():                                # Caso o quadro seja um dr (disconnection request):
                logging.debug('Ses.half2(): O quadro é DR. Devolve um DC')
                dc = Quadro()
                dc.generate_dc()                                # Gera um quadro dc (disconnection confirmed)
                self.lower.envia(dc)                            # envia para a camada de baixo transmitir para a outra ponta
                logging.info('------------------------------')
                logging.info('|     Desconectado Ativo     |')
                logging.info('------------------------------')
                self.state = State.disconnected                 # muda o estado da MEF para disconnected

    # Esta subcamada não implementa o handle
    def handle(self):
        pass

    # Método handle timeout
    def handle_timeout(self):
        # Ações dependem do estado em que a MEF está, considerando:
        if self.state == State.wait:            # Caso esteja no estado de wait
            self.state = State.disconnected         # Muda o estado para disconnected
            self.lower.reset_arq()                  # reseta o ARQ (zerando números de sequência e fazendo o estado do ARQ ir para idle)
        elif self.state == State.half1:         # Caso esteja no estado half1 (parte da desconexão)
            self.state = State.disconnected         # Muda o estado para disconnected
            self.lower.reset_arq()                  # reseta o ARQ (zerando números de sequência e fazendo o estado do ARQ ir para idle)
        elif self.state == State.half2:         # Caso esteja no estado half2 (parte da desconexão)
            self.state = State.disconnected         # Muda o estado para disconnected
            self.lower.reset_arq()                  # reseta o ARQ (zerando números de sequência e fazendo o estado do ARQ ir para idle)

    # Método que estabelece a conexão com a outra ponta, é chamado pela camada de aplicação caso seja digitado um #Conecta como mensagem 
    def connect(self):
        logging.debug('Ses.connect(): chegou aqui')
        if self.state == State.disconnected:                                # Verifica de antemão se o estado da MEF é disconnected
            logging.debug('Ses.connect(): verificou estado, going to Wait')
            quadro = Quadro()
            quadro.generate_cr()                                            # Gera um quadro CR (connection request) para ser transmitido para a outra ponta
            self.state = State.wait                                         # muda o estado da MEF para wait
            self.lower.envia(quadro)                                        # envia o CR para a camada de baixo (ARQ) para ser transmitido

    # Método que faz a desconexão com a outra ponta, é chamado pela camada de aplicação caso seja digitado um #Desconecta como mensagem
    def disconnect(self):
        logging.debug('Ses.disconnect(): chegou aqui')
        if self.state == State.connected:                                   # Verifica de antemão se o estado da MEF é connected
            logging.debug('Ses.disconect(): Going to half2')
            quadro = Quadro()
            quadro.generate_dr()                                            # Gera um quadro DR (disconnection request) para ser transmitido para a outra ponta
            self.state = State.half2                                        # muda o estado da MEF para half2 (parte da desconexão)
            self.lower.envia(quadro)                                        # envia o DR para a camada de baixo (ARQ) para ser transmitido para outra ponta
