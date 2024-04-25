-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: tpzdb
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
-- Table structure for table `automaton_spells`
--

DROP TABLE IF EXISTS `automaton_spells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `automaton_spells` (
  `spellid` smallint(4) unsigned NOT NULL,
  `skilllevel` smallint(3) unsigned NOT NULL DEFAULT '0',
  `heads` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `enfeeble` smallint(4) unsigned NOT NULL DEFAULT '0',
  `immunity` smallint(4) unsigned NOT NULL DEFAULT '0',
  `removes` int(6) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`spellid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=14;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automaton_spells`
--

LOCK TABLES `automaton_spells` WRITE;
/*!40000 ALTER TABLE `automaton_spells` DISABLE KEYS */;
INSERT INTO `automaton_spells` VALUES (1,12,31,0,0,136129);
INSERT INTO `automaton_spells` VALUES (2,45,31,0,0,0);
INSERT INTO `automaton_spells` VALUES (3,81,31,0,0,0);
INSERT INTO `automaton_spells` VALUES (4,147,31,0,0,0);
INSERT INTO `automaton_spells` VALUES (5,207,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (6,313,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (14,27,16,0,0,3);
INSERT INTO `automaton_spells` VALUES (15,36,16,0,0,4);
INSERT INTO `automaton_spells` VALUES (16,45,16,0,0,5);
INSERT INTO `automaton_spells` VALUES (17,60,16,0,0,6);
INSERT INTO `automaton_spells` VALUES (18,120,16,0,0,7);
INSERT INTO `automaton_spells` VALUES (19,105,16,0,0,2079);
INSERT INTO `automaton_spells` VALUES (20,90,16,0,0,594974);
INSERT INTO `automaton_spells` VALUES (23,0,61,134,0,0);
INSERT INTO `automaton_spells` VALUES (24,96,61,134,0,0);
INSERT INTO `automaton_spells` VALUES (43,24,24,0,0,0);
INSERT INTO `automaton_spells` VALUES (125,24,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (44,84,24,0,0,0);
INSERT INTO `automaton_spells` VALUES (126,84,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (45,144,24,0,0,0);
INSERT INTO `automaton_spells` VALUES (127,144,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (46,217,24,0,0,0);
INSERT INTO `automaton_spells` VALUES (128,217,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (47,281,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (48,54,24,0,0,0);
INSERT INTO `automaton_spells` VALUES (130,54,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (49,114,24,0,0,0);
INSERT INTO `automaton_spells` VALUES (131,114,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (50,188,24,0,0,0);
INSERT INTO `automaton_spells` VALUES (132,188,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (51,241,24,0,0,0);
INSERT INTO `automaton_spells` VALUES (133,241,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (52,347,24,0,0,0);
INSERT INTO `automaton_spells` VALUES (54,105,8,0,0,0);
INSERT INTO `automaton_spells` VALUES (56,42,61,13,128,0);
INSERT INTO `automaton_spells` VALUES (57,147,24,0,0,0);
INSERT INTO `automaton_spells` VALUES (58,21,61,4,32,0);
INSERT INTO `automaton_spells` VALUES (59,57,61,6,16,0);
INSERT INTO `automaton_spells` VALUES (106,99,8,0,0,0);
INSERT INTO `automaton_spells` VALUES (108,66,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (110,135,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (111,232,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (129,286,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (134,286,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (143,99,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (144,60,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (145,153,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (146,251,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (147,281,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (148,349,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (149,75,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (150,178,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (151,256,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (152,286,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (153,368,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (154,45,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (155,138,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (156,246,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (157,276,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (158,331,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (159,15,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (160,108,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (161,227,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (162,266,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (163,296,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (164,90,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (165,203,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (166,261,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (167,291,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (168,389,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (169,30,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (170,123,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (171,236,40,0,0,0);
INSERT INTO `automaton_spells` VALUES (172,271,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (173,313,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (220,18,61,3,256,0);
INSERT INTO `automaton_spells` VALUES (221,141,57,3,256,0);
INSERT INTO `automaton_spells` VALUES (230,33,61,135,0,0);
INSERT INTO `automaton_spells` VALUES (231,111,61,135,0,0);
INSERT INTO `automaton_spells` VALUES (245,45,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (247,78,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (248,331,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (254,27,61,5,64,0);
INSERT INTO `automaton_spells` VALUES (260,105,8,0,0,0);
INSERT INTO `automaton_spells` VALUES (270,120,32,140,0,0);
INSERT INTO `automaton_spells` VALUES (277,256,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (286,227,61,21,0,0);
INSERT INTO `automaton_spells` VALUES (477,337,16,0,0,0);
INSERT INTO `automaton_spells` VALUES (493,286,8,0,0,0);
INSERT INTO `automaton_spells` VALUES (79,286,8,0,0,0);
INSERT INTO `automaton_spells` VALUES (80,286,8,0,0,0);
INSERT INTO `automaton_spells` VALUES (276,286,8,0,0,0);
INSERT INTO `automaton_spells` VALUES (25,286,8,0,0,0);
INSERT INTO `automaton_spells` VALUES (232,286,8,0,0,0);
INSERT INTO `automaton_spells` VALUES (511,286,61,0,0,0);
INSERT INTO `automaton_spells` VALUES (847,368,32,0,0,0);
INSERT INTO `automaton_spells` VALUES (879,281,8,597,0,0);

/*!40000 ALTER TABLE `automaton_spells` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-09 11:09:23
