# Diário de bordo do membor da equipe:

**Aluno: Guilherme Medeiros**

Tudo o que está citado abaixo foi desenvolvido presencialmente ou via remoto em conjunto com o membro Rafael Teles, membro da equipe.

### 17/05 
Iniciado o projeto. Em aula foi desenvolvido grande parte da classe Enquadramento, contendo parte da máquina de estado e do quadro que será construído. Aqui também foi compreendido o funcionamento da pySerial e do Serial Emu, e foi bem sucedida a emulação de duas portas seriais que podem se comunicar.

### 22/05
Enquadramento foi melhor desenvolvido até aqui, agora com uma classe com a aplicação que roda o enquadramento para transmitir e/ou receber da outra fonte. Além disso foi inserido (em aula) o conceito de subcamada e o projeto foi parcialmente adequado para o funcionamento desse sistema, ainda não prevê camadas posteriores, entretanto.
Enfrentando algumas dificuldades de trabalhar com bytes e bits dentro da linguagem Python, principalmente quanto a imprimir na tela e verificar o que está sendo transmitido ou recebido. De qualquer forma, foi possível desenvolver as flags e acertar o que funciona como começo e fim de quadro pela camada de Enquadramento.
Além disso, em conjunto com o Rafael que já possuia certo conhecimento no assunto, foi desenvolvido o CRC antes de ser passado em aula, com o objetivo de adiantar o desenvolvimento do projeto. O CRC usou o CRC16 já implementado no Python, colocando nos ultimos 2 bytes da mensagem. Foi bastante simples de implementar.

### 29-01-02/06
Foi passado em aula a camada ARQ, que faz a garantia de entrega através de troca de mensagens que sinalizam a entrega de um pacote. Aqui foi desenvolvida uma máquina de estados (todas as MEFs podem ser encontradas no diretorio de documentação na raíz do repositório) e essa MEF foi desenvolvida seguindo o padrão de subcamada que implementa os callbacks. Para isso, teve de ser melhor desenvolvido o quadro que é enquadrado e transmitido:

 bit7: 
        0=Data
        1=ack
        
    bit3: Sequência. Numeração do bloco. 0 ou 1.
    
    Controle:   |bit7: 0=Data; 1=ack
                |bit3: Sequência (numeração do bloco)
    |____1_____|____ 1_____|____1_____|_______<= 1024_______|__2__|
    | Controle | Reservado | ID Proto |         Dados       | FCS |

Seguindo o quadro desenvolvido, não foi difícil implementar a camada ARQ, que agora define parte do formato do quadro. Nela, foi necessário gerar alguns quadros de ack e de dados, o que foi bastante complicado de compreender devido a ainda pouca experiência com o trabalho com bytes em Python. O projeto foi testado com as camadas applicação-ARQ-Enquadramento e funcionou como o esperado.

### 07/06
Se mostrou necessário criar uma classe Quadro que define como é o quadro a ser transmitido e compreendido pelo protocolo. Essa classe agora é quem cria e verifica em todas as subcamadas, os formatos de quadro a serem transmitidos. Isso foi necessário devido a necessidade de encapsulamento, já que anteriormente essa funcionalidade estava dentro da classe ARQ, que é uma subcamada de garantia de entrega e não uma classe que determina o formato dos quadros. Com essa classe ficou mais fácil verificar cada um dos bits e dos formatos que o quadro pode assumir. Para isso funcionar, óbvio, teve de ser adequado em cada uma das subcamadas o funcionamento considerando esta classe.

### 13/06
A camada de Sessão foi apresentada em aula e muita coisa deve ser mudada para comportá-la, principalmente pelo quadro, que ganha mais bits de controle. Aqui a classe Quadro foi modificada para comportar a nova classe que viria, tendo que ser modificados alguns parâmetros nas outras classes também. Grande parte do trabalho nessa fase do projeto foi simplesmente verificar erros testando o programa, imprimindo logs, vendo até onde a mensagem chegava e onde ela se perdia, o que se mostrou uma experiência bastante satisfatória a ser desenvolvida. Aliás, em todas as fases do projeto eu e o Rafael em vários momentos nos pegamos simplesmente imprimindo logs e vendo em que parte do programa estava dando problema.


### 16-17/06
Primeiramente o projeto foi adaptado a uma nova forma de manipular os bits das mensagens, considerando algumas dicas dadas pelo professor. Depois disso, a MEF da camada de Sessão foi montada, ainda mostrando alguns problemas a serem verificados.

### 18/06 
Em alguns testes foram verificados alguns erros estruturais em ambas as camadas para funcionar com a Sessão. Eles foram corrigidos e o programa está parcialmente funcionando, só precisa ser verificado uma forma de fazer a desconexão ao final da sessão.


### 22/06
A desconexão foi desenvolvida e alguns bugs foram corrigidos, o programa, nesse estado, está funcionando como o planejado. Alguns reparos internos ainda são necessários e o programa precisa ser comentado.
