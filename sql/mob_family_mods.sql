-- MySQL dump 10.13  Distrib 5.6.13, for Win64 (x86_64)
--
-- Host: localhost    Database: tpzdb
-- ------------------------------------------------------
-- Server version   5.6.13-log

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
-- Table structure for table `mob_family_mods`
--

DROP TABLE IF EXISTS `mob_family_mods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mob_family_mods` (
  `familyid` smallint(5) unsigned NOT NULL,
  `modid` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT '0',
  `is_mob_mod` boolean NOT NULL DEFAULT '0',
  PRIMARY KEY (`familyid`,`modid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=13 PACK_KEYS=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mob_family_mods`
--

LOCK TABLES `mob_family_mods` WRITE;
/*!40000 ALTER TABLE `mob_family_mods` DISABLE KEYS */;
--INSERT INTO `mob_family_mods` VALUES (175,29,50,0);
INSERT INTO `mob_family_mods` VALUES (4,7,60,1);
INSERT INTO `mob_family_mods` VALUES (193,3,40,1); -- Pet wyvern  100 MP
INSERT INTO `mob_family_mods` VALUES (34,3,100,1); -- Carbuncle 100 MP
INSERT INTO `mob_family_mods` VALUES (267,4,20,1); -- Guivre 20 yalm sight range
INSERT INTO `mob_family_mods` VALUES (87,3,10,1); -- Dragon MP
INSERT INTO `mob_family_mods` VALUES (87,4,18,1); -- Dragon 18 yalm sight range
INSERT INTO `mob_family_mods` VALUES (87,5,10,1); -- Dragon 10 yalm sound range


-- Define sublinks aka will link with other families??
INSERT INTO `mob_family_mods` VALUES (240,10,1,1);
INSERT INTO `mob_family_mods` VALUES (169,10,1,1);
INSERT INTO `mob_family_mods` VALUES (358,10,1,1);
INSERT INTO `mob_family_mods` VALUES (190,10,2,1);
INSERT INTO `mob_family_mods` VALUES (189,10,2,1);
INSERT INTO `mob_family_mods` VALUES (334,10,2,1);
INSERT INTO `mob_family_mods` VALUES (46,10,3,1);
INSERT INTO `mob_family_mods` VALUES (252,10,3,1);
INSERT INTO `mob_family_mods` VALUES (47,10,3,1);
INSERT INTO `mob_family_mods` VALUES (245,10,4,1);
INSERT INTO `mob_family_mods` VALUES (216,10,4,1);
INSERT INTO `mob_family_mods` VALUES (133,10,5,1);
INSERT INTO `mob_family_mods` VALUES(373, 10, 5, 1); -- Dynamis goblin?
INSERT INTO `mob_family_mods` VALUES(532, 10, 5, 1); -- Xzomit baby?
INSERT INTO `mob_family_mods` VALUES (184,10,5,1);
INSERT INTO `mob_family_mods` VALUES (59,10,5,1);
INSERT INTO `mob_family_mods` VALUES (253,10,6,1);
INSERT INTO `mob_family_mods` VALUES (254,10,6,1);
INSERT INTO `mob_family_mods` VALUES (289,10,6,1);
INSERT INTO `mob_family_mods` VALUES (307,10,6,1);
INSERT INTO `mob_family_mods` VALUES (212,10,7,1);
INSERT INTO `mob_family_mods` VALUES (362,10,7,1);
INSERT INTO `mob_family_mods` VALUES (213,10,8,1);
INSERT INTO `mob_family_mods` VALUES (285,10,8,1);
INSERT INTO `mob_family_mods` VALUES (176,10,8,1);
INSERT INTO `mob_family_mods` VALUES (246,10,9,1);
INSERT INTO `mob_family_mods` VALUES (308,10,9,1);
INSERT INTO `mob_family_mods` VALUES (326,10,9,1);
INSERT INTO `mob_family_mods` VALUES (171,10,10,1);
INSERT INTO `mob_family_mods` VALUES (182,10,10,1);
INSERT INTO `mob_family_mods` VALUES (310,10,10,1);
INSERT INTO `mob_family_mods` VALUES (469,10,10,1);
INSERT INTO `mob_family_mods` VALUES (233,10,11,1);
INSERT INTO `mob_family_mods` VALUES (311,10,11,1);
INSERT INTO `mob_family_mods` VALUES (199,10,12,1);
INSERT INTO `mob_family_mods` VALUES (288,10,12,1);
INSERT INTO `mob_family_mods` VALUES (165,10,13,1);
INSERT INTO `mob_family_mods` VALUES (166,10,13,1);
INSERT INTO `mob_family_mods` VALUES (301,10,13,1);
INSERT INTO `mob_family_mods` VALUES (27,10,14,1);
INSERT INTO `mob_family_mods` VALUES (294,10,14,1);

INSERT INTO `mob_family_mods` VALUES (169,11,15,1);
INSERT INTO `mob_family_mods` VALUES (358,11,15,1);
INSERT INTO `mob_family_mods` VALUES (110,3,50,1);
--INSERT INTO `mob_family_mods` VALUES (121,242,20,0); Ghost paralyze resist? no ty
--INSERT INTO `mob_family_mods` VALUES (52,242,20,0 Ghost paralyze resist? no ty
INSERT INTO `mob_family_mods` VALUES (258,34,25,1);
INSERT INTO `mob_family_mods` VALUES (234,37,1,1);
INSERT INTO `mob_family_mods` VALUES (72,3,50,1);
INSERT INTO `mob_family_mods` VALUES (140,3,50,1);
INSERT INTO `mob_family_mods` VALUES (141,3,50,1);
INSERT INTO `mob_family_mods` VALUES (207,3,50,1);
INSERT INTO `mob_family_mods` VALUES (255,3,50,1);
INSERT INTO `mob_family_mods` VALUES (253,3,50,1);
INSERT INTO `mob_family_mods` VALUES (194,3,50,1);
INSERT INTO `mob_family_mods` VALUES (135,4,4,1);
INSERT INTO `mob_family_mods` VALUES (394,41,988,1);
INSERT INTO `mob_family_mods` VALUES (394,42,989,1);
INSERT INTO `mob_family_mods` VALUES (394,43,2,1);
INSERT INTO `mob_family_mods` VALUES (150,4,30,1);
INSERT INTO `mob_family_mods` VALUES (394,4,30,1);
INSERT INTO `mob_family_mods` VALUES (236,4,30,1);
INSERT INTO `mob_family_mods` VALUES (481,41,988,1);
INSERT INTO `mob_family_mods` VALUES (481,42,989,1);


-- Most undead, Rocs, and Hecteyes are highly resistant to sleep,
-- Kindred and bat(s) are fairly resistant
--INSERT INTO `mob_family_mods` VALUES (47,240,50,0);
--INSERT INTO `mob_family_mods` VALUES (48,240,50,0);
--INSERT INTO `mob_family_mods` VALUES (52,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (74,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (86,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (88,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (89,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (115,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (121,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (125,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (139,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (142,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (143,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (169,240,50,0);
--INSERT INTO `mob_family_mods` VALUES (203,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (204,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (205,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (221,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (222,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (223,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (227,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (358,240,50,0);
--INSERT INTO `mob_family_mods` VALUES (359,240,100,0);
--INSERT INTO `mob_family_mods` VALUES (227,243,75,0);	-- skeleton	blind resist
--INSERT INTO `mob_family_mods` VALUES (142,243,75,0);	-- hound blind resist
--INSERT INTO `mob_family_mods` VALUES (143,243,75,0);	-- hound blind resist
--INSERT INTO `mob_family_mods` VALUES (121,243,75,0);	-- ghost blind resist
--INSERT INTO `mob_family_mods` VALUES (46,243,75,0);		-- bat blind resist
--INSERT INTO `mob_family_mods` VALUES (47,243,75,0);		-- bat blind resist

-- Experience bonus
INSERT INTO `mob_family_mods` VALUES (208,382,23,1);	-- Ram +23% EXP
INSERT INTO `mob_family_mods` VALUES (266,382,23,1);	-- Wyvern +23% EXP 
INSERT INTO `mob_family_mods` VALUES (109,382,10,1);	-- Euvhi +10% EXP 
INSERT INTO `mob_family_mods` VALUES (194,382,10,1);	-- Phuabo +10% EXP 
INSERT INTO `mob_family_mods` VALUES (132,382,10,1);	-- Gnole +10% EXP 



-- Attack bonus
INSERT INTO `mob_family_mods` VALUES (208,62,10,0);		-- Ram +10% Attack
INSERT INTO `mob_family_mods` VALUES (242,62,10,0);		-- Tiger +10% Attack
INSERT INTO `mob_family_mods` VALUES (555,62,10,0);		-- Smilodon +10% Attack
INSERT INTO `mob_family_mods` VALUES (136,62,10,0);		-- Goobbue +10% Attack
INSERT INTO `mob_family_mods` VALUES (179,62,10,0);		-- Manticore +10% Attack
INSERT INTO `mob_family_mods` VALUES (246,62,20,0);		-- Troll +20% Attack 
INSERT INTO `mob_family_mods` VALUES (217,62,20,0);		-- Scorpion +20% Attack
INSERT INTO `mob_family_mods` VALUES (62,62,20,0);		-- Cerberus +20% Attack
INSERT INTO `mob_family_mods` VALUES (180,62,25,0);		-- Marid +25% Attack 
INSERT INTO `mob_family_mods` VALUES (89,62,25,0);		-- Draugar +25% Attack 
INSERT INTO `mob_family_mods` VALUES (252,62,25,0);		-- Vampyr +25% Attack 
INSERT INTO `mob_family_mods` VALUES (191,62,25,0);		-- Orobon +25% Attack 
INSERT INTO `mob_family_mods` VALUES (1,62,25,0);		-- Acrolith +25% Attack 
INSERT INTO `mob_family_mods` VALUES (132,62,25,0);		-- Gnole +25% Attack 
INSERT INTO `mob_family_mods` VALUES (6,62,25,0);		-- Amphiptere +25% Attack 
INSERT INTO `mob_family_mods` VALUES (207,62,25,0);		-- Rafflesia +25% Attack 
INSERT INTO `mob_family_mods` VALUES (211,62,25,0);		-- Ruszor +25% Attack 
INSERT INTO `mob_family_mods` VALUES (944,62,25,0);		-- WotG Orc +25% Attack 
INSERT INTO `mob_family_mods` VALUES (945,62,25,0);		-- WotG Orc War Machine +25% Attack 
INSERT INTO `mob_family_mods` VALUES (461,62,25,0);     -- Gabbrath(Achuka) +25% Attack 
INSERT INTO `mob_family_mods` VALUES (626,62,25,0);	    -- Gabbrath +25% Attack 
INSERT INTO `mob_family_mods` VALUES (183,62,25,0);	    -- Mimic +25% Attack 
INSERT INTO `mob_family_mods` VALUES (135,62,25,0);	    -- Golem +20% Attack 

-- Flat Attack Penalty
INSERT INTO `mob_family_mods` VALUES (213,23,-20,0);	-- Sahagin -20 Attack

-- Defense Bonus
INSERT INTO `mob_family_mods` VALUES (272,63,20,0);		-- Zdei +20% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (233,63,20,0);		-- Soulflayer +20% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (74,63,20,0);		-- Corse +20% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (2,63,20,0);		-- Adamantoise +20% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (275,63,20,0);		-- Mini-Adamantoise +20% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (253,63,12,0);	    -- Wamoura +12% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (307,63,12,0);	    -- Wamoura(Achamoth) +12% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (252,63,25,0);	    -- Vampyr +25% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (191,63,25,0);	    -- Orobon +25% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (27,63,25,0);		-- Apkallu +25% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (246,63,25,0);	    -- Troll +25% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (209,63,25,0);	    -- Rampart +25% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (63,63,25,0);	 	-- Chariot +25% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (180,63,25,0);	    -- Marid +25% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (211,63,25,0);		-- Ruszor +25% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (942,63,25,0);		-- WotG Quadav +25% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (465,63,25,0);		-- Yggreant(Yumcax) +25% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (628,63,25,0);		-- Yggreant +25% Defense Bonus

-- Defense Penalty
INSERT INTO `mob_family_mods` VALUES (1,63,-25,0);		-- Acrolith -25% Defense Penalty
INSERT INTO `mob_family_mods` VALUES (1,302,-25,0);		-- Acrolith(Wulgaru) -25% Defense Penalty

-- Flat Defense Bonus
INSERT INTO `mob_family_mods` VALUES (171,1,25,0);		-- Lamiae +25 Defense Bonus
INSERT INTO `mob_family_mods` VALUES (310,1,25,0);		-- Lamiae(Experimental Lamiae) +25 Defense Bonus
INSERT INTO `mob_family_mods` VALUES (182,1,25,0);		-- Merrow +25 Defense Bonus

-- Evasion Bonus
INSERT INTO `mob_family_mods` VALUES (542,68,20,0);		-- Toad +20 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (196,68,10,0);		-- Poroggo +10 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (203,68,12,0);		-- Qutrub(Normal) +12 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (204,68,12,0);		-- Qutrub(Unused) +12 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (205,68,12,0);		-- Qutrub(Qutrub_Wastrel) +12 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (303,68,12,0);		-- Qutrub(ZareehklTheJu) +12 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (188,68,25,0);		-- Opo-opo +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (27,68,25,0);		-- Apkallu +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (199,68,25,0);		-- Qiqirn +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (198,68,25,0);		-- Puk +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (286,68,25,0);		-- Puk(Vulpangue) +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (72,68,25,0);		-- Colibri +20 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (287,68,25,0);		-- Colibri(Chamrosh) +20 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (176,68,10,0);		-- Mamool ja +10 evasion
INSERT INTO `mob_family_mods` VALUES (285,68,10,0);		-- Gulool_Ja_Ja +10 evasion
INSERT INTO `mob_family_mods` VALUES (119,68,25,0);		-- Gear +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (120,68,25,0);		-- Gears +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (90,68,25,0);		-- Dvergr +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (316,68,25,0);		-- Dvergr +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (131,68,25,0);		-- Gnat +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (6,68,25,0);		-- Amphiptere +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (117,68,25,0);		-- Gargouille +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (118,68,25,0);		-- Gargoyle +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (170,68,25,0);		-- Ladybug +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (192,68,25,0);		-- Peiste +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (195,68,25,0);		-- Pixie +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (517,68,25,0);		-- Pixie +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (604,68,25,0);		-- Pixie +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (616,68,25,0);		-- Pixie +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (617,68,25,0);		-- Pixie +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (231,68,25,0);		-- Slug +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (73,68,25,0);		-- Corpselights +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (943,68,25,0);		-- WotG Yagudo +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (460,68,25,0);		-- Waktza(Hurkan) +25 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (524,68,25,0);		-- Waktza +25 Evasion Racial

-- Evasion Penalty
INSERT INTO `mob_family_mods` VALUES (59,68,-10,0);	    -- Bugbear -10 Evasion
INSERT INTO `mob_family_mods` VALUES (180,68,-20,0);	-- Marid -20 Evasion
INSERT INTO `mob_family_mods` VALUES (295,68,-20,0);	-- Marid(Iriz Ima) -20 Evasion
INSERT INTO `mob_family_mods` VALUES (371,68,-20,0);	-- Marid -20 Evasion

-- PDT
INSERT INTO `mob_family_mods` VALUES (203,387,200,0);	-- Qutrub +200%(Bonus)
INSERT INTO `mob_family_mods` VALUES (204,387,200,0);	-- Qutrub +200%(Bonus)
INSERT INTO `mob_family_mods` VALUES (205,387,200,0);	-- Qutrub +200%(Bonus)

-- Breath Damage Taken(BDT)
INSERT INTO `mob_family_mods` VALUES (203,388,200,0);	-- Qutrub +200%(Bonus)
INSERT INTO `mob_family_mods` VALUES (204,388,200,0);	-- Qutrub +200%(Bonus)
INSERT INTO `mob_family_mods` VALUES (205,388,200,0);	-- Qutrub +200%(Bonus)
INSERT INTO `mob_family_mods` VALUES (62,388,25,0);		-- Cerberus +25%(Bonus)
INSERT INTO `mob_family_mods` VALUES (252,388,-13,0); 	-- Vampyr(NM) -13%
INSERT INTO `mob_family_mods` VALUES (284,388,-13,0); 	-- Vampyr(NM) -13%

-- Ranged damage taken(RDT)
INSERT INTO `mob_family_mods` VALUES (203,390,200,0);	-- Qutrub +200%(Bonus)
INSERT INTO `mob_family_mods` VALUES (204,390,200,0);	-- Qutrub +200%(Bonus)
INSERT INTO `mob_family_mods` VALUES (205,390,200,0);	-- Qutrub +200%(Bonus)

-- Magic damage taken (MDT)
INSERT INTO `mob_family_mods` VALUES (1,389,-13,0); 	-- Acrolith -13%
INSERT INTO `mob_family_mods` VALUES (302,389,-13,0); 	-- Wulgaru(Acrolith) -13%
INSERT INTO `mob_family_mods` VALUES (112,389,25,0); 	-- Flan +25%(Bonus)
INSERT INTO `mob_family_mods` VALUES (203,389,200,0);	-- Qutrub +200%(Bonus)
INSERT INTO `mob_family_mods` VALUES (204,389,200,0);	-- Qutrub +200%(Bonus)
INSERT INTO `mob_family_mods` VALUES (205,389,200,0);	-- Qutrub +200%(Bonus)
INSERT INTO `mob_family_mods` VALUES (61,389,-25,0); 	-- Cardian -25%
INSERT INTO `mob_family_mods` VALUES (74,389,-25,0); 	-- Corse -25%
INSERT INTO `mob_family_mods` VALUES (110,389,-13,0); 	-- EvilWeapon -13%
INSERT INTO `mob_family_mods` VALUES (122,389,-13,0); 	-- Ghrah -13%
INSERT INTO `mob_family_mods` VALUES (123,389,-13,0); 	-- Ghrah -13%
INSERT INTO `mob_family_mods` VALUES (124,389,-13,0); 	-- Ghrah -13%
INSERT INTO `mob_family_mods` VALUES (175,389,-50,0);	-- Magic Pot -50%
INSERT INTO `mob_family_mods` VALUES (7,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (8,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (9,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (10,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (11,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (12,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (13,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (14,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (15,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (16,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (17,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (18,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (19,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (20,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (21,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (22,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (23,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (24,389,-13,0); 	-- Animated Weapon -13%
INSERT INTO `mob_family_mods` VALUES (171,389,-13,0); 	-- Lamiae -13%
INSERT INTO `mob_family_mods` VALUES (4,389,-25,0);		-- Ahriman -25%
INSERT INTO `mob_family_mods` VALUES (169,389,-25,0);	-- Kindred  -25%
INSERT INTO `mob_family_mods` VALUES (89,389,-13,0);	-- Draugar  -13%
INSERT INTO `mob_family_mods` VALUES (52,389,-25,0);	-- Bhoot  -25%
INSERT INTO `mob_family_mods` VALUES (63,389,-13,0);	-- Chariot  -13%
INSERT INTO `mob_family_mods` VALUES (209,389,-43,0);	-- Rampart  -43%
INSERT INTO `mob_family_mods` VALUES (27,389,-25,0);	-- Apkallu  -25%
INSERT INTO `mob_family_mods` VALUES (191,389,-13,0);	-- Orobon  -13%
INSERT INTO `mob_family_mods` VALUES (551,389,-13,0);	-- "Blue" Sea Monk  -13%
INSERT INTO `mob_family_mods` VALUES (233,389,-25,0);	-- Soulflayer  -25%
INSERT INTO `mob_family_mods` VALUES (90,389,-50,0);	-- Dvergr  -50%
INSERT INTO `mob_family_mods` VALUES (316,389,-50,0);	-- Dvergr  -50%
INSERT INTO `mob_family_mods` VALUES (117,389,-13,0);	-- Gargouille  -13%
INSERT INTO `mob_family_mods` VALUES (118,389,-13,0);	-- Gargoyle  -13%
INSERT INTO `mob_family_mods` VALUES (6,389,-25,0);		-- Amphiptere  -25%
INSERT INTO `mob_family_mods` VALUES (195,389,-25,0);	-- Pixie  -25%
INSERT INTO `mob_family_mods` VALUES (62,389,-50,0);	-- Cerberus  -63%
INSERT INTO `mob_family_mods` VALUES (163,389,-63,0);	-- Hydra  -63%
INSERT INTO `mob_family_mods` VALUES (164,389,-63,0);	-- Hydra  -63%
INSERT INTO `mob_family_mods` VALUES (168,389,-63,0);	-- Khimaira  -63%
INSERT INTO `mob_family_mods` VALUES (252,389,-25,0); 	-- Vampyr(NM) -25%
INSERT INTO `mob_family_mods` VALUES (284,389,-38,0); 	-- Vampyr(NM) -38%
INSERT INTO `mob_family_mods` VALUES (460,389,35,0);	-- Waktza(Hurkan) +35%(Bonus)
INSERT INTO `mob_family_mods` VALUES (524,389,35,0);	-- Waktza +35%(Bonus)
INSERT INTO `mob_family_mods` VALUES (457,389,20,0);	-- Cehuetzi (Kumhau) +20%(Bonus)
INSERT INTO `mob_family_mods` VALUES (618,389,20,0);	-- Cehuetzi +20%(Bonus)
INSERT INTO `mob_family_mods` VALUES (461,389,35,0);	-- Gabbrath(Achuka) +35%(Bonus)
INSERT INTO `mob_family_mods` VALUES (626,389,35,0);	-- Gabbrath +35%(Bonus)
INSERT INTO `mob_family_mods` VALUES (456,389,-5,0);	-- Bztavian(Colkhab) -5%
INSERT INTO `mob_family_mods` VALUES (625,389,-5,0);	-- Bztavian -5%
INSERT INTO `mob_family_mods` VALUES (629,389,35,0);	-- Rockfin(Tchakka) +35%(Bonus)
INSERT INTO `mob_family_mods` VALUES (452,389,35,0);	-- Rockfin +35%(Bonus)
INSERT INTO `mob_family_mods` VALUES (465,389,-10,0);	-- Yggdreant(Yumcax) -10%
INSERT INTO `mob_family_mods` VALUES (628,389,-10,0);	-- Yggdreant -10%
INSERT INTO `mob_family_mods` VALUES (464,389,-25,0);	-- Snapweed -25%



-- MDB
INSERT INTO `mob_family_mods` VALUES (171,29,40,0); 	-- Lamiae +40 MDB
INSERT INTO `mob_family_mods` VALUES (182,29,40,0); 	-- Merrow +40 MDB
INSERT INTO `mob_family_mods` VALUES (175,29,12,0); 	-- Magic pot +12 MDB
INSERT INTO `mob_family_mods` VALUES (252,29,10,0); 	-- Vampyr +10 MDB
INSERT INTO `mob_family_mods` VALUES (284,29,20,0); 	-- Vampyr(NM) +20 MDB
INSERT INTO `mob_family_mods` VALUES (89,29,20,0);  	-- Draugar +20 MDB
INSERT INTO `mob_family_mods` VALUES (52,29,20,0);  	-- Bhoot +20 MDB
INSERT INTO `mob_family_mods` VALUES (233,29,20,0); 	-- Soulflayer +20 MDB
INSERT INTO `mob_family_mods` VALUES (90,29,40,0); 	    -- Dvergr +40 MDB
INSERT INTO `mob_family_mods` VALUES (316,29,40,0); 	-- Dvergr +40 MDB
INSERT INTO `mob_family_mods` VALUES (6,29,20,0); 	    -- Amphiptere +20 MDB
INSERT INTO `mob_family_mods` VALUES (195,29,16,0); 	-- Pixie +16 MDB
INSERT INTO `mob_family_mods` VALUES (39,29,40,0); 	    -- Dark Monoceros +40 MDB
INSERT INTO `mob_family_mods` VALUES (109,29,20,0); 	-- Euvhi +20 MDB
INSERT INTO `mob_family_mods` VALUES (122,29,20,0); 	-- Ghrah +20 MDB
INSERT INTO `mob_family_mods` VALUES (123,29,20,0); 	-- Ghrah +20 MDB
INSERT INTO `mob_family_mods` VALUES (124,29,20,0); 	-- Ghrah +20 MDB
INSERT INTO `mob_family_mods` VALUES (272,29,20,0); 	-- Zdei +20 MDB
INSERT INTO `mob_family_mods` VALUES (449,29,62,0); 	-- Bahamut +62 MDB
INSERT INTO `mob_family_mods` VALUES (163,29,29,0); 	-- Hydra +29 MDB
INSERT INTO `mob_family_mods` VALUES (164,29,29,0); 	-- Hydra +29 MDB
INSERT INTO `mob_family_mods` VALUES (16,29,250,0); 	-- Animated Weapon(Instrument) +250 MDB
INSERT INTO `mob_family_mods` VALUES (629,29,50,0); 	-- Rockfin(Tchakka) +50 MDB
INSERT INTO `mob_family_mods` VALUES (452,29,50,0); 	-- Rockfin +50 MDB

-- MEVA
INSERT INTO `mob_family_mods` VALUES (99,31,30,0); 	    -- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (100,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (101,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (102,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (103,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (104,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (105,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (106,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (155,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (156,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (157,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (158,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (159,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (160,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (161,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (162,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (934,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (935,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (936,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (937,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (938,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (939,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (940,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (941,31,30,0); 	-- Elemental +30 MEVA
INSERT INTO `mob_family_mods` VALUES (943,31,30,0);		-- WotG Yagudo +30 MEVA
INSERT INTO `mob_family_mods` VALUES (165,31,30,0); 	-- Imp +30 MEVA
INSERT INTO `mob_family_mods` VALUES (166,31,30,0); 	-- Imp +30 MEVA
INSERT INTO `mob_family_mods` VALUES (301,31,30,0); 	-- Imp(Verdelet) +30 MEVA
INSERT INTO `mob_family_mods` VALUES (456,31,25,0);		-- Bztavian(Colkhab) +25 MEVA
INSERT INTO `mob_family_mods` VALUES (625,31,25,0);		-- Bztavian +25 MEVA


-- Move Speed
INSERT INTO `mob_family_mods` VALUES (1,169,-15,0); 	-- Acrolith -15%

--Crit Reduction
INSERT INTO `mob_family_mods` VALUES (457,908,25,0);    -- Cehuetzi(Kumhau) -25% critical hit damage taken
INSERT INTO `mob_family_mods` VALUES (618,908,25,0);    -- Cehuetzi -25% critical hit damage taken

-- -GA Chance
INSERT INTO `mob_family_mods` VALUES (175,7,50,1);	-- Magic Pot 50% chance to -Ga

-- Dual Wield
INSERT INTO `mob_family_mods` VALUES (285,44,1,1); -- Gulool_Ja_Ja
INSERT INTO `mob_family_mods` VALUES (971,44,1,1); -- Aldo
INSERT INTO `mob_family_mods` VALUES (972,44,1,1); -- Maximilian

-- Immunities

-- Status resist trait

-- Absorb
INSERT INTO `mob_family_mods` VALUES (319,460,100,0);	-- Shiva - Ice
INSERT INTO `mob_family_mods` VALUES (320,463,100,0);	-- Ramuh - Thunder
INSERT INTO `mob_family_mods` VALUES (321,462,100,0);	-- Titan - Earth
INSERT INTO `mob_family_mods` VALUES (322,459,100,0);	-- Ifrit - Fire
INSERT INTO `mob_family_mods` VALUES (323,464,100,0);	-- Leviathan - Water	
INSERT INTO `mob_family_mods` VALUES (231,464,100,0);	-- Slug - Water	
INSERT INTO `mob_family_mods` VALUES (324,461,100,0);	-- Garuda - Wind
INSERT INTO `mob_family_mods` VALUES (198,461,100,0);	-- Puk - Wind
INSERT INTO `mob_family_mods` VALUES (34,465,100,0);	-- Carbuncle - Light

-- Parrying
INSERT INTO `mob_family_mods` VALUES (339,106,3,1);	-- Chapuli 
INSERT INTO `mob_family_mods` VALUES (585,106,3,1);	-- Chapuli-Jug

-- Magic Aggro range
INSERT INTO `mob_family_mods` VALUES (34,95,40,1);	-- Carbuncle 
INSERT INTO `mob_family_mods` VALUES (35,95,40,1);	-- Diabolos 
INSERT INTO `mob_family_mods` VALUES (319,95,40,1);	-- Shiva
INSERT INTO `mob_family_mods` VALUES (320,95,40,1);	-- Ramuh
INSERT INTO `mob_family_mods` VALUES (321,95,40,1);	-- Titan
INSERT INTO `mob_family_mods` VALUES (322,95,40,1);	-- Ifrit 
INSERT INTO `mob_family_mods` VALUES (323,95,40,1);	-- Leviathan	
INSERT INTO `mob_family_mods` VALUES (324,95,40,1);	-- Garuda 
INSERT INTO `mob_family_mods` VALUES (325,95,40,1);	-- Fenrir 
INSERT INTO `mob_family_mods` VALUES (378,95,40,1);	-- Diabolos 

-- Yovra
INSERT INTO `mob_family_mods` VALUES (271,68,50,0);		-- +50 Evasion Racial
INSERT INTO `mob_family_mods` VALUES (271,63,50,0);		-- +50% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (271,370,50,0);	-- +50/tick Regen
INSERT INTO `mob_family_mods` VALUES (271,28,35,1);		-- +35% Experience Bonus

-- Antlion
INSERT INTO `mob_family_mods` VALUES (26,62,10,0);		-- Antlion +10% Attack
INSERT INTO `mob_family_mods` VALUES (26,63,20,0);		-- Antlion +20% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (357,62,10,0);		-- Antlion +10% Attack
INSERT INTO `mob_family_mods` VALUES (357,63,20,0);		-- Antlion +20% Defense Bonus


-- Chigoe
INSERT INTO `mob_family_mods` VALUES (64,63,-20,0);		---20% Defense Penalty
INSERT INTO `mob_family_mods` VALUES (64,68,10,0);		-- +10 Evasion Bonus
INSERT INTO `mob_family_mods` VALUES (64,62,-50,0);		---50% Attack Penalty

-- Tauri
INSERT INTO `mob_family_mods` VALUES (240,63,-20,0);	-- -20% Defense penalty
INSERT INTO `mob_family_mods` VALUES (240,68,-10,0);	-- -10 Evasion penalty

-- Buffalo
INSERT INTO `mob_family_mods` VALUES (57,62,10,0);		-- +10% Attack
INSERT INTO `mob_family_mods` VALUES (57,63,20,0);		-- +20% Defense

-- Bugard
INSERT INTO `mob_family_mods` VALUES (58,62,10,0);		-- +10% Attack
INSERT INTO `mob_family_mods` VALUES (58,63,20,0);		-- +20% Defense

-- Behemoth
INSERT INTO `mob_family_mods` VALUES (479,62,35,0);		-- +35% Bonus Attack
INSERT INTO `mob_family_mods` VALUES (479,63,20,0);		-- +20% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (51,62,35,0);		-- +35% Bonus Attack
INSERT INTO `mob_family_mods` VALUES (51,63,20,0);		-- +20% Defense Bonus

-- Archaic Mirrors
INSERT INTO `mob_family_mods` VALUES (238,29,112,0);	    -- +112 MDB
INSERT INTO `mob_family_mods` VALUES (238,388,-50,0);    -- -50% BDT
INSERT INTO `mob_family_mods` VALUES (238,1,5000,0);     -- +5000 Defense Bonus

-- Promy Mobs
INSERT INTO `mob_family_mods` VALUES (255,63,-10,0);	-- Wanderer -10 Defense Penalty
INSERT INTO `mob_family_mods` VALUES (255,68,40,0);		-- Wanderer +40 Evasion Bonus
INSERT INTO `mob_family_mods` VALUES (78,63,10,0);		-- Craver +10% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (256,63,-10,0);	-- Weeper -10% Defense Penalty
INSERT INTO `mob_family_mods` VALUES (137,63,10,0);		-- Gorger +10% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (138,63,10,0);		-- Gorger +10% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (220,63,10,0);		-- Seether +10% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (241,63,10,0);		-- Thinker +10% Defense Bonus
INSERT INTO `mob_family_mods` VALUES (241,29,12,0); -- Thinker +12 MDB
INSERT INTO `mob_family_mods` VALUES (78,29,12,0); --  Craver +12 MDB
INSERT INTO `mob_family_mods` VALUES (137,29,12,0); -- Gorger +12 MDB
INSERT INTO `mob_family_mods` VALUES (138,29,12,0); -- Gorger +12 MDB
INSERT INTO `mob_family_mods` VALUES (255,29,12,0); -- Wanderer +12 MDB
INSERT INTO `mob_family_mods` VALUES (256,29,12,0); -- Weeper +12 MDB
INSERT INTO `mob_family_mods` VALUES (220,29,12,0); -- Seether +12 MDB
INSERT INTO `mob_family_mods` VALUES (181,389,-50,0); -- Memory Receptacle -50% MDT
INSERT INTO `mob_family_mods` VALUES (503,29,12,0); -- Mammet +12 MDB
INSERT INTO `mob_family_mods` VALUES (499,387,100,0); -- Stray +100% PDT(Bonus)
INSERT INTO `mob_family_mods` VALUES (499,388,100,0); -- Stray +100% BDT(Bonus)
INSERT INTO `mob_family_mods` VALUES (499,389,100,0); -- Stray +100% MDT(Bonus)

-- Jugs
INSERT INTO `mob_family_mods` VALUES (556,62,60,0);		-- Tiger Familiar +60% Attack
INSERT INTO `mob_family_mods` VALUES (556,63,-10,0);	-- Tiger Familiar -10% Defense
INSERT INTO `mob_family_mods` VALUES (571,62,40,0);		-- Pugil Familiar +40% Attack
INSERT INTO `mob_family_mods` VALUES (571,63,-10,0);	-- Pugil Familiar -10% Defense
INSERT INTO `mob_family_mods` VALUES (560,62,-10,0);    -- Crab Familiar -10% Attack
INSERT INTO `mob_family_mods` VALUES (560,63,10,0);     -- Crab Familiar +10% Def
INSERT INTO `mob_family_mods` VALUES (588,62,-10,0);    -- Courier Carrie -10% Attack
INSERT INTO `mob_family_mods` VALUES (588,63,20,0);     -- Courier Carrie +20% Def
INSERT INTO `mob_family_mods` VALUES (623,62,-10,0);    -- Porter Crab -10% Attack
INSERT INTO `mob_family_mods` VALUES (623,63,60,0);     -- Porter Crab +60% Def
INSERT INTO `mob_family_mods` VALUES (564,62,30,0);     -- Lizard Familiar +30% Attack
INSERT INTO `mob_family_mods` VALUES (564,63,-20,0);    -- Lizard Familiar -20% Def
INSERT INTO `mob_family_mods` VALUES (562,63,30,0);     -- Antlion Familiar +30% Def
INSERT INTO `mob_family_mods` VALUES (558,62,20,0);     -- Beetle Familiar +20% Attack
INSERT INTO `mob_family_mods` VALUES (565,62,30,0);     -- Diremite Familiar +30% Attack
INSERT INTO `mob_family_mods` VALUES (561,388,-35,0);   -- Funguar Familiar -35% BDT
INSERT INTO `mob_family_mods` VALUES (561,389,-35,0);   -- Funguar Familiar -35% MDT
INSERT INTO `mob_family_mods` VALUES (568,28,30,0);     -- Fly Familiar +30 MAB
INSERT INTO `mob_family_mods` VALUES (574,30,50,0);     -- Coeurl Familiar +50 MACC
INSERT INTO `mob_family_mods` VALUES (621,28,30,0);     -- Lynx Familiar +30 MAB
INSERT INTO `mob_family_mods` VALUES (559,30,50,0);     -- Flytrap Familiar +50 MACC
INSERT INTO `mob_family_mods` VALUES (559,29,50,0);     -- Flytrap Familiar +50 MDB
INSERT INTO `mob_family_mods` VALUES (559,63,25,0);     -- Flytrap Familiar +25% Def
INSERT INTO `mob_family_mods` VALUES (577,62,20,0);		-- Hippogryph Familiar +20% Attack
INSERT INTO `mob_family_mods` VALUES (581,62,30,0);		-- Slime Familiar +30% Attack
INSERT INTO `mob_family_mods` VALUES (581,49,500,0);    -- Slime Familiar -50% Slashing
INSERT INTO `mob_family_mods` VALUES (579,62,-20,0);    -- Slug Familiar -20% Attack
INSERT INTO `mob_family_mods` VALUES (579,63,30,0);     -- Slug Familiar +30% Def
INSERT INTO `mob_family_mods` VALUES (579,29,10,0);	    -- Slug Familiar +40 MDB
INSERT INTO `mob_family_mods` VALUES (579,30,50,0);     -- Slug Familiar +50 MACC
INSERT INTO `mob_family_mods` VALUES (579,51,500,0);    -- Slug Familiar -50% Impact
INSERT INTO `mob_family_mods` VALUES (579,52,500,0);    -- Slug Familiar -50% H2H
INSERT INTO `mob_family_mods` VALUES (579,49,700,0);    -- Slime Familiar -30% Slashing
INSERT INTO `mob_family_mods` VALUES (582,63,30,0);     -- Snapweed Familiar +30% Def
INSERT INTO `mob_family_mods` VALUES (582,389,-25,0);   -- Snapweed Familiar -25% MDT
INSERT INTO `mob_family_mods` VALUES (569,62,10,0);     -- Raaz Familiar +10% Attack
INSERT INTO `mob_family_mods` VALUES (569,63,-10,0);    -- Raaz Familiar -10% Def
INSERT INTO `mob_family_mods` VALUES (575,63,-10,0);    -- Ladybug Familiar -10% Def
INSERT INTO `mob_family_mods` VALUES (583,62,30,0);     -- Acuex Familiar +30% Attack
INSERT INTO `mob_family_mods` VALUES (583,51,250,0);    -- Acuex Familiar -75% Impact
INSERT INTO `mob_family_mods` VALUES (583,52,250,0);    -- Acuex Familiar -75% H2H
INSERT INTO `mob_family_mods` VALUES (583,49,875,0);    -- Acuex Familiar -12.5% Slashing
INSERT INTO `mob_family_mods` VALUES (583,50,875,0);    -- Acuex Familiar -12.5% Piercing
INSERT INTO `mob_family_mods` VALUES (583,1279,875,0);  -- Acuex Familiar -12.5% Ranged
INSERT INTO `mob_family_mods` VALUES (583,388,100,0);   -- Acuex Familiar +100% BDT
INSERT INTO `mob_family_mods` VALUES (583,389,50,0);    -- Acuex Familiar +50% MDT
INSERT INTO `mob_family_mods` VALUES (578,62,30,0);		-- Raptor Familiar +30% Attack
INSERT INTO `mob_family_mods` VALUES (578,63,-10,0);	-- Raptor Familiar -10% Defense
INSERT INTO `mob_family_mods` VALUES (584,62,-10,0);    -- Tulfaire Familiar -10% Attack
INSERT INTO `mob_family_mods` VALUES (584,30,50,0);     -- Tulfaire Familiar +50 MACC
INSERT INTO `mob_family_mods` VALUES (585,62,10,0);		-- Chapuli Familiar +10% Attack
INSERT INTO `mob_family_mods` VALUES (586,62,30,0);		-- Spider Familiar +30% Attack
INSERT INTO `mob_family_mods` VALUES (586,63,-10,0);	-- Spider Familiar -10% Defense
INSERT INTO `mob_family_mods` VALUES (619,62,-30,0);	-- Mosquito Familiar -30% Attack
INSERT INTO `mob_family_mods` VALUES (624,62,60,0);		-- Yellow Beetle +60% Attack
INSERT INTO `mob_family_mods` VALUES (624,63,-20,0);	-- Yellow Beetle -20% Defense

-- Dynamis Mobs
INSERT INTO `mob_family_mods` VALUES (337,62,25,0);	-- Quadav +25% Attk
INSERT INTO `mob_family_mods` VALUES (337,63,25,0);	-- Quadav +25% DEF
INSERT INTO `mob_family_mods` VALUES (337,29,10,0);	-- Quadav +10 MDB
INSERT INTO `mob_family_mods` VALUES (337,28,-100,1); -- Quadav -100% exp

INSERT INTO `mob_family_mods` VALUES (334,62,25,0);	-- Orc +25% Attk
INSERT INTO `mob_family_mods` VALUES (334,63,25,0);	-- Orc +25% DEF
INSERT INTO `mob_family_mods` VALUES (334,28,-100,1); -- Orc -100% exp

INSERT INTO `mob_family_mods` VALUES (360,62,25,0);	-- Yagudo +25% Attk
INSERT INTO `mob_family_mods` VALUES (360,63,25,0);	-- Yagudo +25% DEF
INSERT INTO `mob_family_mods` VALUES (360,29,30,0);	-- Yagudo +30 MDB
INSERT INTO `mob_family_mods` VALUES (360,28,-100,1); -- Yagudo -100% exp

INSERT INTO `mob_family_mods` VALUES (327,62,25,0);	-- Goblin +25% Attk
INSERT INTO `mob_family_mods` VALUES (327,63,25,0);	-- Goblin +25% DEF
INSERT INTO `mob_family_mods` VALUES (327,29,20,0);	-- Goblin +20 MDB
INSERT INTO `mob_family_mods` VALUES (327,28,-100,1); -- Goblin -100% exp

INSERT INTO `mob_family_mods` VALUES (509,62,25,0);	-- Hydra +25% Attk
INSERT INTO `mob_family_mods` VALUES (509,63,25,0);	-- Hydra +25% DEF
INSERT INTO `mob_family_mods` VALUES (509,29,50,0);	-- Hydra  +50 MDB
INSERT INTO `mob_family_mods` VALUES (509,28,-100,1); -- Hydra -100% exp

INSERT INTO `mob_family_mods` VALUES (358,62,25,0);	-- Kindred +25% Attk
INSERT INTO `mob_family_mods` VALUES (358,63,25,0);	-- Kindred +25% DEF
INSERT INTO `mob_family_mods` VALUES (358,389,-25,0); -- Kindred -25% MDT
INSERT INTO `mob_family_mods` VALUES (358,29,70,0);	 -- Kindred +70 MDB 
INSERT INTO `mob_family_mods` VALUES (358,28,-100,1); -- Kindred -100% exp

INSERT INTO `mob_family_mods` VALUES (511,62,25,0);	-- Ahriman +25% Attk
INSERT INTO `mob_family_mods` VALUES (511,63,25,0);	-- Ahriman +25% DEF
INSERT INTO `mob_family_mods` VALUES (511,389,-25,0); -- Ahriman -25% MDT
INSERT INTO `mob_family_mods` VALUES (511,29,70,0);	 -- Ahriman +50 MDB
INSERT INTO `mob_family_mods` VALUES (511,23,16,1);	 -- Silence Immunity
INSERT INTO `mob_family_mods` VALUES (511,28,-100,1); -- Ahriman -100% exp

INSERT INTO `mob_family_mods` VALUES (92,366,75,0); -- Statue-Goblin +75 WEP DMG
INSERT INTO `mob_family_mods` VALUES (92,29,112,0);	-- Statue-Goblin +112 MDB
INSERT INTO `mob_family_mods` VALUES (92,388,-50,0); -- Statue-Goblin -50% BDT
INSERT INTO `mob_family_mods` VALUES (92,73,100,0);	-- Statue-Goblin +100 Store TP
INSERT INTO `mob_family_mods` VALUES (92,1,5000,0);  -- Statue-Goblin +5000 Defense Bonus
INSERT INTO `mob_family_mods` VALUES (92,28,-100,1); -- Statue-Goblin -100% exp

INSERT INTO `mob_family_mods` VALUES (411,366,75,0); -- Statue-Goblin +75 WEP DMG
INSERT INTO `mob_family_mods` VALUES (411,29,112,0);	-- Statue-Goblin +112 MDB
INSERT INTO `mob_family_mods` VALUES (411,388,-50,0); -- Statue-Goblin -50% BDT
INSERT INTO `mob_family_mods` VALUES (411,73,100,0);	-- Statue-Goblin +100 Store TP
INSERT INTO `mob_family_mods` VALUES (411,1,5000,0);  -- Statue-Goblin +5000 Defense Bonus
INSERT INTO `mob_family_mods` VALUES (411,28,-100,1); -- Statue-Goblin -100% exp

INSERT INTO `mob_family_mods` VALUES (93,366,75,0); -- Statue-Orc +75 WEP DMG
INSERT INTO `mob_family_mods` VALUES (93,29,62,0);	-- Statue-Orc +62 MDB
INSERT INTO `mob_family_mods` VALUES (93,388,-50,0); -- Statue-Orc -50% BDT
INSERT INTO `mob_family_mods` VALUES (93,73,100,0);	-- Statue-Orc +100 Store TP
INSERT INTO `mob_family_mods` VALUES (93,1,5000,0);  -- Statue-Orc +5000 Defense Bonus
INSERT INTO `mob_family_mods` VALUES (93,28,-100,1); -- Statue-Orc -100% exp

INSERT INTO `mob_family_mods` VALUES (412,366,75,0); -- Statue-Orc +75 WEP DMG
INSERT INTO `mob_family_mods` VALUES (412,29,62,0);	-- Statue-Orc +62 MDB
INSERT INTO `mob_family_mods` VALUES (412,388,-50,0); -- Statue-Orc -50% BDT
INSERT INTO `mob_family_mods` VALUES (412,73,100,0);	-- Statue-Orc +100 Store TP
INSERT INTO `mob_family_mods` VALUES (412,1,5000,0);  -- Statue-Orc +5000 Defense Bonus
INSERT INTO `mob_family_mods` VALUES (412,28,-100,1); -- Statue-Orc -100% exp

INSERT INTO `mob_family_mods` VALUES (94,366,75,0); -- Statue-Quadav +75 WEP DMG
INSERT INTO `mob_family_mods` VALUES (94,29,112,0);	-- Statue-Quadav +112 MDB
INSERT INTO `mob_family_mods` VALUES (94,388,-50,0); -- Statue-Quadav -50% BDT
INSERT INTO `mob_family_mods` VALUES (94,73,100,0);	-- Statue-Quadav +100 Store TP
INSERT INTO `mob_family_mods` VALUES (94,1,5000,0);  -- Statue-Quadav +5000 Defense Bonus
INSERT INTO `mob_family_mods` VALUES (94,28,-100,1); -- Statue-Quadav -100% exp

INSERT INTO `mob_family_mods` VALUES (413,366,75,0); -- Statue-Quadav +75 WEP DMG
INSERT INTO `mob_family_mods` VALUES (413,29,112,0);	-- Statue-Quadav +112 MDB
INSERT INTO `mob_family_mods` VALUES (413,388,-50,0); -- Statue-Quadav -50% BDT
INSERT INTO `mob_family_mods` VALUES (413,73,100,0);	-- Statue-Quadav +100 Store TP
INSERT INTO `mob_family_mods` VALUES (413,1,5000,0);  -- Statue-Quadav +5000 Defense Bonus
INSERT INTO `mob_family_mods` VALUES (413,28,-100,1); -- Statue-Quadav -100% exp

INSERT INTO `mob_family_mods` VALUES (95,366,75,0); -- Statue-Yagudo +75 WEP DMG
INSERT INTO `mob_family_mods` VALUES (95,29,162,0);	-- Statue-Yagudo +162 MDB
INSERT INTO `mob_family_mods` VALUES (95,388,-50,0); -- Statue-Yagudo -50% BDT
INSERT INTO `mob_family_mods` VALUES (95,73,100,0);	-- Statue-Yagudo +100 Store TP
INSERT INTO `mob_family_mods` VALUES (95,1,5000,0);  -- Statue-Yagudo +5000 Defense Bonus
INSERT INTO `mob_family_mods` VALUES (95,28,-100,1); -- Statue-Yagudo -100% exp

INSERT INTO `mob_family_mods` VALUES (414,366,75,0); -- Statue-Yagudo +75 WEP DMG
INSERT INTO `mob_family_mods` VALUES (414,29,162,0);	-- Statue-Yagudo +162 MDB
INSERT INTO `mob_family_mods` VALUES (414,388,-50,0); -- Statue-Yagudo -50% BDT
INSERT INTO `mob_family_mods` VALUES (414,73,100,0);	-- Statue-Yagudo +100 Store TP
INSERT INTO `mob_family_mods` VALUES (414,1,5000,0);  -- Statue-Yagudo +5000 Defense Bonus
INSERT INTO `mob_family_mods` VALUES (414,28,-100,1); -- Statue-Yagudo -100% exp

INSERT INTO `mob_family_mods` VALUES (510,62,25,0);	-- Kindreds Wyvern +25% Attk
INSERT INTO `mob_family_mods` VALUES (510,63,25,0);	-- Kindreds Wyvern +25% DEF
INSERT INTO `mob_family_mods` VALUES (510,29,20,0);	-- Kindreds Wyvern +20 MDB 
INSERT INTO `mob_family_mods` VALUES (510,28,-100,1); -- Kindreds Wyvern -100% exp

-- Misc
INSERT INTO `mob_family_mods` VALUES(195, 107, 1, 1); -- Pixie (Friendly cures and raises)

-- Roaming mods
SET @roam_distance = 31, @roam_cool = 36, @roam_turns = 51, @roam_rate = 52;

-- Yovra
INSERT INTO `mob_family_mods` VALUES (271,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (271,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (271,@roam_cool,35,1);
INSERT INTO `mob_family_mods` VALUES (271,@roam_rate,30,1);

-- Bugbear
INSERT INTO `mob_family_mods` VALUES (59,@roam_distance,0,1);
INSERT INTO `mob_family_mods` VALUES (59,@roam_turns,0,1);
INSERT INTO `mob_family_mods` VALUES (59,@roam_rate,0,1);

-- Moblin
INSERT INTO `mob_family_mods` VALUES (184,@roam_distance,5,1);

-- Leech
INSERT INTO `mob_family_mods` VALUES (172,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (369,@roam_distance,15,1);

-- Rabbit
INSERT INTO `mob_family_mods` VALUES (206,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (206,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (206,@roam_cool,35,1);
INSERT INTO `mob_family_mods` VALUES (206,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (404,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (404,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (404,@roam_cool,35,1);
INSERT INTO `mob_family_mods` VALUES (404,@roam_rate,30,1);

-- Sheep
INSERT INTO `mob_family_mods` VALUES (226,@roam_turns,5,1);
INSERT INTO `mob_family_mods` VALUES (226,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (226,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (226,@roam_rate,30,1);

-- Tiger
INSERT INTO `mob_family_mods` VALUES (242,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (242,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (242,@roam_cool,45,1);

-- Lizards
INSERT INTO `mob_family_mods` VALUES (97,@roam_turns,4,1);
INSERT INTO `mob_family_mods` VALUES (97,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (97,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (174,@roam_turns,4,1);
INSERT INTO `mob_family_mods` VALUES (174,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (174,@roam_rate,30,1);

-- Bee
INSERT INTO `mob_family_mods` VALUES (48,@roam_cool,15,1);
INSERT INTO `mob_family_mods` VALUES (48,@roam_turns,2,1);

-- Beetle
INSERT INTO `mob_family_mods` VALUES (49,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (49,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (49,@roam_rate,30,1);

-- Funguar
INSERT INTO `mob_family_mods` VALUES (116,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (116,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (116,@roam_rate,30,1);

-- Sapling
INSERT INTO `mob_family_mods` VALUES (216,@roam_distance,20,1);

-- Treant
INSERT INTO `mob_family_mods` VALUES (245,@roam_cool,65,1);
INSERT INTO `mob_family_mods` VALUES (245,@roam_rate,30,1);

-- Crab
INSERT INTO `mob_family_mods` VALUES (372,@roam_cool,15,1);
INSERT INTO `mob_family_mods` VALUES (75,@roam_cool,15,1);
INSERT INTO `mob_family_mods` VALUES (76,@roam_cool,15,1);
INSERT INTO `mob_family_mods` VALUES (77,@roam_cool,15,1);

-- Bat Trio
INSERT INTO `mob_family_mods` VALUES (47,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (47,@roam_cool,35,1);
INSERT INTO `mob_family_mods` VALUES (47,@roam_rate,30,1);

-- Giant Bat
INSERT INTO `mob_family_mods` VALUES (46,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (46,@roam_cool,35,1);
INSERT INTO `mob_family_mods` VALUES (46,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (71,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (71,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (71,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (188,@roam_cool,35,1);
INSERT INTO `mob_family_mods` VALUES (188,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (188,@roam_rate,20,1);

INSERT INTO `mob_family_mods` VALUES (139,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (139,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (258,@roam_cool,90,1);
INSERT INTO `mob_family_mods` VALUES (258,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (227,@roam_cool,65,1);
INSERT INTO `mob_family_mods` VALUES (227,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (227,@roam_turns,5,1);

INSERT INTO `mob_family_mods` VALUES (110,@roam_cool,45,1);
INSERT INTO `mob_family_mods` VALUES (110,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (110,@roam_rate,30,1);

-- Elementals
INSERT INTO `mob_family_mods` VALUES (99,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (100,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (101,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (102,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (103,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (104,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (105,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (106,@roam_turns,3,1);

INSERT INTO `mob_family_mods` VALUES (155,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (156,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (157,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (158,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (159,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (160,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (161,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (162,@roam_turns,3,1);

-- Gigas
INSERT INTO `mob_family_mods` VALUES (328,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (328,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (328,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (328,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (126,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (126,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (126,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (126,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (127,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (127,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (127,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (127,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (128,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (128,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (128,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (128,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (129,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (129,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (129,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (129,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (130,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (130,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (130,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (130,@roam_rate,30,1);

-- Tonberry
INSERT INTO `mob_family_mods` VALUES (243,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (243,@roam_turns,5,1);
INSERT INTO `mob_family_mods` VALUES (243,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (244,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (244,@roam_turns,5,1);
INSERT INTO `mob_family_mods` VALUES (244,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (217,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (217,@roam_rate,30,1);

-- Behe
INSERT INTO `mob_family_mods` VALUES (479,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (51,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (57,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (57,@roam_turns,4,1);
INSERT INTO `mob_family_mods` VALUES (57,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (62,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (80,@roam_cool,30,1);
INSERT INTO `mob_family_mods` VALUES (80,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (80,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (180,@roam_cool,30,1);
INSERT INTO `mob_family_mods` VALUES (180,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (180,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (208,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (208,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (2,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (2,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (58,@roam_cool,45,1);
INSERT INTO `mob_family_mods` VALUES (58,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (58,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (98,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (98,@roam_turns,5,1);
INSERT INTO `mob_family_mods` VALUES (98,@roam_rate,30,1);

-- Raptors
INSERT INTO `mob_family_mods` VALUES (210,@roam_cool,40,1);
INSERT INTO `mob_family_mods` VALUES (210,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (210,@roam_distance,30,1);

INSERT INTO `mob_family_mods` VALUES (376,@roam_cool,40,1);
INSERT INTO `mob_family_mods` VALUES (376,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (376,@roam_distance,30,1);

INSERT INTO `mob_family_mods` VALUES (377,@roam_cool,40,1);
INSERT INTO `mob_family_mods` VALUES (377,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (377,@roam_distance,30,1);

INSERT INTO `mob_family_mods` VALUES (257,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (257,@roam_rate,30,1);

-- Manticore
INSERT INTO `mob_family_mods` VALUES (179,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (179,@roam_turns,4,1);
INSERT INTO `mob_family_mods` VALUES (179,@roam_distance,30,1);
INSERT INTO `mob_family_mods` VALUES (179,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (26,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (26,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (26,@roam_rate,30,1);

-- Crawler
INSERT INTO `mob_family_mods` VALUES (79,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (79,@roam_rate,30,1);

-- Diremite
INSERT INTO `mob_family_mods` VALUES (81,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (81,@roam_turns,2,1);

INSERT INTO `mob_family_mods` VALUES (136,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (136,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (136,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (186,@roam_cool,30,1);
INSERT INTO `mob_family_mods` VALUES (186,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (212,@roam_cool,10,1);
INSERT INTO `mob_family_mods` VALUES (212,@roam_rate,20,1);

INSERT INTO `mob_family_mods` VALUES (218,@roam_cool,30,1);
INSERT INTO `mob_family_mods` VALUES (219,@roam_cool,30,1);

INSERT INTO `mob_family_mods` VALUES (251,@roam_cool,40,1);
INSERT INTO `mob_family_mods` VALUES (251,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (112,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (112,@roam_turns,2,1);

INSERT INTO `mob_family_mods` VALUES (70,@roam_cool,30,1);
INSERT INTO `mob_family_mods` VALUES (70,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (70,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (72,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (72,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (140,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (140,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (141,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (141,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (125,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (125,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (125,@roam_cool,40,1);

INSERT INTO `mob_family_mods` VALUES (74,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (74,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (74,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (86,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (86,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (115,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (115,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (115,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (359,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (359,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (359,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (121,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (121,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (142,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (142,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (142,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (143,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (143,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (143,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (203,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (203,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (203,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (204,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (204,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (204,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (205,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (205,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (205,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (221,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (221,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (221,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (222,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (222,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (222,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (223,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (223,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (223,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (252,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (252,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (252,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (56,@roam_rate,20,1);
INSERT INTO `mob_family_mods` VALUES (56,@roam_turns,5,1);
INSERT INTO `mob_family_mods` VALUES (56,@roam_cool,30,1);

INSERT INTO `mob_family_mods` VALUES (61,@roam_rate,20,1);
INSERT INTO `mob_family_mods` VALUES (61,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (61,@roam_cool,40,1);

INSERT INTO `mob_family_mods` VALUES (68,@roam_rate,20,1);
INSERT INTO `mob_family_mods` VALUES (68,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (68,@roam_cool,40,1);

INSERT INTO `mob_family_mods` VALUES (69,@roam_rate,20,1);
INSERT INTO `mob_family_mods` VALUES (69,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (69,@roam_cool,40,1);

INSERT INTO `mob_family_mods` VALUES (83,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (83,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (83,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (84,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (84,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (84,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (85,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (85,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (85,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (367,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (367,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (367,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (368,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (368,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (368,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (135,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (135,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (135,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (175,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (175,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (175,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (232,@roam_rate,20,1);
INSERT INTO `mob_family_mods` VALUES (232,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (232,@roam_cool,40,1);

-- Dragons
INSERT INTO `mob_family_mods` VALUES (163,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (163,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (164,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (164,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (259,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (260,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (261,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (262,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (263,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (264,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (265,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (266,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (267,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (268,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (391,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (391,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (392,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (392,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (393,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (393,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (87,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (4,@roam_turns,5,1);
INSERT INTO `mob_family_mods` VALUES (4,@roam_cool,40,1);

INSERT INTO `mob_family_mods` VALUES (169,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (169,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (169,@roam_distance,15,1);

INSERT INTO `mob_family_mods` VALUES (358,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (358,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (358,@roam_distance,15,1);

INSERT INTO `mob_family_mods` VALUES (165,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (165,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (166,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (166,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (233,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (233,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (240,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (240,@roam_cool,40,1);
INSERT INTO `mob_family_mods` VALUES (240,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (190,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (190,@roam_rate,30,1);

-- Sandworm
INSERT INTO `mob_family_mods` VALUES (215,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (215,@roam_distance,50,1);
INSERT INTO `mob_family_mods` VALUES (215,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (215,@roam_rate,30,1);


INSERT INTO `mob_family_mods` VALUES (126,54,180,1);
INSERT INTO `mob_family_mods` VALUES (127,54,180,1);
INSERT INTO `mob_family_mods` VALUES (128,54,180,1);
INSERT INTO `mob_family_mods` VALUES (129,54,180,1);
INSERT INTO `mob_family_mods` VALUES (130,54,180,1);
INSERT INTO `mob_family_mods` VALUES (328,54,180,1);

INSERT INTO `mob_family_mods` VALUES (169,54,120,1);
INSERT INTO `mob_family_mods` VALUES (358,54,120,1);

INSERT INTO `mob_family_mods` VALUES (115,54,100,1);
INSERT INTO `mob_family_mods` VALUES (359,54,100,1);
INSERT INTO `mob_family_mods` VALUES (115,85,1,1); -- Fomor Hate

-- All animated weapons have MP
INSERT INTO `mob_family_mods` VALUES (7,3,50,1);
INSERT INTO `mob_family_mods` VALUES (8,3,50,1);
INSERT INTO `mob_family_mods` VALUES (9,3,50,1);
INSERT INTO `mob_family_mods` VALUES (11,3,50,1);
INSERT INTO `mob_family_mods` VALUES (12,3,50,1);
INSERT INTO `mob_family_mods` VALUES (13,3,50,1);
INSERT INTO `mob_family_mods` VALUES (14,3,50,1);
INSERT INTO `mob_family_mods` VALUES (15,3,50,1);
INSERT INTO `mob_family_mods` VALUES (16,3,50,1);
INSERT INTO `mob_family_mods` VALUES (17,3,50,1);
INSERT INTO `mob_family_mods` VALUES (18,3,50,1);
INSERT INTO `mob_family_mods` VALUES (19,3,50,1);
INSERT INTO `mob_family_mods` VALUES (20,3,50,1);
INSERT INTO `mob_family_mods` VALUES (21,3,50,1);
INSERT INTO `mob_family_mods` VALUES (23,3,50,1);
INSERT INTO `mob_family_mods` VALUES (24,3,50,1);

-- Never standback
INSERT INTO `mob_family_mods` VALUES (196,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (203,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (204,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (205,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (112,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (165,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (166,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (549,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (32,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (33,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (34,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (35,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (36,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (37,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (38,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (39,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (40,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (41,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (42,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (43,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (44,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (45,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (52,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (495,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (92,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (93,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (94,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (95,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (121,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (122,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (123,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (124,56,-1,1);
-- elementals don't standback
INSERT INTO `mob_family_mods` VALUES (99,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (100,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (101,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (102,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (103,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (104,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (105,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (106,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (4,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (139,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (511,56,-1,1);

-- Weapon bonus damage
INSERT INTO `mob_family_mods` VALUES (57,59,15,1);  -- Buffalo
INSERT INTO `mob_family_mods` VALUES (58,59,10,1);  -- Bugard
INSERT INTO `mob_family_mods` VALUES (80,59,10,1);  -- Dhalmel
INSERT INTO `mob_family_mods` VALUES (266,59,15,1); -- Wyvern
INSERT INTO `mob_family_mods` VALUES (87,59,20,1);  -- Dragon
INSERT INTO `mob_family_mods` VALUES (136,59,15,1); -- Goobbue
INSERT INTO `mob_family_mods` VALUES (179,59,20,1); -- Manticore +20 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (217,59,15,1); -- Scorpion
INSERT INTO `mob_family_mods` VALUES (208,59,15,1); -- Ram
INSERT INTO `mob_family_mods` VALUES (210,59,10,1); -- Raptor
INSERT INTO `mob_family_mods` VALUES (242,59,10,1); -- Tiger
INSERT INTO `mob_family_mods` VALUES (257,59,15,1); -- Wivre +15 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (180,59,20,1); -- Marid +20 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (371,59,20,1); -- Marid (NM? Family #2)
INSERT INTO `mob_family_mods` VALUES (203,59,13,1); -- Qutrub +13 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (204,59,13,1); -- Qutrub +13 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (205,59,13,1); -- Qutrub +13 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (252,59,30,1); -- Vampyr +30 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (284,59,30,1); -- Vampyr +30 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (171,59,10,1); -- Lamia +10 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (182,59,10,1); -- Merrow +10 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (176,59,20,1); -- Mamool Ja +20 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (177,59,20,1); -- Mamool Ja +20 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (591,59,10,1); -- Mamool Ja (Sword) +10 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (128,59,20,1); -- WoTG Gigas +20 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (942,59,15,1); -- WoTG Quadav +15 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (943,59,10,1); -- WoTG Yagudo +10 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (944,59,20,1); -- WoTG Orc +20 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (945,59,20,1); -- WoTG Orc War Machine +20 Weapon dmg
INSERT INTO `mob_family_mods` VALUES (946,59,15,1); -- WoTG Goblin +15 Weapon dmg

/*!40000 ALTER TABLE `mob_family_mods` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-10-09 17:42:22
