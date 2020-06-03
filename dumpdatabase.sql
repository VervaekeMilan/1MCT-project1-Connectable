-- MySQL dump 10.17  Distrib 10.3.17-MariaDB, for debian-linux-gnueabihf (armv7l)
--
-- Host: localhost    Database: project1
-- ------------------------------------------------------
-- Server version	10.3.17-MariaDB-0+deb10u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Actuatoren`
--

DROP TABLE IF EXISTS `Actuatoren`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Actuatoren` (
  `ActuatorID` int(11) NOT NULL AUTO_INCREMENT,
  `Naam` varchar(45) NOT NULL,
  `Beschrijving` varchar(345) DEFAULT NULL,
  PRIMARY KEY (`ActuatorID`),
  UNIQUE KEY `ActuatorID_UNIQUE` (`ActuatorID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Actuatoren`
--

LOCK TABLES `Actuatoren` WRITE;
/*!40000 ALTER TABLE `Actuatoren` DISABLE KEYS */;
INSERT INTO `Actuatoren` VALUES (1,'Peltier Cooler','An element that makes a temperature difference between its cold and hot side'),(2,'Fan','A Component to cool the cooling element'),(3,'Linear Actuator','A motor that makes linear motion');
/*!40000 ALTER TABLE `Actuatoren` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Actuatoren_has_Statussen`
--

DROP TABLE IF EXISTS `Actuatoren_has_Statussen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Actuatoren_has_Statussen` (
  `Actuatoren_ActuatorID` int(11) NOT NULL,
  `Statussen_StatusID` int(11) NOT NULL,
  PRIMARY KEY (`Actuatoren_ActuatorID`,`Statussen_StatusID`),
  KEY `fk_Actuatoren_has_Statussen_Statussen1_idx` (`Statussen_StatusID`),
  KEY `fk_Actuatoren_has_Statussen_Actuatoren1_idx` (`Actuatoren_ActuatorID`),
  CONSTRAINT `fk_Actuatoren_has_Statussen_Actuatoren1` FOREIGN KEY (`Actuatoren_ActuatorID`) REFERENCES `Actuatoren` (`ActuatorID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actuatoren_has_Statussen_Statussen1` FOREIGN KEY (`Statussen_StatusID`) REFERENCES `Statussen` (`StatusID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Actuatoren_has_Statussen`
--

LOCK TABLES `Actuatoren_has_Statussen` WRITE;
/*!40000 ALTER TABLE `Actuatoren_has_Statussen` DISABLE KEYS */;
/*!40000 ALTER TABLE `Actuatoren_has_Statussen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Inlezingen`
--

DROP TABLE IF EXISTS `Inlezingen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Inlezingen` (
  `InlezingID` int(11) NOT NULL AUTO_INCREMENT,
  `SensorID` int(11) NOT NULL,
  `Tijd` datetime NOT NULL,
  `Meetwaarde` int(11) DEFAULT NULL,
  PRIMARY KEY (`InlezingID`),
  UNIQUE KEY `InlezingID_UNIQUE` (`InlezingID`),
  KEY `sensorID_idx` (`SensorID`),
  CONSTRAINT `sensorID` FOREIGN KEY (`SensorID`) REFERENCES `Sensoren` (`SensorID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inlezingen`
--

LOCK TABLES `Inlezingen` WRITE;
/*!40000 ALTER TABLE `Inlezingen` DISABLE KEYS */;
INSERT INTO `Inlezingen` VALUES (1,1,'2020-01-31 02:15:13',5),(2,2,'2021-05-03 06:33:48',6),(3,3,'2020-07-08 08:30:03',5),(4,1,'2021-05-03 08:37:02',4),(5,3,'2019-10-15 16:02:57',8),(6,1,'2020-02-22 09:51:46',4),(7,3,'2020-01-08 06:54:52',1),(8,1,'2019-07-17 19:10:57',7),(9,2,'2020-04-06 05:05:07',5),(10,1,'2020-05-06 15:51:00',10),(11,2,'2021-01-29 22:43:28',3),(12,1,'2021-01-06 23:30:40',7),(13,3,'2019-12-09 08:47:29',8),(14,1,'2021-01-22 15:20:23',5),(15,3,'2019-09-10 11:23:08',10),(16,2,'2019-06-28 15:53:37',2),(17,2,'2019-07-06 14:05:45',10),(18,1,'2020-05-18 14:59:28',6),(19,2,'2020-07-16 07:59:02',1),(20,1,'2019-06-15 12:23:48',7),(21,2,'2020-10-13 10:10:25',10),(22,2,'2020-06-25 05:00:40',10),(23,2,'2021-04-14 19:05:40',7),(24,1,'2019-05-30 00:05:23',4),(25,2,'2019-09-29 06:29:55',7),(26,3,'2019-07-01 14:49:02',1),(27,1,'2021-02-02 12:55:51',2),(28,3,'2020-07-31 23:36:06',5),(29,3,'2019-10-21 14:18:17',9),(30,2,'2020-12-28 19:06:28',7),(31,1,'2021-02-21 02:49:18',3),(32,2,'2019-09-18 04:22:48',8),(33,1,'2020-03-24 19:48:00',9),(34,2,'2020-10-07 21:47:47',8),(35,2,'2019-06-26 10:00:29',8),(36,3,'2021-05-15 11:01:34',8),(37,1,'2019-11-24 17:35:00',10),(38,1,'2021-05-25 07:00:38',6),(39,2,'2021-05-21 06:18:33',4),(40,1,'2019-12-31 10:27:32',8),(41,3,'2019-06-30 00:01:54',8),(42,1,'2020-09-26 15:44:38',3),(43,3,'2020-06-26 09:08:27',10),(44,3,'2020-08-31 12:38:13',3),(45,2,'2020-03-12 15:12:41',8),(46,2,'2020-03-19 08:21:55',8),(47,3,'2019-10-24 02:37:09',6),(48,1,'2019-08-10 05:20:18',5),(49,1,'2020-09-13 11:57:13',5),(50,2,'2020-06-02 01:56:01',6),(51,2,'2021-05-15 22:20:33',7),(52,1,'2020-12-12 16:06:14',8),(53,3,'2021-01-02 18:49:16',9),(54,1,'2020-06-27 10:54:50',10),(55,1,'2021-01-25 06:46:51',6),(56,1,'2019-11-26 17:52:56',2),(57,1,'2019-10-04 12:51:26',3),(58,2,'2021-04-04 03:50:30',7),(59,1,'2020-07-16 09:37:06',1),(60,3,'2021-04-24 20:42:06',1),(61,1,'2019-11-06 09:41:50',4),(62,3,'2020-04-01 21:35:04',2),(63,2,'2020-10-24 06:37:41',5),(64,3,'2020-09-22 12:03:12',8),(65,1,'2020-11-03 21:40:44',7),(66,1,'2021-04-11 23:12:31',6),(67,1,'2020-05-06 09:44:32',5),(68,1,'2020-10-25 10:35:33',4),(69,2,'2019-07-17 20:10:19',6),(70,1,'2021-03-08 16:27:36',6),(71,3,'2020-02-21 21:19:37',4),(72,2,'2020-07-25 00:10:00',4),(73,1,'2021-03-29 04:22:30',10),(74,3,'2020-09-03 22:37:19',5),(75,1,'2020-10-30 21:19:34',3),(76,1,'2020-01-06 06:59:57',4),(77,2,'2020-09-02 21:51:36',4),(78,1,'2021-01-04 13:47:35',6),(79,2,'2019-11-27 10:02:26',7),(80,2,'2019-11-27 13:13:33',5),(81,2,'2019-10-02 13:46:48',3),(82,2,'2020-06-15 23:50:24',6),(83,1,'2019-11-08 21:43:33',2),(84,3,'2020-09-27 10:34:28',9),(85,3,'2019-09-03 15:54:55',7),(86,1,'2020-09-18 12:22:58',6),(87,2,'2020-03-16 03:38:34',6),(88,1,'2020-05-03 12:47:25',8),(89,1,'2020-01-12 11:00:13',2),(90,1,'2020-05-29 06:52:54',10),(91,3,'2019-09-04 23:47:47',6),(92,1,'2020-12-17 12:19:07',6),(93,1,'2019-11-21 15:57:24',5),(94,2,'2020-03-12 16:47:10',9),(95,2,'2021-01-02 10:58:38',10),(96,1,'2020-06-06 05:52:52',6),(97,1,'2020-08-26 09:57:05',8),(98,3,'2021-02-03 16:38:28',1),(99,2,'2020-02-21 02:45:28',8),(100,1,'2020-07-20 06:29:25',2);
/*!40000 ALTER TABLE `Inlezingen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Inlezingen_has_Actuatoren`
--

DROP TABLE IF EXISTS `Inlezingen_has_Actuatoren`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Inlezingen_has_Actuatoren` (
  `Inlezingen_InlezingID` int(11) NOT NULL,
  `Actuatoren_ActuatorID` int(11) NOT NULL,
  PRIMARY KEY (`Inlezingen_InlezingID`,`Actuatoren_ActuatorID`),
  KEY `fk_Inlezingen_has_Actuatoren_Actuatoren1_idx` (`Actuatoren_ActuatorID`),
  KEY `fk_Inlezingen_has_Actuatoren_Inlezingen1_idx` (`Inlezingen_InlezingID`),
  CONSTRAINT `fk_Inlezingen_has_Actuatoren_Actuatoren1` FOREIGN KEY (`Actuatoren_ActuatorID`) REFERENCES `Actuatoren` (`ActuatorID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inlezingen_has_Actuatoren_Inlezingen1` FOREIGN KEY (`Inlezingen_InlezingID`) REFERENCES `Inlezingen` (`InlezingID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inlezingen_has_Actuatoren`
--

LOCK TABLES `Inlezingen_has_Actuatoren` WRITE;
/*!40000 ALTER TABLE `Inlezingen_has_Actuatoren` DISABLE KEYS */;
/*!40000 ALTER TABLE `Inlezingen_has_Actuatoren` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sensoren`
--

DROP TABLE IF EXISTS `Sensoren`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sensoren` (
  `SensorID` int(11) NOT NULL AUTO_INCREMENT,
  `Naam` varchar(45) NOT NULL,
  `Beschrijving` varchar(345) DEFAULT NULL,
  `Meeteenheid` varchar(45) NOT NULL,
  PRIMARY KEY (`SensorID`),
  UNIQUE KEY `SensorID_UNIQUE` (`SensorID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sensoren`
--

LOCK TABLES `Sensoren` WRITE;
/*!40000 ALTER TABLE `Sensoren` DISABLE KEYS */;
INSERT INTO `Sensoren` VALUES (1,'IR Receiver Ky-022','A component that receives an IR signal form an IR remote','null'),(2,'Temperature Sensor DS18B20','A Component to measure the temperature','°C'),(3,'Rotary Encoder','A compontent that when interacted with, creates 2 digital, out of phase signals','null');
/*!40000 ALTER TABLE `Sensoren` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Statussen`
--

DROP TABLE IF EXISTS `Statussen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Statussen` (
  `StatusID` int(11) NOT NULL AUTO_INCREMENT,
  `Status` varchar(45) DEFAULT NULL,
  `Start` datetime DEFAULT NULL,
  `End` datetime DEFAULT NULL,
  PRIMARY KEY (`StatusID`),
  UNIQUE KEY `StatusID_UNIQUE` (`StatusID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Statussen`
--

LOCK TABLES `Statussen` WRITE;
/*!40000 ALTER TABLE `Statussen` DISABLE KEYS */;
INSERT INTO `Statussen` VALUES (1,'nisi.','2019-07-10 06:12:18','2019-06-19 04:00:22'),(2,'ante','2019-07-20 20:52:56','2019-08-17 23:19:26'),(3,'magnis','2020-06-05 14:02:13','2019-11-30 15:30:05'),(4,'felis','2020-07-11 07:56:35','2019-08-18 02:20:49'),(5,'ridiculus','2021-03-14 13:45:01','2020-02-05 12:15:35'),(6,'leo.','2020-07-04 14:11:55','2020-04-06 18:22:10'),(7,'libero','2020-07-24 22:09:04','2020-04-04 14:47:02'),(8,'egestas,','2019-08-21 09:30:00','2019-12-20 14:38:11'),(9,'sapien,','2020-10-23 06:43:40','2020-06-02 04:49:49'),(10,'erat','2020-02-21 12:30:24','2019-12-23 20:30:34'),(11,'amet,','2019-08-01 16:47:25','2020-03-22 05:48:46'),(12,'dolor','2020-09-06 18:35:41','2020-10-03 20:43:36'),(13,'ut','2019-10-08 03:33:58','2020-05-04 20:01:44'),(14,'Donec','2020-05-26 08:46:22','2020-09-20 07:25:04'),(15,'eros.','2019-08-23 17:07:53','2020-09-30 00:31:04'),(16,'et','2020-05-15 20:34:49','2019-12-15 15:58:46'),(17,'ac','2020-11-29 06:25:25','2020-06-10 10:06:36'),(18,'ridiculus','2020-02-19 20:51:44','2019-07-21 20:45:02'),(19,'sed,','2020-01-25 08:55:33','2021-05-16 11:48:29'),(20,'et,','2020-06-17 22:34:22','2020-01-20 08:08:18'),(21,'montes,','2020-07-29 05:48:38','2021-03-20 19:38:51'),(22,'Vivamus','2020-01-17 09:32:11','2021-02-28 05:06:49'),(23,'nec','2020-11-08 14:15:27','2021-02-23 19:55:26'),(24,'Nulla','2020-03-01 23:59:51','2019-06-08 16:18:09'),(25,'tincidunt.','2020-10-17 14:25:55','2021-03-24 19:33:25'),(26,'venenatis','2019-10-22 17:33:26','2020-05-11 00:22:56'),(27,'Donec','2019-11-14 10:36:20','2021-04-30 08:29:29'),(28,'Proin','2020-12-19 20:36:21','2020-08-28 16:18:26'),(29,'id','2019-09-17 09:23:59','2019-06-17 18:49:44'),(30,'enim,','2020-02-26 12:30:24','2019-06-18 05:01:26'),(31,'sapien,','2021-01-21 15:50:13','2020-12-31 19:49:38'),(32,'ornare,','2021-01-04 03:58:50','2020-05-03 11:18:19'),(33,'pharetra','2020-02-02 04:09:47','2020-10-12 13:54:09'),(34,'euismod','2020-07-12 09:38:53','2019-08-28 03:18:37'),(35,'ullamcorper','2020-06-16 10:32:48','2019-11-07 00:44:42'),(36,'feugiat','2019-08-05 04:08:07','2020-10-18 23:59:19'),(37,'sed,','2020-08-05 09:23:32','2019-12-13 15:23:03'),(38,'adipiscing.','2020-08-08 16:07:32','2020-10-04 03:32:15'),(39,'magna','2020-03-28 14:31:04','2020-07-18 22:40:00'),(40,'vitae,','2020-12-17 17:08:04','2019-09-11 12:18:15'),(41,'posuere,','2020-12-10 11:51:39','2020-01-14 20:02:41'),(42,'Nam','2020-08-11 07:46:16','2020-12-11 18:42:10'),(43,'vitae','2019-05-27 16:09:05','2021-02-27 07:19:56'),(44,'magnis','2019-08-06 00:29:05','2020-08-20 02:46:36'),(45,'vel','2020-02-26 01:31:31','2020-12-27 04:39:21'),(46,'Sed','2019-11-10 16:10:58','2020-07-31 03:39:42'),(47,'scelerisque','2020-03-24 05:57:21','2020-12-02 03:28:52'),(48,'non,','2021-04-02 19:17:04','2020-11-06 07:41:15'),(49,'egestas,','2019-08-04 20:30:39','2020-11-14 15:32:14'),(50,'egestas.','2019-12-30 07:03:09','2019-12-21 18:55:56'),(51,'Vivamus','2021-01-31 00:35:45','2021-05-06 20:56:06'),(52,'nulla','2020-04-11 10:15:02','2021-05-18 01:21:17'),(53,'nec,','2019-08-28 20:56:26','2020-12-25 19:07:50'),(54,'lorem,','2020-06-21 09:17:06','2019-06-02 04:13:58'),(55,'risus.','2020-11-01 07:20:24','2020-01-20 17:14:29'),(56,'sociis','2020-08-06 08:09:41','2020-02-22 09:49:35'),(57,'ornare','2020-06-10 20:55:23','2020-08-02 20:50:32'),(58,'velit','2019-12-09 02:25:05','2020-05-12 16:13:49'),(59,'vel','2019-06-24 16:56:03','2020-04-09 20:22:35'),(60,'malesuada','2019-10-11 06:11:33','2019-09-28 02:36:08'),(61,'amet,','2020-02-26 23:14:17','2020-02-10 14:56:19'),(62,'sed','2020-12-18 05:29:25','2020-05-11 05:07:31'),(63,'diam.','2021-05-01 20:00:53','2019-12-13 09:42:28'),(64,'Nulla','2020-12-29 22:50:55','2019-10-16 00:28:05'),(65,'amet,','2019-11-18 19:22:54','2020-08-26 21:35:13'),(66,'Nunc','2020-01-11 05:12:52','2020-10-12 04:18:31'),(67,'sodales.','2020-01-13 09:20:19','2020-05-23 22:07:18'),(68,'amet','2021-03-30 18:46:33','2021-01-28 20:35:57'),(69,'Fusce','2021-02-02 18:43:26','2019-06-19 04:34:15'),(70,'a,','2020-10-21 18:47:22','2021-02-24 19:51:19'),(71,'non,','2020-11-01 16:08:21','2020-08-26 12:40:25'),(72,'Donec','2020-02-11 04:49:38','2019-12-17 10:47:35'),(73,'lorem','2019-06-15 14:44:02','2019-11-11 18:55:42'),(74,'ut','2020-12-14 00:26:07','2020-04-25 02:47:08'),(75,'ac','2019-10-18 08:46:36','2021-04-06 02:35:31'),(76,'eu,','2021-01-11 18:07:59','2019-06-25 06:33:42'),(77,'Phasellus','2019-11-14 05:01:11','2020-04-13 07:06:46'),(78,'Ut','2019-12-26 03:09:07','2019-07-20 11:12:10'),(79,'ipsum','2019-10-11 12:08:45','2020-12-14 22:47:55'),(80,'magna.','2020-02-25 13:56:46','2020-06-17 14:40:03'),(81,'iaculis','2020-09-29 19:02:08','2021-05-18 14:09:30'),(82,'vulputate','2020-06-04 23:57:57','2021-04-03 21:31:22'),(83,'amet,','2019-08-10 11:23:47','2020-02-16 18:00:31'),(84,'Sed','2020-03-17 12:00:47','2019-09-05 07:07:35'),(85,'non','2020-12-13 13:01:52','2020-01-31 02:58:18'),(86,'nascetur','2021-05-06 23:24:54','2020-09-16 19:08:43'),(87,'Mauris','2019-12-08 23:11:48','2019-09-08 13:05:32'),(88,'non,','2021-05-20 11:14:32','2021-03-26 16:11:13'),(89,'adipiscing','2019-09-30 23:10:53','2020-09-10 22:12:09'),(90,'pellentesque','2019-10-01 01:01:40','2021-03-16 20:55:34'),(91,'tellus.','2020-10-03 04:51:43','2020-08-21 22:42:36'),(92,'Aliquam','2020-09-12 09:17:49','2020-04-03 03:53:25'),(93,'mi','2020-12-22 18:08:29','2019-06-03 04:50:45'),(94,'risus,','2020-03-24 17:38:13','2020-03-30 03:16:17'),(95,'Proin','2021-01-15 18:19:03','2020-05-23 14:21:02'),(96,'magna','2020-11-18 11:21:40','2020-08-10 02:08:09'),(97,'Cras','2019-11-29 07:23:42','2021-03-04 05:06:57'),(98,'molestie.','2019-10-06 18:28:06','2019-09-26 00:46:35'),(99,'mi.','2019-08-12 14:03:15','2020-05-19 23:26:56'),(100,'egestas','2020-06-30 18:50:18','2020-02-27 12:10:02');
/*!40000 ALTER TABLE `Statussen` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-26 19:12:12
