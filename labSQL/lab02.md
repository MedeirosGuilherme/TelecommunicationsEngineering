# Lab02 de SQL

# Joins

## Listar o ID de todos os clientes que possuam um empréstimo, uma conta ou ambos.

Dividindo o problema em dois:

1. Listar o ID de todos os clientes que possuam emprestimo:

```SQL
SELECT DISTINCT idPessoa FROM Mutuario;
```

2. Listar o ID de todos os clientes que possuam uma conta:

```SQL
SELECT DISTINCT idPessoa FROM Correntista;

```

Para resolver o problema, usaremos UNION:

```SQL
(SELECT DISTINCT idPessoa FROM Mutuario) UNION (SELECT DISTINCT idPessoa FROM Correntista);
```

## Intersecção: Listar o ID de todos os clientes que possuam um empréstimo E uma conta.

```SQL
SELECT idPessoa FROM Correntista WHERE idPessoa IN (SELECT idPEssoa FROM Mutuario);
```

## JOIN: Selecionar junções de tabelas fazendo produtos cartesianos de junção:

1. Se o nome da chave estrangeira for igual ao nome da chave na outra enditade:

```SQL

SELECT f.Nome, f.Sobrenome, d.dNome FROM Funcionario f NATURAL JOIN Departamento d;
```

2. Se o nome da chave estrangeira for diferente, usa-se o INNER JOIN:

```SQL
SELECT f.Nome, f.Sobrenome, d.dNome
	FROM Funcionario f
		INNER JOIN Departamento d ON f.idDepartamento = d.idDepartamento;
```

# Exercícios: 

1. Liste os nomes de todos os departamentos que possuam mais de dois funcionários:

```SQL
SELECT dNome, COUNT(*) AS Total FROM Funcionario NATURAL JOIN Departamento GROUP BY dNome;
```

Aqui,, com a operação AS, já foi dado o apelido TOTAL para a coluna COUNT(*)

# Subconsutas aninhadas


SELECT idPessoa FROM Mutuario WHERE idPessoa NOT IN (SELECT idPESSOA FROM Correntista)

