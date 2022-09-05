-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: banco
-- ------------------------------------------------------
-- Server version	5.7.17

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
-- Table structure for table `Agencia`
--

DROP TABLE IF EXISTS `Agencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Agencia` (
  `idAgencia` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  PRIMARY KEY (`idAgencia`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Agencia`
--

LOCK TABLES `Agencia` WRITE;
/*!40000 ALTER TABLE `Agencia` DISABLE KEYS */;
INSERT INTO `Agencia` VALUES (1,'Praia comprida','São José'),(2,'Centro','Florianópolis'),(3,'Bela Vista','Palhoça'),(4,'Kobrasol','São José'),(5,'Centro','Chapecó'),(6,'Coqueiros','Florianópolis'),(7,'Centro','Palhoça');
/*!40000 ALTER TABLE `Agencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Conta`
--

DROP TABLE IF EXISTS `Conta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Conta` (
  `idConta` int(11) NOT NULL,
  `saldo` double NOT NULL,
  `idAgencia` int(11) NOT NULL,
  PRIMARY KEY (`idConta`),
  KEY `fk_Conta_Agencia1_idx` (`idAgencia`),
  CONSTRAINT `fk_Conta_Agencia1` FOREIGN KEY (`idAgencia`) REFERENCES `Agencia` (`idAgencia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Conta`
--

LOCK TABLES `Conta` WRITE;
/*!40000 ALTER TABLE `Conta` DISABLE KEYS */;
INSERT INTO `Conta` VALUES (521,1000,4),(20831,1200,1),(70321,200,6),(70411,450,2),(70611,500,6),(70711,880,1),(81021,10000,3),(90811,15000,5);
/*!40000 ALTER TABLE `Conta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Correntista`
--

DROP TABLE IF EXISTS `Correntista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Correntista` (
  `idConta` int(11) NOT NULL,
  `idPessoa` int(11) NOT NULL,
  PRIMARY KEY (`idConta`,`idPessoa`),
  KEY `fk_Conta_has_Cliente_Cliente1_idx` (`idPessoa`),
  KEY `fk_Conta_has_Cliente_Conta1_idx` (`idConta`),
  CONSTRAINT `fk_Conta_has_Cliente_Conta1` FOREIGN KEY (`idConta`) REFERENCES `Conta` (`idConta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Conta_Cliente1` FOREIGN KEY (`idPessoa`) REFERENCES `Pessoa` (`idPessoa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Correntista`
--

LOCK TABLES `Correntista` WRITE;
/*!40000 ALTER TABLE `Correntista` DISABLE KEYS */;
INSERT INTO `Correntista` VALUES (70711,4),(20831,8),(70411,12),(20831,16),(70711,20),(81021,24),(70611,28),(70611,32),(70611,36),(70321,40),(90811,44),(521,48);
/*!40000 ALTER TABLE `Correntista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Emprestimo`
--

DROP TABLE IF EXISTS `Emprestimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Emprestimo` (
  `idEmprestimo` int(11) NOT NULL AUTO_INCREMENT,
  `valor` double DEFAULT NULL,
  `idAgencia` int(11) NOT NULL,
  PRIMARY KEY (`idEmprestimo`),
  KEY `fk_Emprestimo_Agencia1_idx` (`idAgencia`),
  CONSTRAINT `fk_Emprestimo_Agencia1` FOREIGN KEY (`idAgencia`) REFERENCES `Agencia` (`idAgencia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Emprestimo`
--

LOCK TABLES `Emprestimo` WRITE;
/*!40000 ALTER TABLE `Emprestimo` DISABLE KEYS */;
INSERT INTO `Emprestimo` VALUES (1,NULL,1),(2,NULL,2),(3,1000,1),(4,2000,3),(5,500,1),(6,1000,2),(7,4000,3);
/*!40000 ALTER TABLE `Emprestimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mutuario`
--

DROP TABLE IF EXISTS `Mutuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Mutuario` (
  `idEmprestimo` int(11) NOT NULL,
  `idPessoa` int(11) NOT NULL,
  PRIMARY KEY (`idEmprestimo`,`idPessoa`),
  KEY `fk_Emprestimo_has_Cliente_Cliente1_idx` (`idPessoa`),
  KEY `fk_Emprestimo_has_Cliente_Emprestimo1_idx` (`idEmprestimo`),
  CONSTRAINT `fk_Emprestimo_has_Cliente_Cliente1` FOREIGN KEY (`idPessoa`) REFERENCES `Pessoa` (`idPessoa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Emprestimo_has_Cliente_Emprestimo1` FOREIGN KEY (`idEmprestimo`) REFERENCES `Emprestimo` (`idEmprestimo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mutuario`
--

LOCK TABLES `Mutuario` WRITE;
/*!40000 ALTER TABLE `Mutuario` DISABLE KEYS */;
INSERT INTO `Mutuario` VALUES (3,8),(6,16),(2,24),(5,32),(1,40),(7,40),(4,48);
/*!40000 ALTER TABLE `Mutuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pessoa`
--

DROP TABLE IF EXISTS `Pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pessoa` (
  `idPessoa` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `CPF` varchar(45) NOT NULL,
  PRIMARY KEY (`idPessoa`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pessoa`
--

LOCK TABLES `Pessoa` WRITE;
/*!40000 ALTER TABLE `Pessoa` DISABLE KEYS */;
INSERT INTO `Pessoa` VALUES (1,'ZAMBI MARTINS ATAIDE','40208311233'),(2,'JOAO ADELSON KIRCHNER NETO','40207211222'),(3,'OLAVIO JEFFERSON PETERNI DE SOUZA','40208311244'),(4,'AMILCAR JOEL SIMM','20707112320'),(5,'JULIA DOS SILVA CORREA','20704112226'),(6,'JULIO KACHNIACZ','20704111117'),(7,'GIOVANNI SALVATORE DE CESETA SANTOS','20707111015'),(8,'EDNIR PEREIRA DE SANTOS NAZARIO','40208311015'),(9,'JOAO ROSENBAE LEMOS JACINTO','40208311117'),(10,'VALMIR DA CUIA DE COSTA','20707119997'),(11,'BRUNA DA SILVEIRA','20707119895'),(12,'MARCUS JULIO NETO','20704119793'),(13,'ALFREDO JOSEFINO PEREIRA DA PEREIRA','20706119782'),(14,'MARIA MOEE SILVEIRA','20706119771'),(15,'SILVIA JOSÉ DE CUNHA','40207219760'),(16,'LIDIANE VERONICA FRAGA','40208319757'),(17,'ROSINEI FABRICIO PEDROSO','40208319760'),(18,'MARIA PORTO','40208319757'),(19,'JULIO JOAO HAMES','20707113451'),(20,'JOSEFINO SANTOS D AVILA NETO','20707113462'),(21,'GENESIO ATAIDE PEDROSO','40208313473'),(22,'SARA CARNEIRO PRIESST PEREIRA','40207213484'),(23,'FERNANDO PATRICIO NETO','40207213495'),(24,'CRISTINA SILVA SILVEIRA','29810213506'),(25,'KATIA SILVA SILVEIRA','29810213517'),(26,'LEONAN DA PEREIRA SANTOS','29010213520'),(27,'CARLOS HENRIQUE ATAIDE DA PEREIRA','29010113531'),(28,'VALDO RICKES PELOSO','20706113542'),(29,'EZEQUIEL JULIO NOVAES PEREIRA','20706113553'),(30,'ERNANI ATAIDE DE S.CARLOS','29810213611'),(31,'MARIO JULIO BUNN','29010113622'),(32,'RAMON JOSEFINO ALVES','20706113633'),(33,'GULIVER JABOSKI ATAIDE','60807213644'),(34,'LEANDRO OLIVEIRA PEREIRA','20706113655'),(35,'AIRTON DANTAS FERNANDES','20706113666'),(36,'ROSIVAN DA CUIA','20706114124'),(37,'AIRTON FERREIRA BROEE','29010214135'),(38,'GULIVER VETTE','29005214146'),(39,'GIOVANI LOPES DE OLIVEIRA','20706114157'),(40,'GULIVER FLORES MIGUEL','20703214160'),(41,'PAOLA PERES ARRIGONI','29810214171'),(42,'GULIVER EVANGELISTA DE ALBUQUERQUE','29010114182'),(43,'VICTOR CESCONETTO DE PIERI','29002114193'),(44,'MARCOS PETRY DA PEREIRA','60908114204'),(45,'ROSEMIRO GOMES DE FARIAS','29810214215'),(46,'MARIANA LUIZA','29810214226'),(47,'MAICON COSTA DOS SILVA','29789114237'),(48,'ANDERSON DEMETRIO PLACIDO','29005214240'),(49,'TIAGO TEIXEIRA','29010217655'),(50,'EVALEIA JULIANA CARLO','40207215553');
/*!40000 ALTER TABLE `Pessoa` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-01  1:26:45
