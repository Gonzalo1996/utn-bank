-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: utnbank
-- ------------------------------------------------------
-- Server version	5.7.31-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `dniCliente` varchar(8) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Apellido` varchar(45) NOT NULL,
  `Fecha_Nac` varchar(10) NOT NULL,
  `Sexo` varchar(45) NOT NULL,
  `Cuil` varchar(11) NOT NULL,
  `Nacionalidad` varchar(45) NOT NULL,
  `Provincia` varchar(45) NOT NULL,
  `Localidad` varchar(45) NOT NULL,
  `Direccion` varchar(45) NOT NULL,
  `Mail` varchar(45) NOT NULL,
  `NombreUsuario` varchar(45) NOT NULL,
  `Contraseña` varchar(45) NOT NULL,
  `estado` varchar(10) NOT NULL,
  PRIMARY KEY (`dniCliente`,`NombreUsuario`),
  UNIQUE KEY `dniCliente_UNIQUE` (`dniCliente`),
  UNIQUE KEY `NombreUsuario_UNIQUE` (`NombreUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES ('10005006','Steven','Rogers','15/05/1920','Masculino','20100050068','Argentina','Buenos Aires','La Plata','Abc 123','elCapi_digno@gmail.com','elCapi','Digno10','Inactivo'),('12345678','Homero','Simpson','12/05/1956','Masculino','20123456789','Argentina','Buenos Aires','Springfield','Av. SiempreViva 742','amantedelacomida53@aol.com','SeñorX','Homer8','Activo'),('15666777','Marcelito','Araujo','12/06/1947','Masculino','20156667778','Argentina','Buenos Aires','Villa Crespo','Mitre','marcearaujo@hotmail.com','marcelitoAraujo','Ma1234','Activo'),('15678876','Charles','Xavier','03/02/1940','Masculino','20156788768','Argentina','Buenos Aires','Grand Bourg','Ricardo Rojas 876','profeX@gmail.com','profeX','Xprofe12','Activo'),('16456789','Miguel','Russo','09/04/1956','Masculino','20164567898','Argentina','Buenos Aires','La Boca','Bransen 905','migueRusso@yahoo.com','migueRusso','boquita1905','Activo'),('16999777','Diego','Maradona','30/10/1960','Masculino','20169997778','Argentina','Buenos Aires','La Plata','Campos de Roca 2','maradona10@gmail.com','elDiego','Diego10','Activo'),('20456987','Tony','Stark','29/05/1970','Masculino','20204569879','Argentina','California','Malibu','10880 Malibu Point','ironman@outlook.com','IamIronman','3000','Activo'),('23417979','Martin','Palermo','07/11/1973','Masculino','20234179798','Argentina','Buenos Aires','La Plata','Fsdf 235','elloco_9@hotmail.com','elTitan','Martin9','Activo'),('26123123','Carlitos','Tevez','05/02/1984','Masculino','20261231238','Argentina','Buenos Aires','La Boca','Brandsen 805','elapache@gmail.com','jugadordelpueblo','Tevez10','Activo'),('26369369','Clint','Barton','31/03/1975','Masculino','20263693698','Argentina','Buenos Aires','Escobar','Ayacucho 123','hawkeye@gmail.com','hawkEye','Halcon66','Activo'),('30486486','Natasha','Romanoff','25/12/1980','Femenino','20304864868','Argentina','La Pampa','Budapest','La Casa 123','blackWidow@yahoo.com','viudita','Negra12','Activo'),('30987123','Fernando','Gago','09/04/1986','Masculino','209871238','Argentina','Buenos Aires','La Boca','Bransen 905','pintitaGago@hotmail.com','pintita12','gago1905','Activo'),('40123123','Bartolomeo','Simpson','20/02/2012','Masculino','20401231238','Argentina','Chubut','Springfield','Av. Siempreviva 742','elbarto@gmail.com','elbarto','Bart08','Activo'),('40123456','Gonzalo','Alderete','20/05/1997','Masculino','123456987','Argentina','Buenos Aires','Tigre','Calle Falsa 123','gonza@gmail.com','gonza123','Contra1','Inactivo'),('40456982','Tamara','Perez','20/11/1992','Femenino','123654891','Argentina','Buenos Aires','Tigre','Calle 123','tamara@gmail.com','tamara1','Contra1','Activo'),('40870419','Alberto','Rodriguez','16/01/1998','Masculino','20408704198','Argentina','Buenos Aires','Garin','Ituzaingo 485','albert.garin1@gmail.com','albertstone','jose1998','Activo'),('42888999','Lisa','Simpson','15/05/2014','Femenino','2042888999','Argentina','La Pampa','Springfield','Av. SiempreViva 742','lisaJazz@gmail.com','lisaPoni','Lisa123','Inactivo'),('65412846','Claudio','Juarez','26/11/2000','Femenino','1236985742','Argentina','La Pampa','Tigre','Pacheco 1234','claudio@gmail.com','claudio2000','Claudio1','Activo');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas_x_clientes`
--

DROP TABLE IF EXISTS `cuentas_x_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentas_x_clientes` (
  `dni` varchar(8) NOT NULL,
  `idtipocuenta` int(11) NOT NULL,
  `nro_cuenta` varchar(45) NOT NULL,
  `cbu` varchar(22) NOT NULL,
  `fecha_creacion` varchar(10) NOT NULL,
  `saldo` decimal(20,2) NOT NULL,
  `estado` varchar(10) NOT NULL,
  PRIMARY KEY (`nro_cuenta`,`cbu`),
  UNIQUE KEY `nro_cuenta_UNIQUE` (`nro_cuenta`),
  UNIQUE KEY `cbu_UNIQUE` (`cbu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas_x_clientes`
--

LOCK TABLES `cuentas_x_clientes` WRITE;
/*!40000 ALTER TABLE `cuentas_x_clientes` DISABLE KEYS */;
INSERT INTO `cuentas_x_clientes` VALUES ('65412846',1,'1122336655654','2850590911223366551','26/11/2020',10000.00,'Inactivo'),('65412846',1,'1236548527896','2850590912365485278961','26/11/2020',10000.00,'Inactivo'),('40456',1,'1236958412322','28505909123695841231','03/12/2020',10000.00,'Activo'),('40456982',1,'1268974569426','2850590912689745694261','03/12/2020',10100.00,'Activo'),('40870419',1,'3213546515346','2850590932135465153461','25/11/2020',9800.00,'Activo'),('16999777',1,'3216549861945','2850590932165498619451','25/11/2020',10000.00,'Activo'),('26123123',2,'3246516548651','2850590932465165486511','20/11/2020',10000.00,'Activo'),('20456987',1,'3435654675675','2850590934356546756751','24/11/2020',10000.00,'Activo'),('12345678',2,'3514651654894','2850590935146516548941','20/11/2020',10000.00,'Activo'),('20456987',2,'3537387354378','2850590935373873543781','20/11/2020',10189.66,'Activo'),('404569',1,'4144578885112','2850590941445788851121','03/12/2020',10000.00,'Activo'),('15666777',1,'4345345354345','2850590943453453543451','20/11/2020',10000.00,'Activo'),('40456982',1,'4423123213512','2850590944231232135121','03/12/2020',10500.00,'Activo'),('40870419',1,'4645684654654','2850590946456846546541','25/11/2020',10000.00,'Activo'),('40870419',2,'5254312312312','2850590952543123123121','20/11/2020',1300.00,'Activo'),('23417979',1,'5464745415165','2850590954647454151651','25/11/2020',10000.00,'Activo'),('30987123',1,'5464987565216','2850590954649875652161','20/11/2020',10000.00,'Activo'),('15678876',2,'5465165186191','2850590954651651861911','25/11/2020',10000.00,'Activo'),('15678876',1,'5467867864532','2850590954678678645321','20/11/2020',10000.00,'Activo'),('15666777',2,'5646516546546','2850590956465165465461','23/11/2020',10000.00,'Activo'),('16999777',1,'6516516854691','2850590965165168546911','25/11/2020',10000.00,'Inactivo'),('40123123',2,'6546516848915','2850590965465168489151','25/11/2020',10866.65,'Activo'),('16999777',1,'6561546516514','2850590965615465165141','25/11/2020',10000.00,'Activo'),('65412846',1,'7788996542365','2850590977889965423651','26/11/2020',10000.00,'Inactivo'),('12345678',1,'7896312391524','2850590978963123915241','03/12/2020',10000.00,'Activo'),('65412846',1,'7896536977477','28505909789653697741','26/11/2020',10000.00,'Activo'),('40456982',2,'8966281333898','2850590989662813338981','03/12/2020',10000.00,'Inactivo'),('40123456',1,'9632147825874','2850590996321478258741','03/12/2020',10400.00,'Activo');
/*!40000 ALTER TABLE `cuentas_x_clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuotas`
--

DROP TABLE IF EXISTS `cuotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuotas` (
  `idcuotas` int(11) NOT NULL,
  `nrocuota` varchar(45) NOT NULL,
  `fecha` varchar(45) DEFAULT NULL,
  `cbu` varchar(22) DEFAULT NULL,
  `importe` decimal(20,2) DEFAULT NULL,
  `dni` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`idcuotas`,`nrocuota`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuotas`
--

LOCK TABLES `cuotas` WRITE;
/*!40000 ALTER TABLE `cuotas` DISABLE KEYS */;
INSERT INTO `cuotas` VALUES (8,'1','02/12/2020','2850590965465168489151',166.67,'40123123'),(8,'2','02/12/2020','2850590965465168489151',166.67,'40123123'),(8,'3','02/12/2020','2850590965465168489151',166.67,'40123123'),(9,'1','02/12/2020','2850590965465168489151',66.67,'40123123'),(9,'2','02/12/2020','2850590965465168489151',66.67,'40123123'),(13,'1','03/12/2020','2850590935373873543781',66.67,'20456987'),(13,'2','03/12/2020','2850590935373873543781',66.67,'20456987'),(16,'1','02/12/2020','2850590952543123123121',200.00,'40870419'),(16,'2','02/12/2020','2850590952543123123121',200.00,'40870419'),(17,'1','03/12/2020','2850590996321478258741',200.00,'40123456'),(19,'1','03/12/2020','2850590912689745694261',300.00,'40456982');
/*!40000 ALTER TABLE `cuotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimientos_x_clientes`
--

DROP TABLE IF EXISTS `movimientos_x_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimientos_x_clientes` (
  `idMovimiento` int(11) NOT NULL AUTO_INCREMENT,
  `dni` varchar(8) NOT NULL,
  `tipoMovimiento` int(11) NOT NULL,
  `fechaDetalle` varchar(10) NOT NULL,
  `importe` decimal(20,2) NOT NULL,
  `cbu` varchar(22) NOT NULL,
  PRIMARY KEY (`idMovimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimientos_x_clientes`
--

LOCK TABLES `movimientos_x_clientes` WRITE;
/*!40000 ALTER TABLE `movimientos_x_clientes` DISABLE KEYS */;
INSERT INTO `movimientos_x_clientes` VALUES (1,'15666777',1,'20/11/2020',10000.00,'2850590943453453543451'),(2,'20456987',1,'20/11/2020',10000.00,'2850590935373873543781'),(3,'40870419',1,'20/11/2020',10000.00,'2850590952543123123121'),(4,'12345678',1,'20/11/2020',10000.00,'2850590935146516548941'),(5,'26123123',1,'20/11/2020',10000.00,'2850590932465165486511'),(6,'15678876',1,'20/11/2020',10000.00,'2850590954678678645321'),(7,'30987123',1,'20/11/2020',10000.00,'2850590954649875652161'),(8,'15666777',1,'23/11/2020',10000.00,'2850590956465165465461'),(9,'20456987',1,'24/11/2020',10000.00,'2850590934356546756751'),(10,'40870419',1,'25/11/2020',10000.00,'2850590932135465153461'),(11,'40123123',1,'25/11/2020',10000.00,'2850590965465168489151'),(12,'16999777',1,'25/11/2020',10000.00,'2850590965165168546911'),(13,'16999777',1,'25/11/2020',10000.00,'2850590965615465165141'),(14,'16999777',1,'25/11/2020',10000.00,'2850590932165498619451'),(15,'15678876',1,'25/11/2020',10000.00,'2850590954651651861911'),(16,'23417979',1,'25/11/2020',10000.00,'2850590954647454151651'),(17,'40870419',1,'25/11/2020',10000.00,'2850590946456846546541'),(18,'65412846',1,'26/11/2020',10000.00,'2850590911223366551'),(19,'65412846',1,'26/11/2020',10000.00,'28505909789653697741'),(20,'65412846',1,'26/11/2020',10000.00,'2850590977889965423651'),(21,'65412846',1,'26/11/2020',10000.00,'2850590912365485278961'),(30,'40870419',4,'02/12/2020',200.00,'2850590932135465153461'),(31,'40870419',7,'02/12/2020',200.00,'2850590952543123123121'),(32,'40123123',2,'02/12/2020',900.00,'2850590965465168489151'),(33,'40123123',5,'02/12/2020',166.67,'2850590965465168489151'),(34,'40123123',5,'02/12/2020',166.67,'2850590965465168489151'),(35,'40123123',5,'02/12/2020',166.67,'2850590965465168489151'),(36,'40123123',5,'02/12/2020',66.67,'2850590965465168489151'),(37,'40123123',5,'02/12/2020',66.67,'2850590965465168489151'),(38,'40870419',6,'02/12/2020',10.00,'2850590943453453543451'),(39,'40870419',2,'02/12/2020',600.00,'2850590952543123123121'),(40,'40870419',5,'02/12/2020',200.00,'2850590952543123123121'),(41,'40870419',5,'02/12/2020',200.00,'2850590952543123123121'),(42,'40123456',1,'03/12/2020',10000.00,'2850590996321478258741'),(43,'40123456',2,'03/12/2020',600.00,'2850590996321478258741'),(44,'40123456',5,'03/12/2020',200.00,'2850590996321478258741'),(45,'40123123',6,'03/12/2020',100.00,'2850590932135465153461'),(46,'20456987',5,'03/12/2020',66.67,'2850590935373873543781'),(47,'20456987',5,'03/12/2020',66.67,'2850590935373873543781'),(48,'40456',1,'03/12/2020',10000.00,'28505909123695841231'),(49,'404569',1,'03/12/2020',10000.00,'2850590941445788851121'),(50,'40456982',1,'03/12/2020',10000.00,'2850590912689745694261'),(51,'40456982',1,'03/12/2020',10000.00,'2850590989662813338981'),(52,'40456982',1,'03/12/2020',10000.00,'2850590944231232135121'),(53,'12345678',1,'03/12/2020',10000.00,'2850590978963123915241'),(54,'40456982',2,'03/12/2020',900.00,'2850590912689745694261'),(55,'40456982',5,'03/12/2020',300.00,'2850590912689745694261'),(56,'40456982',4,'03/12/2020',500.00,'2850590912689745694261'),(57,'40456982',7,'03/12/2020',500.00,'2850590944231232135121'),(58,'40456982',6,'03/12/2020',500.00,'2850590932135465153461'),(59,'40456982',6,'03/12/2020',100.00,'2850590932165498619451');
/*!40000 ALTER TABLE `movimientos_x_clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamos` (
  `idPrestamos` int(11) NOT NULL,
  `nroCuota` int(11) NOT NULL,
  `dni` varchar(8) NOT NULL,
  `fecha` varchar(10) NOT NULL,
  `importe_pedido` decimal(20,2) NOT NULL,
  `importe_a_pagar_x_mes` decimal(20,2) NOT NULL,
  `plazo_pago` int(11) NOT NULL,
  `estado` varchar(45) NOT NULL,
  `cbu` varchar(22) DEFAULT NULL,
  PRIMARY KEY (`idPrestamos`,`nroCuota`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamos`
--

LOCK TABLES `prestamos` WRITE;
/*!40000 ALTER TABLE `prestamos` DISABLE KEYS */;
INSERT INTO `prestamos` VALUES (1,1,'40123123','24/11/2020',900.00,300.00,3,'Activo','2850590965465168489151'),(1,2,'40123123','24/11/2020',900.00,300.00,3,'Activo','2850590965465168489151'),(1,3,'40123123','24/11/2020',900.00,300.00,3,'Activo','2850590965465168489151'),(2,1,'20456987','22/11/2020',400.00,200.00,2,'Activo','2850590934356546756751'),(2,2,'20456987','22/11/2020',400.00,200.00,2,'Activo','2850590934356546756751'),(3,1,'40870419','14/10/2020',100.00,50.00,2,'Activo','2850590932135465153461'),(3,2,'40870419','14/10/2020',100.00,50.00,2,'Activo','2850590932135465153461'),(4,1,'40870419','1/11/2020',1200.00,200.00,3,'Activo','2850590932135465153461'),(4,2,'40870419','1/11/2020',1200.00,200.00,3,'Activo','2850590932135465153461'),(5,1,'16999777','20/05/2020',1500.00,500.00,3,'Activo','2850590932165498619451'),(5,2,'16999777','20/05/2020',1500.00,500.00,3,'Activo','2850590932165498619451'),(5,3,'16999777','20/05/2020',1500.00,500.00,3,'Activo','2850590932165498619451'),(6,1,'12345678','13/10/2020',75.00,25.00,3,'Activo','2850590935146516548941'),(6,2,'12345678','13/10/2020',75.00,25.00,3,'Activo','2850590935146516548941'),(6,3,'12345678','13/10/2020',75.00,25.00,3,'Activo','2850590935146516548941'),(7,1,'40123123','01/12/2020',900.00,300.00,3,'Rechazado','2850590965465168489151'),(7,2,'40123123','01/12/2020',900.00,300.00,3,'Rechazado','2850590965465168489151'),(7,3,'40123123','01/12/2020',900.00,300.00,3,'Rechazado','2850590965465168489151'),(8,1,'40123123','01/12/2020',500.00,166.67,3,'Inactivo','2850590965465168489151'),(8,2,'40123123','01/12/2020',500.00,166.67,3,'Inactivo','2850590965465168489151'),(8,3,'40123123','01/12/2020',500.00,166.67,3,'Inactivo','2850590965465168489151'),(9,1,'40123123','02/12/2020',200.00,66.67,3,'Inactivo','2850590965465168489151'),(9,2,'40123123','02/12/2020',200.00,66.67,3,'Inactivo','2850590965465168489151'),(9,3,'40123123','02/12/2020',200.00,66.67,3,'Activo','2850590965465168489151'),(10,1,'40870419','02/12/2020',900.00,300.00,3,'Activo','2850590952543123123121'),(10,2,'40870419','02/12/2020',900.00,300.00,3,'Activo','2850590952543123123121'),(10,3,'40870419','02/12/2020',900.00,300.00,3,'Activo','2850590952543123123121'),(11,1,'40870419','02/12/2020',500.00,166.67,3,'Rechazado','2850590932135465153461'),(11,2,'40870419','02/12/2020',500.00,166.67,3,'Rechazado','2850590932135465153461'),(11,3,'40870419','02/12/2020',500.00,166.67,3,'Rechazado','2850590932135465153461'),(12,1,'40123123','02/12/2020',600.00,100.00,6,'Activo','2850590965465168489151'),(12,2,'40123123','02/12/2020',600.00,100.00,6,'Activo','2850590965465168489151'),(12,3,'40123123','02/12/2020',600.00,100.00,6,'Activo','2850590965465168489151'),(12,4,'40123123','02/12/2020',600.00,100.00,6,'Activo','2850590965465168489151'),(12,5,'40123123','02/12/2020',600.00,100.00,6,'Activo','2850590965465168489151'),(12,6,'40123123','02/12/2020',600.00,100.00,6,'Activo','2850590965465168489151'),(13,1,'20456987','02/12/2020',200.00,66.67,3,'Inactivo','2850590935373873543781'),(13,2,'20456987','02/12/2020',200.00,66.67,3,'Inactivo','2850590935373873543781'),(13,3,'20456987','02/12/2020',200.00,66.67,3,'Activo','2850590935373873543781'),(14,1,'20456987','02/12/2020',123.00,20.50,6,'Activo','2850590935373873543781'),(14,2,'20456987','02/12/2020',123.00,20.50,6,'Activo','2850590935373873543781'),(14,3,'20456987','02/12/2020',123.00,20.50,6,'Activo','2850590935373873543781'),(14,4,'20456987','02/12/2020',123.00,20.50,6,'Activo','2850590935373873543781'),(14,5,'20456987','02/12/2020',123.00,20.50,6,'Activo','2850590935373873543781'),(14,6,'20456987','02/12/2020',123.00,20.50,6,'Activo','2850590935373873543781'),(15,1,'40123123','02/12/2020',900.00,300.00,3,'Activo','2850590965465168489151'),(15,2,'40123123','02/12/2020',900.00,300.00,3,'Activo','2850590965465168489151'),(15,3,'40123123','02/12/2020',900.00,300.00,3,'Activo','2850590965465168489151'),(16,1,'40870419','02/12/2020',600.00,200.00,3,'Inactivo','2850590952543123123121'),(16,2,'40870419','02/12/2020',600.00,200.00,3,'Inactivo','2850590952543123123121'),(16,3,'40870419','02/12/2020',600.00,200.00,3,'Activo','2850590952543123123121'),(17,1,'40123456','03/12/2020',600.00,200.00,3,'Inactivo','2850590996321478258741'),(17,2,'40123456','03/12/2020',600.00,200.00,3,'Activo','2850590996321478258741'),(17,3,'40123456','03/12/2020',600.00,200.00,3,'Activo','2850590996321478258741'),(18,1,'40123123','03/12/2020',500.00,166.67,3,'Pendiente','2850590965465168489151'),(18,2,'40123123','03/12/2020',500.00,166.67,3,'Pendiente','2850590965465168489151'),(18,3,'40123123','03/12/2020',500.00,166.67,3,'Pendiente','2850590965465168489151'),(19,1,'40456982','03/12/2020',900.00,300.00,3,'Inactivo','2850590912689745694261'),(19,2,'40456982','03/12/2020',900.00,300.00,3,'Activo','2850590912689745694261'),(19,3,'40456982','03/12/2020',900.00,300.00,3,'Activo','2850590912689745694261'),(20,1,'40456982','03/12/2020',600.00,100.00,6,'Rechazado','2850590912689745694261'),(20,2,'40456982','03/12/2020',600.00,100.00,6,'Rechazado','2850590912689745694261'),(20,3,'40456982','03/12/2020',600.00,100.00,6,'Rechazado','2850590912689745694261'),(20,4,'40456982','03/12/2020',600.00,100.00,6,'Rechazado','2850590912689745694261'),(20,5,'40456982','03/12/2020',600.00,100.00,6,'Rechazado','2850590912689745694261'),(20,6,'40456982','03/12/2020',600.00,100.00,6,'Rechazado','2850590912689745694261');
/*!40000 ALTER TABLE `prestamos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipocuenta`
--

DROP TABLE IF EXISTS `tipocuenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipocuenta` (
  `idtipoCuenta` int(11) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idtipoCuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipocuenta`
--

LOCK TABLES `tipocuenta` WRITE;
/*!40000 ALTER TABLE `tipocuenta` DISABLE KEYS */;
INSERT INTO `tipocuenta` VALUES (1,'Caja de Ahorro'),(2,'Cuenta Corriente');
/*!40000 ALTER TABLE `tipocuenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipomovimientos`
--

DROP TABLE IF EXISTS `tipomovimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipomovimientos` (
  `idtipoMovimientos` int(11) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idtipoMovimientos`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipomovimientos`
--

LOCK TABLES `tipomovimientos` WRITE;
/*!40000 ALTER TABLE `tipomovimientos` DISABLE KEYS */;
INSERT INTO `tipomovimientos` VALUES (1,'Apertura Cuenta'),(2,'Deposito Prestamo'),(3,'Transaccion a terceros'),(4,'Transaccion a cuenta propia'),(5,'Pago Prestamo'),(6,'Transaccion de terceros'),(7,'Transaccion de cuenta propia');
/*!40000 ALTER TABLE `tipomovimientos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipousuario`
--

DROP TABLE IF EXISTS `tipousuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipousuario` (
  `idTipoUsuario` int(11) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`idTipoUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipousuario`
--

LOCK TABLES `tipousuario` WRITE;
/*!40000 ALTER TABLE `tipousuario` DISABLE KEYS */;
INSERT INTO `tipousuario` VALUES (1,'Administrador'),(2,'Cliente');
/*!40000 ALTER TABLE `tipousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `Usuario` varchar(45) NOT NULL,
  `Contraseña` varchar(45) NOT NULL,
  `tipo_usuario` int(11) NOT NULL,
  PRIMARY KEY (`Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES ('Admin','1234',1),('albertstone','jose1998',2),('claudio2000','Claudio1',2),('elbarto','Bart08',2),('elCapi','Digno10',2),('elDiego','Diego10',2),('elTitan','Martin9',2),('gonza123','Contra1',2),('hawkEye','Halcon66',2),('IamIronman','3000',2),('jugadordelpueblo','Tevez10',2),('lisaPoni','Lisa123',2),('marcelitoAraujo','Ma1234',2),('migueRusso','boquita1905',2),('pintita12','gago1905',2),('profeX','Xprofe12',2),('SeñorX','Homer8',2),('tamara1','Contra1',2),('viudita','Negra12',2);
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

-- Dump completed on 2021-02-08 15:40:29
