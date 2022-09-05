-- MySQL dump 10.13  Distrib 5.7.38, for Linux (x86_64)
--
-- Host: ampto.sj.ifsc.edu.br    Database: lab01guilherme
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Candidato`
--

DROP TABLE IF EXISTS `Candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Candidato` (
  `idCandidato` int NOT NULL,
  `senha` varchar(45) NOT NULL,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`idCandidato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Candidato`
--

LOCK TABLES `Candidato` WRITE;
/*!40000 ALTER TABLE `Candidato` DISABLE KEYS */;
INSERT INTO `Candidato` VALUES (1,'1234','guilherme'),(2,'bandodedados','emerson');
/*!40000 ALTER TABLE `Candidato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Elaborador`
--

DROP TABLE IF EXISTS `Elaborador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Elaborador` (
  `idElaborador` int NOT NULL,
  `senha` varchar(45) NOT NULL,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`idElaborador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Elaborador`
--

LOCK TABLES `Elaborador` WRITE;
/*!40000 ALTER TABLE `Elaborador` DISABLE KEYS */;
INSERT INTO `Elaborador` VALUES (1,'1234','Saul'),(2,'fusca','Diego');
/*!40000 ALTER TABLE `Elaborador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Gestor`
--

DROP TABLE IF EXISTS `Gestor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Gestor` (
  `idGestor` int NOT NULL,
  `nome` varchar(45) NOT NULL,
  `senha` varchar(45) NOT NULL,
  PRIMARY KEY (`idGestor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Gestor`
--

LOCK TABLES `Gestor` WRITE;
/*!40000 ALTER TABLE `Gestor` DISABLE KEYS */;
INSERT INTO `Gestor` VALUES (1,'casagrande','1234'),(2,'anitta','1234');
/*!40000 ALTER TABLE `Gestor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProcessoSeletivo`
--

DROP TABLE IF EXISTS `ProcessoSeletivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProcessoSeletivo` (
  `idProcessoSeletivo` int NOT NULL,
  `inicioInsc` date NOT NULL,
  `fimInsc` date NOT NULL,
  `dataProva` date NOT NULL,
  `inicioRecurso` date NOT NULL,
  `fimRecurso` date NOT NULL,
  `dataGabarito` date NOT NULL,
  `Gestor_idGestor` int NOT NULL,
  PRIMARY KEY (`idProcessoSeletivo`),
  KEY `fk_ProcessoSeletivo_Gestor1_idx` (`Gestor_idGestor`),
  CONSTRAINT `fk_ProcessoSeletivo_Gestor1` FOREIGN KEY (`Gestor_idGestor`) REFERENCES `Gestor` (`idGestor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProcessoSeletivo`
--

LOCK TABLES `ProcessoSeletivo` WRITE;
/*!40000 ALTER TABLE `ProcessoSeletivo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProcessoSeletivo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProcessoSeletivo_has_Candidato`
--

DROP TABLE IF EXISTS `ProcessoSeletivo_has_Candidato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProcessoSeletivo_has_Candidato` (
  `ProcessoSeletivo_idProcessoSeletivo` int NOT NULL,
  `Candidato_idCandidato` int NOT NULL,
  PRIMARY KEY (`ProcessoSeletivo_idProcessoSeletivo`,`Candidato_idCandidato`),
  KEY `fk_ProcessoSeletivo_has_Candidato_Candidato1_idx` (`Candidato_idCandidato`),
  KEY `fk_ProcessoSeletivo_has_Candidato_ProcessoSeletivo1_idx` (`ProcessoSeletivo_idProcessoSeletivo`),
  CONSTRAINT `fk_ProcessoSeletivo_has_Candidato_Candidato1` FOREIGN KEY (`Candidato_idCandidato`) REFERENCES `Candidato` (`idCandidato`),
  CONSTRAINT `fk_ProcessoSeletivo_has_Candidato_ProcessoSeletivo1` FOREIGN KEY (`ProcessoSeletivo_idProcessoSeletivo`) REFERENCES `ProcessoSeletivo` (`idProcessoSeletivo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProcessoSeletivo_has_Candidato`
--

LOCK TABLES `ProcessoSeletivo_has_Candidato` WRITE;
/*!40000 ALTER TABLE `ProcessoSeletivo_has_Candidato` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProcessoSeletivo_has_Candidato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prova`
--

DROP TABLE IF EXISTS `Prova`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prova` (
  `idProva` int NOT NULL,
  `Gestor_idGestor` int NOT NULL,
  PRIMARY KEY (`idProva`),
  KEY `fk_Prova_Gestor1_idx` (`Gestor_idGestor`),
  CONSTRAINT `fk_Prova_Gestor1` FOREIGN KEY (`Gestor_idGestor`) REFERENCES `Gestor` (`idGestor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prova`
--

LOCK TABLES `Prova` WRITE;
/*!40000 ALTER TABLE `Prova` DISABLE KEYS */;
/*!40000 ALTER TABLE `Prova` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prova_has_Questao`
--

DROP TABLE IF EXISTS `Prova_has_Questao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prova_has_Questao` (
  `Prova_idProva` int NOT NULL,
  `Questao_idQUestao` int NOT NULL,
  PRIMARY KEY (`Prova_idProva`,`Questao_idQUestao`),
  KEY `fk_Prova_has_Questao_Questao1_idx` (`Questao_idQUestao`),
  KEY `fk_Prova_has_Questao_Prova1_idx` (`Prova_idProva`),
  CONSTRAINT `fk_Prova_has_Questao_Prova1` FOREIGN KEY (`Prova_idProva`) REFERENCES `Prova` (`idProva`),
  CONSTRAINT `fk_Prova_has_Questao_Questao1` FOREIGN KEY (`Questao_idQUestao`) REFERENCES `Questao` (`idQUestao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prova_has_Questao`
--

LOCK TABLES `Prova_has_Questao` WRITE;
/*!40000 ALTER TABLE `Prova_has_Questao` DISABLE KEYS */;
/*!40000 ALTER TABLE `Prova_has_Questao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Questao`
--

DROP TABLE IF EXISTS `Questao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Questao` (
  `idQUestao` int NOT NULL,
  `descricao` varchar(500) NOT NULL,
  `altA` varchar(100) NOT NULL,
  `altB` varchar(100) NOT NULL,
  `altC` varchar(100) NOT NULL,
  `altD` varchar(100) NOT NULL,
  `altCerta` varchar(100) NOT NULL,
  `dificuldade` int NOT NULL,
  `Elaborador_idElaborador` int NOT NULL,
  `Tema_idTema` int NOT NULL,
  PRIMARY KEY (`idQUestao`),
  KEY `fk_Questao_Elaborador1_idx` (`Elaborador_idElaborador`),
  KEY `fk_Questao_Tema1_idx` (`Tema_idTema`),
  CONSTRAINT `fk_Questao_Elaborador1` FOREIGN KEY (`Elaborador_idElaborador`) REFERENCES `Elaborador` (`idElaborador`),
  CONSTRAINT `fk_Questao_Tema1` FOREIGN KEY (`Tema_idTema`) REFERENCES `Tema` (`idTema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Questao`
--

LOCK TABLES `Questao` WRITE;
/*!40000 ALTER TABLE `Questao` DISABLE KEYS */;
/*!40000 ALTER TABLE `Questao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RecursoCandidatoQuestao`
--

DROP TABLE IF EXISTS `RecursoCandidatoQuestao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RecursoCandidatoQuestao` (
  `Candidato_idCandidato` int NOT NULL,
  `Questao_idQUestao` int NOT NULL,
  `data` date NOT NULL,
  PRIMARY KEY (`Candidato_idCandidato`,`Questao_idQUestao`),
  KEY `fk_Candidato_has_Questao_Questao1_idx` (`Questao_idQUestao`),
  KEY `fk_Candidato_has_Questao_Candidato1_idx` (`Candidato_idCandidato`),
  CONSTRAINT `fk_Candidato_has_Questao_Candidato1` FOREIGN KEY (`Candidato_idCandidato`) REFERENCES `Candidato` (`idCandidato`),
  CONSTRAINT `fk_Candidato_has_Questao_Questao1` FOREIGN KEY (`Questao_idQUestao`) REFERENCES `Questao` (`idQUestao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RecursoCandidatoQuestao`
--

LOCK TABLES `RecursoCandidatoQuestao` WRITE;
/*!40000 ALTER TABLE `RecursoCandidatoQuestao` DISABLE KEYS */;
/*!40000 ALTER TABLE `RecursoCandidatoQuestao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tema`
--

DROP TABLE IF EXISTS `Tema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tema` (
  `idTema` int NOT NULL,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`idTema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tema`
--

LOCK TABLES `Tema` WRITE;
/*!40000 ALTER TABLE `Tema` DISABLE KEYS */;
/*!40000 ALTER TABLE `Tema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TemaElaborador`
--

DROP TABLE IF EXISTS `TemaElaborador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TemaElaborador` (
  `Elaborador_idElaborador` int NOT NULL,
  `Tema_idTema` int NOT NULL,
  PRIMARY KEY (`Elaborador_idElaborador`,`Tema_idTema`),
  KEY `fk_Elaborador_has_Tema_Tema1_idx` (`Tema_idTema`),
  KEY `fk_Elaborador_has_Tema_Elaborador_idx` (`Elaborador_idElaborador`),
  CONSTRAINT `fk_Elaborador_has_Tema_Elaborador` FOREIGN KEY (`Elaborador_idElaborador`) REFERENCES `Elaborador` (`idElaborador`),
  CONSTRAINT `fk_Elaborador_has_Tema_Tema1` FOREIGN KEY (`Tema_idTema`) REFERENCES `Tema` (`idTema`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TemaElaborador`
--

LOCK TABLES `TemaElaborador` WRITE;
/*!40000 ALTER TABLE `TemaElaborador` DISABLE KEYS */;
/*!40000 ALTER TABLE `TemaElaborador` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-17 13:59:20
