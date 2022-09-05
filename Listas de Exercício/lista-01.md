# Lista de exercícios 01 de Banco de Dados | BCD 29008
Semestre: 2022/2
Aluno: Guilherme medeiros

----------------------------------------------------------

1. Cada ala do hospital possui uma enfermeira responsável. Cada enfermeira pode atender no máximo em uma ala do hospital. Uma enfermeira pode ser chefe de outras enfermeiras, mas cada enfermeira só pode ter uma única chefe.

![ex1](images/1.png)

2. Construa um diagrama ER para representar informações sobre filmes, atores, diretores e prêmios recebidos. Assuma que cada filme tem apenas um diretor, vários atores e poderá ter recebido vários prêmios no festival do ano de seu lançamento, como: melhor filme, melhor ator, melhor atriz, melhor diretor e melhor trilha sonora. No festival, cada prêmio só pode ser atribuído a no máximo um filme. Ou seja, se em 2021 o filme “F” recebeu o prêmio de “melhor filme”, então nenhum outro filme em 2021 poderá receber tal prêmio.

![ex2](images/2.png)

3. Construa um diagrama ER para representar um sistema que gerencia senhas de atendimento. O cliente
ao chegar no estabelecimento vai até um equipamento gerador de senha, informa para qual assunto
deseja atendimento e gera uma senha, registrando o horário que a mesma foi gerada. O atendente
sempre que estiver disponível aciona o botão “chamar próximo cliente” pra saber qual senha deve ser
atendida. O gerente usa o sistema de informação para saber o tempo que durou cada atendimento,
quantos atendimentos cada atendente realizou no dia, mês ou ano, bem como quantos atendimentos teve
por assunto.

![ex3](images/3.png)

4. Construa um diagrama ER para representar um sistema de gestão de uma livraria. A livraria precisa manter
um cadastro de clientes e fornecedores. Sobre os clientes é importante alguns dados pessoais, como
nome, CPF, telefone, além de registrar os dados de todas as compras que ele já fez, o que inclui o livro,
valor e data. Para o fornecedor é importante registrar o nome e CNPJ, além de registrar todas as compras
que foram feitas com ele. Para cada livro é importante saber seu título, ISBN, editora, nomes dos autores,
bem como sua quantidade em estoque.

![ex4](images/4.png)

5. Uma empresa de desenvolvimento de software possui diferentes produtos (softwares) destinados a
diferentes sistemas operacionais (i.e. Linux, macOS, Windows, iOS, Android). Alguns produtos são
específicos para um sistema operacional, já outros podem ser destinados para mais de um sistema
operacional. Durante o ciclo de vida de um produto diversas versões podem ser lançadas, seja para corrigir
algum problema ou para acrescentar novas funcionalidades. Construa um diagrama ER para permitir que
essa empresa possa registrar todos detalhes citados para os seus produtos.

![ex5](images/5.png)

6. Construa um diagrama ER para representar um sistema de votação online. O sistema deverá permitir
gerenciar várias eleições. Cada eleição tem um título, uma ou mais questões (i.e. prefeito, vereador, etc.) e
cada questão tem uma ou mais respostas (i.e. nomes dos candidatos); uma lista de eleitores aptos a votar
naquela eleição; data de início; de término; bem como a data que foi feita a apuração. A lista de eleitores é
específica para cada eleição, sendo que cada um eleitor tem um nome, um e-mail e uma senha. Um eleitor
não pode aparecer duas vezes em uma mesma eleição, porém ele poderá aparecer em eleições diferentes.
Em uma eleição, cada eleitor só pode depositar um único voto, contudo o voto não é obrigatório.

![ex6](images/6.png)


7. O Instituto Federal é composto por vários campi, cada campus possui vários departamentos e cada departamento oferta vários cursos de diferentes modalidades, como técnico integrado, técnico concomitante,
técnico subsequente, superior e pós-graduação.
Um curso é composto por diversas disciplinas e uma mesma disciplina pode ser ofertada em mais de
um curso. Por exemplo, a disciplina Cálculo I é ofertada nos cursos Engenharia de Telecomunicações e
Engenharia de Computação. Cada disciplina possui um nome, uma sigla, um código, uma carga horária
teórica, uma carga horária prática e o conjunto de disciplinas que são seus pré-requisitos. Um professor
possui uma titulação, uma área de formação, um conjunto de disciplinas que estaria apto a ministrar e está
lotado em um departamento. O aluno tem um nome, uma matrícula exclusiva por curso e poderá fazer
quantos cursos desejar na instituição. Em todos os cursos a matrícula dos alunos é feita por disciplina. Ou
seja, o aluno escolhe quais disciplinas deseja cursar naquele semestre, desde que atenda a cadeia de
pré-requisitos de cada disciplina.
Um professor pode ministrar diferentes disciplinas a cada semestre, podendo essas serem de diferentes
cursos. Cada edição de uma disciplina ocorre um espaço físico específico e em dias e horários específicos.
Por exemplo, a disciplina Banco de dados em 2021-02 e ministrada pelo professor Emerson e acontece no
Laboratório de Programação na terça-feira às 07:30 e na quinta-feira às 09:40. Para cada edição de uma
disciplina é importante registar a presença diária de cada aluno, as notas que cada aluno tirou em cada
uma das avaliações previstas, podendo uma disciplina ter uma ou mais avaliações e, por fim, registrar
a situação final do aluno quando a edição for finalizada, podendo ser: cursando, trancado, aprovado,
reprovado ou validado.

![ex7](images/7.png)