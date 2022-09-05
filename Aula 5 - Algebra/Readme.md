# Algebra relacional

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


