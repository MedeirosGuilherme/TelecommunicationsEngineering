-- -----------------------------------------------------
-- Schema pp01guilherme
-- -----------------------------------------------------

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
