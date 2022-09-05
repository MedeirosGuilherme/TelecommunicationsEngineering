# SQLite - uso e conceitos

## lab01

-------------------------------------------

Foi criado um arquivo sqlite utilizando o comando:

```
sqlite3 lab01.sqlite
```

Assim o banco está pronto para ser usado, e após construir já está dentro do cliente para criar as tabelas.

Primeiramente vamos garantir a integridade do banco com:

```
PRAGMA foreign_keys ON
```

Foi criada uma tabela no cliente SQL com:

```
sqlite> INSERT INTO Pessoa (idPessoa,nome,email,cidade,uf) VALUES (1, 'Guilherme Medeiros', 'guilherme.alth@gmail.com', '$Palhoça$', 'SC');
sqlite> INSERT INTO Pessoa (idPessoa,nome,email,cidade,uf) VALUES (2, 'Juca Pinheiro', 'juca@email.com', 'São José', 'SC');
```

A Tabela pode ser conferida com o comando:

```
sqlite> SELECT * FROM pessoa;
1|Guilherme Medeiros|guilherme.alth@gmail.com|$Palhoça$|SC
2|Juca Pinheiro|juca@email.com|São José|SC
sqlite> .header on
sqlite> .mode column
sqlite> SELECT * FROM pessoa;
idPessoa    nome                email                     cidade      uf        
----------  ------------------  ------------------------  ----------  ----------
1           Guilherme Medeiros  guilherme.alth@gmail.com  $Palhoça$  SC        
2           Juca Pinheiro       juca@email.com            São José  SC        
sqlite> 

```

O .mode e o .header funcionam para melhorar a visualização dos dados.

Além do .mode column, pode-se usar o .mode csv por exemplo, para dispôr a tabela em um formato fácil de exportar para CSV.

Para exportar para o .csv, pode-se fazer, isso faz com que o SELECT vá para o arquivo csv. Para voltar o output para a tela basta fazer ```.output```

```
sqlite> .header off
sqlite> .mode csv
sqlite> .output saida.csv
sqlite> SELECT * FROM pessoa;
sqlite> SELECT * FROM Pessoa;
```

Para se importar de um arquivo CSV, basta fazer:

```
sqlite> .mode csv
sqlite> .import "file.csv" Pessoa
```

Algumas outras operações feitas:

```
sqlite> .header on
sqlite> .mode column
sqlite> SELECT * FROM Pessoa;
idPessoa    nome                email                     cidade      uf        
----------  ------------------  ------------------------  ----------  ----------
1           Guilherme Medeiros  guilherme.alth@gmail.com  $Palhoça$  SC        
2           Juca Pinheiro       juca@email.com            São José  SC        
3           Ana Paula           ana@email.com             Florianopo  SC        
4           Sandra Rosa         sandra@email.com          São José  SP        
sqlite> SELECT nome,cidade,uf FROM Pessoa;
nome                cidade      uf        
------------------  ----------  ----------
Guilherme Medeiros  $Palhoça$  SC        
Juca Pinheiro       São José  SC        
Ana Paula           Florianopo  SC        
Sandra Rosa         São José  SP        
sqlite> SELECT nome,cidade,uf FROM Pessoa
   ...> WHERE uf='SP';
nome         cidade                 uf        
-----------  ---------------------  ----------
Sandra Rosa  São José dos Campos  SP        
sqlite> 
```

Esta tabela não possui auto increment em nenhum campo. Vamos criar agora uma tabela com auto increment. Para criar esta tabela, basta fazer:
```
CREATE TABLE Telefone (idTelefone INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, rotulo TEXT NOT NULL, numero TEXT NOT NULL, idPessoa INTEGER NOT NULL, FOREIGN KEY (idPessoa) REFERENCES Pessoa(idPessoa));
```
O AUTOINCREMENT serve para justamente fazer com que a coluna se auto incremente naturalmente e o NOT NULL força a coluna a ser preenchida, não pode ser vazia.

Além disso, nessa instrução foi colocada uma chave estrangeira, para se criar uma relação entre as tabelas. Ela foi criada com a instrução FOREIGN KEY que recebe uma coluna da tabela atual que REFERENCIA uma coluna em outra tabela [Pessoa(idPessoa)].

Para garantir a integridade do banco é necessário sempre usar o comando ```PRAGMA foreign_keys ON```, garantindo a itnegridade de chaves estrangeiras.

