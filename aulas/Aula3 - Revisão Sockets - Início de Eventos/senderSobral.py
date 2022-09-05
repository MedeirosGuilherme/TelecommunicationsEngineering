import sys
from socket import *
import argparse

parser = argparse.ArgumentParser(description='Comunicador UDP')
parser.add_argument(help='IP', type=str, dest='ip')
parser.add_argument(help='PORT', type=int, dest='port')

args = parser.parse_args()

cliente = socket(AF_INET, SOCK_DGRAM, 17)
cliente.bind(('0.0.0.0', 6666))

while True:
    try:
        algo = sys.stdin.readline()
    except KeyboardInterrupt:
        break

    try:
        cliente.sendto(algo.encode(), (args.ip, args.port))
    except Exception as e:
        print('Erro ao enviar: ', e)

    try:
        dados,addr = cliente.recvfrom(1024)
        print("Recebido: %s vindos de: %s" % (dados.decode(), addr))
    except Exception as e:
        print('Erro ao receber: ', e)
