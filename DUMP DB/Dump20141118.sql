CREATE DATABASE  IF NOT EXISTS `cc6` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `cc6`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: 127.0.0.1    Database: cc6
-- ------------------------------------------------------
-- Server version	5.6.16

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
-- Table structure for table `bin`
--

DROP TABLE IF EXISTS `bin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bin` (
  `binId` int(11) NOT NULL DEFAULT '0',
  `bin` bigint(20) DEFAULT NULL,
  `descripcion` char(100) DEFAULT NULL,
  `correlativo` int(11) DEFAULT NULL,
  PRIMARY KEY (`binId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bin`
--

LOCK TABLES `bin` WRITE;
/*!40000 ALTER TABLE `bin` DISABLE KEYS */;
INSERT INTO `bin` VALUES (412587,4125870000000000,'PREMIER',3),(423698,4236980000000000,'PLATINUM',7),(456987,4569870000000000,'CLASICA',3);
/*!40000 ALTER TABLE `bin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombreCliente` varchar(100) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `genero` char(1) DEFAULT NULL,
  `nomenclaturaDireccion` varchar(100) DEFAULT NULL,
  `zona` int(2) DEFAULT NULL,
  `colonia` int(11) DEFAULT NULL,
  `departamento` int(11) DEFAULT NULL,
  `municipio` int(11) DEFAULT NULL,
  `telefono1` int(8) DEFAULT NULL,
  `telefono2` int(8) DEFAULT NULL,
  `nit` varchar(100) NOT NULL,
  `dpi` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE KEY `nit` (`nit`),
  UNIQUE KEY `dpi` (`dpi`),
  UNIQUE KEY `email` (`email`),
  KEY `departamento` (`departamento`),
  KEY `municipio` (`municipio`),
  CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`departamento`) REFERENCES `departamentos` (`idDepartamento`),
  CONSTRAINT `clientes_ibfk_2` FOREIGN KEY (`municipio`) REFERENCES `municipios` (`idMunicipio`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'MILTON AARON GODINEZ RIVAS','1991-11-06','M','38 CALLE A 4-43',8,NULL,1,1,58251533,NULL,'68253400','2080205510101','milaronix@gmail.com'),(9,'WALTER GODINEZ','2014-11-24','M','38 CALLE A 4-43',8,0,1,1,247625321,58251643,'6825340M','2080205410101','WALTERNGP@HOTMAIL.COM'),(10,'CINDY ZAMORA INTERIANO','2014-10-13','F','35 CALLE 3-89',5,0,5,391,24235252,56475925,'60274301','2050854690102','CINDY.ZAMORA@GALILEO.EDU'),(19,'JORGE LUIS VELIZ RODRIGUEZ','1985-01-13','M','35 CALLE B 4-98',5,0,1,1,58693214,0,'236587K','20805546213','JORGE.VELIZ@GMAIL.COM'),(21,'ANIBAL ANTONIO ZECENIA SANTOS','1990-11-10','M','7MA AVENIDA 4-75',15,0,1,1,58256497,24569871,'548796L','208065475974','ANIBAL.SANTOS@GMAIL.COM');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas`
--

DROP TABLE IF EXISTS `cuentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuentas` (
  `idCuenta` int(11) NOT NULL AUTO_INCREMENT,
  `numerodecuenta` bigint(20) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `fechaApertura` date DEFAULT NULL,
  `saldo` double DEFAULT NULL,
  `bin` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idCuenta`),
  UNIQUE KEY `numeroDeCuenta` (`numerodecuenta`),
  KEY `idCliente` (`idCliente`),
  CONSTRAINT `cuentas_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas`
--

LOCK TABLES `cuentas` WRITE;
/*!40000 ALTER TABLE `cuentas` DISABLE KEYS */;
INSERT INTO `cuentas` VALUES (1,4236980000000002,10,'2014-11-16',0,4236980000000000),(2,4236980000000003,10,'2014-11-16',600,4236980000000000),(3,4125870000000002,10,'2014-11-16',0,4125870000000000),(4,4236980000000004,10,'2014-11-16',0,4236980000000000),(5,4125870000000003,10,'2014-11-16',0,4125870000000000),(6,4236980000000005,1,'2014-11-16',0,4236980000000000),(7,4569870000000002,1,'2014-11-16',50,4569870000000000),(8,4236980000000006,9,'2014-11-16',0,4236980000000000),(13,4236980000000007,19,'2014-11-18',1500,4236980000000000),(14,4569870000000003,21,'2014-11-18',1000,4569870000000000);
/*!40000 ALTER TABLE `cuentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departamentos` (
  `idDepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idDepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamentos`
--

LOCK TABLES `departamentos` WRITE;
/*!40000 ALTER TABLE `departamentos` DISABLE KEYS */;
INSERT INTO `departamentos` VALUES (1,'GUATEMALA'),(2,'ALTA VERAPAZ'),(3,'BAJA VERAPAZ'),(4,'CHIMALTENANGO'),(5,'CHIQUIMULA'),(6,'EL PROGRESO'),(7,'EL QUICHE'),(8,'ESCUINTLA'),(9,'HUEHUETENANGO'),(10,'IZABAL'),(11,'JALAPA'),(12,'JUTIAPA'),(13,'PETEN'),(14,'QUETZALTENANGO'),(15,'RETALHULEU'),(16,'SACATEPEQUEZ'),(17,'SAN MARCOS'),(18,'SANTA ROSA'),(19,'SOLOLA'),(20,'SUCHITEPEQUEZ'),(21,'TOTONICAPAN'),(22,'ZACAPA');
/*!40000 ALTER TABLE `departamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `municipios`
--

DROP TABLE IF EXISTS `municipios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `municipios` (
  `idMunicipio` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) DEFAULT NULL,
  `idDepartamento` int(11) DEFAULT NULL,
  PRIMARY KEY (`idMunicipio`),
  KEY `idDepartamento` (`idDepartamento`),
  CONSTRAINT `municipios_ibfk_1` FOREIGN KEY (`idDepartamento`) REFERENCES `departamentos` (`idDepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=656 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `municipios`
--

LOCK TABLES `municipios` WRITE;
/*!40000 ALTER TABLE `municipios` DISABLE KEYS */;
INSERT INTO `municipios` VALUES (1,'GUATEMALA',1),(329,'SANTA CATARINA PINULA',1),(330,'SAN JOSE PINULA',1),(331,'SAN JOSE DEL GOLFO',1),(332,'PALENCIA',1),(333,'CHINAUTLA',1),(334,'SAN PEDRO AYAMPUC',1),(335,'MIXCO',1),(336,'SAN PEDRO SACATEPEQUEZ',1),(337,'SAN JUAN SACATEPEQUEZ',1),(338,'SAN RAYMUNDO',1),(339,'CHUARRANCHO',1),(340,'FRAIJANES',1),(341,'AMATITLAN',1),(342,'VILLA NUEVA',1),(343,'VILLA CANALES',1),(344,'SAN MIGUEL PETAPA ',1),(345,'COBAN',2),(346,'SANTA CRUZ VERAPAZ',2),(347,'SAN CRISTOBAL VERAPAZ',2),(348,'TACTIC',2),(349,'TAMAHU',2),(350,'SAN MIGUEL TUCURU',2),(351,'PANZOS',2),(352,'SENAHU',2),(353,'SAN PEDRO CARCHA',2),(354,'SANJUAN CHAMELCO',2),(355,'LANQUIN',2),(356,'SANTA MARIA CAHABON',2),(357,'CHISEC',2),(358,'CHAHAL',2),(359,'FRAY BARTOLOME DE LAS CASAS',2),(360,'SANTA CATARINA LA TINTA ',2),(361,'SALAMA',3),(362,'SAN MIGUEL CHICAJ',3),(363,'RABINAL',3),(364,'CUBULCO',3),(365,'GRANADOS',3),(366,'SANTA CRUZ EL CHOL',3),(367,'SAN JERONIMO',3),(368,'PURULHA ',3),(369,'CHIMALTENANGO',4),(370,'SAN JOSE POAQUIL',4),(371,'SAN MARTIN JILOTEPEQUE',4),(372,'SAN JUAN COMALAPA',4),(373,'SANTA APOLONIA',4),(374,'TECPAN GUATEMALA',4),(375,'PATZUN',4),(376,'SAN MIGUEL POCHUTA',4),(377,'PATZICIA',4),(378,'SANTA CRUZ BALANYA',4),(379,'ACATENANGO',4),(380,'SAN PEDRO YEPOCAPA',4),(381,'SAN ANDRES ITZAPA',4),(382,'PARRAMOS',4),(383,'ZARAGOZA',4),(384,'EL TEJAR ',4),(385,'CHIQUIMULA',5),(386,'SAN JOSE LA ARADA',5),(387,'SAN JUAN HERMITA',5),(388,'JOCOTAN',5),(389,'CAMOTAN',5),(390,'OLOPA',5),(391,'ESQUIPULAS',5),(392,'CONCEPCION LAS MINAS',5),(393,'QUEZALTEPEQUE',5),(394,'SAN JACINTO',5),(395,'IPALA',5),(396,'GUASTATOYA',6),(397,'MORAZAN',6),(398,'SAN AGUSTIN ACASAGUASTLAN',6),(399,'SAN CRISTOBAL ACASAGUASTLAN',6),(400,'EL JICARO',6),(401,'SANSARE',6),(402,'SANARATE',6),(403,'SAN ANTONIO LA PAZ ',6),(404,'SANTA CRUZ DEL QUICHE',7),(405,'CHICHE',7),(406,'CHINIQUE',7),(407,'ZACUALPA',7),(408,'CHAJUL',7),(409,'SANTO TOMAS CHICHICSTENANGO',7),(410,'PATZITE',7),(411,'SAN ANTONIO ILOTENANGO',7),(412,'SAN PEDRO JOCOPILAS',7),(413,'CUNEN',7),(414,'SAN JUAN COTZAL',7),(415,'JOYABAJ',7),(416,'SANTA MARIA NEBAJ',7),(417,'SAN ANDRES SAJCABAJA',7),(418,'SAN MIGUEL USPATAN SACAPULAS',7),(419,'SAN BARTOLOME JOCOTENANGO',7),(420,'CANILLA',7),(421,'CHICAMAN',7),(422,'PLAYA GRNADE - IXCAN',7),(423,'PACHALUM ',7),(424,'ESCUINTLA',8),(425,'SANTA LUCIA COTZUMALGUAPA',8),(426,'LA DEMOCRACIA',8),(427,'SIQUINALA',8),(428,'MASAGUA',8),(429,'PUEBLO NUEVO TIQUISATE',8),(430,'LA GOMERA',8),(431,'GUANAGAZAPA',8),(432,'PUERTO DE SAN JOSE',8),(433,'IZTAPA',8),(434,'PALIN',8),(435,'SAN VICENTE PACAYA NUEVA CONCEPCION ',8),(436,'HUEHUETENANGO',9),(437,'CHIANTLA',9),(438,'MALACATANCITO',9),(439,'CUILCO',9),(440,'NENTON',9),(441,'SAN PEDRO NECT',9),(442,'A JACALTENANGO',9),(443,'SAN PEDRO SOLOMA',9),(444,'SAN ILDELFONSO IXTAHUAC´N',9),(445,'SANTA BARBARA',9),(446,'LA LIBERTAD',9),(447,'LA DEMOCRACIA',9),(448,'SAN MIGUEL ACATAN',9),(449,'SAN RAFAEL LA INDEPENDENCIA',9),(450,'TODOS SANTOS CHUCHCUMATAN',9),(451,'SAN JUAN ATITAN',9),(452,'SANTA EULALIA',9),(453,'SAN MATEO IXTATAN',9),(454,'COLOTENANGO',9),(455,'SAN SEBASTIAN HUEHUETENANGO',9),(456,'TECTITAN',9),(457,'CONCEPCION HUISTA',9),(458,'SAN JUAN IXCOY',9),(459,'SAN ANTONIO HUISTA',9),(460,'SAN SEBASTIAN COATAN',9),(461,'SANTA CRUZ BARILLAS',9),(462,'AGUACATAN',9),(463,'SAN RAFAEL PETZAL',9),(464,'SAN GASPAR IXCHIL',9),(465,'SANTIAGO CHIMALTENANGO',9),(466,'SANTA ANA HUISTA ',9),(467,'PUERTO BARRIOS',10),(468,'LIVINGSTON',10),(469,'EL ESTOR',10),(470,'MORALES',10),(471,'LOS AMATES',10),(472,'JALAPA',11),(473,'SAN PEDRO PINULA',11),(474,'SAN LUIS JILOTEPEQUE',11),(475,'SAN MANUEL CHAPARRON',11),(476,'SAN CARLOS ALZATATE',11),(477,'MONJAS',11),(478,'MATAQUESCUINTLA ',11),(479,'JUTIAPA',12),(480,'EL PROGRESO',12),(481,'SANTA CATARINA MITA',12),(482,'AGUA BLANCA',12),(483,'ASUNCION MITA',12),(484,'YUPILTEPEQUE',12),(485,'ATESCATEMPA',12),(486,'JEREZ',12),(487,'EL ADELANTO',12),(488,'ZAPOTITLAN',12),(489,'COMAPA',12),(490,'JALPATAGUA',12),(491,'CONGUACO',12),(492,'MOYUTA',12),(493,'PASACO',12),(494,'SAN JOSE ACATEMPA',12),(495,'QUEZADA ',12),(496,'FLORES',13),(497,'SAN JOSE',13),(498,'SAN BENITO',13),(499,'SAN ANDRES',13),(500,'LA LIBERTAD',13),(501,'SAN FRANCISCO',13),(502,'SANTA ANA',13),(503,'DOLORES',13),(504,'SAN LUIS',13),(505,'SAYAXCHE',13),(506,'MELCHOR DE MENCOS',13),(507,'POPTUN ',13),(508,'QUETZALTENANGO',14),(509,'SALCAJA',14),(510,'OLINTEPEQUE',14),(511,'SAN CARLOS SIJA',14),(512,'SIBILIA',14),(513,'CABRICAN',14),(514,'CAJOLA',14),(515,'SAN MIGUEL SIGUILÇA',14),(516,'SAN JUAN OSTUNCALCO',14),(517,'SAN MATEO',14),(518,'CONCEPCION CHIQUIRICHAPA',14),(519,'SAN MARTIN SACATEPEQUEZ',14),(520,'ALMOLONGA',14),(521,'CANTEL',14),(522,'HUITAN',14),(523,'ZUNIL',14),(524,'COLOMBA',14),(525,'SAN FRANCISCO LA UNION',14),(526,'EL PALMAR',14),(527,'COATEPEQUE',14),(528,'GENOVA',14),(529,'FLORES COSTA CUCA LA ESPERANZA',14),(530,'PALESTINA DE LOS ALTOS ',14),(531,'RETALHULEU',15),(532,'SAN SEBASTIAN',15),(533,'SANTA CRUZ MULUA',15),(534,'SAN MARTIN ZAPOTITLAN',15),(535,'SAN FELIPE RETALHULEU',15),(536,'SAN ANDRES VILLA SECA',15),(537,'CHAMPERICO',15),(538,'NUEVO SAN CARLOS',15),(539,'EL ASINTAL ',15),(540,'ANTIGUA GUATEMALA',16),(541,'JOCOTENANGO',16),(542,'PASTORES',16),(543,'SUMPANGO',16),(544,'SANTO DOMINGO XENACOJ',16),(545,'SANTIAGO SACATEPEQUEZ',16),(546,'SAN BARTOLOME MILPAS ALTAS',16),(547,'SAN LUCAS SACATEPEQUEZ',16),(548,'SANTA LUCIA MILPAS ALTAS',16),(549,'MAGDALENA MILPAS ALTAS',16),(550,'SANTA MARIA DE JESUS',16),(551,'CIUDAD VIEJA',16),(552,'SAN MIGUEL DUEÑAS',16),(553,'SAN JUAN ALOTENANGO',16),(554,'SAN ANTONIO AGUAS CALIENTES',16),(555,'SANTA CATARINA BARAHONA ',16),(556,'SAN MARCOS',17),(557,'SAN PEDRO SACATEPEQUEZ',17),(558,'COMITANCILLO',17),(559,'SAN ANTONIO SACATEPEQUEZ',17),(560,'SAN MIGUEL IXTAHUACAN',17),(561,'CONCEPCION TUTUAPA',17),(562,'TACANA',17),(563,'SIBINAL',17),(564,'TAJUMULCO',17),(565,'TEJUTLA',17),(566,'SAN RAFAEL PIE DE LA CUESTA',17),(567,'NUEVO PROGRESO',17),(568,'EL TUMBADOR',17),(569,'SAN JOSE EL RODEO',17),(570,'MALACATAN',17),(571,'CATARINA',17),(572,'AYUTLA',17),(573,'OCOS',17),(574,'SAN PABLO',17),(575,'EL QUETZAL',17),(576,'LA REFORMA',17),(577,'PAJAPITA',17),(578,'IXCHIGUAN',17),(579,'SAN JOSE OJETENAN',17),(580,'SAN CRISTOBAL CUCHO',17),(581,'SIPACAPA',17),(582,'ESQUIPULAS PALO GORDO',17),(583,'RIO BLANCO',17),(584,'SAN LORENZO ',17),(585,'CUILAPA',18),(586,'BERBERENA',18),(587,'SAN ROSA DE LIMA',18),(588,'CASILLAS',18),(589,'SAN RAFAEL LAS FLORES',18),(590,'ORATORIO',18),(591,'SAN JUAN TECUACO',18),(592,'CHIQUIMULILLA',18),(593,'TAXISCO',18),(594,'SANTA MARIA IXHUATAN',18),(595,'GUAZACAPAN',18),(596,'SANTA CRUZ NARANJO',18),(597,'PUEBLO NUEVO VIÑAS',18),(598,'NUEVA SANTA ROSA ',18),(599,'SOLOLA',19),(600,'SAN JOSE CHACAYA',19),(601,'SANTA MARIA VISITACION',19),(602,'SANTA LUCIA UTATLAN',19),(603,'NAHUALA',19),(604,'SANTA CATARINA IXTAHUACAN',19),(605,'SANTA CLARA LA LAGUNA',19),(606,'CONCEPCION',19),(607,'SAN ANDRES SEMETABAJ',19),(608,'PANAJACHEL',19),(609,'SANTA CATARINA PALOPO',19),(610,'SAN ANTONIO PALOPO',19),(611,'SAN LUCAS TOLIMAN',19),(612,'SANTA CRUZ LA LAGUNA',19),(613,'SNA PABLO LA LAGUNA',19),(614,'SAN MARCOS LA LAGUNA',19),(615,'SAN JUAN LA LAGUNA',19),(616,'SAN PEDRO LA LAGUNA',19),(617,'SANTIAGO ATITLAN ',19),(618,'MAZATENANGO',20),(619,'CUYOTENANGO',20),(620,'SAN FRANCISCO ZAPOTITLAN',20),(621,'SAN BERNARDINO',20),(622,'SAN JOSE EL IDOLO',20),(623,'SANTO DOMINGO SUCHITEPEQUEZ',20),(624,'SAN LORENZO',20),(625,'SAMAYAC',20),(626,'SAN PABLO JOCOPILAS',20),(627,'SAN ANTONIO SUCHITEPEQUEZ',20),(628,'SAN MIGUEL PANAN',20),(629,'SAN GABRIEL',20),(630,'CHICACAO',20),(631,'PATULUL',20),(632,'SANTA BARBARA',20),(633,'SAN JUAN BAUTISTA',20),(634,'SANTO TOMAS LA UNION',20),(635,'ZUNILITO',20),(636,'PUEBLO NUEVO SUCHITEPEQUEZ',20),(637,'RIO BRAVO ',20),(638,'TOTONICAPAN',21),(639,'SAN CRISTOBAL TOTONICAPAN',21),(640,'SAN FRANCISCO EL ALTO',21),(641,'SAN ANDRES XECUL',21),(642,'MOMOSTENANGO',21),(643,'SANTA MARIA CHIQUIMULA',21),(644,'SANTA LUCIA LA REFORMA',21),(645,'SAN BARTOLO AGUAS CALIENTES ',21),(646,'ZACAPA',22),(647,'ESTANZUELA',22),(648,'RIO HONDO',22),(649,'GUALAN',22),(650,'TECULUTAN',22),(651,'USUMATLAN',22),(652,'CABAÑAS',22),(653,'SAN DIEGO',22),(654,'LA UNION',22),(655,'HUITE',22);
/*!40000 ALTER TABLE `municipios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipotransacciones`
--

DROP TABLE IF EXISTS `tipotransacciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipotransacciones` (
  `tipoTransaccion` char(1) NOT NULL DEFAULT '',
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`tipoTransaccion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipotransacciones`
--

LOCK TABLES `tipotransacciones` WRITE;
/*!40000 ALTER TABLE `tipotransacciones` DISABLE KEYS */;
INSERT INTO `tipotransacciones` VALUES ('C','CONSUMO'),('D','DEPOSITO');
/*!40000 ALTER TABLE `tipotransacciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipousuario`
--

DROP TABLE IF EXISTS `tipousuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipousuario` (
  `idTipoUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) DEFAULT NULL,
  `leer` char(1) DEFAULT NULL,
  `crear` char(1) DEFAULT NULL,
  `modificar` char(1) DEFAULT NULL,
  `eliminar` char(1) DEFAULT NULL,
  PRIMARY KEY (`idTipoUsuario`),
  UNIQUE KEY `descripcion` (`descripcion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipousuario`
--

LOCK TABLES `tipousuario` WRITE;
/*!40000 ALTER TABLE `tipousuario` DISABLE KEYS */;
INSERT INTO `tipousuario` VALUES (1,'administrador','1','1','1','1'),(2,'consulta','1','0','0','0'),(3,'creador','1','1','1','0');
/*!40000 ALTER TABLE `tipousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transacciones`
--

DROP TABLE IF EXISTS `transacciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transacciones` (
  `autorizacion` int(11) NOT NULL AUTO_INCREMENT,
  `numeroDeCuenta` bigint(20) DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `tipoTransaccion` char(1) DEFAULT NULL,
  `concepto` varchar(100) DEFAULT NULL,
  `fechaTransaccion` date DEFAULT NULL,
  `monto` float DEFAULT NULL,
  `hora` time DEFAULT NULL,
  PRIMARY KEY (`autorizacion`),
  KEY `tipoTransaccion` (`tipoTransaccion`),
  KEY `idCliente` (`idCliente`),
  KEY `numeroDeCuenta` (`numeroDeCuenta`),
  CONSTRAINT `transacciones_ibfk_1` FOREIGN KEY (`tipoTransaccion`) REFERENCES `tipotransacciones` (`tipoTransaccion`),
  CONSTRAINT `transacciones_ibfk_2` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  CONSTRAINT `transacciones_ibfk_3` FOREIGN KEY (`numeroDeCuenta`) REFERENCES `cuentas` (`numerodecuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacciones`
--

LOCK TABLES `transacciones` WRITE;
/*!40000 ALTER TABLE `transacciones` DISABLE KEYS */;
INSERT INTO `transacciones` VALUES (1,4236980000000003,10,'D','DEPOSITO EN EFECTIVO POR Q150','2014-11-18',150,'01:17:35'),(2,4236980000000007,19,'D','DEPOSITO EN EFECTIVO POR Q1000','2014-11-18',1000,'02:37:54'),(3,4569870000000003,21,'D','DEPOSITO EN EFECTIVO POR Q1000','2014-11-18',1000,'02:38:21'),(4,4569870000000002,1,'D','DEPOSITO EN EFECTIVO POR Q1150','2014-11-18',1150,'02:39:42'),(5,4569870000000002,1,'C','CONSUMO - RESERVA 1025 - POR Q100','2014-11-18',100,'02:53:54'),(6,4569870000000002,1,'C','CONSUMO - RESERVA 1025 - POR Q100','2014-11-18',100,'02:55:01'),(7,4236980000000007,19,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'02:55:01'),(8,4569870000000002,1,'C','CONSUMO - RESERVA 1025 - POR Q100','2014-11-18',100,'02:55:32'),(9,4236980000000007,19,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'02:55:32'),(11,4569870000000002,1,'C','CONSUMO - RESERVA 1025 - POR Q100','2014-11-18',100,'02:56:22'),(12,4236980000000007,19,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'02:56:22'),(13,4236980000000003,10,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'02:56:22'),(14,4569870000000002,1,'C','CONSUMO - RESERVA 1025 - POR Q100','2014-11-18',100,'03:09:55'),(15,4236980000000007,19,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:09:55'),(16,4236980000000003,10,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:09:56'),(17,4569870000000002,1,'C','CONSUMO - RESERVA 1025 - POR Q100','2014-11-18',100,'03:10:54'),(18,4236980000000007,19,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:10:54'),(19,4236980000000003,10,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:10:54'),(20,4569870000000002,1,'C','CONSUMO - RESERVA 1025 - POR Q100','2014-11-18',100,'03:16:37'),(21,4236980000000007,19,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:16:37'),(22,4236980000000003,10,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:16:37'),(23,4569870000000002,1,'C','CONSUMO - RESERVA 1025 - POR Q100','2014-11-18',100,'03:17:58'),(24,4236980000000007,19,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:17:59'),(25,4236980000000003,10,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:17:59'),(26,4569870000000002,1,'C','CONSUMO - RESERVA 1025 - POR Q100','2014-11-18',100,'03:31:32'),(27,4236980000000007,19,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:31:34'),(28,4236980000000003,10,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:31:34'),(29,4569870000000002,1,'C','CONSUMO - RESERVA 1025 - POR Q100','2014-11-18',100,'03:32:40'),(30,4236980000000007,19,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:32:40'),(31,4236980000000003,10,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:32:41'),(32,4569870000000002,1,'C','CONSUMO - RESERVA 1025 - POR Q100','2014-11-18',100,'03:34:30'),(33,4236980000000007,19,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:34:30'),(34,4236980000000003,10,'D','DEPOSITO - RESERVA 1025 - POR Q50','2014-11-18',50,'03:34:30');
/*!40000 ALTER TABLE `transacciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `idUsuario` varchar(100) NOT NULL DEFAULT '',
  `idCliente` int(11) DEFAULT NULL,
  `contrasenia` varchar(100) DEFAULT NULL,
  `tipoUsuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `idUsuario` (`idUsuario`),
  KEY `tipoUsuario` (`tipoUsuario`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`tipoUsuario`) REFERENCES `tipousuario` (`idTipoUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES ('milaronix',1,'gato',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-18  3:58:59
