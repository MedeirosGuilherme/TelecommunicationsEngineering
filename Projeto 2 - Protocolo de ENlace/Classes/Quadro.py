from enum import Enum
import ByteUtils
import logging  # https://realpython.com/python-logging/
'''
 _______________________________________________________
|____1_____|____ 1_____|____1_____|_______<= 1024_______|
| Controle | Reservado | ID Proto |         Dados       |
                                                       
                                                       
Controle:   |bit7: 0=Data; 1=ack                    | ARQ
            |bit3: Sequência (numeração do bloco)   |

            |bit0&1 |00 = CR|                       | Conexão
                    |01 = CC|                       |
                    |10 = DR|                       | 
                    |11 = DC|                       |
            |bit2: 0 = Dados; 1 = Controle          |

Reservado:  |idConexão|
'''

# Classe Quadro responsável por criar e gerenciar quadros em todas as subcamadas.
# O quadro está descrito acima e todo o código fica mais simples conhecendo os padrões do quadro.
class Quadro:
    
    # Construtor da classe Quadro, sem retorno, inicia todos os segmentos do quadro (controle, reservado, id_proto e dados)
    def __init__(self):
        self.controle = 0
        self.reservado = 0
        self.id_proto = 0
        self.dados = None
        self.log = True
        logging.basicConfig(level=logging.INFO)  # DEBUG, INFO, WARNING, ERROR, CRITICAL

    # Método create_from_bytes, que cria e retorna um quadro recebendo um buffer como parâmetros.
    @staticmethod
    def create_from_bytes(buffer: bytes):
        quadro = Quadro()
        quadro.controle = buffer[0]  # Primeiro byte
        quadro.reservado = buffer[1]  # Segundo byte
        quadro.id_proto = buffer[2]  # Terceiro byte
        quadro.dados = buffer[3:-2]
        return quadro

    # Método serialize, considerando um objeto quadro criado, monta e retorna um bytearray para ser transmitido, inserindo todos os segmentos do quadro.
    def serialize(self):
        b = bytearray()
        b.append(self.controle)
        b.append(self.reservado)
        b.append(self.id_proto)
        if self.dados != None:
            b += self.dados
        return b

    # Método que verifica se um quadro já construído é um ack e se está no número de sequência correto.
        # Recebe:
            # Número de sequência como parâmetro.
        # Retorna:
            # True caso o quadro realmente seja um ack e se o número de sequência recebido for igual ao número de sequência do quadro.
            # False caso uma das duas condições acima não sejam cumpridas.
    def is_ack_n(self, n):
        if ByteUtils.get_bit(self.controle, 7) == 1:        # Verificando bit que indica ACK
            if ByteUtils.get_bit(self.controle, 3) == n:    # Verificando se o bit de sequência é igual ao número de sequência passado.
                return True
            else:
                return False
        else:
            return False

    # Método que verifica se um quadro já construído é um quadro de dados e se está no número de sequência correto.
        # Recebe:
            # Número de sequência como parâmetro.
        # Retorna:
            # True caso o quadro realmente seja um quadro de dados e se o número de sequência recebido for igual ao número de sequência do quadro.
            # False caso uma das duas condições acima não sejam cumpridas.
    def is_data_m(self, m):
        if ByteUtils.get_bit(self.controle, 7) == 0:        # Verifica o bit que indica DATA
            if ByteUtils.get_bit(self.controle, 3) == m:    # Verifica se o bit de sequência é igual ao número de sequência passado.
                return True
        else:
            return False

    # Gerador de acks, insere nos parâmetros do objeto bits que indicam para as subcamadas que esse é um quadro de ACK. Sem retorno. Utiliza o método generate_controle_byte.
    def generate_ack(self, counter):
        self.controle = self.generate_controle_byte(1, counter)
        self.dados = None

    # Gerador de byte de controle (ack ou data).
        # Recebe:
            # Tipo:
                # 0 representa Data
                # 1 representa ACK
            # Counter: bit bit de sequência
        # Retorna:
            # byte de controle do quadro.
    def generate_controle_byte(self, tipo, counter):
        if tipo == 0:
            self.controle = ByteUtils.clear_bit(self.controle, 7)
        else:
            self.controle = ByteUtils.set_bit(self.controle, 7)

        if counter == 0:
            self.controle = ByteUtils.clear_bit(self.controle, 3)
        else:
            self.controle = ByteUtils.set_bit(self.controle, 3)

        return self.controle

    # Abaixo métodos de criação de CR, CC, DR e DC, para serem utilizados na camada de sessão todos são muito semelhantes e apenas setam bits especificos para criar os bytes:
        # cr: 0000 0100
        # cc: 0000 0110
        # dr: 0000 0101
        # dc: 0000 0111
    # Ambos os métodos não possuem retorno.
    def generate_cr(self):
        self.controle = ByteUtils.clear_bit(self.controle, 0)
        self.controle = ByteUtils.clear_bit(self.controle, 1)
        self.controle = ByteUtils.set_bit(self.controle, 2)

    def generate_cc(self):
        self.controle = ByteUtils.clear_bit(self.controle, 0)
        self.controle = ByteUtils.set_bit(self.controle, 1)
        self.controle = ByteUtils.set_bit(self.controle, 2)

    def generate_dr(self):
        self.controle = ByteUtils.set_bit(self.controle, 0)
        self.controle = ByteUtils.clear_bit(self.controle, 1)
        self.controle = ByteUtils.set_bit(self.controle, 2)

    def generate_dc(self):
        self.controle = ByteUtils.set_bit(self.controle, 0)
        self.controle = ByteUtils.set_bit(self.controle, 1)
        self.controle = ByteUtils.set_bit(self.controle, 2)

    # Abaixo métodos de verificação de byte de controle para CR, CC, DR e DC para serem utilizados na camada de sessão. Os métodos são semelhantes e retornam:
        # True se o byte de controle possui o padrão exigido, ou False qualquer um dos bits do byte estiver fora do padrão:
    
    # Verifica CR: 0000 0100
    # Retorna True se o padrão acima estiver correto, retorna Falso caso contrário
    def is_cr(self):
        logging.debug('Qaudro.is_cr(): ' + str(self.controle))
        if ByteUtils.get_bit(self.controle, 2) == 1:
            if ByteUtils.get_bit(self.controle, 1) == 0:
                if ByteUtils.get_bit(self.controle, 0) == 0:
                    return True
                else:
                    return False
            else:
                return False
        else:
            return False

    # Verifica CC: 0000 0110
    # Retorna True se o padrão acima estiver correto, retorna Falso caso contrário
    def is_cc(self):
        logging.debug('Qaudro.is_cc(): ' + str(self.controle))
        if ByteUtils.get_bit(self.controle, 2) == 1:
            if ByteUtils.get_bit(self.controle, 1) == 1:
                if ByteUtils.get_bit(self.controle, 0) == 0:
                    return True
                else:
                    logging.debug('Quadro.is_cc(): False 0')
                    return False
            else:
                logging.debug('Quadro.is_cc(): False 1')
                return False
        else:
            logging.debug('Quadro.is_cc(): False 2')
            return False
    
    # Verifica DR: 0000 0101
    # Retorna True se o padrão acima estiver correto, retorna Falso caso contrário
    def is_dr(self):
        logging.debug('Qaudro.is_dr(): ' + str(self.controle))
        if ByteUtils.get_bit(self.controle, 2) == 1:
            if ByteUtils.get_bit(self.controle, 1) == 0:
                if ByteUtils.get_bit(self.controle, 0) == 1:
                    return True
                else:
                    return False
            else:
                return False
        else:
            return False

    # Verifica DC: 0000 0111
    # Retorna True se o padrão acima estiver correto, retorna Falso caso contrário
    def is_dc(self):
        logging.debug('Qaudro.is_dc(): ' + str(self.controle))
        if ByteUtils.get_bit(self.controle, 2) == 1:
            if ByteUtils.get_bit(self.controle, 1) == 1:
                if ByteUtils.get_bit(self.controle, 0) == 1:
                    return True
                else:
                    return False
            else:
                return False
        else:
            return False

    # Verifica se o quadro construído é um quadro de dados, verificando o bit de controle (E não um Ack), retorna:
        # True:
            # Caso o byte de controle represente Data
        # False:
            # Caso o contrário seja verdadeiro
    def is_data(self):
        if ByteUtils.get_bit(self.controle, 2) == 0:
            return True
        else:
            return False
