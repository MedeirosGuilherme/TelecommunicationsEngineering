import sys
from Subcamada import Subcamada
from Quadro import Quadro
import logging  # https://realpython.com/python-logging/


class Aplicacao(Subcamada):

    # Construtor da classe aplicação, inicia subcamada, timeout e logging
    def __init__(self):
        # iniciando a subcamada, passando como source a entrada do teclado 
        Subcamada.__init__(self, sys.stdin, 3)
        # Desativando o timeout, já que ele não existe nessa camada
        self.disable_timeout()
        logging.basicConfig(level=logging.DEBUG)  # DEBUG, INFO, WARNING, ERROR, CRITICAL

    # Método recebe da camada aplicação, sem retorno, recebe a parte dos dados do quadro da camada de sessão e imprime na tela, decodificando em ascii
    def recebe(self, quadro):
        logging.debug('App.recebe(): Chegou aqui')
        print('> ' + quadro.dados.decode('ascii'))

    # Handle do poller da camada de aplicação, sem retorno
    def handle(self):
        msg = sys.stdin.readline()[:-1]
        dados = msg.encode('ascii')                     # Codificando uma mensagem para passar para a camada de biaxo.

        # Verificação se a mensagem é um comando de desconexão através da flag #
        if msg.startswith('#'):
            logging.debug('App.handle(): #Comando')
            if msg == "#Conecta":                       # Chama o método connect da camada de sessão se a mensagem passada é #Conecta
                self.lower.connect()
            elif msg == "#Desconecta":                  # Chama o método disconnect da camada de sessão se a mensagem passada é #Desconecta
                self.lower.disconnect()
        else:                                           # Caso não seja uma mensagem de conexão:
            while len(dados) > 0:   
                quadro = Quadro()                           # Monta o quadro com um objeto quadro
                quadro.dados = dados[0:1024]
                self.lower.envia(quadro)                    # Envia os dados no quadro montado para a camada de sessão enviar para as camadas seguintes.
                dados = dados[1024:]
