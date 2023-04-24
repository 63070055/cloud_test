-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: library
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `author_id` int NOT NULL,
  `author_name` varchar(255) NOT NULL,
  PRIMARY KEY (`author_id`),
  UNIQUE KEY `author_name_UNIQUE` (`author_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (1,'Julie Ellse'),(2,'Mario Johnson');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `book_status` varchar(255) NOT NULL,
  `book_language` varchar(255) DEFAULT NULL,
  `book_edition` int DEFAULT NULL,
  `book_type` enum('documentary','fiction','journal','magazine','publication','textbook') NOT NULL,
  `book_isbn` char(13) NOT NULL,
  `barcode` char(13) NOT NULL,
  `book_year` int NOT NULL,
  `book_title` varchar(255) NOT NULL,
  `book_accessnumber` int DEFAULT NULL,
  `book_publisher` varchar(255) NOT NULL,
  `book_price` float NOT NULL,
  `book_quantity` int NOT NULL,
  `book_librarian_id` int NOT NULL,
  `book_image` varchar(255) NOT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE KEY `barcode_UNIQUE` (`barcode`),
  KEY `librarian_id_idx` (`book_librarian_id`),
  CONSTRAINT `librarian_id` FOREIGN KEY (`book_librarian_id`) REFERENCES `cataloging_dept` (`ca_librarian_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'unborrow','english',2,'documentary','7662372201885','000001100101',2009,'World of Tigers',7894656,'sea-add',249,10,1,'/uploads/book1.jpg'),(2,'borrowed','thai',3,'textbook','7189034567812','4712841875122',1987,'luca Espanol',372412,'Bookfinya',149,46,1,'/uploads/book2.jpg');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_author`
--

DROP TABLE IF EXISTS `book_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_author` (
  `ba_book_id` int NOT NULL,
  `ba_author_id` int NOT NULL,
  PRIMARY KEY (`ba_book_id`,`ba_author_id`),
  KEY `author_id_idx` (`ba_author_id`),
  CONSTRAINT `author_id` FOREIGN KEY (`ba_author_id`) REFERENCES `author` (`author_id`),
  CONSTRAINT `book_id` FOREIGN KEY (`ba_book_id`) REFERENCES `book` (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_author`
--

LOCK TABLES `book_author` WRITE;
/*!40000 ALTER TABLE `book_author` DISABLE KEYS */;
INSERT INTO `book_author` VALUES (1,1);
/*!40000 ALTER TABLE `book_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow_item`
--

DROP TABLE IF EXISTS `borrow_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow_item` (
  `item_no` int NOT NULL AUTO_INCREMENT,
  `return_date` date NOT NULL,
  `bi_borrow_id` int NOT NULL,
  `bi_book_id` int NOT NULL,
  PRIMARY KEY (`item_no`,`bi_borrow_id`),
  KEY `borrow_id_idx` (`bi_borrow_id`),
  KEY `book_id_idx` (`bi_book_id`),
  CONSTRAINT `bi_book_id` FOREIGN KEY (`bi_book_id`) REFERENCES `book` (`book_id`),
  CONSTRAINT `bi_borrow_id` FOREIGN KEY (`bi_borrow_id`) REFERENCES `borrow_return` (`borrow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow_item`
--

LOCK TABLES `borrow_item` WRITE;
/*!40000 ALTER TABLE `borrow_item` DISABLE KEYS */;
INSERT INTO `borrow_item` VALUES (1,'2022-04-29',1,2),(2,'2022-04-30',2,1),(3,'2022-05-01',3,1);
/*!40000 ALTER TABLE `borrow_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow_return`
--

DROP TABLE IF EXISTS `borrow_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow_return` (
  `borrow_id` int NOT NULL,
  `borrow_date` date NOT NULL,
  `borrow_status` varchar(255) NOT NULL,
  `borrow_dateline_date` date NOT NULL,
  `br_member_id` int NOT NULL,
  `br_librarian_id` int NOT NULL,
  PRIMARY KEY (`borrow_id`),
  KEY `member_id_idx` (`br_member_id`) /*!80000 INVISIBLE */,
  KEY `librarian_id_idx` (`br_librarian_id`),
  CONSTRAINT `br_librarian_id` FOREIGN KEY (`br_librarian_id`) REFERENCES `information_service_dept` (`info_librarian_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `br_member_id` FOREIGN KEY (`br_member_id`) REFERENCES `member` (`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow_return`
--

LOCK TABLES `borrow_return` WRITE;
/*!40000 ALTER TABLE `borrow_return` DISABLE KEYS */;
INSERT INTO `borrow_return` VALUES (1,'2022-01-29','borrowed','2022-04-29',1,2),(2,'2022-01-30','borrowed','2022-04-30',2,2),(3,'2022-02-01','borrowed','2022-05-01',1,2);
/*!40000 ALTER TABLE `borrow_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cataloging_dept`
--

DROP TABLE IF EXISTS `cataloging_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cataloging_dept` (
  `ca_librarian_id` int NOT NULL,
  PRIMARY KEY (`ca_librarian_id`),
  CONSTRAINT `ca_librarian_id` FOREIGN KEY (`ca_librarian_id`) REFERENCES `librarian` (`librarian_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cataloging_dept`
--

LOCK TABLES `cataloging_dept` WRITE;
/*!40000 ALTER TABLE `cataloging_dept` DISABLE KEYS */;
INSERT INTO `cataloging_dept` VALUES (1);
/*!40000 ALTER TABLE `cataloging_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `information_service_dept`
--

DROP TABLE IF EXISTS `information_service_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `information_service_dept` (
  `info_librarian_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`info_librarian_id`),
  CONSTRAINT `info_librarian_id` FOREIGN KEY (`info_librarian_id`) REFERENCES `librarian` (`librarian_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `information_service_dept`
--

LOCK TABLES `information_service_dept` WRITE;
/*!40000 ALTER TABLE `information_service_dept` DISABLE KEYS */;
INSERT INTO `information_service_dept` VALUES (2);
/*!40000 ALTER TABLE `information_service_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `librarian`
--

DROP TABLE IF EXISTS `librarian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `librarian` (
  `librarian_id` int NOT NULL AUTO_INCREMENT,
  `p_mobile` char(10) NOT NULL,
  `p_faculty` varchar(255) DEFAULT NULL,
  `p_firstname` varchar(255) NOT NULL,
  `p_lastname` varchar(255) NOT NULL,
  `p_username` varchar(255) NOT NULL,
  `p_position` varchar(255) NOT NULL,
  `p_department` varchar(255) NOT NULL,
  `p_address` varchar(255) NOT NULL,
  `p_email` varchar(255) NOT NULL,
  `p_password` varchar(45) NOT NULL,
  `p_function` varchar(255) DEFAULT NULL,
  `cataloging_dept` tinyint(1) NOT NULL,
  `information_service_dept` tinyint(1) NOT NULL,
  PRIMARY KEY (`librarian_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `librarian`
--

LOCK TABLES `librarian` WRITE;
/*!40000 ALTER TABLE `librarian` DISABLE KEYS */;
INSERT INTO `librarian` VALUES (1,'0996286167','IT','Nattapong','Waijaree','admin','librarian','KMITL','480/470 Bangwa','eartgoasdcas@gmail.com','Aa123456','librarian',1,0),(2,'0854675896','IT','google','cherom','admin1','librarian','KMITL','480/471 Bangwa','google@hotmail.com','Aa1234567','librarian',0,1);
/*!40000 ALTER TABLE `librarian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `member_id` int NOT NULL AUTO_INCREMENT,
  `p_mobile` char(10) NOT NULL,
  `p_faculty` varchar(255) DEFAULT NULL,
  `p_firstname` varchar(255) NOT NULL,
  `p_lastname` varchar(255) NOT NULL,
  `p_username` varchar(255) NOT NULL,
  `p_position` varchar(255) NOT NULL,
  `p_address` varchar(255) NOT NULL,
  `p_email` varchar(255) NOT NULL,
  `p_password` varchar(45) NOT NULL,
  `p_major` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'0865484569','IT','Gsy','Ritey','nattapong','member','48/85 Bangkok','digitol@hotmail.com','Aa1122','IT'),(2,'0859645874','IT','papang','joi','papang55','member','48/47 Bangkok','gol@gmail.com','Qq123456','IT'),(4,'0854697854','IT','papang55','homepage','papanfza55','member','8/89 Bangkok thailand','librarian@gmail.com','Qq123456','IT'),(5,'0854756985','IT','facebook','instar','youtube','member','5/6 valorant','valo@gmail.com','Ww123456','IT'),(6,'0865445588','IT','asdasdasdasdasda','asdasdasdasdasda','asdasdasdasdasda','member','asdasdasdasdasda','asdasd@gmail.com','Aa111111','IT');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_librarian_id` int DEFAULT NULL,
  `user_member_id` int DEFAULT NULL,
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_UN` (`token`),
  KEY `token_lb_FK` (`user_librarian_id`),
  KEY `token_mb_FK` (`user_member_id`),
  CONSTRAINT `token_lb_FK` FOREIGN KEY (`user_librarian_id`) REFERENCES `librarian` (`librarian_id`) ON DELETE CASCADE,
  CONSTRAINT `token_mb_FK` FOREIGN KEY (`user_member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (40,NULL,1,'An/&muvH-U2-tFId6fzNKmGvQtu@&Op5WL25vcO/tdW/MpzXH/BlCD9ZT@k=1WCD*YOP7hZ-#pWqT5CGns/0-zZxu^bCA!TR8qH-');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-29  9:14:23
