from enum import Enum
import poller
import socket
import math

# Define os estados da MEF usando a classe Enum, obedecendo o padrão da máquina de estado definida em sala.
class State(Enum):
    idle = 0
    tx0 = 1
    tx1 = 2
    tx2 = 3
    rx0 = 4
    rx1 = 5
    rx2 = 6

# Classe principal do cliente TFTP, implementa os métodos do Poller, a máquina de estado, 
class client_tftp(poller.Callback):
    
    # Construtor da classe que recebe como argumentos o ip de destino, o arquivo à ser transferido, o endereço ip local e a porta para ser usado no bindo pelo socke
    def __init__(self, server_ip, filename, client_ip, client_port):
        
        # Define variáveis para os argumetnos do construtor e dá bind no socket
        self.server_ip = server_ip
        self.port_out = -1  # o handle descobre a porta do server. Não preciso passar aqui
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)  
        self.sock.bind((client_ip, int(client_port)))
        self.timeout = 1 # Define o timeout
        
        # Define o poller passando como source o socket definido acima e o timeout
        poller.Callback.__init__(self, self.sock, self.timeout)
        
        # Define o estado inicial como idle e os dealers para serem usados depois pela MEF
        self.state = State.idle
        self.dealers = {
            State.tx0: self.tx0,
            State.tx1: self.tx1,
            State.tx2: self.tx2,
            State.rx0: self.rx0,
            State.rx1: self.rx1,
            State.rx2: self.rx2
        }  
        self.n = 0                      # Variáveis que serão utilizadas para o controle dos estados, self.n descreve o bloco atual 
        self.max_n = 0                  # max_n descreve a quantidade máxima de blocos
        self.filename = filename        # arquivo que será usado para a transmissão
        self.file_data = bytearray()    # bytearray que será usado para criar o frame
        self.timeout_counter = 0        # contador de timeout
        self.timeout_limit = 3          # máximo de timeouts permitidos

    # Implementação dos métodos do poller
    def handle(self):
        self.timeout_counter = 0                # reseta o timeout
        data, addr = self.sock.recvfrom(1024)   # adiciona o que chegou no socket
        self.port_out = addr[1]                 # handle descobre a porta do servidor, vindo do recvfrom
        self.dealer_selector(data)              # 

    # implementa o timeout que vem do Poller
    def handle_timeout(self):
        
        # Este conjunto de condicionais modifica o funcionamento do timeout de acordo com o estado que o sistema se encontra na MEF,
            # Em todos os casos, as variáveis auxiliares são zeradas no timeout e chama o método timeout_manager
        
        # caso a MEF esteja nos estado tx0 ou rx0, o estado volta para o idle 
        if (self.state == State.tx0) | (self.state == State.rx0):
            self.state = State.idle
            self.n = 0
            self.max_n = 0
            print('Timeout tx0 ou rx0')
            self.timeout_manager()
        
        # caso a MEF esteja no estado tx1, o estado não muda com o timeout
        elif self.state == State.tx1:
            self.send_file_chunk()      # Envia o bloco do arquivo
            print('Timeout tx1')        
            self.timeout_manager()
        
        # caso a MEF esteja no estado tx2, o estado não muda com o timeout
        elif self.state == State.tx2:
            self.send_file_chunk()      # Reenvia o último bloco do arquivo
            print('Timeout tx2')
            self.timeout_manager()
        
        # caso a mef esteja no estado rx1 ou  rx2, o estado muda para idle
        elif (self.state == State.rx1) | (self.state == State.rx2):
            self.state = State.idle
            self.n = 0
            self.max_n = 0
            print('Timeout rx1 ou rx2')
            self.timeout_manager()
        
        # caso a mef esteja no estado idle, o estado não muda com o timeout
        elif self.state == State.idle:
            print('Timeout idle')
            self.timeout_manager()
        
        # caso o timeout aconteça antes da MEF ser iniciada, apenas chama o timeout_manager
        else:
            print('Timeout sem estado')
            self.timeout_manager()

    # método que faz a gerência dos timeouts, utilizado para controle dentro do protocolo
    def timeout_manager(self):
        self.timeout_counter += 1                       # itera o contador de timeouts
        
        # condicional que finaliza o programa caso o limite de timeouts seja atingido
        if self.timeout_counter == self.timeout_limit:  
            self.exit()

    # método que finaliza o programa
    def exit(self):
        print('Programa encerrado')
        self.disable()
        self.disable_timeout()

    # método para verificar se o dado recebido é um ack e se ele representa o ack do bloco correto, verificando a numeração, retornando um booleano, ele verifica:
        # tamanho do bloco
        # formato do ack
    def is_ack_n(self, ack, n):
         
        if len(ack) != 4:
            return False
        opcode1 = ack[0]
        opcode2 = ack[1]
        block = (ack[2] << 8) + ack[3]
        x = n & 0xffff
        if (opcode1 == 0) & (opcode2 == 4) & (block == x):
            print('is_ack_n: retornou true')
            return True
        else:
            print('is_ack_n: retornou false')
            print(opcode1 == 0)
            print(opcode2 == 4)
            print(block == x)
            print(block)
            print(x)
            return False

    # Método que envia um pedaço do arquivo, como o protocolo demanda. 
    def send_file_chunk(self):
        self.sock.sendto(self.data(), (self.server_ip, self.port_out))

    # Método genérico de envio de dados, utilizado para enviar o ack_n 
    def send(self, data):
        self.sock.sendto(data, (self.server_ip, self.port_out))

    # Método para fazer o upload do write request, partindo do estado inicial (idle) 
    def upload(self):
        if self.state == State.idle:
            wrq = self.wrq()                                        # adiciona padrão de frame wrq
            self.sock.sendto(wrq, (self.server_ip, 69))             # tem q ser 69 sempre pra requisicao
            self.n = 1                                              # inicia o iterador n, indicando que o bloco a ser transmitido é o primeiro
            print('upload: passou socket')                          
            with open(self.filename, 'r') as file:
                self.file_data.clear()
                self.file_data = file.read().encode()
                self.max_n = math.ceil(len(self.file_data) / 512)   # configura o max_n lendo o tamanho do arquivo e dividindo pelo tamanho do bloco (512)
                print('upload: abriu arquivo')
            self.state = State.tx0                                  # modifica o estado atual para tx0 na MEF
            print('upload: finalizou upload')
        else:
            print('Entrou no upload, mas não estava no stado idle')

    # Método necessário para o funcionamento da MEF,  
    def dealer_selector(self, data):
        current_dealer = self.dealers[self.state]
        return current_dealer(data)

    # Não é necessário implementar o estado idle, o programa é iniciado nele mas já sai para o estado rx0 ou tx0 quando recebe o argumento de linha de comando na entrada
    def idle(self):
        pass

    # Os próximos métodos definem o funcionamento de cada estado da MEF
    # Estado TX0, representa o primeiro estado de envio, enviando o primeiro bloco caso receba um ack_0 confirmando o write request
    def tx0(self, ack):
        print('tx0: Entrou')
        if self.is_ack_n(ack, 0):                                           # verifica se o ack recebido é o correto (0)
            print('tx0: chegou ack correto')
            self.send_file_chunk()                                          # envia o primeiro bloco do arquivo
            print('tx0: enviado pedaco: ' + str(self.n))
            # self.n += 1
            # Caso o número máximo de blocos seja 1 (O arquivo tem tamanho menor do que o de 1 único bloco) o estado já pula o tx1 e parte para o tx2
            if self.max_n == 1:         
                self.state = State.tx2
                print('tx0: arquivo pequeno. State => tx2')
            # Caso o número máximo de blocos seja maior que 1, o programa continua normalmente partindo para o estado tx1 
            else:
                self.state = State.tx1
                print('tx0: arquivo maior que 1 pacote. State => tx1')
        # Caso não receba o aqui correto, o programa entende que algum problema aconteceu e volta para o estado idle
        else:
            print('tx0: nao veio ack: ' + ack.decode())
            self.state = State.idle

    # Estado TX1, o segundo estado de transmissão, que transmite todos os blocos até o fim. Também verificando o ack recebido (de 1 até max_n-1) 
    def tx1(self, ack):
        print('tx1: entrou')
        print('self_n: ' + str(self.n))
        
        # Verifica se o ack recebido é o ack do atual n
        if self.is_ack_n(ack, self.n):
            print('tx1: recebeu ack correto')
            if self.n < (self.max_n - 1):       # Verifica se o bloco recebido não é o último, mantém o estado no tx1, incrementando o n e enviando o arquivo.
                print('tx1: n < max_x-1')
                self.n += 1
                self.send_file_chunk()
            elif self.n == (self.max_n - 1):    # Verifica se o bloco recebido é o último, enviando o último bloco e modificando o estado para tx2, que aguardará pelo último ack
                print('tx1: n = max_x-1')
                self.n += 1
                self.send_file_chunk()
                self.state = State.tx2

    # Estado TX2 é o terceiro e último estado de transmissão. Aguarda o ultimo ack e, caso não receba, o estado tx2 no handle_timeout reenvia o ultimo bloco. 
    def tx2(self, ack):
        print('tx2: entrou')
        if self.is_ack_n(ack, self.n): # caso o dado recebido seja o ack esperado (n == max_n), a transmissão acaba e o estado volta para o idle, reiniciando o n e o max_n e finalizando o programa
            self.state = State.idle
            self.n = 0
            self.max_n = 0
            print('tx2: State=idle, n=0, max_n=0')
            self.exit()

    # Método análago ao upload. Possui o mesmo funcionamento, entretanto este método leva a MEF do estado idle para o rx0, enviando um read request ao servidor, e incrementando o iterador self.n para 1
    def download(self):
        if self.state == State.idle:
            self.file_data.clear()
            rrq = self.rrq()
            self.sock.sendto(rrq, (self.server_ip, 69))
            self.n = 1
            self.state = State.rx0

    # Estado RX0, primeiro estado de recepção, recebendo o primeiro bloco de arquivos e enviando um ack_1 
    def rx0(self, data):
        print('rx0: entrou')
        if self.is_data_n(data) == 1:                               # verifica se o bloco de dados recebido é o bloco correto, comparando o n utilizando o método is_data_n (abaixo)
            print('rx0: recebeu data_n correto')
            if len(data) == 516:                                    # condicional que lê o tamanho do bloco recebido para saber se é o último bloco
                self.file_data += data[4:]                          # retira do bloco o dado recebido, retirando o opcode e a numeração do bloco e adicionando a uma variável que é construída bloco à bloco
                print('rx0: len(data) == 516')
                ack_n = self.ack(self.n)                            # constrói o ack para ser enviado para enviar na linha abaixo
                self.send(ack_n)
                print('rx0: enviou ack_' + str(self.n))
                self.n += 1                                         # incrementa o iterador n e muda de estado para o rx1
                self.state = State.rx1
            elif len(data) < 516:                                   # verifica se o bloco de dados recebido é o último, lendo o tamanho do bloco
                self.file_data += data[4:]                          # novamente o dado é extraído do resto do frame e o ack_n é construído e enviado
                print('rx0: len(data) < 516 ultimo ack')
                ack_n = self.ack(self.n)
                self.send(ack_n)
                print('rx0: enviou ulimo ack_' + str(self.n))
                self.n += 1
                self.state = State.rx2                              # o estado é mudado para o rx2, ultimo estado de recepção, que adiciona a um arquivo no modo de escrita a variável self.file_data, que foi construída bloco à bloco
                with open(self.filename, 'w') as file:
                    file.write(self.file_data.decode())
        else:                                                       # caso o bloco de dados não seja o correto (comparando com o iterador n), o programa entende que um erro aconteceu e volta para o estado idle
            print('rx0: recebeu data errado. volta pra idle')
            self.state = State.idle
            self.n = 0
            self.max_n = 0

    """
    opcode | block | result
    -------|-------|-------
    0      | 0     | 0
    0      | 1     | 0
    1      | 0     | 2
    1      | 1     | 1
               
      2 bytes    2 bytes      n bytes
     ----------------------------------
    | Opcode3 |  Block #  |   Data     |
     ----------------------------------
    """
    
    # Método is_data_n é muito parecido com o is_ack_n, que verifica se o bloco é um bloco de dados e se tem o frame em um formato de um bloco data. Além disso, verifica se o bloco recebido é o bloco correto
    def is_data_n(self, data_n):
        # O método constrói o bloco de dados esperado e compara com o bloco recebido. O bloco construído é feito à partir do iterador n
        b = bytearray()
        b += data_n
        opcode_rx = b[0:2]
        block_rx = b[2:4]
        a = bytearray()
        a.append(0)
        a.append(3)
        a.append(self.n >> 8)  # adiciona msb do block
        a.append(self.n & 0xff)  # adiciona lsb do block
        opcode_ref = a[0:2]
        block_ref = a[2:4]
        
        # A condicional retorna flags de acordo com o resultado da comparação, retornando 1 caso o bloco esteja correto, 2 caso o bloco seja de dados mas não é o bloco esperado e 0 caso não seja um bloco de dados (comparando pelo opcode e self.n)
        if (opcode_ref == opcode_rx) & (block_ref == block_rx):
            print('is_data_n: returned 1')
            return 1
        elif opcode_ref == opcode_rx:
            print('is_data_n: returned 1')
            return 2
        else:
            print('is_data_n: returned 1')
            return 0

    # Estado RX1, que representa todos os recebimentos de dados depois do primeiro, todo o funcionamento depende do retorno da função is_data_n (acima) 
    def rx1(self, data):
        if self.is_data_n(data) == 1:                           # caso seja o bloco correto de dados
            if len(data) == 516:                                # se o tamanho for o máximo permitido para um bloco, este bloco não é o último e o estado se mantém em rx1, enviando o ack_n correto e armazenando o dado incrementando file_data com os dados recebidos
                ack_n = self.ack(self.n)
                self.send(ack_n)
                self.n += 1
                self.state = State.rx1
                self.file_data += data[4:]
            elif len(data) < 512:                               # caso o bloco tenha o tamanho menor que o máximo para um bloco, este é o ultimo e o estado parte para rx2, enviando o ack_n correto e armazenando o dado incrementando file_data com os dados recebidos
                ack_n = self.ack(self.n)
                self.send(ack_n)
                self.n += 1
                self.state = State.rx2
                self.file_data += data[4:]
                with open(self.filename, 'w') as file:
                    file.write(self.file_data.decode())
        elif self.is_data_n(data) == 2:
            block = (data >> (8*(len(data)-4))) << 16
            ack_n = self.ack(block)
            self.send(ack_n)
        else:                                                   # caso o dado recebido não seja um bloco correto (não possui opcode como um bloco data), algum erro aconteceu e o programa volta pro estado idle
            self.state = State.idle
            self.n = 0
            self.max_n = 0

    # Estado RX2 é o ultimo estado de recepção, que envia o ultimo ack_n e volta o estado para idle
    def rx2(self, data):
        if self.is_data_n(data):
            ack_n = self.ack(self.n)
            self.send(ack_n)
            self.n = 0
            self.state = State.idle


    # Os métodos abaixo representam a criação dos blocos de acordo com sua função (rrq, wrq, ack, data e error) o comentário que segue em cima de cada método é o formato do bloco

    """
     2 bytes     string    1 byte    string    1 byte
     ------------------------------------------------
    | Opcode1 |  Filename  |  0  |    Mode    |   0  |
     ------------------------------------------------
    """

    def rrq(self):
        b = bytearray()
        b.append(0)  # 0000 0000
        b.append(1)  # 0000 0001
        b += self.filename.encode()  # adiciona nome em bytes
        b.append(0)  # 0000 0000
        b += 'netascii'.encode()   # adiciona octet em bytes
        b.append(0)  # 0000 0000
        return b

    """
     2 bytes      string    1 byte   string     1 byte
     -------------------------------------------------
    | Opcode2 |  Filename  |   0  |    Mode    |   0  |
     -------------------------------------------------
    """

    def wrq(self):
        b = bytearray()
        b.append(0)  # 0000 0000
        b.append(2)  # 0000 0010
        b += self.filename.encode()  # adiciona nome em bytes
        b.append(0)  # 0000 0000
        b += 'netascii'.encode()  # adiciona octet em bytes
        b.append(0)  # 0000 0000
        return b

    """               
      2 bytes    2 bytes      n bytes
     ----------------------------------
    | Opcode3 |  Block #  |   Data     |
     ----------------------------------
    """

    def data(self):
        b = bytearray()
        b.append(0)  # 0000 0000
        b.append(3 & 0xff)  # 3 AND 1111 1111 = 0000 0011
        b.append(self.n >> 8)  # adiciona msb do block
        b.append(self.n & 0xff)  # adiciona lsb do block
        b += self.file_data[((self.n * 512) - 512):(self.n * 512)]  # adiciona data em bytes
        return b

    """"
    2 bytes     2 bytes
    ---------------------
    | Opcode4 |   Block #  |
    ---------------------
    """

    def ack(self, n):
        b = bytearray()
        b.append(0)  # 0000 0000
        b.append(4 & 0xff)  # 4 AND 1111 1111 = 0000 0100
        b.append(n >> 8)  # adiciona msb do block
        b.append(n & 0xff)  # adiciona lsb do block
        return b

    """
      2 bytes   2 bytes       string    1 byte
    ------------------------------------------
    | Opcode5 |  ErrorCode |   ErrMsg   |  0  |
    ------------------------------------------
    
     Value     Meaning
    |---------|----------------------------------------|
     0         Not defined, see error message (if any).
     1         File not found.
     2         Access violation.
     3         Disk full or allocation exceeded.
     4         Illegal TFTP operation.
     5         Unknown transfer ID.
     6         File already exists.
     7         No such user.
    """

    def error(self, error_code, err_msg):
        b = bytearray()
        b.append(0)  # 0000 0000
        b.append(5)  # 5 AND 1111 1111 = 0000 0101
        b.append(error_code >> 8)  # adiciona msb do error_code
        b.append(error_code & 0xff)  # adiciona lsb do error_code
        b += err_msg.encode()  # adiciona err_msg em bytes
        b.append(0)  # 0000 0000
        return b
