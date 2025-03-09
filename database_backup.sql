-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: travel
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'admin','$2a$10$OiPcUFcEfu1jYuxN2KYUneXvr8VHkVIiIo3m28COZAugu9MNdT0zy');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline` (
  `al_id` int NOT NULL,
  `al_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`al_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline`
--

LOCK TABLES `airline` WRITE;
/*!40000 ALTER TABLE `airline` DISABLE KEYS */;
INSERT INTO `airline` VALUES (101,'Spirit'),(102,'Indigo');
/*!40000 ALTER TABLE `airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `transaction_id` int NOT NULL,
  `pnr_no` int NOT NULL,
  PRIMARY KEY (`pnr_no`,`transaction_id`),
  KEY `transaction_id` (`transaction_id`),
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `payments` (`transaction_id`),
  CONSTRAINT `book_ibfk_2` FOREIGN KEY (`pnr_no`) REFERENCES `ticket` (`pnr_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `customer_id` int NOT NULL,
  `dob` date DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('UAWE1','AAA',123,'1111-11-11'),('Sanchit Raut','Time Chambers, Andheri West, Mumbai',111111,'2024-11-06'),('Zarrar Peshimam','Agarwal, Jogeshwari West, Mumbai',7700086,'2005-11-06'),('Arjun','Time Chambers, Andheri West, Mumbai',7700087,'2024-11-20'),('Kevin Shah','Time Chambers, Andheri West, Mumbai',7700088,'2000-01-26'),('Viraj Salunke','Somaiya, Vasai West, Mumbai',7700096,'2005-06-06'),('Aniruddh Saraf','Kolmandal Estate, Santacruz West, Mumbai',7700100,'2005-09-23'),('Prinka Devi','Anand Villa, Andheri East, Mumbai',7700101,'2005-01-31'),('Shiven Shukla','Agarwal, Jogeshwari West, Mumbai',7700116,'2005-06-06'),('Ayush Jena','MCP Chol, Andheri West, Mumbai',7700117,'2005-11-01'),('Rayyan Gosling','Rajpand, Juhu, Mumbai',7700118,'2002-09-09'),('Anuj Singh','Rajpand, Juhu, Mumbai',7700119,'2000-07-29'),('Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2003-06-07'),('Sumit','Time Chambers, Andheri West, Mumbai',7700121,'2001-06-07'),('Aaditya Sawant','Bhandup',7700123,'2001-10-18'),('Rayyan Khan','Time Chambers, Andheri West, Mumbai',7700199,'2006-01-04'),('Shiven','Bhayandar',34384783,'2005-11-07');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_customer` AFTER DELETE ON `customer` FOR EACH ROW BEGIN
insert customer_delete_log (customer_id, name, address, dob, deleted_time, deleted_date) 
VALUES (OLD.customer_id, OLD.name, OLD.address, OLD.dob, CURTIME(), CURDATE()); 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `customer_delete_log`
--

DROP TABLE IF EXISTS `customer_delete_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_delete_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `deleted_time` time NOT NULL,
  `deleted_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_delete_log`
--

LOCK TABLES `customer_delete_log` WRITE;
/*!40000 ALTER TABLE `customer_delete_log` DISABLE KEYS */;
INSERT INTO `customer_delete_log` VALUES (1,'Sarang Doshi','Amar Villa, Santacruz East, Mumbai',7700120,'2001-01-01','21:49:36','2024-10-23'),(2,'Sanchit','Time Chambers, Andheri West, Mumbai',7700120,'2005-02-06','12:44:07','2024-11-06'),(3,'Sanchit','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-04','12:44:56','2024-11-06'),(4,'Sanchit','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-04','14:49:14','2024-11-06'),(5,'Sanchit','Time Chambers, Andheri West, Mumbai',7700120,'2024-10-14','14:54:44','2024-11-06'),(6,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-08-05','14:58:47','2024-11-06'),(7,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-03','15:04:38','2024-11-06'),(8,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-04','15:05:54','2024-11-06'),(9,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2023-12-10','15:12:01','2024-11-06'),(10,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2004-04-27','15:12:56','2024-11-06'),(11,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2004-06-18','15:21:10','2024-11-06'),(12,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-11','15:31:25','2024-11-06'),(13,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2003-11-06','15:54:35','2024-11-06'),(14,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-04','20:40:59','2024-11-06'),(15,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2006-02-06','20:48:24','2024-11-06'),(16,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2001-02-02','20:50:25','2024-11-06'),(17,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2003-10-06','21:48:07','2024-11-06'),(18,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2001-10-15','22:11:30','2024-11-06'),(19,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-02-14','22:15:51','2024-11-06'),(20,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-03','22:18:03','2024-11-06'),(21,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-10-15','22:28:51','2024-11-06'),(22,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-10-29','22:34:40','2024-11-06'),(23,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2008-02-06','22:36:42','2024-11-06'),(24,'Sanchit','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-13','22:42:11','2024-11-06'),(25,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-28','22:46:21','2024-11-06'),(26,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-10-28','22:55:30','2024-11-06'),(27,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-10-27','23:02:28','2024-11-06'),(28,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-01-06','23:06:42','2024-11-06'),(29,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-10-28','23:10:02','2024-11-06'),(30,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-20','23:12:03','2024-11-06'),(31,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-10-28','23:14:26','2024-11-06'),(32,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-18','23:15:08','2024-11-06'),(33,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-13','23:16:08','2024-11-06'),(34,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-10-27','23:22:38','2024-11-06'),(35,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'2024-11-12','07:04:33','2024-11-07'),(36,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700121,'2008-01-06','07:04:37','2024-11-07'),(37,'Sanchit Raut','Time Chambers, Andheri West, Mumbai',7700120,'1999-06-30','07:08:38','2024-11-07');
/*!40000 ALTER TABLE `customer_delete_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_phone`
--

DROP TABLE IF EXISTS `customer_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_phone` (
  `customer_id` int DEFAULT NULL,
  `ph_no` varchar(15) NOT NULL,
  KEY `fk_customer_id` (`customer_id`),
  CONSTRAINT `fk_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_phone`
--

LOCK TABLES `customer_phone` WRITE;
/*!40000 ALTER TABLE `customer_phone` DISABLE KEYS */;
INSERT INTO `customer_phone` VALUES (7700086,'990101840'),(7700088,'981111841'),(111111,'9987654321'),(7700120,'9987654321'),(34384783,'1234567890'),(7700123,'8888899999'),(7700121,'1234567890'),(7700199,'1234567890'),(7700087,'1234567890'),(123,'1000000000'),(123,'1000000000');
/*!40000 ALTER TABLE `customer_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customer_view`
--

DROP TABLE IF EXISTS `customer_view`;
/*!50001 DROP VIEW IF EXISTS `customer_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customer_view` AS SELECT 
 1 AS `customer_id`,
 1 AS `name`,
 1 AS `dob`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `data_entries`
--

DROP TABLE IF EXISTS `data_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_entries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entry` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_entries`
--

LOCK TABLES `data_entries` WRITE;
/*!40000 ALTER TABLE `data_entries` DISABLE KEYS */;
INSERT INTO `data_entries` VALUES (1,'uhhkj');
/*!40000 ALTER TABLE `data_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `seat` int NOT NULL,
  `departure_time` varchar(10) DEFAULT NULL,
  `destination` varchar(50) DEFAULT NULL,
  `flight_no` int NOT NULL,
  `arrival_time` varchar(10) DEFAULT NULL,
  `travel_class` varchar(50) DEFAULT NULL,
  `food` varchar(10) DEFAULT NULL,
  `departure` varchar(50) DEFAULT NULL,
  `travel_date` date DEFAULT NULL,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`flight_no`,`customer_id`),
  KEY `fk_cust` (`customer_id`),
  CONSTRAINT `fk_cust` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES (15,'9:00','Chennai',209,'12:00','Economic','Non Veg','Pune','2024-09-29',7700100),(11,'9:00','Delhi',233,'12:00','Economic','Non Veg','Pune','2024-09-29',7700100),(11,'9:00','Hydrabad',239,'12:00','Economic','Non Veg','Pune','2024-09-29',7700117),(2,'3:50','Banglore',256,'5:50','Economic','Veg','Mumbai','2024-01-02',7700088),(8,'9:00','Banglore',299,'12:00','Economic','Veg','Pune','2024-09-29',7700118),(37,'12:30','Chennai',356,'14:11','Business','Veg','Mumbai','2024-11-13',7700199),(65,'11:00','Madras',378,'14:51','First Class','Veg','Mumbai','2024-12-25',7700123),(28,'23:03','Ahmedaoab',599,'02:56','Business',NULL,'Mumbai','2024-11-19',34384783),(15,'14:23','Chennai',2220,'16:29','Economic','Veg','Mumbai','2024-11-15',7700087),(1,'2:00','Pune',2268,'3:00','Business','Veg','Mumbai','2024-11-02',7700086);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `flight_list`
--

DROP TABLE IF EXISTS `flight_list`;
/*!50001 DROP VIEW IF EXISTS `flight_list`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `flight_list` AS SELECT 
 1 AS `name`,
 1 AS `destination`,
 1 AS `travel_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `journey_mode`
--

DROP TABLE IF EXISTS `journey_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journey_mode` (
  `seats` int NOT NULL,
  `food` varchar(10) DEFAULT NULL,
  `destination` varchar(50) DEFAULT NULL,
  `departure` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journey_mode`
--

LOCK TABLES `journey_mode` WRITE;
/*!40000 ALTER TABLE `journey_mode` DISABLE KEYS */;
INSERT INTO `journey_mode` VALUES (200,'Veg','Banglore','Mumbai'),(150,'Veg','Pune','Mumbai');
/*!40000 ALTER TABLE `journey_mode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `transaction_id` int NOT NULL,
  `mode_of_payment` varchar(20) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_customer` (`customer_id`),
  CONSTRAINT `fk_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `payments_chk_1` CHECK ((`price` >= 2000))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (88845,'UPI',17729,7700086),(88856,'Debit Card',28800,7700088),(88860,'UPI',15000,7700100),(88861,'UPI',30000,7700101),(88862,'Debit Card',3000,7700117),(88863,'Credit Card',14560,7700118),(88865,'UPI',25000,7700088),(88866,'Credit Card',9000,7700088),(88867,'Credit Card',9000,7700101),(88868,'UPI',29099,7700088);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_mode` BEFORE INSERT ON `payments` FOR EACH ROW BEGIN
IF NEW.mode_of_payment not in ('UPI','Debit Card', 'Credit Card')THEN
SIGNAL SQLSTATE '45004'
SET MESSAGE_TEXT = 'ERROR: Invalid mode of payment!!!';
END IF; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `payments_subset`
--

DROP TABLE IF EXISTS `payments_subset`;
/*!50001 DROP VIEW IF EXISTS `payments_subset`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `payments_subset` AS SELECT 
 1 AS `transaction_id`,
 1 AS `mode_of_payment`,
 1 AS `price`,
 1 AS `customer_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `booking_date` date DEFAULT NULL,
  `booking_time` varchar(10) DEFAULT NULL,
  `pnr_no` int NOT NULL,
  `transaction_id` int DEFAULT NULL,
  PRIMARY KEY (`pnr_no`),
  KEY `fk_payments` (`transaction_id`),
  CONSTRAINT `fk_payments` FOREIGN KEY (`transaction_id`) REFERENCES `payments` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES ('2023-12-02','7:30',80001,88845),('2024-09-02','9:50',80002,88856);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `seat` int NOT NULL,
  `arrival_time` varchar(10) DEFAULT NULL,
  `departure_time` varchar(10) DEFAULT NULL,
  `train_no` int NOT NULL,
  `travel_class` varchar(50) DEFAULT NULL,
  `food` varchar(10) DEFAULT NULL,
  `travel_date` date DEFAULT NULL,
  `departure` varchar(50) DEFAULT NULL,
  `destination` varchar(50) DEFAULT NULL,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`train_no`,`customer_id`),
  KEY `fk_custom` (`customer_id`),
  CONSTRAINT `fk_custom` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
INSERT INTO `train` VALUES (49,'01:30','22:55',269,'First AC','Veg','2024-11-20','Mumbai','Kolkata',7700100),(51,'14:11','12:00',269,'Second AC','Veg','2024-11-13','Kolkata','Mumbai',7700121),(92,'13:30','10:24',985,'Third AC',NULL,'2024-11-26','Mumbai','Chennai',7700120),(200,'12:50','4:50',1256,'2nd AC','Veg','2024-11-09','Mumbai','Ahemdabad',7700086),(101,'3:00','5:00',3169,'2nd AC','Veg','2024-11-12','Mumbai','Banglore',7700101),(100,'3:00','5:00',3269,'2nd AC','Veg','2024-11-12','Mumbai','Banglore',7700088);
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `customer_view`
--

/*!50001 DROP VIEW IF EXISTS `customer_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_view` AS select `customer`.`customer_id` AS `customer_id`,`customer`.`name` AS `name`,`customer`.`dob` AS `dob` from `customer` where ((`customer`.`customer_id` < 10000000) and (`customer`.`customer_id` >= 1000000)) */
/*!50002 WITH CASCADED CHECK OPTION */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `flight_list`
--

/*!50001 DROP VIEW IF EXISTS `flight_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `flight_list` AS select `c`.`name` AS `name`,`f`.`destination` AS `destination`,`f`.`travel_date` AS `travel_date` from (`customer` `c` join `flight` `f` on((`c`.`customer_id` = `f`.`customer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `payments_subset`
--

/*!50001 DROP VIEW IF EXISTS `payments_subset`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `payments_subset` AS select `payments`.`transaction_id` AS `transaction_id`,`payments`.`mode_of_payment` AS `mode_of_payment`,`payments`.`price` AS `price`,`payments`.`customer_id` AS `customer_id` from `payments` where ((`payments`.`customer_id` = 7700088) or (`payments`.`customer_id` = 7700101)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-09 11:41:33
