-- Candidatos (cantoras pop)

INSERT INTO Candidato(senha, nome) VALUES("wakawaka", "Shakira");
INSERT INTO Candidato(senha, nome) VALUES("halo", "Beyonce");
INSERT INTO Candidato(senha, nome) VALUES("umbrella", "Rihanna");
INSERT INTO Candidato(senha, nome) VALUES("cassandra", "Florence");
INSERT INTO Candidato(senha, nome) VALUES("anaconda", "NickyMinaj");
INSERT INTO Candidato(senha, nome) VALUES("telephone", "LadyGaga");
INSERT INTO Candidato(senha, nome) VALUES("roar", "KatyPerry");

-- Elaboradores (cantores pop)

INSERT INTO Elaborador(senha, nome) VALUES("starboy", "TheWeeknd");
INSERT INTO Elaborador(senha, nome) VALUES("baby", "JustinBieber");
INSERT INTO Elaborador(senha, nome) VALUES("treasure", "BrunoMars");
INSERT INTO Elaborador(senha, nome) VALUES("thriller", "MichaelJackson");
INSERT INTO Elaborador(senha, nome) VALUES("stan", "Eminem");

-- Gestores (Cientistas)

INSERT INTO Gestor(senha, nome) VALUES("relatividade", "Einstein");
INSERT INTO Gestor(senha, nome) VALUES("quantum", "Planck");
INSERT INTO Gestor(senha, nome) VALUES("cat", "Schroedinger");
INSERT INTO Gestor(senha, nome) VALUES("inercia", "Newton");
INSERT INTO Gestor(senha, nome) VALUES("termodinamica", "Kelvin");

-- Temas

INSERT INTO Tema(nome) VALUES("Música Pop");
INSERT INTO Tema(nome) VALUES("Música country");
INSERT INTO Tema(nome) VALUES("Literatura");
INSERT INTO Tema(nome) VALUES("POO");
INSERT INTO Tema(nome) VALUES("Física");
INSERT INTO Tema(nome) VALUES("Qualquer Cosia");

-- TemaElaborador

INSERT INTO TemaElaborador(Elaborador_idElaborador, Tema_idTema) VALUES(1,1);
INSERT INTO TemaElaborador(Elaborador_idElaborador, Tema_idTema) VALUES(1,2);
INSERT INTO TemaElaborador(Elaborador_idElaborador, Tema_idTema) VALUES(2,1);
INSERT INTO TemaElaborador(Elaborador_idElaborador, Tema_idTema) VALUES(5,3);
INSERT INTO TemaElaborador(Elaborador_idElaborador, Tema_idTema) VALUES(5,1);
INSERT INTO TemaElaborador(Elaborador_idElaborador, Tema_idTema) VALUES(5,2);
INSERT INTO TemaElaborador(Elaborador_idElaborador, Tema_idTema) VALUES(4,4);
INSERT INTO TemaElaborador(Elaborador_idElaborador, Tema_idTema) VALUES(4,1);
INSERT INTO TemaElaborador(Elaborador_idElaborador, Tema_idTema) VALUES(3,5);

-- Questao

INSERT INTO Questao(descricao, altA, altB, altC, altD, altCerta, dificuldade, Elaborador_idElaborador, Tema_idTema) VALUES("Quem é a vocalista da banda Florence + The Machine?", "Florence", "LadyGaga", "Anitta", "Beyonce", "a", 1, 2, 1);
INSERT INTO Questao(descricao, altA, altB, altC, altD, altCerta, dificuldade, Elaborador_idElaborador, Tema_idTema) VALUES("Qual foi o album da Beyonce lançado em 2016?", "Beyonce", "Dance Fever", "Lemonade", "Ride the Lightining", "c", 1, 1, 1);
INSERT INTO Questao(descricao, altA, altB, altC, altD, altCerta, dificuldade, Elaborador_idElaborador, Tema_idTema) VALUES("O que significa a sigla POO?", "Programação Oitenta e Oito", "Programação Ornitorrinco de Oculos", "Programação Orientada a Objetos", "Programação Objetos Orientados", "c", 1, 3, 4);
INSERT INTO Questao(descricao, altA, altB, altC, altD, altCerta, dificuldade, Elaborador_idElaborador, Tema_idTema) VALUES("Desses conceitos, qual NÃO faz parte EXCLUSIVAMENTE da orientação a objetos?", "Threads", "Estruruação", "identação", "Uso de classes", "d", 1, 2, 4);
INSERT INTO Questao(descricao, altA, altB, altC, altD, altCerta, dificuldade, Elaborador_idElaborador, Tema_idTema) VALUES("Progamar um objeto consiste em: ", "Criar um programa multithread", "Definir uma classe que criará um objeto quando usada", "Usar estrutura de dados", "Criar banco de dados", "b",1, 1, 4);
INSERT INTO Questao(descricao, altA, altB, altC, altD, altCerta, dificuldade, Elaborador_idElaborador, Tema_idTema) VALUES("Em uma função de uma classe com retorno void: ", "O retorno é uma string", "O retorno é um inteiro", "O retorno é uma lista", "Não existe retorno", "d", 1, 2, 4);
INSERT INTO Questao(descricao, altA, altB, altC, altD, altCerta, dificuldade, Elaborador_idElaborador, Tema_idTema) VALUES("Quem escreveu Dom Casmurro?", "Machado de Assis", "Guilherme Medeiros", "Marcelo Sobral", "Diego Medeiros", "a", 1, 1, 3);
INSERT INTO Questao(descricao, altA, altB, altC, altD, altCerta, dificuldade, Elaborador_idElaborador, Tema_idTema) VALUES("Quem escreveu Metamorfose?", "Kafka", "Montesquier", "Marx", "Locke", "a", 2, 2, 3);
INSERT INTO Questao(descricao, altA, altB, altC, altD, altCerta, dificuldade, Elaborador_idElaborador, Tema_idTema) VALUES("Qual desses autores não escreveu ficção científica?", "Isaac Asimov", "Arthur C. Clark", "Philip K. Dick", "Bob Dylan", "d", 3, 3, 3);
INSERT INTO Questao(descricao, altA, altB, altC, altD, altCerta, dificuldade, Elaborador_idElaborador, Tema_idTema) VALUES("Qual dessas risadinhas da internet não foi criada por um brasileiro?", "rsrsrs", "hahahah", "psoakrpaoskaa", "lol", "d", 2, 3, 6);

-- Prova

INSERT INTO Prova(Gestor_idGestor) VALUES(1);
INSERT INTO Prova(Gestor_idGestor) VALUES(1);
INSERT INTO Prova(Gestor_idGestor) VALUES(2);
INSERT INTO Prova(Gestor_idGestor) VALUES(3);
INSERT INTO Prova(Gestor_idGestor) VALUES(4);

-- ProvaQuestao

INSERT INTO Prova_has_Questao(Prova_idProva, Questao_idQUestao) VALUES (1, 1);
INSERT INTO Prova_has_Questao(Prova_idProva, Questao_idQUestao) VALUES (1, 2);
INSERT INTO Prova_has_Questao(Prova_idProva, Questao_idQUestao) VALUES (2, 3);
INSERT INTO Prova_has_Questao(Prova_idProva, Questao_idQUestao) VALUES (2, 4);
INSERT INTO Prova_has_Questao(Prova_idProva, Questao_idQUestao) VALUES (2, 5);
INSERT INTO Prova_has_Questao(Prova_idProva, Questao_idQUestao) VALUES (2, 6);
INSERT INTO Prova_has_Questao(Prova_idProva, Questao_idQUestao) VALUES (3, 7);
INSERT INTO Prova_has_Questao(Prova_idProva, Questao_idQUestao) VALUES (3, 8);
INSERT INTO Prova_has_Questao(Prova_idProva, Questao_idQUestao) VALUES (3, 9);
INSERT INTO Prova_has_Questao(Prova_idProva, Questao_idQUestao) VALUES (4, 10);

-- Processo Seletivo

INSERT INTO ProcessoSeletivo(Gestor_idGestor, Prova_idProva) VALUES(1, 1);
INSERT INTO ProcessoSeletivo(Gestor_idGestor, Prova_idProva) VALUES(1, 2);
INSERT INTO ProcessoSeletivo(Gestor_idGestor, Prova_idProva) VALUES(2, 1);
INSERT INTO ProcessoSeletivo(Gestor_idGestor, Prova_idProva) VALUES(3, 4);

-- Processo Seletivo Candidato:

INSERT INTO ProcessoSeletivo_has_Candidato(ProcessoSeletivo_idProcessoSeletivo, Candidato_idCandidato) VALUES(1, 1);
INSERT INTO ProcessoSeletivo_has_Candidato(ProcessoSeletivo_idProcessoSeletivo, Candidato_idCandidato) VALUES(1, 2);
INSERT INTO ProcessoSeletivo_has_Candidato(ProcessoSeletivo_idProcessoSeletivo, Candidato_idCandidato) VALUES(1, 3);
INSERT INTO ProcessoSeletivo_has_Candidato(ProcessoSeletivo_idProcessoSeletivo, Candidato_idCandidato) VALUES(1, 4);
INSERT INTO ProcessoSeletivo_has_Candidato(ProcessoSeletivo_idProcessoSeletivo, Candidato_idCandidato) VALUES(3, 1);
INSERT INTO ProcessoSeletivo_has_Candidato(ProcessoSeletivo_idProcessoSeletivo, Candidato_idCandidato) VALUES(3, 2);
INSERT INTO ProcessoSeletivo_has_Candidato(ProcessoSeletivo_idProcessoSeletivo, Candidato_idCandidato) VALUES(3, 3);

-- Gabarito

INSERT INTO Gabarito(gabarito, ProcessoSeletivo_idProcessoSeletivo, Candidato_idCandidato) VALUES("a,b",1,1);
INSERT INTO Gabarito(gabarito, ProcessoSeletivo_idProcessoSeletivo, Candidato_idCandidato) VALUES("b,c",1,2);
INSERT INTO Gabarito(gabarito, ProcessoSeletivo_idProcessoSeletivo, Candidato_idCandidato) VALUES("a,c",1,3);