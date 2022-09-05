
-- ADICIONAR AQUI O ESQUEMA A SER UTILIZADO ------------

--========================================================== INSTRUÇÕES DDL: ------------------=======================================================================================


-- -----------------------------------------------------
-- Table `Candidato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Candidato` (
  `idCandidato` INT NOT NULL AUTO_INCREMENT,
  `senha` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCandidato`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Elaborador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Elaborador` (
  `idElaborador` INT NOT NULL AUTO_INCREMENT,
  `senha` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idElaborador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gestor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gestor` (
  `idGestor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGestor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tema`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tema` (
  `idTema` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTema`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TemaElaborador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TemaElaborador` (
  `Elaborador_idElaborador` INT NOT NULL,
  `Tema_idTema` INT NOT NULL,
  PRIMARY KEY (`Elaborador_idElaborador`, `Tema_idTema`),
  INDEX `fk_Elaborador_has_Tema_Tema1_idx` (`Tema_idTema` ASC),
  INDEX `fk_Elaborador_has_Tema_Elaborador_idx` (`Elaborador_idElaborador` ASC),
  CONSTRAINT `fk_Elaborador_has_Tema_Elaborador`
    FOREIGN KEY (`Elaborador_idElaborador`)
    REFERENCES `Elaborador` (`idElaborador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Elaborador_has_Tema_Tema1`
    FOREIGN KEY (`Tema_idTema`)
    REFERENCES `Tema` (`idTema`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Questao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Questao` (
  `idQUestao` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(500) NOT NULL,
  `altA` VARCHAR(100) NOT NULL,
  `altB` VARCHAR(100) NOT NULL,
  `altC` VARCHAR(100) NOT NULL,
  `altD` VARCHAR(100) NOT NULL,
  `altCerta` VARCHAR(100) NOT NULL,
  `dificuldade` INT NOT NULL,
  `Elaborador_idElaborador` INT NOT NULL,
  `Tema_idTema` INT NOT NULL,
  PRIMARY KEY (`idQUestao`),
  INDEX `fk_Questao_Elaborador1_idx` (`Elaborador_idElaborador` ASC),
  INDEX `fk_Questao_Tema1_idx` (`Tema_idTema` ASC),
  CONSTRAINT `fk_Questao_Elaborador1`
    FOREIGN KEY (`Elaborador_idElaborador`)
    REFERENCES `Elaborador` (`idElaborador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Questao_Tema1`
    FOREIGN KEY (`Tema_idTema`)
    REFERENCES `Tema` (`idTema`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RecursoCandidatoQuestao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RecursoCandidatoQuestao` (
  `Candidato_idCandidato` INT NOT NULL,
  `Questao_idQUestao` INT NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`Candidato_idCandidato`, `Questao_idQUestao`),
  INDEX `fk_Candidato_has_Questao_Questao1_idx` (`Questao_idQUestao` ASC),
  INDEX `fk_Candidato_has_Questao_Candidato1_idx` (`Candidato_idCandidato` ASC),
  CONSTRAINT `fk_Candidato_has_Questao_Candidato1`
    FOREIGN KEY (`Candidato_idCandidato`)
    REFERENCES `Candidato` (`idCandidato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Candidato_has_Questao_Questao1`
    FOREIGN KEY (`Questao_idQUestao`)
    REFERENCES `Questao` (`idQUestao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prova`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prova` (
  `idProva` INT NOT NULL AUTO_INCREMENT AUTO_INCREMENT,
  `Gestor_idGestor` INT NOT NULL,
  PRIMARY KEY (`idProva`),
  INDEX `fk_Prova_Gestor1_idx` (`Gestor_idGestor` ASC),
  CONSTRAINT `fk_Prova_Gestor1`
    FOREIGN KEY (`Gestor_idGestor`)
    REFERENCES `Gestor` (`idGestor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prova_has_Questao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Prova_has_Questao` (
  `Prova_idProva` INT NOT NULL,
  `Questao_idQUestao` INT NOT NULL,
  PRIMARY KEY (`Prova_idProva`, `Questao_idQUestao`),
  INDEX `fk_Prova_has_Questao_Questao1_idx` (`Questao_idQUestao` ASC),
  INDEX `fk_Prova_has_Questao_Prova1_idx` (`Prova_idProva` ASC),
  CONSTRAINT `fk_Prova_has_Questao_Prova1`
    FOREIGN KEY (`Prova_idProva`)
    REFERENCES `Prova` (`idProva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prova_has_Questao_Questao1`
    FOREIGN KEY (`Questao_idQUestao`)
    REFERENCES `Questao` (`idQUestao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProcessoSeletivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProcessoSeletivo` (
  `idProcessoSeletivo` INT NOT NULL AUTO_INCREMENT,
  `Gestor_idGestor` INT NOT NULL,
  `Prova_idProva` INT NOT NULL,
  PRIMARY KEY (`idProcessoSeletivo`),
  INDEX `fk_ProcessoSeletivo_Gestor1_idx` (`Gestor_idGestor` ASC),
  INDEX `fk_ProcessoSeletivo_Prova1_idx` (`Prova_idProva` ASC),
  CONSTRAINT `fk_ProcessoSeletivo_Gestor1`
    FOREIGN KEY (`Gestor_idGestor`)
    REFERENCES `Gestor` (`idGestor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProcessoSeletivo_Prova1`
    FOREIGN KEY (`Prova_idProva`)
    REFERENCES `Prova` (`idProva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProcessoSeletivo_has_Candidato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProcessoSeletivo_has_Candidato` (
  `ProcessoSeletivo_idProcessoSeletivo` INT NOT NULL,
  `Candidato_idCandidato` INT NOT NULL,
  PRIMARY KEY (`ProcessoSeletivo_idProcessoSeletivo`, `Candidato_idCandidato`),
  INDEX `fk_ProcessoSeletivo_has_Candidato_Candidato1_idx` (`Candidato_idCandidato` ASC),
  INDEX `fk_ProcessoSeletivo_has_Candidato_ProcessoSeletivo1_idx` (`ProcessoSeletivo_idProcessoSeletivo` ASC),
  CONSTRAINT `fk_ProcessoSeletivo_has_Candidato_ProcessoSeletivo1`
    FOREIGN KEY (`ProcessoSeletivo_idProcessoSeletivo`)
    REFERENCES `ProcessoSeletivo` (`idProcessoSeletivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProcessoSeletivo_has_Candidato_Candidato1`
    FOREIGN KEY (`Candidato_idCandidato`)
    REFERENCES `Candidato` (`idCandidato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gabarito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gabarito` (
  `idGabarito` INT NOT NULL AUTO_INCREMENT,
  `gabarito` VARCHAR(45) NOT NULL,
  `Candidato_idCandidato` INT NOT NULL,
  `ProcessoSeletivo_idProcessoSeletivo` INT NOT NULL,
  PRIMARY KEY (`idGabarito`),
  INDEX `fk_Gabarito_Candidato1_idx` (`Candidato_idCandidato` ASC),
  INDEX `fk_Gabarito_ProcessoSeletivo1_idx` (`ProcessoSeletivo_idProcessoSeletivo` ASC),
  CONSTRAINT `fk_Gabarito_Candidato1`
    FOREIGN KEY (`Candidato_idCandidato`)
    REFERENCES `Candidato` (`idCandidato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gabarito_ProcessoSeletivo1`
    FOREIGN KEY (`ProcessoSeletivo_idProcessoSeletivo`)
    REFERENCES `ProcessoSeletivo` (`idProcessoSeletivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

--========================================================== INSTRUÇÕES DML: ------------------=======================================================================================


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