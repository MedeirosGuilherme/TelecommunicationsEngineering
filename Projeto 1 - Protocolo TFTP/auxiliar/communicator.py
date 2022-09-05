import poller
import sys, time
import socket

"""
Callback com o objetivo de monitorar o teclado e enviar esses dados por sockets.
Se nada for digitado, será impresso na tela uma mensagem de timeout.
"""


class CallbackSend(poller.Callback):

    def __init__(self, tout, ip_sock, port_sock, s):
        self.ip = ip_sock
        self.port = port_sock
        self.sock = s
        self.disable_timeout()
        poller.Callback.__init__(self, sys.stdin, tout)

    def handle(self):
        l = sys.stdin.readline()
        self.send(l)

    def handle_timeout(self):
        print('Nothing to send yet')

    def send(self, dado):
        self.sock.sendto(dado, (self.ip, self.port))
        self.enable_timeout()
        self.reload_timeout()

""""
Callback com o objetivo de monitorar o recebimento de dados por socket.
Se algo chegar, será impresso na tela.
Se nada chegar, será impresso na tela uma mensagem de timeout.
"""


class CallbackReceive(poller.Callback):

    def __init__(self, tout, s):
        self.sock = s
        poller.Callback.__init__(self, self.sock, tout)
        self.buffer = ''

    def handle(self):
        data, addr = self.sock.recvfrom(1024)
        print('addr: ' + str(addr))
        self.disable_timeout()
        self.disable()
        return data

    def handle_timeout(self):
        self.disable_timeout()
        self.disable()
        return -1


timeout = 2
portIn = 5555
ipIn = "127.0.0.1"
portOut = 5555
ipOut = "127.0.0.1"
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((ipIn, portIn))

rx = CallbackReceive(timeout, sock)
# tx = CallbackSend(timeout, ipOut, portOut, sock)

sched = poller.Poller()
sched.adiciona(rx)
# sched.adiciona(tx)

aux = sched.despache()

print(aux)
