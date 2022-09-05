from socket import *
import sys

# obtém IP e port para enviar datagramas
# Serão usados por argumento de linha de comando

# Cria socket UDP
# Vincula IP e port ao socket com o bind

# ... Lê do teclado e envia
# ... se receber algo do socket, apresentar em tela

import socket

UDP_IP = sys.argv[1]
UDP_PORT = int(sys.argv[2])
MESSAGE = bytes(sys.argv[3], "utf-8")
 
print("UDP target IP: %s" % UDP_IP)
print("UDP target port: %s" % UDP_PORT)
print("MensagemTeste: %s" % MESSAGE)
 
sock = socket.socket(socket.AF_INET, # Internet
                      socket.SOCK_DGRAM) # UDP
sock.sendto(MESSAGE, (UDP_IP, UDP_PORT))
