# Exercíco 10


Considere o DER da figura 2.12. Para que a restrição de cardinalidade mínima seja obedecida, que ocorrências de entidade devem existir no banco de dados, quando for incluida uma ocorrência de EMPREGAD? E quando for incluída uma ocorrência de Mesa?

![figura1](screenshot1.png)

No caso da ocorrência de uma entidade EMPREGADO, deve-se existir uma ocorrência de mesa, algo do tipo:

```
E1, M1
E2, M2
```

Cada Empregado deve estar relacionado apenas a uma MESA, não é possível, por exemplo, a existência do seguinte caso:

```
E1, M1
E2, M2
```

Já na ocorrência de uma entidade MESA, não é necessário a ocorrência de um EMPREGADO, do tipo:

```
M4,
M1, E1
M2, E2
M3
```