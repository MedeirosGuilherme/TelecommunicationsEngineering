# lab01 de SQL

Usando o banco de dados correto:

```SQL
use lab01guilherme;
```

1. Liste o sobrenome de todos os funcionários;

```SQL
SELECT Sobrenome FROM Funcionario;
```


2. Liste o sobrenome de todos os funcionários, porém sem duplicatas;

```SQL
SELECT DISTINCT Sobrenome FROM Funcionario;
```

3. Liste o nome de todos os departamentos cujo orçamento seja maior que 15.000, 00;

```SQL
SELECT dNome FROM Departamento WHERE Orcamento > 15000;
```

4. Liste todos os dados de todos os funcionários cujo sobrenome seja “Coelho” ou “Pereira” e apresente o
resultado ordenado pelo nome do funcionário;

```SQL
SELECT * FROM Funcionario WHERE Sobrenome = "Coelho" OR Sobrenome = "Pereira";
```

5. Liste todos os dados de todos os funcionários que trabalham no departamento 1;

```SQL
SELECT * FROM Funcionario WHERE idDepartamento = 1;
```

6. Liste os nomes de todos os funcionários que trabalham nos departamentos 1 ou 2;

```SQL
SELECT Nome FROM Funcionario WHERE idDepartamento=1 OR idDepartamento=2;
```

7. Liste os nomes de todos os funcionários cujo sobrenome termine em eira e apresente o resultado ordenado
pelo nome e sobrenome;

```SQL
SELECT Nome FROM Funcionario WHERE Sobrenome LIKE '%eira%' ORDER BY Nome,Sobrenome;
```

8. Liste a soma dos orçamentos de todos os departamentos;

```SQL
SELECT SUM(orcamento) FROM Departamento;
```

9. Liste o total de funcionários de cada departamento. Atenção: só é necessário informar o código do
departamento e o total de funcionários;

```SQL
SELECT idDepartamento,COUNT(*) FROM Funcionario GROUP BY idDepartamento;
```

10. Adicione um departamento Compras com o orçamento de 100.000, 00 e adicione um funcionário “Juliano
Souza”, com matrícula 786, nesse novo departamento;

```SQL
SELECT @maxIdDepart:=MAX(idDepartamento) FROM Departamento;
INSERT INTO Departamento (idDepartamento,dNome,Orcamento) VALUES(@maxIdDepart+1,'Compras',100000);

SELECT @idCompras:= (SELECT idDepartamento FROM Departamento WHERE dNome='Compras');
INSERT INTO Funcionario (idFuncionario,Nome,Sobrenome,idDepartamento) VALUES (786, 'Juliano','Souza',@idCompras);

```

11. Reduzir em 10% o orçamento de todos os departamentos;

Com o SET_SAFE_UPDATES=0

```SQL
UPDATE Departamento SET Orcamento:= Orcamento-Orcamento/10 
```

12. Exclua o departamento “Pesquisa e desenvolvimento”;

```SQL
Existe uma restrição de chave chave estrangeira que não permite deletar essa linha da tabela: Existem funcionários que participam deste departamento.
```

13. Migrar todos os funcionários do departamento “Pesquisa e desenvolvimento” para o departamento de “TI”.

```SQL
SELECT @idPesqDev:=idDepartamento FROM Departamento WHERE dNome = 'Pesquisa e desenvolvimento';
SELECT @idTI:=idDepartamento FROM Departamento WHERE dNome = 'TI';

UPDATE Funcionario SET idDepartamento=@idTI WHERE idDepartamento=@idPesqDev;

```

14. Adicione o funcionário “Paulo Aguiar”, com idFuncionario = 123, no departamento de TI;

```
Impossível adicionar, já existe essa chave primária 123 na tabela Funcionario
```

15. Exclua todos os funcionários do departamento de TI

```SQL
SELECT @idTi:=idDepartamento FROM Departamento WHERE dNome='TI';

DELETE FROM Funcionario WHERE idDepartamento=@idTi;
```

16. Adicione 3 novos funcionários no departamento Financeiro;
```

```