-- phpMyAdmin SQL Dump
-- version 3.3.8
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- G�n�r� le : Sam 25 Juin 2011 � 10:09
-- Version du serveur: 6.0.0
-- Version de PHP: 5.2.9-2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de donn�es: `tpzdb`
--

-- --------------------------------------------------------

--
-- Structure de la table `pet_list`
--

DROP TABLE IF EXISTS `pet_list`;
CREATE TABLE IF NOT EXISTS `pet_list` (
  `petid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(15) NOT NULL,
  `poolid` int(10) unsigned NOT NULL DEFAULT '0',
  `minLevel` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `maxLevel` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `element` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`petid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Contenu de la table `pet_list`
--

INSERT INTO `pet_list` VALUES (0, 'FireSpirit', 5830, 1, 99, 0, 1);
INSERT INTO `pet_list` VALUES (1, 'IceSpirit', 5831, 1, 99, 0, 2);
INSERT INTO `pet_list` VALUES (2, 'AirSpirit', 5832, 1, 99, 0, 3);
INSERT INTO `pet_list` VALUES (3, 'EarthSpirit', 5833, 1, 99, 0, 4);
INSERT INTO `pet_list` VALUES (4, 'ThunderSpirit', 5834, 1, 99, 0, 5);
INSERT INTO `pet_list` VALUES (5, 'WaterSpirit', 5835, 1, 99, 0, 6);
INSERT INTO `pet_list` VALUES (6, 'LightSpirit', 5836, 1, 99, 0, 7);
INSERT INTO `pet_list` VALUES (7, 'DarkSpirit', 5837, 1, 99, 0, 8);
INSERT INTO `pet_list` VALUES (8, 'Carbuncle', 4588, 1, 99, 0, 7);
INSERT INTO `pet_list` VALUES (9, 'Fenrir', 4581, 1, 99, 0, 8);
INSERT INTO `pet_list` VALUES (10, 'Ifrit', 4582, 1, 99, 0, 1);
INSERT INTO `pet_list` VALUES (11, 'Titan', 4583, 1, 99, 0, 4);
INSERT INTO `pet_list` VALUES (12, 'Leviathan', 4584, 1, 99, 0, 6);
INSERT INTO `pet_list` VALUES (13, 'Garuda', 4585, 1, 99, 0, 3);
INSERT INTO `pet_list` VALUES (14, 'Shiva', 4586, 1, 99, 0, 2);
INSERT INTO `pet_list` VALUES (15, 'Ramuh', 4587, 1, 99, 0, 5);
INSERT INTO `pet_list` VALUES (16, 'Diabolos', 4590, 1, 99, 0, 8);
INSERT INTO `pet_list` VALUES (17, 'Alexander', 4589, 1, 99, 0, 7);
INSERT INTO `pet_list` VALUES (18, 'Odin', 4591, 1, 99, 0, 8);
INSERT INTO `pet_list` VALUES (19, 'Atomos', 1, 1, 99, 0, 0);
INSERT INTO `pet_list` VALUES (20, 'CaitSith', 5775, 1, 99, 0, 7);
-- NQ Jugs
INSERT INTO `pet_list` VALUES (21, 'SheepFamiliar', 4598, 23, 35, 1800, 0);
INSERT INTO `pet_list` VALUES (22, 'HareFamiliar', 4641, 23, 35, 1800, 0);
INSERT INTO `pet_list` VALUES (23, 'CrabFamiliar', 4610, 23, 55, 1800, 0);
INSERT INTO `pet_list` VALUES (24, 'CourierCarrie', 4611, 23, 75, 1800, 0);
INSERT INTO `pet_list` VALUES (25, 'Homunculus', 4616, 23, 75, 3600, 0);
INSERT INTO `pet_list` VALUES (26, 'FlytrapFamiliar', 4619, 28, 40, 1800, 0);
INSERT INTO `pet_list` VALUES (27, 'TigerFamiliar', 4604, 28, 40, 1800, 0);
INSERT INTO `pet_list` VALUES (28, 'FlowerpotBill', 4602, 28, 40, 1800, 0);
INSERT INTO `pet_list` VALUES (29, 'EftFamiliar', 4621, 33, 45, 1800, 0);
INSERT INTO `pet_list` VALUES (30, 'LizardFamiliar', 4600, 33, 45, 1800, 0);
INSERT INTO `pet_list` VALUES (31, 'MayflyFamiliar', 4596, 33, 45, 1800, 0);
INSERT INTO `pet_list` VALUES (32, 'FunguarFamiliar', 4614, 33, 75, 1800, 0);
INSERT INTO `pet_list` VALUES (33, 'BeetleFamiliar', 4606, 38, 45, 1800, 0);
INSERT INTO `pet_list` VALUES (34, 'AntlionFamiliar', 4625, 38, 50, 1800, 0);
INSERT INTO `pet_list` VALUES (35, 'DiremiteFamiliar', 4623, 43, 55, 1800, 0);
-- HQ Jugs
INSERT INTO `pet_list` VALUES (36, 'LullabyMelodia', 4599, 43, 75, 1800, 0);
INSERT INTO `pet_list` VALUES (37, 'KeenearedSteffi', 4595, 43, 75, 1800, 0);
INSERT INTO `pet_list` VALUES (38, 'FlowerpotBen', 4603, 51, 75, 1800, 0);
INSERT INTO `pet_list` VALUES (39, 'SaberSiravarde', 4605, 51, 75, 1800, 0);
INSERT INTO `pet_list` VALUES (40, 'ColdbloodComo', 4601, 53, 75, 1800, 0);
INSERT INTO `pet_list` VALUES (41, 'ShellbusterOrob', 4597, 53, 75, 1800, 0);
INSERT INTO `pet_list` VALUES (42, 'VoraciousAudrey', 4620, 53, 75, 1800, 0);
INSERT INTO `pet_list` VALUES (43, 'AmbusherAllie', 4622, 58, 75, 1800, 0);
INSERT INTO `pet_list` VALUES (44, 'LifedrinkerLars', 4624, 63, 75, 3600, 0);
INSERT INTO `pet_list` VALUES (45, 'PanzerGalahad', 4607, 63, 75, 1800, 0);
INSERT INTO `pet_list` VALUES (46, 'ChopsueyChucky', 4626, 63, 85, 1800, 0);
INSERT INTO `pet_list` VALUES (47, 'AmigoSabotender', 4618, 75, 85, 3600, 0);
INSERT INTO `pet_list` VALUES (48, 'Wyvern', 5551, 1, 99, 0, 0);
-- Post Abyssea Jugs
INSERT INTO `pet_list` VALUES (49, 'Crafty Clyvonne', 4608, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (50, 'Bloodclaw Shasr', 4609, 73, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (51, 'Lucky Lulush', 4612, 73, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (52, 'Fatso Fargann', 4613, 73, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (53, 'Discreet Louise', 4615, 73, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (54, 'Swift Sieghard', 4617, 73, 94, 1800, 0);
INSERT INTO `pet_list` VALUES (55, 'Dipper Yuly', 4627, 73, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (56, 'Flowerpot Merle', 4628, 73, 99, 10800, 0);
INSERT INTO `pet_list` VALUES (57, 'Nursery Nazuna', 4629, 73, 86, 1800, 0);
INSERT INTO `pet_list` VALUES (58, 'Mailbuster Ceta', 4630, 73, 95, 1800, 0);
INSERT INTO `pet_list` VALUES (59, 'Audacious Anna', 4631, 73, 95, 1800, 0);
INSERT INTO `pet_list` VALUES (60, 'Presto Julio', 4632, 73, 93, 1800, 0);
INSERT INTO `pet_list` VALUES (61, 'Bugeyed Broncha', 4633, 73, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (62, 'Gooey Gerard', 4634, 73, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (63, 'Gorefang Hobs', 4635, 73, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (64, 'Faithful Falcor', 4636, 73, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (65, 'Crude Raphie', 4637, 73, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (66, 'Dapper Mac', 4638, 73, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (67, 'Slippery Silas', 4639, 23, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (68, 'Turbid Toloi', 4640, 23, 99, 1800, 0);
INSERT INTO `pet_list` VALUES (69, 'HarlequinFrame', 5124, 1, 99, 0, 0);
INSERT INTO `pet_list` VALUES (70, 'ValoredgeFrame', 5125, 1, 99, 0, 0);
INSERT INTO `pet_list` VALUES (71, 'SharpshotFrame', 5126, 1, 99, 0, 0);
INSERT INTO `pet_list` VALUES (72, 'StormwakerFrame', 5127, 1, 99, 0, 0);
-- INSERT INTO `pet_list` VALUES (73, 'AdventuringFellow', 0, 1, 99, 0, 0);
-- 74 is Chocobo in the enum..
INSERT INTO `pet_list` VALUES (75, 'Luopan', 6040, 1, 99, 0, 0);

INSERT INTO `pet_list` VALUES (76, 'Roche', 6775, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (77, 'Caroline', 6776, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (78, 'Ken', 6777, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (79, 'Jedd', 6778, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (80, 'Annabelle', 6779, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (81, 'Waluis', 6780, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (82, 'SlimeFamiliar', 6781, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (83, 'Patrice', 6782, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (84, 'Arthur', 6783, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (85, 'Candi', 6784, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (86, 'Honey', 6785, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (87, 'LynxFamiliar', 6786, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (88, 'Gaston', 6787, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (89, 'Kiyomaro', 6788, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (90, 'Vickie', 6789, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (91, 'Alice', 6790, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (92, 'Storm', 6791, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (93, 'Iyo', 6792, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (94, 'Patrick', 6793, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (95, 'Shizuna', 6794, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (96, 'Randy', 6795, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (97, 'Lynn', 6796, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (98, 'Percival', 6797, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (99, 'AcuexFamiliar', 6798, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (100, 'Bredo', 6799, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (101, 'WeevilFamiliar', 6800, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (102, 'Angelina', 6801, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (103, 'Reinhard', 6802, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (104, 'Hermes', 6803, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (105, 'PorterCrabFamiliar', 6804, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (106, 'Edwin', 6805, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (107, 'Ibuki', 6806, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (108, 'Zhivago', 6807, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (109, 'Malfik', 6808, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (110, 'Angus', 6809, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (111, 'Xerin', 6810, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (112, 'Bertha', 6811, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (113, 'SpiderFamiliar', 6812, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (114, 'Hachirobe', 6813, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (115, 'ColibriFamiliar', 6814, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (116, 'Leera', 6815, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (117, 'Dortwin', 6816, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (118, 'Peter', 6817, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (119, 'Henry', 6818, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (120, 'HippogryphFamiliar', 6819, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (121, 'Roland', 6820, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (122, 'MosquitoFamiliar', 6821, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (123, 'Yoko', 6822, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (124, 'Glenn', 6823, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (125, 'YellowBeetleFamiliar', 6824, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (126, 'Sefina', 6825, 73, 90, 1800, 0);
-- Need two extra pet IDs after final ones or else server breaks for some reason
INSERT INTO `pet_list` VALUES (127, 'PH', 6825, 73, 90, 1800, 0);
INSERT INTO `pet_list` VALUES (128, 'PH', 6825, 73, 90, 1800, 0);

