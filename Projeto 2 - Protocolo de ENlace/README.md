# Projeto 2: Um protocolo de enlace ponto-a-ponto

O projeto foi desenvolvido pela equipe formado por:

```
Guilherme Medeiros
Rafael Teles
```

## Executando o software.

Os arquivos do projeto estão dentro do diretório [classes](classes), para iniciar o projeto deve-se entrar no diretório e executar o arquivo main.py com o comando:

```bash
python3 main.py {porta_serial}
```

Substituindo ```{porta_serial}``` pela sua porta serial de comunicação.

Depois de executar esse comando em cada uma das extremidades do link, é necessário começar a conexão, isso pode ser feito utilizando o comando ```#Conecta```, que faz com que um dos lados mande uma _connection request_ para o outro, começando a conexão. Só então as mensagens fluirão pelo link.

Com a troca de mensagens acontecendo, para se desconectar os links, é necessário utilizar o comando ```#Desconecta``` em qualquer um dos lados conectados. Isso fará com que ambos os lados se desconectem, possibilitando, inclusive, uma nova conexão.

**Obs1:** O projeto foi inicialmente testado entre dois links do nosso projeto, funcionando perfeitamente. Quando testado no programa exemplo cedido pelo professor ele apresentou falhas, que serão tratadas. 

**Obs2:** Como ainda possue alguns problemas a serem resolvidos, o projeto continua com os logs ativados.