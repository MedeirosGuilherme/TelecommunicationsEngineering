A figura 2.38 apresenta um DER de parte de um sistema de recursos humanos em uma organização. Descreva em português tudo o que está representado neste diagrama

![screen](screenshot1.png)

O diagrama descreve um quadro de funcionários de uma empresa.

Nele, existe um DEPARTAMENTO que não necessariamente tem EMPREGADOS, mas pode ter N EMPREGADOS. Um EMPREGADO só pode participar de um departamento mas necessariamente está aterlado a um. 

Um EMPREGADO tem um cpf, um nome e um tipo de empregado. Este empregado pode ser um GERENTE uma SECRETÁRIA e um ENGENHEIRO.

UM GERENTE necessariamente gerencia 1 ou mais EMPREGADOS. um EMPREGADO não necessariamente é gerenciado por um GERENTE, mas se for, só é gerenciado por um.

Já a secretária pode ou não ter o domínio de um ou mais PROCESSADOR DE TEXTOS, que necessariamente é dominado por uma ou mais SECRETÁRIAS.

O ENGENHEIRO possui um CREA e pode (não necessariamente) participar de um ou mais PROJETOs, que pode ou não ter participação de um ou mais ENGENHEIROs.