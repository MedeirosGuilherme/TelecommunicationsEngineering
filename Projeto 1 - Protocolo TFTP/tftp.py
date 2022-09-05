from client_tftp import client_tftp
import sys
import poller

# Arquivo principal para a execução do projeto. 

# tftp é um objeto da classe client_tftp, que implementa o funcionamento do protocolo.
# Recebe como argumento de entrada, nessa ordem:
    # Endereço de destino.
    # Flag put ou get para transmitir ou receber um arquivo, respectivamente.
    # Arquivo de destino
    # Seu endereço IP para a execução do bind do socket
    # Sua porta para a execução do bind do do socket
# Essas entradas são utilizadas pelo o construtor da classe client_tftp
    
tftp = client_tftp(sys.argv[1], sys.argv[3], sys.argv[4], sys.argv[5])  # Cria callback

# Cria poller
sched = poller.Poller()

# Adiciona o callback do TFTP no Poller
sched.adiciona(tftp)  

# Condicionais para receber ou enviar um arquivo por TFTP
if sys.argv[2] == "put":
    tftp.upload()  # envia request wrq na porta 69
elif sys.argv[2] == "get":
    tftp.download()  # envia request rrq na porta 69

# Despacha o poller e monitora qualquer entrada no IP e porta definida pelo socket, passada pelos argumentos de entrada
sched.despache()  


