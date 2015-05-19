-- MySQL dump 10.13  Distrib 5.5.38, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: obelixdb
-- ------------------------------------------------------
-- Server version	5.5.38-0+wheezy1

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add log entry',7,'add_logentry'),(20,'Can change log entry',7,'change_logentry'),(21,'Can delete log entry',7,'delete_logentry'),(22,'Can add corso',8,'add_corso'),(23,'Can change corso',8,'change_corso'),(24,'Can delete corso',8,'delete_corso'),(25,'Can add studente',9,'add_studente'),(26,'Can change studente',9,'change_studente'),(27,'Can delete studente',9,'delete_studente'),(28,'Can add insegnamento',10,'add_insegnamento'),(29,'Can change insegnamento',10,'change_insegnamento'),(30,'Can delete insegnamento',10,'delete_insegnamento'),(31,'Can add user profile',11,'add_userprofile'),(32,'Can change user profile',11,'change_userprofile'),(33,'Can delete user profile',11,'delete_userprofile'),(34,'Can add notifica',12,'add_notifica'),(35,'Can change notifica',12,'change_notifica'),(36,'Can delete notifica',12,'delete_notifica'),(37,'Can add dispensa',13,'add_dispensa'),(38,'Can change dispensa',13,'change_dispensa'),(39,'Can delete dispensa',13,'delete_dispensa'),(40,'Can add opinione',14,'add_opinione'),(41,'Can change opinione',14,'change_opinione'),(42,'Can delete opinione',14,'delete_opinione'),(43,'Can add commentarium',15,'add_commentarium'),(44,'Can change commentarium',15,'change_commentarium'),(45,'Can delete commentarium',15,'delete_commentarium'),(46,'Can add segnalazione',16,'add_segnalazione'),(47,'Can change segnalazione',16,'change_segnalazione'),(48,'Can delete segnalazione',16,'delete_segnalazione'),(49,'Can add bannato',17,'add_bannato'),(50,'Can change bannato',17,'change_bannato'),(51,'Can delete bannato',17,'delete_bannato');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$10000$xjeM72vKWAWz$hmmKMtaJWz9+ATZk3xkyN6OxcSdRj5/WO8QNuQmUduw=','2015-05-19 08:41:47',1,'obelix','','','obelix.fim@gmail.com',1,1,'2015-05-19 08:40:34');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`),
  CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispense_bannato`
--

DROP TABLE IF EXISTS `dispense_bannato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispense_bannato` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_profile_id` int(11) NOT NULL,
  `motivazione` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dispense_bannato_82936d91` (`user_profile_id`),
  CONSTRAINT `user_profile_id_refs_id_bb969ab8` FOREIGN KEY (`user_profile_id`) REFERENCES `dispense_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispense_bannato`
--

LOCK TABLES `dispense_bannato` WRITE;
/*!40000 ALTER TABLE `dispense_bannato` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispense_bannato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispense_commentarium`
--

DROP TABLE IF EXISTS `dispense_commentarium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispense_commentarium` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utente_id` int(11) NOT NULL,
  `dispensa_id` int(11) NOT NULL,
  `commento` longtext NOT NULL,
  `data_pub` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dispense_commentarium_b2400c30` (`utente_id`),
  KEY `dispense_commentarium_aba965bd` (`dispensa_id`),
  CONSTRAINT `utente_id_refs_id_13828653` FOREIGN KEY (`utente_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `dispensa_id_refs_id_bc5b3465` FOREIGN KEY (`dispensa_id`) REFERENCES `dispense_dispensa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispense_commentarium`
--

LOCK TABLES `dispense_commentarium` WRITE;
/*!40000 ALTER TABLE `dispense_commentarium` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispense_commentarium` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispense_corso`
--

DROP TABLE IF EXISTS `dispense_corso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispense_corso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titolo` varchar(20) NOT NULL,
  `descrizione` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispense_corso`
--

LOCK TABLES `dispense_corso` WRITE;
/*!40000 ALTER TABLE `dispense_corso` DISABLE KEYS */;
INSERT INTO `dispense_corso` VALUES (1,'LT-Fisica','Materiale per il corso di laurea triennale in fisica.'),(2,'LT-Informatica','Materiale per il corso di laurea triennale in informatica.'),(3,'LT-Matematica','Materiale per il corso di laurea triennale in matematica.'),(4,'LM-Fisica','Materiale per il corso di laurea magistrale in fisica.'),(5,'LM-Matematica','Materiale per il corso di laurea magistrale in matematica.');
/*!40000 ALTER TABLE `dispense_corso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispense_dispensa`
--

DROP TABLE IF EXISTS `dispense_dispensa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispense_dispensa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `insegnamento_id` int(11) NOT NULL,
  `utente_id` int(11) NOT NULL,
  `titolo` varchar(100) NOT NULL,
  `descrizione` longtext NOT NULL,
  `data_pub` datetime NOT NULL,
  `documento` varchar(100) NOT NULL,
  `mi_piace` int(10) unsigned NOT NULL,
  `non_mi_piace` int(10) unsigned NOT NULL,
  `notifica_id` int(11) NOT NULL,
  `num_com` int(11) NOT NULL,
  `eliminabile` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notifica_id` (`notifica_id`),
  KEY `dispense_dispensa_b7033388` (`insegnamento_id`),
  KEY `dispense_dispensa_b2400c30` (`utente_id`),
  CONSTRAINT `utente_id_refs_id_7867b37b` FOREIGN KEY (`utente_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `insegnamento_id_refs_id_34d3a700` FOREIGN KEY (`insegnamento_id`) REFERENCES `dispense_insegnamento` (`id`),
  CONSTRAINT `notifica_id_refs_id_5cf25d33` FOREIGN KEY (`notifica_id`) REFERENCES `dispense_notifica` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispense_dispensa`
--

LOCK TABLES `dispense_dispensa` WRITE;
/*!40000 ALTER TABLE `dispense_dispensa` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispense_dispensa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispense_insegnamento`
--

DROP TABLE IF EXISTS `dispense_insegnamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispense_insegnamento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titolo` varchar(100) NOT NULL,
  `corso_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dispense_insegnamento_52e431c0` (`corso_id`),
  CONSTRAINT `corso_id_refs_id_e08bec98` FOREIGN KEY (`corso_id`) REFERENCES `dispense_corso` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispense_insegnamento`
--

LOCK TABLES `dispense_insegnamento` WRITE;
/*!40000 ALTER TABLE `dispense_insegnamento` DISABLE KEYS */;
INSERT INTO `dispense_insegnamento` VALUES (1,'Analisi dei dati meteoclimatici',1),(2,'Analisi matematica',1),(3,'Chimica',1),(4,'Complementi di analisi matematica',1),(5,'Fisica dell\'atmosfera',1),(6,'Fisica dello stato solido',1),(7,'Fisica generale I',1),(8,'Fisica generale II',1),(9,'Fisica generale III',1),(10,'Fondamenti di programmazione e calcolo numerico',1),(11,'Geometria',1),(12,'Informatica di base e applicazioni scientifiche',1),(13,'Istituzioni di struttura della materia',1),(14,'Laboratorio di fisica I',1),(15,'Laboratorio di fisica II',1),(16,'Inglese',1),(17,'Meccanica analitica',1),(18,'Meccanica quantistica',1),(19,'Metodi matematici per la fisica',1),(20,'Spettroscopia',1),(21,'Termodinamica e fluidi',1),(22,'Termodinamica statistica',1),(23,'Algebra lineare',2),(24,'Algoritmi e strutture dati',2),(25,'Analisi matematica I',2),(26,'Analisi matematica II',2),(27,'Apprendimento ed evoluzione in sistemi artificiali',2),(28,'Architettura dei calcolatori',2),(29,'Basi di dati',2),(30,'Calcolo numerico',2),(31,'Calcolo parallelo',2),(32,'Elaborazione degli elementi in chimica',2),(33,'Fisica',2),(34,'Geometria',2),(35,'Gestione avanzata dell\'informazione',2),(36,'Inglese',2),(37,'Linguaggi dinamici',2),(38,'Linguaggi formali e compilazione',2),(39,'Metodi di ottimizzazione per la logistica',2),(40,'Progetto del software',2),(41,'Programmazione I',2),(42,'Programmazione II',2),(43,'Programmazione a oggetti',2),(44,'Protocolli ed architetture di rete',2),(45,'Sistemi operativi',2),(46,'Statistica ed elementi di probabilita\'',2),(47,'Algebra A',3),(48,'Algebra B',3),(49,'Algebra lineare',3),(50,'Algoritmi e strutture dati',3),(51,'Analisi matematica I',3),(52,'Analisi matematica II',3),(53,'Analisi matematica A',3),(54,'Analisi numerica A',3),(55,'Calcolo numerico',3),(56,'Catene di Markov',3),(57,'Fisica A',3),(58,'Fisica B',3),(59,'Fisica matematica A',3),(60,'Fisica matematica B',3),(61,'Fondamenti di matematica I',3),(62,'Geometria',3),(63,'Geometria B',3),(64,'Geometria delle curve',3),(65,'Informatica di base e applicazioni scientifiche',3),(66,'Informatica generale',3),(67,'Laboratorio di fisica I',3),(68,'Linguaggi formali e compilazione',3),(69,'Inglese',3),(70,'Ottimizzazione numerica',3),(71,'Probabilita\' e statistica',3),(72,'Programmazione II',3),(73,'Teoria della misura',3),(74,'Termodinamica e fluidi',3),(75,'Topologia algebrica',3),(76,'Chimica fisica delle biomolecole',4),(77,'Elettronica e acquisizione dati',4),(78,'Fabbricazione e caratterizzazione di nanostrutture',4),(79,'Fisica dei semiconduttori',4),(80,'Fisica dei sistemi biologi',4),(81,'Fisica della materia condensata I',4),(82,'Fisica della materia condensata II',4),(83,'Fisica delle transizioni di fase',4),(84,'Fisica teorica applicata',4),(85,'Fondamenti di nanoscienze',4),(86,'Istituzioni di fisica teorica',4),(87,'Laboratorio di fisica moderna',4),(88,'Meccanica quantistica moderna',4),(89,'Meccanica statistica e processi stocastici',4),(90,'Scoperte scientifiche e societa\'',4),(91,'Sensori ed attuatori',4),(92,'Teoria classica dei campi e relativita\'',4),(93,'Teoria quantisitica dei campi',4),(94,'Teoria quantistica dei sistemi a molti corpi',4),(95,'Algebra e teoria dei codici',5),(96,'Algoritmi di approssimazione',5),(97,'Analisi superiore',5),(98,'Calcolo delle variazioni',5),(99,'Calcolo parallelo',5),(100,'Didattica della matematica',5),(101,'Equazioni alle derivate parziali',5),(102,'Fondamenti di matematica II',5),(103,'Geometria combinatoria',5),(104,'Laboratorio di fisica computazionale',5),(105,'Matematiche elementari da un punto di vista superiore',5),(106,'Meccanica statistica e sistemi dinamici',5),(107,'Metodi matematici della meccanica quantistica',5),(108,'Metodi numerici',5),(109,'Metodi probabilistici',5),(110,'Processi stocastici',5),(111,'Sistemi complessi',5),(112,'Strutture algebriche',5);
/*!40000 ALTER TABLE `dispense_insegnamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispense_notifica`
--

DROP TABLE IF EXISTS `dispense_notifica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispense_notifica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `controllo` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispense_notifica`
--

LOCK TABLES `dispense_notifica` WRITE;
/*!40000 ALTER TABLE `dispense_notifica` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispense_notifica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispense_notifica_destinatari`
--

DROP TABLE IF EXISTS `dispense_notifica_destinatari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispense_notifica_destinatari` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notifica_id` int(11) NOT NULL,
  `userprofile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notifica_id` (`notifica_id`,`userprofile_id`),
  KEY `dispense_notifica_destinatari_08368e5f` (`notifica_id`),
  KEY `dispense_notifica_destinatari_1be1924f` (`userprofile_id`),
  CONSTRAINT `notifica_id_refs_id_f610a274` FOREIGN KEY (`notifica_id`) REFERENCES `dispense_notifica` (`id`),
  CONSTRAINT `userprofile_id_refs_id_c6c3bb49` FOREIGN KEY (`userprofile_id`) REFERENCES `dispense_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispense_notifica_destinatari`
--

LOCK TABLES `dispense_notifica_destinatari` WRITE;
/*!40000 ALTER TABLE `dispense_notifica_destinatari` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispense_notifica_destinatari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispense_opinione`
--

DROP TABLE IF EXISTS `dispense_opinione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispense_opinione` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utente_id` int(11) NOT NULL,
  `dispensa_id` int(11) NOT NULL,
  `positiva` tinyint(1) NOT NULL,
  `negativa` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dispense_opinione_b2400c30` (`utente_id`),
  KEY `dispense_opinione_aba965bd` (`dispensa_id`),
  CONSTRAINT `utente_id_refs_id_78ea025e` FOREIGN KEY (`utente_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `dispensa_id_refs_id_95058a2f` FOREIGN KEY (`dispensa_id`) REFERENCES `dispense_dispensa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispense_opinione`
--

LOCK TABLES `dispense_opinione` WRITE;
/*!40000 ALTER TABLE `dispense_opinione` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispense_opinione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispense_segnalazione`
--

DROP TABLE IF EXISTS `dispense_segnalazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispense_segnalazione` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accusatore_id` int(11) NOT NULL,
  `dispensa_id` int(11) NOT NULL,
  `motivazione` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dispense_segnalazione_0e134228` (`accusatore_id`),
  KEY `dispense_segnalazione_aba965bd` (`dispensa_id`),
  CONSTRAINT `dispensa_id_refs_id_3a5a4847` FOREIGN KEY (`dispensa_id`) REFERENCES `dispense_dispensa` (`id`),
  CONSTRAINT `accusatore_id_refs_id_6ef3f631` FOREIGN KEY (`accusatore_id`) REFERENCES `dispense_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispense_segnalazione`
--

LOCK TABLES `dispense_segnalazione` WRITE;
/*!40000 ALTER TABLE `dispense_segnalazione` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispense_segnalazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispense_studente`
--

DROP TABLE IF EXISTS `dispense_studente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispense_studente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(70) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=949 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispense_studente`
--

LOCK TABLES `dispense_studente` WRITE;
/*!40000 ALTER TABLE `dispense_studente` DISABLE KEYS */;
INSERT INTO `dispense_studente` VALUES (1,'DAVIDE','DALLE AVE','30073@studenti.unimore.it'),(2,'EUGENIO','BRUSONI','34001@studenti.unimore.it'),(3,'MICHELE','FONTANINI','32542@studenti.unimore.it'),(4,'MORENO','DAOLIO','22008@studenti.unimore.it'),(5,'SIMONE','FERRARI','23098@studenti.unimore.it'),(6,'LORENZO','GIOVANARDI','23845@studenti.unimore.it'),(7,'DANIELA','GRASSO','44121@studenti.unimore.it'),(8,'ALBERTO','ROSSI','58063@studenti.unimore.it'),(9,'VINCENZO','SOLOMITA','37615@studenti.unimore.it'),(10,'ENZO','CANOSSA','7646@studenti.unimore.it'),(11,'PASQUALE','SINOPOLI','58294@studenti.unimore.it'),(12,'LUDOVICO','IACONIANNI','63346@studenti.unimore.it'),(13,'DENIS','VIGNUDELLI','39270@studenti.unimore.it'),(14,'VERONICA','ROTOLO','58080@studenti.unimore.it'),(15,'GIOVANNI','RICCI','65648@studenti.unimore.it'),(16,'MARCO','ROSCIANI','65786@studenti.unimore.it'),(17,'GIOVANNI','RINALDI','67401@studenti.unimore.it'),(18,'ALBERTO','ARTIOLI','76161@studenti.unimore.it'),(19,'GREGORIO','RAGAZZINI','81788@studenti.unimore.it'),(20,'GEMMA','GHELFI','45757@studenti.unimore.it'),(21,'CRISTIANO','BULGARI','48733@studenti.unimore.it'),(22,'FULVIA','VENTURI','71605@studenti.unimore.it'),(23,'GIULIO','PANISI','72922@studenti.unimore.it'),(24,'ALBERTO MARIA','SUFFRITTI','73397@studenti.unimore.it'),(25,'FRANCO','LOMBARDINI','74751@studenti.unimore.it'),(26,'FRANCESCO','VILLANI','77826@studenti.unimore.it'),(27,'FRANCESCO','CASOLARI','78120@studenti.unimore.it'),(28,'DIEGO','DAVOLI','78380@studenti.unimore.it'),(29,'GIACOMO','VISCONTI PRASCA','80738@studenti.unimore.it'),(30,'MARCELLO','IOTTI','82292@studenti.unimore.it'),(31,'TOMMASO','PINCELLI','71221@studenti.unimore.it'),(32,'FEDERICO','MONGIARDO','55052@studenti.unimore.it'),(33,'ROSETTA','CORDONE','56949@studenti.unimore.it'),(34,'GIORGIO','CALZOLARO','58690@studenti.unimore.it'),(35,'MATTIA','FANTINI','61383@studenti.unimore.it'),(36,'MICHELE','BOTTAZZI','65106@studenti.unimore.it'),(37,'CECILIA','BULGARELLI','65488@studenti.unimore.it'),(38,'ANDREA','MARCHETTI','66409@studenti.unimore.it'),(39,'FRANCESCA','GHERPELLI','66457@studenti.unimore.it'),(40,'GIOVANNI','GUERZONI','66889@studenti.unimore.it'),(41,'PASQUALE','DONATACCI','67141@studenti.unimore.it'),(42,'ELENA','CIPRESSI','68569@studenti.unimore.it'),(43,'MASSIMILIANO','CANTORE','68661@studenti.unimore.it'),(44,'MATTEO','BERTOLANI','71170@studenti.unimore.it'),(45,'FRANCESCO','DALLARI','71790@studenti.unimore.it'),(46,'VALENTINA','TAVONI','71848@studenti.unimore.it'),(47,'DAVIDE','GIOVANETTI','71940@studenti.unimore.it'),(48,'EMANUELE','LORENZANO','72025@studenti.unimore.it'),(49,'ALESSANDRO','LOSI','72213@studenti.unimore.it'),(50,'ENRICO','GANDOLFI','73255@studenti.unimore.it'),(51,'GIULIO','BURSI','73522@studenti.unimore.it'),(52,'GIANMARCO','CORDONE','73832@studenti.unimore.it'),(53,'FRANCESCO','GRANDI','74383@studenti.unimore.it'),(54,'ANDREA','AMADORI','75157@studenti.unimore.it'),(55,'ROBERTO','CONFLITTI','75433@studenti.unimore.it'),(56,'ENRICO','GARALDI','77971@studenti.unimore.it'),(57,'RICCARDO','MIGLIORI','78055@studenti.unimore.it'),(58,'FRANCESCO','CALZOLARI','78116@studenti.unimore.it'),(59,'MATTEO','BATTAGLIOLI','78215@studenti.unimore.it'),(60,'BRAHIM','EL GOUMRI','78696@studenti.unimore.it'),(61,'JACOPO','CUOGHI','80061@studenti.unimore.it'),(62,'EUGENIO','NURRITO','80274@studenti.unimore.it'),(63,'GIACOMO','DI NOTO','80882@studenti.unimore.it'),(64,'JESSICA','GUERZONI','80896@studenti.unimore.it'),(65,'MATTEO','COLOMBINI','81394@studenti.unimore.it'),(66,'NICOLA','CAVANI','81409@studenti.unimore.it'),(67,'NAWZAD','KHURSHID','81458@studenti.unimore.it'),(68,'RICCARDO','MURACCHINI','81573@studenti.unimore.it'),(69,'CHIARA','CASTAGNOLI','81783@studenti.unimore.it'),(70,'FABIO','DAVOLI','81789@studenti.unimore.it'),(71,'MATTIA','RIGHI','82286@studenti.unimore.it'),(72,'RICCARDO','COMPAGNI','82323@studenti.unimore.it'),(73,'MARCO','MEDICI','82328@studenti.unimore.it'),(74,'MATTEO','BONI','84823@studenti.unimore.it'),(75,'LUDOVICA','LUGLI','84875@studenti.unimore.it'),(76,'LORENZO','PANISI','85004@studenti.unimore.it'),(77,'MARCO','BOMPANI','85101@studenti.unimore.it'),(78,'ALESSIO','FIORENZA','85167@studenti.unimore.it'),(79,'ALBERTO','GUANDALINI','85170@studenti.unimore.it'),(80,'LUCA','ANDERLINI','85187@studenti.unimore.it'),(81,'ALESSANDRO','DAVOLI','85275@studenti.unimore.it'),(82,'BARBARA','BERTOZZI','85279@studenti.unimore.it'),(83,'JACOPO','BELFIORI','85270@studenti.unimore.it'),(84,'ELENA','ZANNONI','85338@studenti.unimore.it'),(85,'ANNA','GAMBERINI','85445@studenti.unimore.it'),(86,'ALESSANDRO','SALTINI','85627@studenti.unimore.it'),(87,'ANDREA','CERFOGLI','85672@studenti.unimore.it'),(88,'ANDREA','SILVESTRI','86103@studenti.unimore.it'),(89,'MARICA','PIGONI','86446@studenti.unimore.it'),(90,'GIULIA','RIGHI','86521@studenti.unimore.it'),(91,'JACOPO','CREDI','86996@studenti.unimore.it'),(92,'LUCA','DALLARI','87199@studenti.unimore.it'),(93,'SILVIA','VICENZI','87211@studenti.unimore.it'),(94,'ILARIA','VENTURELLI','87216@studenti.unimore.it'),(95,'MAURIZIO','ACCOLLA','87612@studenti.unimore.it'),(96,'MATTEO','PUVIANI','87879@studenti.unimore.it'),(97,'ANDREA','BACCARINI','88258@studenti.unimore.it'),(98,'PIERO','BRUSTOLIN','88292@studenti.unimore.it'),(99,'GABRIEL ANDRES','PIOVANO','88361@studenti.unimore.it'),(100,'AGNESE','ROSI','88395@studenti.unimore.it'),(101,'ENRICO','CALZATI','88402@studenti.unimore.it'),(102,'STEFANO','BENUZZI','88429@studenti.unimore.it'),(103,'SALVATORE FABIO','GUCCIARDO','88438@studenti.unimore.it'),(104,'ANNA','VALENTINI','88575@studenti.unimore.it'),(105,'CARLO','PIACENTINI','88920@studenti.unimore.it'),(106,'ANTONIO','SPAGNOLO','89226@studenti.unimore.it'),(107,'ALFREDO','BONINI','89285@studenti.unimore.it'),(108,'LUCA','GHIRARDI','89318@studenti.unimore.it'),(109,'MARCO','BARBIERI','89371@studenti.unimore.it'),(110,'DENIS','MATTEI','89384@studenti.unimore.it'),(111,'ENRICO','CREMONINI','89512@studenti.unimore.it'),(112,'DAVIDE','VENTURI','89525@studenti.unimore.it'),(113,'ELENA','GIANELLI','83337@studenti.unimore.it'),(114,'LUCA','FLAMMIA','89934@studenti.unimore.it'),(115,'FABIO','VERZINI','90108@studenti.unimore.it'),(116,'ARIANNA','BERGONZINI','90291@studenti.unimore.it'),(117,'TOMMASO','GORNI','90339@studenti.unimore.it'),(118,'FRANCESCO','PETOCCHI','90514@studenti.unimore.it'),(119,'GIANLUCA','DOTTI','90566@studenti.unimore.it'),(120,'LUCA','NASI','90567@studenti.unimore.it'),(121,'SILVIA','FERRI','90754@studenti.unimore.it'),(122,'JORGE','LOZANO ESTEBAN','50893@studenti.unimore.it'),(123,'MATTEO','STANZANI','160066@studenti.unimore.it'),(124,'GIOVANNI','BERGIANTI','163570@studenti.unimore.it'),(125,'ENRICO','VEZZALINI','165684@studenti.unimore.it'),(126,'LAURA','BELLENTANI','165947@studenti.unimore.it'),(127,'FABIO','BORGHI','166094@studenti.unimore.it'),(128,'IACOPO','BERTELLI','166207@studenti.unimore.it'),(129,'DARIO','VITALI','166341@studenti.unimore.it'),(130,'SARA','RONCHEJ','166435@studenti.unimore.it'),(131,'DARIO','GARUTI','166436@studenti.unimore.it'),(132,'MAURIZIO','MURATORI','166462@studenti.unimore.it'),(133,'GIORDANO','CALVANESE','166789@studenti.unimore.it'),(134,'MICHAEL','BRANDOLI','166790@studenti.unimore.it'),(135,'DAVIDE','FERRARESI','166879@studenti.unimore.it'),(136,'MARCELLO','ZANGHIERI','167296@studenti.unimore.it'),(137,'VALENTINA','ORSINI','167444@studenti.unimore.it'),(138,'NICOLO\'','BASSOLI','167599@studenti.unimore.it'),(139,'RICCARDO','GNUDI','167782@studenti.unimore.it'),(140,'FLAVIO','TONIONI','167979@studenti.unimore.it'),(141,'FABIO','ANSALONI','168144@studenti.unimore.it'),(142,'JESSICA','PASQUA','168175@studenti.unimore.it'),(143,'RICCARDO','GOZZI','168194@studenti.unimore.it'),(144,'LISA','BRAVAGLIERI','168504@studenti.unimore.it'),(145,'DANIELE','FRASSINETI','168775@studenti.unimore.it'),(146,'LORENZO','ROSSI','168919@studenti.unimore.it'),(147,'FEDERICO','FEDELE','169499@studenti.unimore.it'),(148,'FILIPPO','PARMEGGIANI','169543@studenti.unimore.it'),(149,'LEONARDO','PETRILLO','169811@studenti.unimore.it'),(150,'SIMONE','CAMATTI','170074@studenti.unimore.it'),(151,'DANIELE','TAVERNARI','170813@studenti.unimore.it'),(152,'FRANCESCO','LENZINI','170838@studenti.unimore.it'),(153,'VERONICA','GUIDETTI','172703@studenti.unimore.it'),(154,'XU','ZHOU','173257@studenti.unimore.it'),(155,'SILVIA','MAZZELLI','176942@studenti.unimore.it'),(156,'PAOLO','ROSI','177478@studenti.unimore.it'),(157,'PIER PAOLO','PAVAROTTI','177504@studenti.unimore.it'),(158,'GIACOMO','ALDROVANDI','177517@studenti.unimore.it'),(159,'STEFANO','PAGLIARI','177975@studenti.unimore.it'),(160,'LUCA','RAZZOLI','179128@studenti.unimore.it'),(161,'GABRIELE','LOSI','179582@studenti.unimore.it'),(162,'DAVIDE','MICELI','179861@studenti.unimore.it'),(163,'PIETRO','CARRA','180223@studenti.unimore.it'),(164,'DAVIDE','TISI','180375@studenti.unimore.it'),(165,'ALICE','BIOLCHINI','180408@studenti.unimore.it'),(166,'MIKI','BONACCI','180439@studenti.unimore.it'),(167,'ELISA','FERRARI','180450@studenti.unimore.it'),(168,'LAURA','MAGAGNA','180620@studenti.unimore.it'),(169,'MATTHIEU','NADINI','180984@studenti.unimore.it'),(170,'ENRICO','SILVAGNI','181520@studenti.unimore.it'),(171,'GIACOMO','SESTI','181816@studenti.unimore.it'),(172,'AGNESE','CHENDI','181830@studenti.unimore.it'),(173,'MARCO','MARCHIONI','182054@studenti.unimore.it'),(174,'LUCA','PEDRELLI','182570@studenti.unimore.it'),(175,'ALBERTO','BARRACCIU','183001@studenti.unimore.it'),(176,'MARCO','BERSELLI','186178@studenti.unimore.it'),(177,'MATTEO','ZANFROGNINI','186905@studenti.unimore.it'),(178,'GIULIA MARIA','BOIANI','187217@studenti.unimore.it'),(179,'GIACOMO','MEDICI','187550@studenti.unimore.it'),(180,'GIULIO','DONDI','187962@studenti.unimore.it'),(181,'CHIARA ELISA','GUSMINI','188154@studenti.unimore.it'),(182,'FILIPPO','CAMPANA','188711@studenti.unimore.it'),(183,'SAMUELE','CORNIA','190252@studenti.unimore.it'),(184,'ANDREA','ZELIOLI','190558@studenti.unimore.it'),(185,'MATTEO','VANDELLI','190639@studenti.unimore.it'),(186,'MATTEO','SIGHINOLFI','190972@studenti.unimore.it'),(187,'IRENE','FUOTI','191474@studenti.unimore.it'),(188,'FILIPPO MARIA','BALLI','191650@studenti.unimore.it'),(189,'MATTEO','BRINI','191834@studenti.unimore.it'),(190,'SIMONE','VACONDIO','192146@studenti.unimore.it'),(191,'ALICE','PORTAL','192160@studenti.unimore.it'),(192,'SAVERIO','CIGARINI','192426@studenti.unimore.it'),(193,'ELENA','ORREA','192721@studenti.unimore.it'),(194,'ANDREA','TONELLI','192934@studenti.unimore.it'),(195,'LUCA','ASCHERO','203985@studenti.unimore.it'),(196,'FABIO','ROCCO','187750@studenti.unimore.it'),(197,'SAMUELE','PELATTI','205253@studenti.unimore.it'),(198,'ALESSIA','LODI','204384@studenti.unimore.it'),(199,'IVAN','MALAGUTI','203271@studenti.unimore.it'),(200,'MARTINA','MUSA','206306@studenti.unimore.it'),(201,'CHIARA','GALEOTTI','206194@studenti.unimore.it'),(202,'PIER ALBINO','COLOMBO','88484@studenti.unimore.it'),(203,'LORENZO','SPINA','206973@studenti.unimore.it'),(204,'MARCO','POSSEGA','206107@studenti.unimore.it'),(205,'NICCOLO\'','VERONESI','207424@studenti.unimore.it'),(206,'FRANCESCA','ROSSI','196978@studenti.unimore.it'),(207,'GABRIELE','GIGLIO','207479@studenti.unimore.it'),(208,'MIRCO','TINCANI','207591@studenti.unimore.it'),(209,'ELIA','COVI','196904@studenti.unimore.it'),(210,'DONATELLA','MARCOLINI','207446@studenti.unimore.it'),(211,'ELENA LARISA','DIACONU','196267@studenti.unimore.it'),(212,'TOMMASO','TURRINI','207693@studenti.unimore.it'),(213,'GIULIA','PAOLANI','196959@studenti.unimore.it'),(214,'MARCO','VACCARI','206465@studenti.unimore.it'),(215,'MARTINA','SURACI','196328@studenti.unimore.it'),(216,'MARTINA','CARAMASCHI','202141@studenti.unimore.it'),(217,'PAOLO','ROSSI','208056@studenti.unimore.it'),(218,'DANIELE','PIGNEDOLI','208308@studenti.unimore.it'),(219,'ELENA','GHIDORSI','201534@studenti.unimore.it'),(220,'LORENZO','RUGGI','207908@studenti.unimore.it'),(221,'GIULIO','TESTI','204957@studenti.unimore.it'),(222,'GIOVANNI','GUERRIERI','208046@studenti.unimore.it'),(223,'ANDREA','GALLI','208164@studenti.unimore.it'),(224,'STEFANO','ANSALONI','71521@studenti.unimore.it'),(225,'ANDREA','RABITTI','71526@studenti.unimore.it'),(226,'SIMONE','FERRARI','31695@studenti.unimore.it'),(227,'ROSARIO','CANNISTRA\'','24402@studenti.unimore.it'),(228,'ANDREA','REBOTTINI','44560@studenti.unimore.it'),(229,'ANGELA','D\'ALCAMO','45417@studenti.unimore.it'),(230,'ANDREA','GRASSI','46341@studenti.unimore.it'),(231,'TERESA','CALIGIURI','44463@studenti.unimore.it'),(232,'MARCO','ZAROTTI','44820@studenti.unimore.it'),(233,'FABRIZIO','PELLACANI','44847@studenti.unimore.it'),(234,'ROBERTO','SCARPONE','44954@studenti.unimore.it'),(235,'DANIEL','VOLANTI','46241@studenti.unimore.it'),(236,'ILENIA','AMADORI','48092@studenti.unimore.it'),(237,'PAOLO','CANTERGIANI','48206@studenti.unimore.it'),(238,'MANUELE','GRAZIAN','51282@studenti.unimore.it'),(239,'STEFANO','DALL\'OLIO','81911@studenti.unimore.it'),(240,'SIMONE','BORDINA','40514@studenti.unimore.it'),(241,'MASSIMO','VEZZELLI','44760@studenti.unimore.it'),(242,'DANIEL','MAFFEI','45164@studenti.unimore.it'),(243,'GIULIANO','MANZITTI','48465@studenti.unimore.it'),(244,'ANTONIO','RADOGNA','58981@studenti.unimore.it'),(245,'DANIELE','ZOBOLI','64786@studenti.unimore.it'),(246,'OTTAVIA','CORTELLONI','70817@studenti.unimore.it'),(247,'MARCO','TIRELLI','71217@studenti.unimore.it'),(248,'GIORGIO','COLAUTTI','71666@studenti.unimore.it'),(249,'MARCO','FERRARI','71810@studenti.unimore.it'),(250,'ELEONORA','CORSINI','71887@studenti.unimore.it'),(251,'RICCARDO','ARLETTI','72419@studenti.unimore.it'),(252,'CARLO','PEDRONI','73506@studenti.unimore.it'),(253,'ALEX','MAZZALI','74933@studenti.unimore.it'),(254,'ALESSANDRA','BONACINI','75186@studenti.unimore.it'),(255,'EMANUELE','GALAVERNI','75346@studenti.unimore.it'),(256,'GIULIO','SPERI','75778@studenti.unimore.it'),(257,'MICHELE','CALA\'','76592@studenti.unimore.it'),(258,'GIORDANO','LANZI','76800@studenti.unimore.it'),(259,'EMANUELE','PEDRONA','83329@studenti.unimore.it'),(260,'EMMANUELE','CIANCAGLINI','54912@studenti.unimore.it'),(261,'ANDREA','SELMINI','57708@studenti.unimore.it'),(262,'SAMUELE','BAISI','57846@studenti.unimore.it'),(263,'FABIO','SAELI','58466@studenti.unimore.it'),(264,'DANIELE','TURRINI','58931@studenti.unimore.it'),(265,'YLENIA','ZUCCHINI','59270@studenti.unimore.it'),(266,'LUCA','MOLINARI','59459@studenti.unimore.it'),(267,'IGOR','CATTOZZI','59874@studenti.unimore.it'),(268,'RICCARDO','FOLLONI','61725@studenti.unimore.it'),(269,'SAMUELE','CARPI','61937@studenti.unimore.it'),(270,'LUCA','ZIRONI','62188@studenti.unimore.it'),(271,'LUCIANO','PEPE','63369@studenti.unimore.it'),(272,'ANDREA','ZUCCARINI','65002@studenti.unimore.it'),(273,'PAOLO','SEMERARO','65141@studenti.unimore.it'),(274,'BENEDETTO ALESSANDRO','CAFARO','65153@studenti.unimore.it'),(275,'ANTONINO','BENANTI','65387@studenti.unimore.it'),(276,'MARCO','TELLINI','65590@studenti.unimore.it'),(277,'VIRGINIA','SIGNORE','66128@studenti.unimore.it'),(278,'ALESSANDRO','VERUCCHI','66275@studenti.unimore.it'),(279,'ARBI','MABROUK','67150@studenti.unimore.it'),(280,'NABIL','YACOUBI','67165@studenti.unimore.it'),(281,'SIMONE','ZENNARO','67865@studenti.unimore.it'),(282,'SOUMIA','MAROUANE','68040@studenti.unimore.it'),(283,'DAVIDE','NEGRI','68311@studenti.unimore.it'),(284,'MICHELE','TOSCAN','68835@studenti.unimore.it'),(285,'GIORGIO','SERVADEI','68999@studenti.unimore.it'),(286,'ANDREA','STRANGIO','69373@studenti.unimore.it'),(287,'ANDREA','INCERTI','69691@studenti.unimore.it'),(288,'GABRIELE','PADUANO','69928@studenti.unimore.it'),(289,'PIERLUIGI','CORSA','70679@studenti.unimore.it'),(290,'GIUSEPPE','CALISI','70756@studenti.unimore.it'),(291,'DILETTA','GALLERANI','71017@studenti.unimore.it'),(292,'MARCO','AGGOGERI','71094@studenti.unimore.it'),(293,'GIOVANNI','MUNGO','71548@studenti.unimore.it'),(294,'DANIELE','CINTORI','72003@studenti.unimore.it'),(295,'FEDERICO','TERZI','72113@studenti.unimore.it'),(296,'SIMONE','BIOLI','72290@studenti.unimore.it'),(297,'ANTONIO','MATACENA','72954@studenti.unimore.it'),(298,'ALESSANDRO','MONTANARI','74421@studenti.unimore.it'),(299,'ALICE','GALLI','74463@studenti.unimore.it'),(300,'FABIO','FERRARI','74652@studenti.unimore.it'),(301,'CHIARA','BUSCEMI','76371@studenti.unimore.it'),(302,'ROBERTO','CALANCA','81978@studenti.unimore.it'),(303,'ANGELO','GERVASI','83783@studenti.unimore.it'),(304,'GIACOMO','LANZARONE','84174@studenti.unimore.it'),(305,'FLAVIO','CACCIAPAGLIA','84190@studenti.unimore.it'),(306,'ELISA','BALBONI','88428@studenti.unimore.it'),(307,'DAVIDE','CAPUTO','83373@studenti.unimore.it'),(308,'RALUCA   IONELA','BUTNARU','16823@studenti.unimore.it'),(309,'ANDREA','RACCUGLIA','68446@studenti.unimore.it'),(310,'GIANLUCA','RAZZOLI','80544@studenti.unimore.it'),(311,'SILVIA','TAMBURRANO','68346@studenti.unimore.it'),(312,'SAVERIO','LEONI','71624@studenti.unimore.it'),(313,'FABIO','BRUSCAGIN','77482@studenti.unimore.it'),(314,'DAMIANO','TIPALDI','77825@studenti.unimore.it'),(315,'ESTER','BELTRAMI','77914@studenti.unimore.it'),(316,'ELISA','SONEGO','77972@studenti.unimore.it'),(317,'MARCO','TAROZZI','78016@studenti.unimore.it'),(318,'RUDY','BARBIERI','78386@studenti.unimore.it'),(319,'MATTEO','DE CARLO','79400@studenti.unimore.it'),(320,'MATTEO','GUIDETTI','80890@studenti.unimore.it'),(321,'PIETRO ARNALDO TULLIO','COTTAFAVI','81811@studenti.unimore.it'),(322,'MARCO','CAMPANI','57533@studenti.unimore.it'),(323,'GIULIO','VEZZELLI','60440@studenti.unimore.it'),(324,'FABRIZIO','MONTANARI','61281@studenti.unimore.it'),(325,'ALBERTO','LEONELLI','64934@studenti.unimore.it'),(326,'CORRADO','TARTAGLIA','65115@studenti.unimore.it'),(327,'MARCELLO','BELLINO','66680@studenti.unimore.it'),(328,'PIETRO','CEDDIA','71028@studenti.unimore.it'),(329,'GIACOMO','FERRARI','71125@studenti.unimore.it'),(330,'ALESSANDRO','MARCHI','71150@studenti.unimore.it'),(331,'MARTINA','PUCELLA','71174@studenti.unimore.it'),(332,'STEFANO','STROZZI','73243@studenti.unimore.it'),(333,'ANDREA','VENNERI','75009@studenti.unimore.it'),(334,'ADELE','CASTELLANI TARABINI','75943@studenti.unimore.it'),(335,'FABIO','FELICETTI','76594@studenti.unimore.it'),(336,'MASSIMILIANO DONATO','TORTOLI','77485@studenti.unimore.it'),(337,'GIULIA','LOSCHI','77668@studenti.unimore.it'),(338,'FILIPPO','VERUCCHI','77775@studenti.unimore.it'),(339,'MICHAEL','PAGANI','77834@studenti.unimore.it'),(340,'YANG YANG','GI','77835@studenti.unimore.it'),(341,'ELIA','VEZZALI','77843@studenti.unimore.it'),(342,'CRISTIAN','PALAZZI','77897@studenti.unimore.it'),(343,'FRANCESCO','PETRALIA','77936@studenti.unimore.it'),(344,'MATIA','FLORINI','78013@studenti.unimore.it'),(345,'STEFANO','FONTANESI','78085@studenti.unimore.it'),(346,'ANDREA','MARASTONI','78157@studenti.unimore.it'),(347,'MIRIAM','BARALDI','78515@studenti.unimore.it'),(348,'ERICA','BERTUGLI','78534@studenti.unimore.it'),(349,'ANDREA','LEONI','80123@studenti.unimore.it'),(350,'DANIELE','TORLAI','80141@studenti.unimore.it'),(351,'MATTEO','TRIGGIANI','80251@studenti.unimore.it'),(352,'ROBERTO','BONVICINI','80685@studenti.unimore.it'),(353,'ANDREA DOMENICO','GIULIANO','80703@studenti.unimore.it'),(354,'VICTOR','SEROV','80886@studenti.unimore.it'),(355,'FABRIZIO','NARNI','80981@studenti.unimore.it'),(356,'FRANCESCO','ASCARI','81237@studenti.unimore.it'),(357,'ANNA','SALVATO','81297@studenti.unimore.it'),(358,'CRISTIANO','CORRADINI','81325@studenti.unimore.it'),(359,'ENRICO','PITTIGLIO','81344@studenti.unimore.it'),(360,'WILVERT ALAIN','YUCRA MAMANI','81525@studenti.unimore.it'),(361,'ROBERTO','BENFATTO','81700@studenti.unimore.it'),(362,'ROBERTO','PISCIOTTA','81869@studenti.unimore.it'),(363,'FILIPPO','MARTINELLI','81874@studenti.unimore.it'),(364,'STEFANO','TOPPI','81997@studenti.unimore.it'),(365,'MARCO','RINALDINI','82071@studenti.unimore.it'),(366,'MATTIA','MARINELLI','82086@studenti.unimore.it'),(367,'LUCIA','ZANI','82281@studenti.unimore.it'),(368,'LUIS ADRIAN','SASSATELLI','15953@studenti.unimore.it'),(369,'GIAN LUCA','ARCETTI','84881@studenti.unimore.it'),(370,'GIORDANO','BERSELLI','84908@studenti.unimore.it'),(371,'DAVIDE','BEDOGNI','84931@studenti.unimore.it'),(372,'FABIO','COTTAFAVI','84944@studenti.unimore.it'),(373,'SONIA','MORETTI','84949@studenti.unimore.it'),(374,'MARCO VALERIO','MANZINI','84952@studenti.unimore.it'),(375,'GIOVANNI','LAMBERTI','84968@studenti.unimore.it'),(376,'LUCA','BOLDRINI','85006@studenti.unimore.it'),(377,'ANDREA','SGHEDONI','85045@studenti.unimore.it'),(378,'ALJOSCHA','VALLUCCI','85055@studenti.unimore.it'),(379,'FABIO','RESTA','85074@studenti.unimore.it'),(380,'MIRKO','MONTANARI','85098@studenti.unimore.it'),(381,'STEFANO','RUSSO','85186@studenti.unimore.it'),(382,'VINCENZO','LOMONACO','85220@studenti.unimore.it'),(383,'EMANUELE','GATTA','85370@studenti.unimore.it'),(384,'DAVIDE','VICENZI','85371@studenti.unimore.it'),(385,'VALERIO','CANTI','85374@studenti.unimore.it'),(386,'RICCARDO','PIZZETTI','85419@studenti.unimore.it'),(387,'CHRISTIAN','LA PIETRA','85704@studenti.unimore.it'),(388,'NGOC YEN','NGUYEN','86033@studenti.unimore.it'),(389,'ALESSIO MATTIA','POPPI','86134@studenti.unimore.it'),(390,'SIMONE','BIAGINI','86476@studenti.unimore.it'),(391,'ALESSANDRO','MARTINES','86636@studenti.unimore.it'),(392,'LORENZA','GAMBINI','86764@studenti.unimore.it'),(393,'ALBERTO','VEZZANI','86928@studenti.unimore.it'),(394,'SARA','SIMONAZZI','87035@studenti.unimore.it'),(395,'NAZLI','TASATAN','87096@studenti.unimore.it'),(396,'LUCA','SCAVAZZA','87207@studenti.unimore.it'),(397,'RICCARDO','CERVI','87711@studenti.unimore.it'),(398,'GIOVANNI','BARTOLOMUCCI','87992@studenti.unimore.it'),(399,'MATTEO','MESTUCCI','88144@studenti.unimore.it'),(400,'LUCA','DI GIOVANNI','88178@studenti.unimore.it'),(401,'FRANCESCO','ROMANO','84777@studenti.unimore.it'),(402,'ANDREA','CALZOLARI','88225@studenti.unimore.it'),(403,'KEVIN','BORGHI','88527@studenti.unimore.it'),(404,'EMANUELE','CLEMENTE','88531@studenti.unimore.it'),(405,'STEFANO','PAIANO','88549@studenti.unimore.it'),(406,'ANDREA','UGUZZONI','88706@studenti.unimore.it'),(407,'NICOLO\'','DONDI','88738@studenti.unimore.it'),(408,'GIANLUCA','BRILLI','88740@studenti.unimore.it'),(409,'DANIELE','BORTOLOTTI','88744@studenti.unimore.it'),(410,'SAMANTHA','MICELI','88894@studenti.unimore.it'),(411,'ANDREA','BERTONI','89099@studenti.unimore.it'),(412,'VITO','SALERNO','89179@studenti.unimore.it'),(413,'VAINER','VENTURELLI','89293@studenti.unimore.it'),(414,'MARKO','CELEKETIC','89346@studenti.unimore.it'),(415,'DENNYS','PREVIDI','89417@studenti.unimore.it'),(416,'GIANCARLO','GUIDA','89425@studenti.unimore.it'),(417,'EMANUELE','VACCARI','89444@studenti.unimore.it'),(418,'DANIELE','SACCANI','89451@studenti.unimore.it'),(419,'GABRIELE','SAVIGNI','89464@studenti.unimore.it'),(420,'MAWETE CHRISTIAN','MFULU','89530@studenti.unimore.it'),(421,'LAURA','BASSI','81743@studenti.unimore.it'),(422,'CRISTINA','TACCONI','82196@studenti.unimore.it'),(423,'MANUELE','NERUCCI','90416@studenti.unimore.it'),(424,'MIRCO','MEATTA','90672@studenti.unimore.it'),(425,'HOUSSEM EDDINE','CHERIFI','90674@studenti.unimore.it'),(426,'ALESSANDRA','DE MARCO','124311@studenti.unimore.it'),(427,'ANDRZEJ KONRAD','SLIWINSKI','146256@studenti.unimore.it'),(428,'ANGELO','MAGLIOCCO','150177@studenti.unimore.it'),(429,'MARCELLO','PELLACANI','115187@studenti.unimore.it'),(430,'ALBERTO','SAGUATTI','160771@studenti.unimore.it'),(431,'ANDREA','MELEGARI','125916@studenti.unimore.it'),(432,'AGNESE','FACCHINI','47687@studenti.unimore.it'),(433,'MARCO','BELLETTINI','55332@studenti.unimore.it'),(434,'FRANCESCA  IGINA','ROMANI','20344@studenti.unimore.it'),(435,'LUCA','GALLI','44621@studenti.unimore.it'),(436,'CLAUDIO','MAMMINO','162872@studenti.unimore.it'),(437,'RICCARDO','PALUMBO','162903@studenti.unimore.it'),(438,'DAVIDE','FERRARI','162996@studenti.unimore.it'),(439,'PAOLO','MARCHI BARALDI','163078@studenti.unimore.it'),(440,'SILVIA','FRANCIA','163191@studenti.unimore.it'),(441,'LORENZO','VINCENZI','163248@studenti.unimore.it'),(442,'ADRIANA COSTANTINA','GIAMPAPA','158205@studenti.unimore.it'),(443,'MAHMOUD','MARZAK','165436@studenti.unimore.it'),(444,'RICCARDO','CORRADINI','165815@studenti.unimore.it'),(445,'MARIKA','GIANNETTO','165980@studenti.unimore.it'),(446,'SIMONE','BITTU','166001@studenti.unimore.it'),(447,'SARA','BASOLU','166083@studenti.unimore.it'),(448,'ELISA','BONEZZI','166192@studenti.unimore.it'),(449,'ANTONELLA','PARISI','166309@studenti.unimore.it'),(450,'ANDREA','OGNIBENE','166404@studenti.unimore.it'),(451,'JESSICA','VACCARI','166405@studenti.unimore.it'),(452,'VITTORIO','VENTURA','166504@studenti.unimore.it'),(453,'EMMANUEL BONSU','BOACHIE','166619@studenti.unimore.it'),(454,'STEFANO','RESTUCCIA','167000@studenti.unimore.it'),(455,'MARCO','MASSELLI','167086@studenti.unimore.it'),(456,'ANTONIO','GUADALUPI','167198@studenti.unimore.it'),(457,'MATTEO','PAGANELLI','167743@studenti.unimore.it'),(458,'DAVIDE','PAGANELLI','167785@studenti.unimore.it'),(459,'BIN','SUN','168204@studenti.unimore.it'),(460,'LUCA','BENZI','168206@studenti.unimore.it'),(461,'GUIDO','SETTI','168225@studenti.unimore.it'),(462,'FRANCESCO','BAI','168290@studenti.unimore.it'),(463,'LORIS','CASAGRANDI','168480@studenti.unimore.it'),(464,'MATTEO','SONDRIO','168560@studenti.unimore.it'),(465,'CHARLES','OPPONG','168768@studenti.unimore.it'),(466,'ROSSANO','BALDI','168788@studenti.unimore.it'),(467,'DANIELE','SALERNO','168849@studenti.unimore.it'),(468,'MARCO','PAOLINI','168911@studenti.unimore.it'),(469,'STEFANO','GREGORIO','168913@studenti.unimore.it'),(470,'MATTIA','GIOVANARDI','169012@studenti.unimore.it'),(471,'ANGELO','PORRELLO','169084@studenti.unimore.it'),(472,'DANNY','PIVANTI','169115@studenti.unimore.it'),(473,'GIACOMO','BARBERI','169280@studenti.unimore.it'),(474,'ALICE','CATELLANI','169304@studenti.unimore.it'),(475,'ATEF','AOUADH','169327@studenti.unimore.it'),(476,'SERENA','ZIVIANI','169364@studenti.unimore.it'),(477,'LUCA','LUSVARGHI','169454@studenti.unimore.it'),(478,'DAVIDE','RICHELDI','169549@studenti.unimore.it'),(479,'ALBERTO','LANCELLOTTI','169699@studenti.unimore.it'),(480,'SARA','OTTANI','169810@studenti.unimore.it'),(481,'PIETRO','SCOLORATO','169857@studenti.unimore.it'),(482,'VALERIO','RIGHI','169960@studenti.unimore.it'),(483,'JEFFERSON','JEYASEELAN','169961@studenti.unimore.it'),(484,'NICOLO\'','CAVEDONI','169962@studenti.unimore.it'),(485,'YIHUA','WENG','170002@studenti.unimore.it'),(486,'VINCENZO','AVITABILE','170012@studenti.unimore.it'),(487,'ALESSIO','RICCIO','170173@studenti.unimore.it'),(488,'ANDREA','QUAGLIOTTI','170284@studenti.unimore.it'),(489,'EMANUELE','MORRI','170394@studenti.unimore.it'),(490,'MARCO','VIGNUDELLI','170493@studenti.unimore.it'),(491,'FEDERICO','SCHENETTI','170499@studenti.unimore.it'),(492,'DIEGO','BARZON','170895@studenti.unimore.it'),(493,'FEDERICO','BONFIGLIOLI','171119@studenti.unimore.it'),(494,'MARCO','PARADISI','171194@studenti.unimore.it'),(495,'FABIOLA','D\'ERCOLE','171293@studenti.unimore.it'),(496,'FRANCESCA','MELILLO','171901@studenti.unimore.it'),(497,'FRANCESCO','MELIOLI','172604@studenti.unimore.it'),(498,'LUCA','PASSINI','172807@studenti.unimore.it'),(499,'ANDREA','GIRGENTI','172998@studenti.unimore.it'),(500,'STEFANO','SPAGGIARI','173247@studenti.unimore.it'),(501,'GRETA','ANDREOLI','173349@studenti.unimore.it'),(502,'STEFANIA','MASINELLI','173366@studenti.unimore.it'),(503,'ANDREA','GANZERLA','176594@studenti.unimore.it'),(504,'MARCO','TORREGGIANI','176747@studenti.unimore.it'),(505,'ITALO','PISCOPIELLO','176748@studenti.unimore.it'),(506,'ANDREA','BRAIDA','177083@studenti.unimore.it'),(507,'DANIELA','CONTI','177684@studenti.unimore.it'),(508,'ANGELO','BACCARANI','177785@studenti.unimore.it'),(509,'FILIPPO','MUZZINI','177873@studenti.unimore.it'),(510,'GIORGIO','MARIN','177934@studenti.unimore.it'),(511,'DAVIDE','SAPIENZA','177992@studenti.unimore.it'),(512,'SABRINA','LEONI','178410@studenti.unimore.it'),(513,'MAXWELL','OPPONG','178654@studenti.unimore.it'),(514,'ELENA','GILIOLI','178797@studenti.unimore.it'),(515,'MICAELA','VERUCCHI','178860@studenti.unimore.it'),(516,'FEDERICO','TAZZIOLI','178942@studenti.unimore.it'),(517,'EMANUELE','VINETI','179438@studenti.unimore.it'),(518,'MATTEO','CREMASCHI','179571@studenti.unimore.it'),(519,'LORENZO','RINALDI','179574@studenti.unimore.it'),(520,'MARCELLO','BERTOLI','179833@studenti.unimore.it'),(521,'RAFFAELLA','MORENA','180047@studenti.unimore.it'),(522,'LUCA','DE SANTIS','180149@studenti.unimore.it'),(523,'MICHELE','BELTRAMI','180395@studenti.unimore.it'),(524,'MARCO','RUSTINELLI','180436@studenti.unimore.it'),(525,'ANDREA','CARPINO','180533@studenti.unimore.it'),(526,'EMANUELE','NALDINI','180645@studenti.unimore.it'),(527,'SIMONE','BERGAMINI','180683@studenti.unimore.it'),(528,'YINGLE','LIN','180788@studenti.unimore.it'),(529,'MATTIA','SPOSITO','181329@studenti.unimore.it'),(530,'NATALIA','ORLANDI','181391@studenti.unimore.it'),(531,'ALESSANDRO','TRIANNI','181493@studenti.unimore.it'),(532,'ANDREA','MALAGOLI','181617@studenti.unimore.it'),(533,'MATTEO','CASTELLARI','181613@studenti.unimore.it'),(534,'SIMONE','CARANI','181633@studenti.unimore.it'),(535,'ALESSIO','GAVIOLI','181873@studenti.unimore.it'),(536,'LEONARDO','MASONI','181921@studenti.unimore.it'),(537,'MARTINA','CASARI','182105@studenti.unimore.it'),(538,'CHADI','DIAA EL DIN','182190@studenti.unimore.it'),(539,'FILIPPO','BARBERI','182384@studenti.unimore.it'),(540,'ANTONINO','PISCIOTTA','182491@studenti.unimore.it'),(541,'BRUNO','MARI','182490@studenti.unimore.it'),(542,'SIMONE','DATTOLO','182619@studenti.unimore.it'),(543,'CINZIA','TONI','182702@studenti.unimore.it'),(544,'LORENZO','BARONIO','182884@studenti.unimore.it'),(545,'LUCA','FORNACIARI','182931@studenti.unimore.it'),(546,'SIMONE','CHIORAZZO','182949@studenti.unimore.it'),(547,'SALVATORE','CAMPANELLA','183078@studenti.unimore.it'),(548,'ANDREA','CORSINI','183484@studenti.unimore.it'),(549,'PIERRE ARMAND','D\' ETTORRE','183732@studenti.unimore.it'),(550,'NICO','CORIALE','183938@studenti.unimore.it'),(551,'ALESSANDRO','FANCINELLI','184251@studenti.unimore.it'),(552,'MARCO','SCHIRINZI','184671@studenti.unimore.it'),(553,'RICCARDO','GALEOTTI','186455@studenti.unimore.it'),(554,'SERGIO','BOSELLI','186830@studenti.unimore.it'),(555,'LORENZIA','JAMES SUBASINGAM','187232@studenti.unimore.it'),(556,'LUCA','TAVERNARI','187261@studenti.unimore.it'),(557,'MATTIA','VINAZZANI','187605@studenti.unimore.it'),(558,'ALESSANDRO','SALVIOLI','187613@studenti.unimore.it'),(559,'MASSIMILIANO','FERRETTI','187677@studenti.unimore.it'),(560,'LUCA','BETTI','187683@studenti.unimore.it'),(561,'GIANPAOLO','SIMONE','187707@studenti.unimore.it'),(562,'ROSSANO','INCERTI','188033@studenti.unimore.it'),(563,'ANDREA','VENTURI','188055@studenti.unimore.it'),(564,'MADDALENA','RUBBIANI','188305@studenti.unimore.it'),(565,'MATTIA','MICELI','188478@studenti.unimore.it'),(566,'DAMIAN','KOBZA','188498@studenti.unimore.it'),(567,'FRANCESCO','BELLEI','188654@studenti.unimore.it'),(568,'VALENTINA','PINCA','188795@studenti.unimore.it'),(569,'GIULIO','PIZZUTO','188862@studenti.unimore.it'),(570,'SIMONE','RINALDI','189059@studenti.unimore.it'),(571,'GIACOMO','SANTINI','189130@studenti.unimore.it'),(572,'LAURA','CANALINI','189138@studenti.unimore.it'),(573,'FRANCESCO','GATTI','189382@studenti.unimore.it'),(574,'GIULIO','SANTI','189439@studenti.unimore.it'),(575,'FEDERICO','BIONDI','189475@studenti.unimore.it'),(576,'FELIX ALEXANDER','SALAMBA','189510@studenti.unimore.it'),(577,'NISHANT','PARHAR','189514@studenti.unimore.it'),(578,'ALESSANDRO','VIVIANI','189558@studenti.unimore.it'),(579,'CHIARA','BRUSCHI','189597@studenti.unimore.it'),(580,'NICO','MARROCCHINO','189753@studenti.unimore.it'),(581,'TULLIO','CROTTI','189778@studenti.unimore.it'),(582,'ELIA','AGAZZANI','189890@studenti.unimore.it'),(583,'ANDREA','MISTRETTA','189960@studenti.unimore.it'),(584,'FERNANDO','COLLI','190039@studenti.unimore.it'),(585,'MATTIA','IORI','190288@studenti.unimore.it'),(586,'FILIPPO','FRANCHINI','190388@studenti.unimore.it'),(587,'EMMANUEL','OSARENKHOE','190506@studenti.unimore.it'),(588,'ALESSANDRO','LANDOLFO','190507@studenti.unimore.it'),(589,'STEFANO','PASQUARIELLO','190527@studenti.unimore.it'),(590,'PAULINA','KAPUSTA','190627@studenti.unimore.it'),(591,'FRANCESCO','CARANDINI','190662@studenti.unimore.it'),(592,'MARCO','ROSSI','190824@studenti.unimore.it'),(593,'RUPINDER','KAUR','190837@studenti.unimore.it'),(594,'OLEKSIY','TKACHENKO','191148@studenti.unimore.it'),(595,'GIANLUCA','MAUGERI','191208@studenti.unimore.it'),(596,'SIMONE','MOSCATELLI','191260@studenti.unimore.it'),(597,'FEDERICO','CASOLI','191315@studenti.unimore.it'),(598,'RICCARDO','CAPRARI','191549@studenti.unimore.it'),(599,'FEDERICO','MOTTA','191685@studenti.unimore.it'),(600,'MICHELE','ALTIERI','191707@studenti.unimore.it'),(601,'BARBARA','FERRARO','191860@studenti.unimore.it'),(602,'ANDREA','BORGHI','191895@studenti.unimore.it'),(603,'FABIO','PICCIATI','192023@studenti.unimore.it'),(604,'LUIGI','ONOFRIETTI','192029@studenti.unimore.it'),(605,'CESARE','BUZZONI','192091@studenti.unimore.it'),(606,'GIULIO','SALANI','192197@studenti.unimore.it'),(607,'VOLHA','MIADZVEDSKAYA','192438@studenti.unimore.it'),(608,'LORENZO','BARCELLONA','192529@studenti.unimore.it'),(609,'MATTIA','VIONI','192547@studenti.unimore.it'),(610,'SIMONE','BISI','192556@studenti.unimore.it'),(611,'ALFRED','FORSON','192607@studenti.unimore.it'),(612,'LOVEPREET','SINGH','192617@studenti.unimore.it'),(613,'LORENZO','FOLLONI','192623@studenti.unimore.it'),(614,'FABIO','PUVIANI','192720@studenti.unimore.it'),(615,'BRUNO','GHION','192862@studenti.unimore.it'),(616,'ALESSIO','MASOLA','192978@studenti.unimore.it'),(617,'LORENZO','LUGLI','192990@studenti.unimore.it'),(618,'EMANUELE','ROSI','192997@studenti.unimore.it'),(619,'EUGENIO','SCACCHETTI','193315@studenti.unimore.it'),(620,'GIULIO ENRICO','CORAZZA','193942@studenti.unimore.it'),(621,'NICOLA','SPADACINI','193962@studenti.unimore.it'),(622,'EUGENIO','ROSSI','195404@studenti.unimore.it'),(623,'DIANA','SIGHINOLFI','176779@studenti.unimore.it'),(624,'PETER ATO','FERGUSON','163035@studenti.unimore.it'),(625,'ERICA','DELRIO','201889@studenti.unimore.it'),(626,'MARCO','FONTANA','203204@studenti.unimore.it'),(627,'PAOLO','CROTTI','204572@studenti.unimore.it'),(628,'LISA','ZANELLI','205017@studenti.unimore.it'),(629,'ERIC','YEBOAH','197206@studenti.unimore.it'),(630,'DAVIDE','BISI','203947@studenti.unimore.it'),(631,'DONATO','FERRARO','202366@studenti.unimore.it'),(632,'ETTORE','PANINI','166753@studenti.unimore.it'),(633,'MATHIAS','BERTI','203657@studenti.unimore.it'),(634,'SERENA','PASSERINI','205296@studenti.unimore.it'),(635,'DANIELE','CRISTONI','203866@studenti.unimore.it'),(636,'DURAN','GUNASEGARAN','202549@studenti.unimore.it'),(637,'NICHOLAS','DI PERSIO','178325@studenti.unimore.it'),(638,'NICOLA','BOTTURA','204899@studenti.unimore.it'),(639,'DANIELE','TOSCHI','187580@studenti.unimore.it'),(640,'MASSIMILIANO','BOSI','205839@studenti.unimore.it'),(641,'MIRCO','ROMAGNOLI','202943@studenti.unimore.it'),(642,'MAURIZIO','FERRI','206173@studenti.unimore.it'),(643,'SIMONE','RICHETTI','206161@studenti.unimore.it'),(644,'TEODOR','CHETRUSCA','202240@studenti.unimore.it'),(645,'ANTONINO','CATANESE','204319@studenti.unimore.it'),(646,'LORENZO CORRADO','MARMIROLI','207237@studenti.unimore.it'),(647,'MATTEO','TOGNARINI','204630@studenti.unimore.it'),(648,'NICOLA','GAMBINI','207295@studenti.unimore.it'),(649,'STEFANO','REMITTI','206987@studenti.unimore.it'),(650,'ALESSIO','LOMBARDINI','206293@studenti.unimore.it'),(651,'ANDREA','TAGLIAVINI','204105@studenti.unimore.it'),(652,'MICHELE','GUZZINATI','206832@studenti.unimore.it'),(653,'FEDERICO','DE MICHELI','203316@studenti.unimore.it'),(654,'DAVIDE','BARIGAZZI','206345@studenti.unimore.it'),(655,'STEFANO','PREDONZANI','87364@studenti.unimore.it'),(656,'MASSIMILIANO','LORENZI','205023@studenti.unimore.it'),(657,'VALERIA','TONI','206886@studenti.unimore.it'),(658,'SIMONE','CAPOZZI','205953@studenti.unimore.it'),(659,'MATTEO','CORRADINI','204329@studenti.unimore.it'),(660,'LUCA','MICCIO','206497@studenti.unimore.it'),(661,'LUCA','RONCONE','207610@studenti.unimore.it'),(662,'GIORGIO','FIORI','204270@studenti.unimore.it'),(663,'MARZIO','CUCCHI','207726@studenti.unimore.it'),(664,'TOMMASO','BORRONI','204165@studenti.unimore.it'),(665,'EMANUELE','GHELFI','206577@studenti.unimore.it'),(666,'LUCA','CARNEVALI','206261@studenti.unimore.it'),(667,'NICOLO\' EMANUELE','MAZZA','207512@studenti.unimore.it'),(668,'ANDREA','ALBANO','206459@studenti.unimore.it'),(669,'MARCO DEMETRIO','MARIN','207878@studenti.unimore.it'),(670,'ALESSANDRO','STEFANI','207474@studenti.unimore.it'),(671,'MAURIZIO','ALBANI','203880@studenti.unimore.it'),(672,'GABRIELE','BANI','205658@studenti.unimore.it'),(673,'ENRICO','MELLONI','204485@studenti.unimore.it'),(674,'MATTIA','PRATI','201950@studenti.unimore.it'),(675,'ANTONIO','MARRA','205016@studenti.unimore.it'),(676,'SIMONE','CAVEDONI','204313@studenti.unimore.it'),(677,'CAROLINA','FALCIONI','203563@studenti.unimore.it'),(678,'SIMONE','MIONE','205212@studenti.unimore.it'),(679,'TOMMY','FACCHINI','207684@studenti.unimore.it'),(680,'FABIO','SGUEGLIA','82183@studenti.unimore.it'),(681,'CLAUDIO','GIOVANNINI','206309@studenti.unimore.it'),(682,'MARCO','ABATI','204486@studenti.unimore.it'),(683,'MARCO','MESCHIARI','89480@studenti.unimore.it'),(684,'DERRICK','DONKOR','202543@studenti.unimore.it'),(685,'PIER PAOLO','ZINI','204237@studenti.unimore.it'),(686,'CARLO','NONATO','203905@studenti.unimore.it'),(687,'STEFANO','BRAGHIN','205559@studenti.unimore.it'),(688,'MICHAEL','ZAROTTI','207000@studenti.unimore.it'),(689,'JACOPO','VIOLI','205376@studenti.unimore.it'),(690,'RICCARDO','NICOLAI','207898@studenti.unimore.it'),(691,'ENRICO','MONTANARI','207737@studenti.unimore.it'),(692,'GIANLUCA','D\'ADDESE','183619@studenti.unimore.it'),(693,'ANDREA','ALTIERO','206655@studenti.unimore.it'),(694,'MATTIA','MALGARINI','208431@studenti.unimore.it'),(695,'RICCARDO','VASIRANI','205516@studenti.unimore.it'),(696,'SIMONE','DE MICCO','206239@studenti.unimore.it'),(697,'MARCO','FORGHIERI','169571@studenti.unimore.it'),(698,'TIZIANA','ADEMI','207651@studenti.unimore.it'),(699,'FRANCESCO','POLLICINO','202190@studenti.unimore.it'),(700,'LUCA','MAGLIOCCA','207506@studenti.unimore.it'),(701,'MARCO','SABLONE','208060@studenti.unimore.it'),(702,'BABAL PREET','KAUR','202448@studenti.unimore.it'),(703,'GIACOMO','GUERZONI','207757@studenti.unimore.it'),(704,'GIACOMO','FRANCIA','204967@studenti.unimore.it'),(705,'SAVERIO','SCADUTO','169351@studenti.unimore.it'),(706,'ANDREA','VEZZELLI','196250@studenti.unimore.it'),(707,'CAMILO ANDRES','NARVAEZ','204652@studenti.unimore.it'),(708,'SVETOSLAV ALEKSANDROV','BANDOV','78315@studenti.unimore.it'),(709,'GABRIELE','GIBERTI','206311@studenti.unimore.it'),(710,'LORENZO','BONARETTI','191527@studenti.unimore.it'),(711,'BARBARA','GIBERTI','187155@studenti.unimore.it'),(712,'ALEKSEI','ZIONI','207891@studenti.unimore.it'),(713,'VINCENZO','CHIRONI','208573@studenti.unimore.it'),(714,'GIACOMO','SCIASCIA','207624@studenti.unimore.it'),(715,'VERONICA','GRIFA','205433@studenti.unimore.it'),(716,'GIOVANNI','IMPROTA','204103@studenti.unimore.it'),(717,'ROBERTO','TARANTINO','205535@studenti.unimore.it'),(718,'SIMONE','BARBIERI','208373@studenti.unimore.it'),(719,'OMAR','GHBARIEH','181334@studenti.unimore.it'),(720,'LORENZO','MONTORSI','206615@studenti.unimore.it'),(721,'ALESSIO','POPOLI','203987@studenti.unimore.it'),(722,'SARAH','TARHY','203608@studenti.unimore.it'),(723,'CARMINE','TURSI','206945@studenti.unimore.it'),(724,'VINCENZO','BRUNO','204664@studenti.unimore.it'),(725,'GIOVANNI BATTISTA','GAGLIANO','207761@studenti.unimore.it'),(726,'DAVIDE','NOBILE','205778@studenti.unimore.it'),(727,'FRANCESCO','DE BARTOLOMEO','208944@studenti.unimore.it'),(728,'LUCIA','BUONDONNO','192443@studenti.unimore.it'),(729,'FEDERICO','CANNIZZARO','168291@studenti.unimore.it'),(730,'OSCAR JOSE\'','ROMERO','189299@studenti.unimore.it'),(731,'FEDERICO','POZZI','207585@studenti.unimore.it'),(732,'FRANCESCO','NICOLI','92227@studenti.unimore.it'),(733,'DONATA','GUERRA','208797@studenti.unimore.it'),(734,'MARIO','PEDICINO','209551@studenti.unimore.it'),(735,'MARCO','TURRINI','32689@studenti.unimore.it'),(736,'SILVIO','PERGREFFI','21987@studenti.unimore.it'),(737,'DARIO','ASTI','42175@studenti.unimore.it'),(738,'CHIARA','RIGOLON','53451@studenti.unimore.it'),(739,'LUCIA','BENASSI','58527@studenti.unimore.it'),(740,'ELENA','COSTANZINI','54398@studenti.unimore.it'),(741,'VIVIANA','PEGGI','59014@studenti.unimore.it'),(742,'SARA','LANZARINI','59791@studenti.unimore.it'),(743,'ZHOUR','HARBOULI','61235@studenti.unimore.it'),(744,'NICOLA','PALTRINIERI','61313@studenti.unimore.it'),(745,'ANDREA','BIAGINI','61875@studenti.unimore.it'),(746,'ANDREA','GIBERTI','64429@studenti.unimore.it'),(747,'LISA','BELLEI','65390@studenti.unimore.it'),(748,'ALESSIA','CORSINI','65515@studenti.unimore.it'),(749,'TERESA ERSILIA','MURGOLO','112185@studenti.unimore.it'),(750,'ANNA','RONCAGLIA','71272@studenti.unimore.it'),(751,'ANITA','LUGLI','71517@studenti.unimore.it'),(752,'MARGHERITA MARIA','FERRARI','71520@studenti.unimore.it'),(753,'LAURA','NASI','72567@studenti.unimore.it'),(754,'MATTEO','LANDI','26229@studenti.unimore.it'),(755,'GIULIA','GASPARINI','51885@studenti.unimore.it'),(756,'TANYA','RIGHETTI','73433@studenti.unimore.it'),(757,'STEFANIA','ROMANO','73984@studenti.unimore.it'),(758,'MATTEO','ROBERTI','81089@studenti.unimore.it'),(759,'SAMANTA','ZANFI','66080@studenti.unimore.it'),(760,'CRISTINA','TOLOMELLI','78058@studenti.unimore.it'),(761,'RICCARDO','BELTRAMI','78059@studenti.unimore.it'),(762,'CHIARA','VITALI','83482@studenti.unimore.it'),(763,'ALARICO','VIOLI','57942@studenti.unimore.it'),(764,'FRANCESCO','NICOLUSSI GOLO','59759@studenti.unimore.it'),(765,'GRETA','PINNA','60343@studenti.unimore.it'),(766,'VALENTINA','LENZINI','65567@studenti.unimore.it'),(767,'MARCELLO','PRANDI','67105@studenti.unimore.it'),(768,'LUCIA','MENOZZI','67267@studenti.unimore.it'),(769,'CARLA','BERTOCCHI','67592@studenti.unimore.it'),(770,'CLAUDIA','ASTARITA','70160@studenti.unimore.it'),(771,'ALESSANDRO','ALBERONI','70675@studenti.unimore.it'),(772,'LORENZO','DIAZZI','71343@studenti.unimore.it'),(773,'LARA','SPADANO','71348@studenti.unimore.it'),(774,'ELISABETTA','BERGAMINI','71432@studenti.unimore.it'),(775,'PATRIZIA','VEZZALI','71655@studenti.unimore.it'),(776,'GIUSEPPE MARCO','INTRIERI','71707@studenti.unimore.it'),(777,'NICOLETTA','INCERTI','71857@studenti.unimore.it'),(778,'FRANCESCO','DRAISCI','71881@studenti.unimore.it'),(779,'MARINA LUCE','DI STEFANO','72060@studenti.unimore.it'),(780,'ELENA','MAGNANINI','72998@studenti.unimore.it'),(781,'VERONICA','FURINI','73536@studenti.unimore.it'),(782,'ANNALISA','PAGLIANI','73542@studenti.unimore.it'),(783,'VALENTINA','GALIOTTO','73898@studenti.unimore.it'),(784,'GIADA','AIETA','74055@studenti.unimore.it'),(785,'ROBERTO','GIALDINI','74127@studenti.unimore.it'),(786,'EDOARDO CARLO','LUPOLI','74769@studenti.unimore.it'),(787,'GIULIA','TALAMI','74892@studenti.unimore.it'),(788,'MIRKO','CAROLLO','77469@studenti.unimore.it'),(789,'SUSY','RIMINUCCI','77525@studenti.unimore.it'),(790,'ENRICO','FERRI','77528@studenti.unimore.it'),(791,'MATTEO','PIFFERI','77820@studenti.unimore.it'),(792,'CHIARA','SEVERINI','77867@studenti.unimore.it'),(793,'FRANCESCA','VIAPPIANI','77993@studenti.unimore.it'),(794,'ANDREA','ROCCAVERDE','78148@studenti.unimore.it'),(795,'CECILIA','BOSCHINI','78591@studenti.unimore.it'),(796,'SIMONE','TURCI','80275@studenti.unimore.it'),(797,'FRANCESCA','MORANI','80976@studenti.unimore.it'),(798,'MARIA VITTORIA','IADEROSA','81307@studenti.unimore.it'),(799,'COSIMO','FIORINI','81308@studenti.unimore.it'),(800,'SARA','SEMEGHINI','81949@studenti.unimore.it'),(801,'SARA','PALLADI','81995@studenti.unimore.it'),(802,'ELISA','GUIDETTI','82291@studenti.unimore.it'),(803,'DEBORA','PIAZZI','84391@studenti.unimore.it'),(804,'DAVIDE','PIGOZZI','84981@studenti.unimore.it'),(805,'GIULIA','SEIDENARI','85049@studenti.unimore.it'),(806,'ERICA','CAVEDONI','85084@studenti.unimore.it'),(807,'CATERINA','MANZINI','85095@studenti.unimore.it'),(808,'ELISA','SEDONI','85117@studenti.unimore.it'),(809,'ERIK','MORGANTE','85193@studenti.unimore.it'),(810,'ALBERTO','MANZINI','85608@studenti.unimore.it'),(811,'MATTIA','VERONI','86416@studenti.unimore.it'),(812,'MATTEO','SPALLANZANI','86461@studenti.unimore.it'),(813,'SARA','PASTORELLO','86720@studenti.unimore.it'),(814,'MARIACHIARA','FERRARI','86878@studenti.unimore.it'),(815,'SERENA','SEVERI','86939@studenti.unimore.it'),(816,'DAVIDE','GUALANDRI','87342@studenti.unimore.it'),(817,'FILIPPO','RAIMONDI','88266@studenti.unimore.it'),(818,'MARIA CHIARA','RIGHI','88287@studenti.unimore.it'),(819,'MARGHERITA','ODONE','88728@studenti.unimore.it'),(820,'ELJA','KOZELI','89094@studenti.unimore.it'),(821,'MARCO','GALLI','89215@studenti.unimore.it'),(822,'ANDREA','RADIGHIERI','89306@studenti.unimore.it'),(823,'MARTA','DE GENNARO','89386@studenti.unimore.it'),(824,'ELIA','GIACOBAZZI','89390@studenti.unimore.it'),(825,'CHIARA','VICINI','80776@studenti.unimore.it'),(826,'CORRADO','IORI','82468@studenti.unimore.it'),(827,'LUCIA','GALANTE','82623@studenti.unimore.it'),(828,'BARBARA','MARTELLA','83408@studenti.unimore.it'),(829,'HANNA OLIWIA','RADECKA','90192@studenti.unimore.it'),(830,'ANDREA','GUGLIELMI','90353@studenti.unimore.it'),(831,'SARA','FACCHINI','90360@studenti.unimore.it'),(832,'SARA','DAVOLI','90407@studenti.unimore.it'),(833,'LUCA','CHIERICI','90476@studenti.unimore.it'),(834,'SARA','ZIVIERI','90510@studenti.unimore.it'),(835,'BENEDETTA','TAROZZI','90520@studenti.unimore.it'),(836,'MONICA','SELIGARDI','90521@studenti.unimore.it'),(837,'MARCO','ZINI','92182@studenti.unimore.it'),(838,'GABRIELE','TASSI','4665@studenti.unimore.it'),(839,'AMELEWORK','LAURIOLA','163072@studenti.unimore.it'),(840,'SIMONE','GAVIOLI','163125@studenti.unimore.it'),(841,'EDOARDO','SANTIMONE','163269@studenti.unimore.it'),(842,'VANESSA','MANNINA','88855@studenti.unimore.it'),(843,'SIMONE','STUPPAZZINI','163326@studenti.unimore.it'),(844,'LEONARDO','CUOGHI','165230@studenti.unimore.it'),(845,'IACOPO','FERRARI','165240@studenti.unimore.it'),(846,'ALESSANDRO','PEDERZOLI','166054@studenti.unimore.it'),(847,'LORENZO','CONTINI','166370@studenti.unimore.it'),(848,'LUCIO','MORINI','166552@studenti.unimore.it'),(849,'ROBERTO','OGNIBENE','166827@studenti.unimore.it'),(850,'RAIMONDO','BUFFO','167164@studenti.unimore.it'),(851,'KHEYZEL CALANGI','RAVINA','167169@studenti.unimore.it'),(852,'LUCA','VIAPPIANI','167440@studenti.unimore.it'),(853,'SILVIA','MARTINELLI','167723@studenti.unimore.it'),(854,'FRANCESCA','PEDRAZZOLI','168145@studenti.unimore.it'),(855,'LUCIA','MAZZALI','168267@studenti.unimore.it'),(856,'MICHELE','GIGLIO','168729@studenti.unimore.it'),(857,'FRANCESCO','BONISOLI','168995@studenti.unimore.it'),(858,'JOYCELYN BAABA','KRUBI','168998@studenti.unimore.it'),(859,'ELIA CARLO','ZIRONDELLI','169146@studenti.unimore.it'),(860,'MATTEO','CERVETTI','169188@studenti.unimore.it'),(861,'ANDREA','MARTIGNONI','169629@studenti.unimore.it'),(862,'GERARDO','PACE','169787@studenti.unimore.it'),(863,'EMANUELE','MALAGOLI','169864@studenti.unimore.it'),(864,'SILVIA','CARMIGNAN','169888@studenti.unimore.it'),(865,'DANIELE','GARZONI','170151@studenti.unimore.it'),(866,'MARILIGIA','LOIZZO','170510@studenti.unimore.it'),(867,'STEFANO','COLLI','170584@studenti.unimore.it'),(868,'MARCO','IAQUINTA','170799@studenti.unimore.it'),(869,'DAVIDE','TROTTA','170829@studenti.unimore.it'),(870,'LAURA','COCCHI','172760@studenti.unimore.it'),(871,'INAYAT','IMRAN','173772@studenti.unimore.it'),(872,'FRANCESCA','ANCESCHI','176961@studenti.unimore.it'),(873,'HARMAN','SAINI','176985@studenti.unimore.it'),(874,'CHIARA','GAVIOLI','177557@studenti.unimore.it'),(875,'GIULIA','GIAMBARRESI','177664@studenti.unimore.it'),(876,'ERIKA','FERRI','178387@studenti.unimore.it'),(877,'GIULIA','ZANASI','178517@studenti.unimore.it'),(878,'ADELAIDE','CUZZI','178808@studenti.unimore.it'),(879,'VALERIA','DONDI','179702@studenti.unimore.it'),(880,'FEDERICA','PARONETTO','180029@studenti.unimore.it'),(881,'LAURA','DE CONTI','180096@studenti.unimore.it'),(882,'LETIZIA','LABATE','180502@studenti.unimore.it'),(883,'FILIPPO','CAMELLINI','180804@studenti.unimore.it'),(884,'ANDREA','ZAFFERI','180912@studenti.unimore.it'),(885,'PIERFRANCESCO','DE FALCIS','181566@studenti.unimore.it'),(886,'CHRISTOPHER','SPENNATO','181607@studenti.unimore.it'),(887,'GIULIA','GHIGLIAZZA','181782@studenti.unimore.it'),(888,'DAVIDE','LUISI','181852@studenti.unimore.it'),(889,'ANDREA','PELLATI','181987@studenti.unimore.it'),(890,'MATTIA','FRANZONI','182191@studenti.unimore.it'),(891,'LIDIA','GETI','182594@studenti.unimore.it'),(892,'ALICE','CODELUPPI','183988@studenti.unimore.it'),(893,'ERICA','BENEDETTI','186918@studenti.unimore.it'),(894,'MARIA LAURA','SOLMI','188801@studenti.unimore.it'),(895,'SARA','GRASSI','189296@studenti.unimore.it'),(896,'CRISTINA','ZANNI','190642@studenti.unimore.it'),(897,'SARA','FERRARI','191058@studenti.unimore.it'),(898,'FRANCESCA','MISELLI','191280@studenti.unimore.it'),(899,'MARIA','CALZOLARI','191639@studenti.unimore.it'),(900,'FEDERICA','BASSI','191894@studenti.unimore.it'),(901,'LUCA','BENATTI','192389@studenti.unimore.it'),(902,'CHIARA','MAGNANI','192490@studenti.unimore.it'),(903,'LAURA','MARCHETTI','192681@studenti.unimore.it'),(904,'CHIARA','BIGNARDI','192710@studenti.unimore.it'),(905,'GIUSEPPE','TANCREDI','192877@studenti.unimore.it'),(906,'MARILENA','MARCHI ADANI','192955@studenti.unimore.it'),(907,'ANNA','FOSSALI','192945@studenti.unimore.it'),(908,'BEATRICE','SALVINI','193104@studenti.unimore.it'),(909,'MIGLENA','ASENOVA','193438@studenti.unimore.it'),(910,'LORENZO','CAMPANI','193938@studenti.unimore.it'),(911,'FLAVIA','MARTELLA','193973@studenti.unimore.it'),(912,'PAOLO','CAVICCHIOLI','202745@studenti.unimore.it'),(913,'SARA','IBATICI','203601@studenti.unimore.it'),(914,'MARIA VALENTINA','MARRA','204480@studenti.unimore.it'),(915,'MARTINA','CHIERICI','203131@studenti.unimore.it'),(916,'LAURA','SIMONAZZI','205309@studenti.unimore.it'),(917,'MARCO','CAPRARI','205569@studenti.unimore.it'),(918,'VALENTINA','BERTANI','205071@studenti.unimore.it'),(919,'ALESSANDRO','ALGERI','204344@studenti.unimore.it'),(920,'ANDREA','TORRICELLI','205548@studenti.unimore.it'),(921,'RICCARDO','PERAZZOLO','203176@studenti.unimore.it'),(922,'LEONARDO','PIGONI','207080@studenti.unimore.it'),(923,'TOMMASO','BERTOCCHI','204669@studenti.unimore.it'),(924,'ELISA','MARONI','205437@studenti.unimore.it'),(925,'GIAN CARLO','DAL FOLCO','207618@studenti.unimore.it'),(926,'JHONNY','BERGIANTI','207354@studenti.unimore.it'),(927,'ALBERTO','RUGGI','204943@studenti.unimore.it'),(928,'ALICE','GRILLINI','207650@studenti.unimore.it'),(929,'SOFIA','CATTALINI','207368@studenti.unimore.it'),(930,'ERICA','IPOCOANA','207531@studenti.unimore.it'),(931,'CAMILLA','DI LUCA','207882@studenti.unimore.it'),(932,'ALBERTO','BOSELLI','181898@studenti.unimore.it'),(933,'LETIZIA','NICOLINI','196932@studenti.unimore.it'),(934,'ARIANNA','CAVANI','203877@studenti.unimore.it'),(935,'GIULIA','BELTRAMI','206237@studenti.unimore.it'),(936,'MATTEO','MAGNANI','207636@studenti.unimore.it'),(937,'JESSICA','BACCILIERI','207223@studenti.unimore.it'),(938,'GINEVRA MARIANNA GIUDITTA','CERAMI','204511@studenti.unimore.it'),(939,'GABRIELE','CASELLI','207231@studenti.unimore.it'),(940,'GIORDANO','DUO','196323@studenti.unimore.it'),(941,'FRANCESCO','BOZZOLA','208051@studenti.unimore.it'),(942,'MANUEL','LAFFI','205308@studenti.unimore.it'),(943,'ANNALAURA','REBUCCI','205934@studenti.unimore.it'),(944,'VALERIA','BUONDONNO','208597@studenti.unimore.it'),(945,'DARIO','COSTA','203178@studenti.unimore.it'),(946,'MADDALENA','ZUCCHI','196805@studenti.unimore.it'),(947,'GIORGIA','FRANCHINI','23093@studenti.unimore.it'),(948,'GRAZIANA','DI GREGORIO','208329@studenti.unimore.it');
/*!40000 ALTER TABLE `dispense_studente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispense_userprofile`
--

DROP TABLE IF EXISTS `dispense_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dispense_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `activation_key` varchar(40) NOT NULL,
  `key_expires` datetime NOT NULL,
  `not_globali` tinyint(1) NOT NULL,
  `ban` tinyint(1) NOT NULL,
  `registrabile` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_id_refs_id_4ee9ef70` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispense_userprofile`
--

LOCK TABLES `dispense_userprofile` WRITE;
/*!40000 ALTER TABLE `dispense_userprofile` DISABLE KEYS */;
INSERT INTO `dispense_userprofile` VALUES (1,1,'SU','2015-05-19 08:40:34',1,0,1);
/*!40000 ALTER TABLE `dispense_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'site','sites','site'),(7,'log entry','admin','logentry'),(8,'corso','dispense','corso'),(9,'studente','dispense','studente'),(10,'insegnamento','dispense','insegnamento'),(11,'user profile','dispense','userprofile'),(12,'notifica','dispense','notifica'),(13,'dispensa','dispense','dispensa'),(14,'opinione','dispense','opinione'),(15,'commentarium','dispense','commentarium'),(16,'segnalazione','dispense','segnalazione'),(17,'bannato','dispense','bannato');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('ytryq1q83aol0rhs8mqzteeglrcaostn','ZTk4MjYzZGIyY2VjMTUxOGJhNWYwNmY3YWQ2ZGQwYjU5OWEyZDUyYjqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHEDVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==','2015-06-02 08:41:47');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-19 10:49:50
