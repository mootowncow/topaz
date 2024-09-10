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
-- Table structure for table `mob_pool_mods`
--

DROP TABLE IF EXISTS `mob_pool_mods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mob_pool_mods` (
  `poolid` smallint(5) unsigned NOT NULL,
  `modid` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT '0',
  `is_mob_mod` boolean NOT NULL DEFAULT '0',
  PRIMARY KEY (`poolid`,`modid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=13 PACK_KEYS=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mob_pool_mods`
--

LOCK TABLES `mob_pool_mods` WRITE;
/*!40000 ALTER TABLE `mob_pool_mods` DISABLE KEYS */;

-- Dual Wield
INSERT INTO `mob_pool_mods` VALUES (237,44,1,1); -- Ark Angel HM 
INSERT INTO `mob_pool_mods` VALUES (3598,44,1,1); -- Shikaree X
INSERT INTO `mob_pool_mods` VALUES (9007,44,1,1); -- Nagi(Custom)
INSERT INTO `mob_pool_mods` VALUES (1386,44,1,1); -- Fomor Ninja
INSERT INTO `mob_pool_mods` VALUES (5857,44,1,1); -- Hoar-knuckled Rimberry


INSERT INTO `mob_pool_mods` VALUES (60,370,20,0);
INSERT INTO `mob_pool_mods` VALUES (70,48,434,1);
INSERT INTO `mob_pool_mods` VALUES (154,163,-70,0);
INSERT INTO `mob_pool_mods` VALUES (236,30,732,1);
INSERT INTO `mob_pool_mods` VALUES (236,33,60,1);
INSERT INTO `mob_pool_mods` VALUES (242,40,30,1);
INSERT INTO `mob_pool_mods` VALUES (242,41,936,1);
INSERT INTO `mob_pool_mods` VALUES (242,42,962,1);
INSERT INTO `mob_pool_mods` VALUES (242,43,1,1);
INSERT INTO `mob_pool_mods` VALUES (242,47,22,1);
--INSERT INTO `mob_pool_mods` VALUES (268,368,150,0);
INSERT INTO `mob_pool_mods` VALUES (268,370,50,0);
INSERT INTO `mob_pool_mods` VALUES (276,12,1,1);
INSERT INTO `mob_pool_mods` VALUES (289,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (370,28,5,1);
INSERT INTO `mob_pool_mods` VALUES (444,23,23,1); -- Bladmall immune to Sleep, Bind, Silence and Gravity.
INSERT INTO `mob_pool_mods` VALUES (519,160,-50,0);
INSERT INTO `mob_pool_mods` VALUES (532,160,-50,0);
INSERT INTO `mob_pool_mods` VALUES (592,68,15,0);
INSERT INTO `mob_pool_mods` VALUES (592,302,45,0);
INSERT INTO `mob_pool_mods` VALUES (592,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (639,63,25,0);
INSERT INTO `mob_pool_mods` VALUES (676,160,-50,0);
--INSERT INTO `mob_pool_mods` VALUES (680,1,322,0); -- (Cerberus) 650 defense total
--INSERT INTO `mob_pool_mods` VALUES (680,31,200,0); -- (Cerberus) 120 magic evasion boost recommended but 200 felt more retail
--INSERT INTO `mob_pool_mods` VALUES (680,251,-50,0); -- (Cerberus) he shouldn't be so resistant to stun, tho this is a systemic stun problem, this is a hack
--INSERT INTO `mob_pool_mods` VALUES (681,368,10,0);
INSERT INTO `mob_pool_mods` VALUES (733,302,5,0);
INSERT INTO `mob_pool_mods` VALUES (768,28,5,1);
INSERT INTO `mob_pool_mods` VALUES (770,4,4,1);
--INSERT INTO `mob_pool_mods` VALUES (820,368,10,0);
INSERT INTO `mob_pool_mods` VALUES (906,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (912,12,25,1);
INSERT INTO `mob_pool_mods` VALUES (930,370,15,0);
INSERT INTO `mob_pool_mods` VALUES (955,28,-100,1); -- Defender EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (958,28,5,1);
INSERT INTO `mob_pool_mods` VALUES (978,28,23,1);
INSERT INTO `mob_pool_mods` VALUES (979,8,60,1);
INSERT INTO `mob_pool_mods` VALUES (979,9,60,1);
INSERT INTO `mob_pool_mods` VALUES (1013,28,-100,1); -- Detector EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (1027,12,1,1);
INSERT INTO `mob_pool_mods` VALUES (1178,163,-100,0);
INSERT INTO `mob_pool_mods` VALUES (1234,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (1270,39,-1,1);
--INSERT INTO `mob_pool_mods` VALUES (1280,368,70,0);
INSERT INTO `mob_pool_mods` VALUES (1306,4,30,1);
INSERT INTO `mob_pool_mods` VALUES (1429,28,10,1);
--INSERT INTO `mob_pool_mods` VALUES (1456,368,20,0);
INSERT INTO `mob_pool_mods` VALUES (1461,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (1491,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (1648,224,5,0);
INSERT INTO `mob_pool_mods` VALUES (1648,17,1,1);
INSERT INTO `mob_pool_mods` VALUES (1663,29,3,1);
INSERT INTO `mob_pool_mods` VALUES (1719,29,2,1);
INSERT INTO `mob_pool_mods` VALUES (1750,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (1754,4,4,1);
--INSERT INTO `mob_pool_mods` VALUES (1792,368,70,0);
INSERT INTO `mob_pool_mods` VALUES (1806,28,10,1);
INSERT INTO `mob_pool_mods` VALUES (1841,28,10,1);
INSERT INTO `mob_pool_mods` VALUES (2032,244,15,0);
INSERT INTO `mob_pool_mods` VALUES (2032,34,20,1);
INSERT INTO `mob_pool_mods` VALUES (2032,35,0,1);
INSERT INTO `mob_pool_mods` VALUES (2047,163,-100,0);
INSERT INTO `mob_pool_mods` VALUES (2083,29,25,0);
INSERT INTO `mob_pool_mods` VALUES (2105,48,434,1);
INSERT INTO `mob_pool_mods` VALUES (2156,370,25,0);
INSERT INTO `mob_pool_mods` VALUES (2180,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (2254,407,100,0);
--INSERT INTO `mob_pool_mods` VALUES (2255,368,70,0);
INSERT INTO `mob_pool_mods` VALUES (2255,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (2255,34,60,1);
INSERT INTO `mob_pool_mods` VALUES (2262,370,125,0);
--INSERT INTO `mob_pool_mods` VALUES (2265,368,150,0);
INSERT INTO `mob_pool_mods` VALUES (2265,370,50,0);
INSERT INTO `mob_pool_mods` VALUES (2271,64,15,0);
INSERT INTO `mob_pool_mods` VALUES (2271,65,15,0);
INSERT INTO `mob_pool_mods` VALUES (2271,165,15,0);
INSERT INTO `mob_pool_mods` VALUES (2314,28,23,1);
INSERT INTO `mob_pool_mods` VALUES (2420,302,10,0);
INSERT INTO `mob_pool_mods` VALUES (2461,61,25,1);
INSERT INTO `mob_pool_mods` VALUES (2462,61,25,1);
INSERT INTO `mob_pool_mods` VALUES (2463,61,20,1);
INSERT INTO `mob_pool_mods` VALUES (2643,160,-50,0);
INSERT INTO `mob_pool_mods` VALUES (2647,160,-50,0);
INSERT INTO `mob_pool_mods` VALUES (2664,12,1,1);
INSERT INTO `mob_pool_mods` VALUES (2675,4,25,1);
INSERT INTO `mob_pool_mods` VALUES (2677,288,55,0);
INSERT INTO `mob_pool_mods` VALUES (2742,37,1,1);
INSERT INTO `mob_pool_mods` VALUES (2745,28,23,1);
INSERT INTO `mob_pool_mods` VALUES (2748,370,5,0);
INSERT INTO `mob_pool_mods` VALUES (2790,168,50,0);
INSERT INTO `mob_pool_mods` VALUES (2790,240,7,0);
INSERT INTO `mob_pool_mods` VALUES (2790,244,7,0);
INSERT INTO `mob_pool_mods` VALUES (2793,4,4,1);
--INSERT INTO `mob_pool_mods` VALUES (2840,368,70,0);
INSERT INTO `mob_pool_mods` VALUES (2840,370,50,0);
INSERT INTO `mob_pool_mods` VALUES (2922,370,100,0);
INSERT INTO `mob_pool_mods` VALUES (2973,370,1,0);
INSERT INTO `mob_pool_mods` VALUES (3051,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (3099,23,23,1); -- Parata immune to Sleep, Bind, Silence and Gravity.
INSERT INTO `mob_pool_mods` VALUES (3124,48,434,1);
INSERT INTO `mob_pool_mods` VALUES (3129,370,50,0);
INSERT INTO `mob_pool_mods` VALUES (3245,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3252,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3257,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3262,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3264,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3265,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3268,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3379,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (3540,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (3549,370,50,0);
INSERT INTO `mob_pool_mods` VALUES (3667,28,-100,1);
INSERT INTO `mob_pool_mods` VALUES (3759,163,-100,0);
INSERT INTO `mob_pool_mods` VALUES (3781,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (3784,2,-1,1); -- Stray GIL_MAX: don't drop gil
INSERT INTO `mob_pool_mods` VALUES (3784,28,-100,1); -- Stray EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (3796,21,97,1);
INSERT INTO `mob_pool_mods` VALUES (3816,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (3824,29,2,1);
INSERT INTO `mob_pool_mods` VALUES (3853,28,23,1);
INSERT INTO `mob_pool_mods` VALUES (3916,29,50,0);
INSERT INTO `mob_pool_mods` VALUES (3916,164,-50,0);
INSERT INTO `mob_pool_mods` VALUES (3916,370,25,0);
INSERT INTO `mob_pool_mods` VALUES (3941,163,-100,0);
INSERT INTO `mob_pool_mods` VALUES (4046,23,6191,1);
INSERT INTO `mob_pool_mods` VALUES (4082,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (4083,370,1,0);
INSERT INTO `mob_pool_mods` VALUES (4186,244,15,0);
INSERT INTO `mob_pool_mods` VALUES (4186,34,20,1);
INSERT INTO `mob_pool_mods` VALUES (4186,35,0,1);
INSERT INTO `mob_pool_mods` VALUES (4187,244,15,0);
INSERT INTO `mob_pool_mods` VALUES (4187,34,20,1);
INSERT INTO `mob_pool_mods` VALUES (4187,35,0,1);
INSERT INTO `mob_pool_mods` VALUES (4188,244,15,0);
INSERT INTO `mob_pool_mods` VALUES (4188,34,20,1);
INSERT INTO `mob_pool_mods` VALUES (4188,35,0,1);
INSERT INTO `mob_pool_mods` VALUES (4189,244,15,0);
INSERT INTO `mob_pool_mods` VALUES (4189,34,20,1);
INSERT INTO `mob_pool_mods` VALUES (4189,35,0,1);
INSERT INTO `mob_pool_mods` VALUES (4204,28,10,1); -- (Variable Hare) 10% XP bonus
INSERT INTO `mob_pool_mods` VALUES (3168,28,10,1); -- (Polar Hare) 10% XP bonus
INSERT INTO `mob_pool_mods` VALUES (4222,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (4261,29,50,0);
INSERT INTO `mob_pool_mods` VALUES (4261,370,25,0);
INSERT INTO `mob_pool_mods` VALUES (4361,288,55,0);
INSERT INTO `mob_pool_mods` VALUES (4361,5,16,1);
INSERT INTO `mob_pool_mods` VALUES (4504,4,30,1);
INSERT INTO `mob_pool_mods` VALUES (4670,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (4671,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (4672,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (4673,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (4438,31,5,1); -- Yagudo Parasite roam distance
INSERT INTO `mob_pool_mods` VALUES (4836,62,1,1); -- Maat (BLM) NO_STANDBACK
INSERT INTO `mob_pool_mods` VALUES (4837,62,1,1); -- Maat (RNG) NO_STANDBACK
INSERT INTO `mob_pool_mods` VALUES (4932,30,1017,1); -- Maat (BST) SPECIAL_SKILL: call_beast
INSERT INTO `mob_pool_mods` VALUES (4932,33,50,1); -- Maat (BST) SPECIAL_COOLDOWN: 50 sec
INSERT INTO `mob_pool_mods` VALUES (5403,62,1,1); -- Maat (NIN) NO_STANDBACK
INSERT INTO `mob_pool_mods` VALUES (5408,30,1036,1); -- Maat (PLD) SPECIAL_SKILL: maats_bash
INSERT INTO `mob_pool_mods` VALUES (5408,33,50,1); -- Maat (PLD) SPECIAL_COOLDOWN: 50 sec
INSERT INTO `mob_pool_mods` VALUES (5408,58,40,1); -- Maat (PLD) SPECIAL_DELAY: 40 sec
INSERT INTO `mob_pool_mods` VALUES (5409,30,1036,1); -- Maat (DRK) SPECIAL_SKILL: maats_bash
INSERT INTO `mob_pool_mods` VALUES (5409,33,50,1); -- Maat (DRK) SPECIAL_COOLDOWN: 50 sec
INSERT INTO `mob_pool_mods` VALUES (5409,58,40,1); -- Maat (DRK) SPECIAL_DELAY: 40 sec

--Family Link
INSERT INTO `mob_pool_mods` VALUES(595, 74, 212, 1); -- Cactrot Rapido will link with all Sabotenders in the zone
INSERT INTO `mob_pool_mods` VALUES(2978, 74, 269, 1); -- Baby Xzomit link to Moms
INSERT INTO `mob_pool_mods` VALUES(4088, 74, 269, 1); -- Baby Xzomit link to Moms

INSERT INTO `mob_pool_mods` VALUES(4285, 74, 245, 1); -- Sapplings link with treants
INSERT INTO `mob_pool_mods` VALUES(3991, 74, 245, 1); -- Sapplings link with treants
INSERT INTO `mob_pool_mods` VALUES(5340, 74, 245, 1); -- Sapplings link with treants
INSERT INTO `mob_pool_mods` VALUES(2392, 74, 245, 1); -- Sapplings link with treants

INSERT INTO `mob_pool_mods` VALUES(2961, 74, 216, 1); -- Treants link with sapplings
INSERT INTO `mob_pool_mods` VALUES(768, 74, 216, 1); -- Treants link with sapplings
INSERT INTO `mob_pool_mods` VALUES(1208, 74, 216, 1); -- Treants link with sapplings
INSERT INTO `mob_pool_mods` VALUES(2275, 74, 216, 1); -- Treants link with sapplings
INSERT INTO `mob_pool_mods` VALUES(3990, 74, 216, 1); -- Treants link with sapplings

INSERT INTO `mob_pool_mods` VALUES(1115, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(2164, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(1767, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(3801, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(1278, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(6631, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(6617, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(6619, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(6628, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(3679, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(5325, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(996, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(396, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(983, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(987, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(1172, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(51, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(990, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(2078, 74, 240, 1); -- Demons link with Tauri
INSERT INTO `mob_pool_mods` VALUES(6742, 74, 240, 1); -- Demons link with Tauri

INSERT INTO `mob_pool_mods` VALUES(4068, 74, 169, 1); -- Tauri link with demons
INSERT INTO `mob_pool_mods` VALUES(2721, 74, 169, 1); -- Tauri link with demons
INSERT INTO `mob_pool_mods` VALUES(5861, 74, 169, 1); -- Tauri link with demons
INSERT INTO `mob_pool_mods` VALUES(1770, 74, 169, 1); -- Tauri link with demons
INSERT INTO `mob_pool_mods` VALUES(3845, 74, 169, 1); -- Tauri link with demons
INSERT INTO `mob_pool_mods` VALUES(5556, 74, 169, 1); -- Tauri link with demons
INSERT INTO `mob_pool_mods` VALUES(3978, 74, 169, 1); -- Tauri link with demons





INSERT INTO `mob_pool_mods` VALUES (2031,28,-100,1); -- Hydras_Avatar EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (2032,28,-100,1); -- Hydras_Hound EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (2033,28,-100,1); -- Hydras_Wyvern EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (2246,28,-100,1); -- Kindreds_Vouivre EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (4185,28,-100,1); -- Vanguards_Avatar EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (4186,28,-100,1); -- Vanguards_Crow EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (4187,28,-100,1); -- Vanguards_Hecteyes EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (4188,28,-100,1); -- Vanguards_Scorpion EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (4189,28,-100,1); -- Vanguards_Slime EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (4190,28,-100,1); -- Vanguards_Wyvern EXP_BONUS: don't give XP

-- Immunities
INSERT INTO `mob_pool_mods` VALUES (6693,23,2048,1); -- (Apollyon) Light Elemetal light sleep immunity 
INSERT INTO `mob_pool_mods` VALUES (6689,23,1,1); -- (Apollyon) Dark Elemental sleep Immunity

-- Dynamis mob pets
INSERT INTO `mob_pool_mods` VALUES (4185,30,50,0); -- +50 Macc
INSERT INTO `mob_pool_mods` VALUES (4186,30,50,0); -- +50 Macc
INSERT INTO `mob_pool_mods` VALUES (4187,30,50,0); -- +50 Macc
INSERT INTO `mob_pool_mods` VALUES (4188,30,50,0); -- +50 Macc
INSERT INTO `mob_pool_mods` VALUES (4189,30,50,0); -- +50 Macc 
INSERT INTO `mob_pool_mods` VALUES (4190,30,50,0); -- +50 Macc


-- Vanguard_Alchemist
INSERT INTO `mob_pool_mods` VALUES (4133,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Ambusher
INSERT INTO `mob_pool_mods` VALUES (4134,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Amputator
INSERT INTO `mob_pool_mods` VALUES (4135,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Armorer
INSERT INTO `mob_pool_mods` VALUES (4136,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Assassin
INSERT INTO `mob_pool_mods` VALUES (4137,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Backstabber
INSERT INTO `mob_pool_mods` VALUES (4138,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Beasttender
INSERT INTO `mob_pool_mods` VALUES (4139,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Bugler
INSERT INTO `mob_pool_mods` VALUES (4140,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Chanter
INSERT INTO `mob_pool_mods` VALUES (4141,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Defender
INSERT INTO `mob_pool_mods` VALUES (4143,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Dollmaster
INSERT INTO `mob_pool_mods` VALUES (4144,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Dragon
INSERT INTO `mob_pool_mods` VALUES (4145,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Drakekeeper
INSERT INTO `mob_pool_mods` VALUES (4146,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Enchanter
INSERT INTO `mob_pool_mods` VALUES (4147,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Exemplar
INSERT INTO `mob_pool_mods` VALUES (4148,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Eye
INSERT INTO `mob_pool_mods` VALUES (4149,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Footsoldier
INSERT INTO `mob_pool_mods` VALUES (4150,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Grappler
INSERT INTO `mob_pool_mods` VALUES (4151,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Gutslasher
INSERT INTO `mob_pool_mods` VALUES (4152,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Hatamoto
INSERT INTO `mob_pool_mods` VALUES (4153,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Hawker
INSERT INTO `mob_pool_mods` VALUES (4154,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Hitman
INSERT INTO `mob_pool_mods` VALUES (4155,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Impaler
INSERT INTO `mob_pool_mods` VALUES (4156,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Inciter
INSERT INTO `mob_pool_mods` VALUES (4157,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Kusa
INSERT INTO `mob_pool_mods` VALUES (4158,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Liberator
INSERT INTO `mob_pool_mods` VALUES (4159,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Maestro
INSERT INTO `mob_pool_mods` VALUES (4160,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Mesmerizer
INSERT INTO `mob_pool_mods` VALUES (4162,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Militant
INSERT INTO `mob_pool_mods` VALUES (4163,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Minstrel
INSERT INTO `mob_pool_mods` VALUES (4164,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Neckchopper
INSERT INTO `mob_pool_mods` VALUES (4165,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Necromancer
INSERT INTO `mob_pool_mods` VALUES (4166,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Ogresoother
INSERT INTO `mob_pool_mods` VALUES (4167,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Oracle
INSERT INTO `mob_pool_mods` VALUES (4168,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Partisan
INSERT INTO `mob_pool_mods` VALUES (4169,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Pathfinder
INSERT INTO `mob_pool_mods` VALUES (4170,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Persecutor
INSERT INTO `mob_pool_mods` VALUES (4171,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Pillager
INSERT INTO `mob_pool_mods` VALUES (4172,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Pitfighter
INSERT INTO `mob_pool_mods` VALUES (4173,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Predator
INSERT INTO `mob_pool_mods` VALUES (4174,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Prelate
INSERT INTO `mob_pool_mods` VALUES (4175,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Priest
INSERT INTO `mob_pool_mods` VALUES (4176,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Protector
INSERT INTO `mob_pool_mods` VALUES (4177,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Purloiner
INSERT INTO `mob_pool_mods` VALUES (4178,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Ronin
INSERT INTO `mob_pool_mods` VALUES (4179,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Salvager
INSERT INTO `mob_pool_mods` VALUES (4180,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Sentinel
INSERT INTO `mob_pool_mods` VALUES (4181,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Shaman
INSERT INTO `mob_pool_mods` VALUES (4182,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Skirmisher
INSERT INTO `mob_pool_mods` VALUES (4183,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Smithy
INSERT INTO `mob_pool_mods` VALUES (4184,106,3,1); -- CAN_PARRY: 3
-- Vanguard_Tinkerer
INSERT INTO `mob_pool_mods` VALUES (4192,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Trooper
INSERT INTO `mob_pool_mods` VALUES (4193,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Vexer
INSERT INTO `mob_pool_mods` VALUES (4195,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Vigilante
INSERT INTO `mob_pool_mods` VALUES (4196,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Vindicator
INSERT INTO `mob_pool_mods` VALUES (4197,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Visionary
INSERT INTO `mob_pool_mods` VALUES (4198,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Welldigger
INSERT INTO `mob_pool_mods` VALUES (4199,106,3,1); -- CAN_PARRY: 3

-- Vanguard_Dragontamer
INSERT INTO `mob_pool_mods` VALUES (4649,106,3,1); -- CAN_PARRY: 3


/*!40000 ALTER TABLE `mob_pool_mods` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-09-20 13:54:52
