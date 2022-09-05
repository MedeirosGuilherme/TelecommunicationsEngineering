# Exercício inicial: Cafeteira

## Quais dados preciso armazenar?
- Usuário: Nome, identificador único, nº café simples, nº café duplo

## Como serão armazenados?
- Arquivo texto, em tabelas

## Como será o acesso?
- Por aplicação comum

## Exercício 1: Cafeteira simples

### Arquivo 1: Usuários

Nome		ID		    nº café Simples		nº café duplo		nº simples Pagos	nº duplos Pagos

Guilherme	0001		2	       		    3			        1	        		2

Pedro		0002		4		     	    0	        		4       			0

José		0003		5			        6	        		3       			5



### Arquivo 2: Preços

Café		Preço
Simples		2,00
Duplo		4,00

Relatórios possíveis:
- Quem tá devendo?
- Quanto um usuário específico deve?
- Quantos cafés tomei até agora? 
 

## Exercício 2: Saldo, ver extrato, ter histórico

### Arquivo 1: Consumo

ID_user     Id_Compra       Data        Tipo

0001        0001            01/11/20    Longo
0001        0002            01/11/20    Curto
0002        0003            01/11/20    Longo
0003        0004            02/11/20    Curto
0001        0005            02/11/20    Longo
0002        0006            03/11/20    Curto


### Arquivo 2: Usuários

Nome		ID		    

Guilherme	0001		

Pedro		0002		

José		0003

### Arquivo 3: Preços

Tipo        Preço

Longo       4,00
Curto       2,00

Relatórios possíveis:
- Quanto o usuário X gastou
- Quanto o usuário X comprou no mês M
- Extrato de consumo do usuário X
- Saldo de um usuário X













