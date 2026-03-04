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
INSERT INTO `automaton_spells` VALUES (47,300,16,0,0,0);
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
INSERT INTO `automaton_spells` VALUES (477,337,16,0,0,0); -- Regen IV
INSERT INTO `automaton_spells` VALUES (79,280,8,13,128,0); -- Slow II
INSERT INTO `automaton_spells` VALUES (80,278,8,4,32,0);-- Paralyze II
INSERT INTO `automaton_spells` VALUES (276,282,8,5,64,0); -- Blind II
INSERT INTO `automaton_spells` VALUES (25,284,8,134,0,0); -- Dia III
INSERT INTO `automaton_spells` VALUES (232,284,8,135,0,0); -- Bio III
INSERT INTO `automaton_spells` VALUES (845,147,8,0,0,0); -- Flurry
INSERT INTO `automaton_spells` VALUES (846,286,8,0,0,0); -- Flurry II
INSERT INTO `automaton_spells` VALUES (511,286,61,0,0,0); -- Haste II
INSERT INTO `automaton_spells` VALUES (879,286,8,597,0,0); -- Inundation
INSERT INTO `automaton_spells` VALUES (109,123,8,0,0,0); -- Refresh
INSERT INTO `automaton_spells` VALUES (473,282,8,0,0,0); -- Refresh II
INSERT INTO `automaton_spells` VALUES (107,278,8,0,0,0); -- Phalanx II

INSERT INTO `automaton_spells` VALUES (368,24,1,0,0,0); -- Foe Requiem
INSERT INTO `automaton_spells` VALUES (369,54,1,0,0,0); -- Foe Requiem II
INSERT INTO `automaton_spells` VALUES (370,114,1,0,0,0); -- Foe Requiem III
INSERT INTO `automaton_spells` VALUES (371,144,1,0,0,0); -- Foe Requiem IV
INSERT INTO `automaton_spells` VALUES (372,188,1,0,0,0); -- Foe Requiem V
INSERT INTO `automaton_spells` VALUES (373,231,1,0,0,0); -- Foe Requiem VI
INSERT INTO `automaton_spells` VALUES (374,274,1,0,0,0); -- Foe Requiem VII

INSERT INTO `automaton_spells` VALUES (378,18,1,0,0,0);  -- Army's Paeon
INSERT INTO `automaton_spells` VALUES (379,48,1,0,0,0); -- Army's Paeon II
INSERT INTO `automaton_spells` VALUES (380,108,1,0,0,0); -- Army's Paeon III
INSERT INTO `automaton_spells` VALUES (381,138,1,0,0,0); -- Army's Paeon IV
INSERT INTO `automaton_spells` VALUES (382,223,1,0,0,0); -- Army's Paeon V
INSERT INTO `automaton_spells` VALUES (383,284,1,0,0,0); -- Army's Paeon VI

INSERT INTO `automaton_spells` VALUES (386,78,1,0,0,0); -- Mage's Ballad
INSERT INTO `automaton_spells` VALUES (387,178,1,0,0,0); -- Mage's Ballad II
INSERT INTO `automaton_spells` VALUES (388,324,1,0,0,0); -- Mage's Ballad III

INSERT INTO `automaton_spells` VALUES (389,1,1,0,0,0);   -- Knight's Minne
INSERT INTO `automaton_spells` VALUES (390,66,1,0,0,0); -- Knight's Minne II
INSERT INTO `automaton_spells` VALUES (391,126,1,0,0,0); -- Knight's Minne III
INSERT INTO `automaton_spells` VALUES (392,207,1,0,0,0); -- Knight's Minne IV
INSERT INTO `automaton_spells` VALUES (393,294,1,0,0,0); -- Knight's Minne V

INSERT INTO `automaton_spells` VALUES (394,12,1,0,0,0);  -- Valor Minuet
INSERT INTO `automaton_spells` VALUES (395,72,1,0,0,0); -- Valor Minuet II
INSERT INTO `automaton_spells` VALUES (396,132,1,0,0,0); -- Valor Minuet III
INSERT INTO `automaton_spells` VALUES (397,215,1,0,0,0); -- Valor Minuet IV
INSERT INTO `automaton_spells` VALUES (398,336,1,0,0,0); -- Valor Minuet V

INSERT INTO `automaton_spells` VALUES (399,36,1,0,0,0); -- Sword Madrigal
INSERT INTO `automaton_spells` VALUES (400,158,1,0,0,0); -- Blade Madrigal

INSERT INTO `automaton_spells` VALUES (419,90,1,0,0,0); -- Advancing March
INSERT INTO `automaton_spells` VALUES (420,203,1,0,0,0); -- Victory March

INSERT INTO `automaton_spells` VALUES (462,102,1,0,0,0); -- Magic Finale

INSERT INTO `automaton_spells` VALUES (421,120,1,0,512,0); -- Battlefield Elegy
INSERT INTO `automaton_spells` VALUES (422,198,1,0,512,0); -- Carnage Elegy



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
