# Resumão da Prova 1 de BCD

## Propriedades ACID

1. Atomicidade: Operações executadas de uma vez ou tudo é desfeito.
2. Consistência: Não existem estados intermediários. O banco via de um estado consistente à outro estado consistente.
3. Isolamento: Transações são feitas isoladamente, sem concorrência.
4. Durabilidade: Todas as modificações são duráveis.

## Modelo Entidade Relacional:

Conceitos:

* Entidade: Coisa diferente de outras coisas. Representa uma tabela no banco de dados.
* Atributo: Conjunto de características de uma entidade, representa uma coluna em uma tabela.
* Superchaves: Conjunto de atributos que podem ser usados para se identificar unicamente uma entidade.
* Chave: Uma superchave na qual não é possível tirar qualquer atributo para a identificação de uma entidade única. Se houver mais de uma chave, essas são definidas chaves candidatas e a escolhida chave.

Diagrama:

* Relacionamento identificador:

```
Considerando uma entidade com relacionamento com outra, diz-se que existe um relacionamento identificador quando não se é possível identificar uma entidade sem a chave primária do outro.
No diagrama, isso é representado por um traço mais grosso no lado da entidade "fraca"
```

## Modelo Relacional:

Relações 1 - 1:

0..1 - 0..1 - Adição de coluna
0..1 - 1..1 - Fusão
1..1 - 1..1 - Fusão 

Relações 1 - N:

Todos são adição de coluna pro lado n

Relações N - N:

Todos são tabela pŕopria

## Algebra relacional

Foram feitos alguns exercícios em:
https://bcd29008.github.io/relax/calc/gist/34bb7c2574120aa2bf461e9b8d679d1e

Utilizando a gist: 34bb7c2574120aa2bf461e9b8d679d1e

Foram estudadas as operações de:

* Seleção (Seleciona linhas)
* Projeção (Seleciona colunas)
* Composição de operações
* Atribuição (Alter table)
* Produto cartesiano 
* Junção natural

Em resumo:
| simbolo| Nome | operação | Descrição|
|----|--------------------|-----------------------------|--------------------------------------------------------------------------------|
| σ  | Seleção            | σsalario>500(funcionario)   |  Seleciona e mostra todas as linhas da tabela que tem o salário maior que 500  |
| Π  | Projeção           | Πnome,salario (funcionario) | Seleciona o nome e o salário (todas as linhas)                                 |
| ×  | Produto Cartesiano | professor × curso           | Seleciona todas as tuplas, independente de terem o mesmo nome                  |
| ▷◁ | Junção             | professor ▷◁ curso          | Seleciona todas as tuplas que possuem o mesmo valor para colunas de mesmo nome |

## Linguagem SQL

### Instruções:

* CREATE TABLE

Cria uma tabela, uma entidade:
```SQL
CREATE TABLE Disciplina(
codigo INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
nome TEXT NOT NULL,
cargaHoraria INTEGER NOT NULL);
```

* INSERT:

```SQL
INSERT INTO Pessoa (nome) VALUES ('Juca');
```

* ALTER TABLE:

```SQL
ALTER TABLE Funcionarios ADD situacao TEXT;
-- No SQLite
PRAGMA foreign_keys=off;
BEGIN TRANSACTION;
ALTER TABLE Funcionario RENAME TO _funcionario_antigo;
CREATE TABLE ....
INSERT INTO Funcionario (...) SELECT (...) from _funcionario_antigo;
COMMIT;
PRAGMA foreign_keys=on;
```



