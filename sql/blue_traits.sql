/*
MySQL Data Transfer
Source Host: localhost
Source Database: tpzdb
Target Host: localhost
Target Database: tpzdb
Date: 7/5/2013 7:20:16 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for blue_traits
-- ----------------------------
DROP TABLE IF EXISTS `blue_traits`;
CREATE TABLE `blue_traits` (
  `trait_category` smallint(2) unsigned NOT NULL,
  `trait_points_needed` smallint(2) unsigned NOT NULL,
  `traitid` tinyint(3) unsigned NOT NULL,
  `modifier` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL,
  PRIMARY KEY (`trait_category`,`trait_points_needed`,`modifier`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `blue_traits` VALUES (1, 2, 32, 230, 8); -- Beast Killer
INSERT INTO `blue_traits` VALUES (1, 2, 32, 1230, 8); -- Beast Killer
INSERT INTO `blue_traits` VALUES (2, 2, 9, 370, 1); -- Auto Regen
INSERT INTO `blue_traits` VALUES (3, 2, 35, 227, 8); -- Lizard Killer
INSERT INTO `blue_traits` VALUES (3, 2, 35, 1227, 8); -- Lizard Killer
INSERT INTO `blue_traits` VALUES (4, 2, 24, 71, 3); -- Clear Mind
INSERT INTO `blue_traits` VALUES (4, 4, 24, 71, 6); -- Clear Mind II
INSERT INTO `blue_traits` VALUES (4, 6, 24, 71, 9); -- Clear Mind III
INSERT INTO `blue_traits` VALUES (4, 6, 24, 295, 1); -- Clear Mind III
INSERT INTO `blue_traits` VALUES (4, 8, 24, 71, 12); -- Clear Mind IV
INSERT INTO `blue_traits` VALUES (5, 2, 48, 1240, 10); -- Resist Sleep
INSERT INTO `blue_traits` VALUES (6, 2, 5, 28, 20); -- Magic Attack Bonus
INSERT INTO `blue_traits` VALUES (6, 4, 5, 28, 24); -- Magic Attack Bonus II
INSERT INTO `blue_traits` VALUES (6, 6, 5, 28, 28); -- Magic Attack Bonus III
INSERT INTO `blue_traits` VALUES (6, 8, 5, 28, 32); -- Magic Attack Bonus IV
INSERT INTO `blue_traits` VALUES (7, 2, 39, 231, 8); -- Undead Killer
INSERT INTO `blue_traits` VALUES (7, 2, 39, 1231, 8); -- Undead Killer
INSERT INTO `blue_traits` VALUES (8, 2, 3, 23, 10); -- Attack Bonus
INSERT INTO `blue_traits` VALUES (8, 2, 3, 24, 10); -- Attack Bonus
INSERT INTO `blue_traits` VALUES (8, 4, 3, 23, 22); -- Attack Bonus II
INSERT INTO `blue_traits` VALUES (8, 4, 3, 24, 22); -- Attack Bonus II
INSERT INTO `blue_traits` VALUES (8, 6, 3, 23, 35); -- Attack Bonus III
INSERT INTO `blue_traits` VALUES (8, 6, 3, 24, 35); -- Attack Bonus III
INSERT INTO `blue_traits` VALUES (8, 8, 3, 23, 48); -- Attack Bonus IV
INSERT INTO `blue_traits` VALUES (8, 8, 3, 24, 48); -- Attack Bonus IV
INSERT INTO `blue_traits` VALUES (9, 2, 11, 359, 10); -- Rapid Shot
INSERT INTO `blue_traits` VALUES (10, 2, 8, 5, 10); -- Max MP Boost
INSERT INTO `blue_traits` VALUES (10, 4, 8, 5, 20); -- Max MP Boost II
INSERT INTO `blue_traits` VALUES (10, 6, 8, 5, 40); -- Max MP Boost III
INSERT INTO `blue_traits` VALUES (10, 8, 8, 5, 60); -- Max MP Boost IV
INSERT INTO `blue_traits` VALUES (11, 2, 4, 1321, 10); -- Defense Bonus
INSERT INTO `blue_traits` VALUES (11, 4, 4, 1321, 22); -- Defense Bonus II
INSERT INTO `blue_traits` VALUES (11, 6, 4, 1321, 35); -- Defense Bonus III
INSERT INTO `blue_traits` VALUES (11, 8, 4, 1321, 48); -- Defense Bonus IV
INSERT INTO `blue_traits` VALUES (12, 2, 33, 229, 8); -- Plantoid Killer
INSERT INTO `blue_traits` VALUES (12, 2, 33, 1229, 8); -- Plantoid Killer
INSERT INTO `blue_traits` VALUES (13, 2, 6, 29, 10);    -- Magic Defense Bonus
INSERT INTO `blue_traits` VALUES (13, 4, 6, 29, 12);    -- Magic Defense Bonus II 
INSERT INTO `blue_traits` VALUES (13, 6, 6, 29, 14);    -- Magic Defense Bonus III
INSERT INTO `blue_traits` VALUES (13, 8, 6, 29, 16);    -- Magic Defense Bonus IV
INSERT INTO `blue_traits` VALUES (14, 8, 10, 369, 1);   -- Auto-refresh
INSERT INTO `blue_traits` VALUES (15, 2, 7, 2, 30);     -- Max HP Boost
INSERT INTO `blue_traits` VALUES (15, 4, 7, 2, 60);     -- Max HP Boost II
INSERT INTO `blue_traits` VALUES (15, 6, 7, 2, 120);    -- Max HP Boost III
INSERT INTO `blue_traits` VALUES (15, 8, 7, 2, 180);    -- Max HP Boost IV
INSERT INTO `blue_traits` VALUES (16, 2, 1, 25, 10);    -- Accuravy Bonus
INSERT INTO `blue_traits` VALUES (16, 2, 1, 26, 10);    -- Accuracy Bonus
INSERT INTO `blue_traits` VALUES (16, 4, 1, 25, 22);    -- Accuravy Bonus II
INSERT INTO `blue_traits` VALUES (16, 4, 1, 26, 22);    -- Accuracy Bonus II
INSERT INTO `blue_traits` VALUES (16, 6, 1, 25, 35);    -- Accuravy Bonus III
INSERT INTO `blue_traits` VALUES (16, 6, 1, 26, 35);    -- Accuracy Bonus III
INSERT INTO `blue_traits` VALUES (16, 8, 1, 25, 48);    -- Accuravy Bonus IV
INSERT INTO `blue_traits` VALUES (16, 8, 1, 26, 48);    -- Accuracy Bonus IV
INSERT INTO `blue_traits` VALUES (17, 2, 13, 296, 25); -- Conserve MP
INSERT INTO `blue_traits` VALUES (17, 4, 13, 296, 28); -- Conserve MP II
INSERT INTO `blue_traits` VALUES (17, 6, 13, 296, 31); -- Conserve MP III
INSERT INTO `blue_traits` VALUES (17, 8, 13, 296, 34); -- Conserve MP IV
INSERT INTO `blue_traits` VALUES (18, 2, 2, 69, 10);    -- Evasion Bonus
INSERT INTO `blue_traits` VALUES (18, 4, 2, 69, 22);    -- Evasion Bonus II
INSERT INTO `blue_traits` VALUES (18, 6, 2, 69, 35);    -- Evasion Bonus III
INSERT INTO `blue_traits` VALUES (18, 8, 2, 69, 48);    -- Evasion Bonus IV
INSERT INTO `blue_traits` VALUES (19, 2, 58, 1249, 10); -- Resist Gravity
INSERT INTO `blue_traits` VALUES (20, 2, 14, 73, 10); -- Store TP
INSERT INTO `blue_traits` VALUES (20, 4, 14, 73, 15); -- Store TP II
INSERT INTO `blue_traits` VALUES (20, 6, 14, 73, 20); -- Store TP III
INSERT INTO `blue_traits` VALUES (20, 8, 14, 73, 25); -- Store TP IV
INSERT INTO `blue_traits` VALUES (21, 2, 17, 291, 10); -- Counter
INSERT INTO `blue_traits` VALUES (21, 4, 17, 291, 12); -- Counter II
INSERT INTO `blue_traits` VALUES (22, 2, 12, 170, 5);  -- Fast Cast
INSERT INTO `blue_traits` VALUES (22, 4, 12, 170, 10); -- Fast cast II
INSERT INTO `blue_traits` VALUES (22, 6, 12, 170, 15); -- Fast cast III
INSERT INTO `blue_traits` VALUES (22, 8, 12, 170, 25); -- Fast cast IV
INSERT INTO `blue_traits` VALUES (23, 2, 106, 174, 8); -- Skillchain Bonus
INSERT INTO `blue_traits` VALUES (23, 4, 106, 174, 12); -- Skillchain Bonus II
INSERT INTO `blue_traits` VALUES (23, 6, 106, 174, 16); -- Skillchain Bonus III
INSERT INTO `blue_traits` VALUES (23, 8, 106, 174, 20); -- Skillchain Bonus IV
INSERT INTO `blue_traits` VALUES (24, 2, 15, 288, 7); -- Double Attack
INSERT INTO `blue_traits` VALUES (24, 4, 16, 302, 5); -- Triple Attack
INSERT INTO `blue_traits` VALUES (25, 2, 18, 259, 10); -- Dual Wield
INSERT INTO `blue_traits` VALUES (25, 4, 18, 259, 15); -- Dual Wield II
INSERT INTO `blue_traits` VALUES (25, 6, 18, 259, 25); -- Dual Wield III
INSERT INTO `blue_traits` VALUES (25, 8, 18, 259, 30); -- Dual Wield IV
INSERT INTO `blue_traits` VALUES (26, 2, 70, 306, 15); -- Zanshin
INSERT INTO `blue_traits` VALUES (27, 2, 110, 407, 5); -- Magic burst bonus
INSERT INTO `blue_traits` VALUES (27, 4, 110, 407, 7); -- Magic burst bonus II
INSERT INTO `blue_traits` VALUES (27, 6, 110, 407, 9); -- Magic burst bonus III
INSERT INTO `blue_traits` VALUES (27, 8, 110, 407, 11); -- Magic burst bonus IV
INSERT INTO `blue_traits` VALUES (28, 2, 20, 0, 0);   -- Gilfinder
INSERT INTO `blue_traits` VALUES (28, 4, 64, 303, 2); -- Treasure Hunter II
INSERT INTO `blue_traits` VALUES (29, 2, 126, 31, 10);   -- Magic evasion bonus
INSERT INTO `blue_traits` VALUES (29, 4, 126, 31, 12);   -- Magic evasion bonus II
INSERT INTO `blue_traits` VALUES (29, 6, 126, 31, 14);   -- Magic evasion bonus III
INSERT INTO `blue_traits` VALUES (29, 8, 126, 31, 16);   -- Magic evasion bonus IV
INSERT INTO `blue_traits` VALUES (30, 2, 136, 1310, 10); -- Shield Barrier
INSERT INTO `blue_traits` VALUES (30, 4, 136, 1310, 15); -- Shield Barrier II
INSERT INTO `blue_traits` VALUES (30, 6, 136, 1310, 20); -- Shield Barrier III
INSERT INTO `blue_traits` VALUES (30, 8, 136, 1310, 25); -- Shield Barrier IV
INSERT INTO `blue_traits` VALUES (31, 2, 98, 421, 5); -- Crit. Atk. Bonus
INSERT INTO `blue_traits` VALUES (31, 4, 98, 421, 8); -- Crit. Atk. Bonus II
INSERT INTO `blue_traits` VALUES (31, 6, 98, 421, 11); -- Crit. Atk. Bonus III
INSERT INTO `blue_traits` VALUES (31, 8, 98, 421, 14); -- Crit. Atk. Bonus IV
INSERT INTO `blue_traits` VALUES (32, 2, 118, 1012, 5); -- Inquartata
INSERT INTO `blue_traits` VALUES (32, 4, 118, 1012, 7); -- Inquartata II
INSERT INTO `blue_traits` VALUES (32, 6, 118, 1012, 9); -- Inquartata III
INSERT INTO `blue_traits` VALUES (32, 8, 118, 1012, 11); -- Inquartata IV
INSERT INTO `blue_traits` VALUES (33, 2, 117, 2000, 5); -- Tenacity
INSERT INTO `blue_traits` VALUES (33, 4, 117, 2000, 7); -- Tenacity II
INSERT INTO `blue_traits` VALUES (33, 6, 117, 2000, 9); -- Tenacity III
INSERT INTO `blue_traits` VALUES (33, 8, 117, 2000, 11); -- Tenacity IV
INSERT INTO `blue_traits` VALUES (34, 2, 107, 903, 500); -- Fencer
INSERT INTO `blue_traits` VALUES (34, 2, 107, 904, 5); -- Fencer
INSERT INTO `blue_traits` VALUES (34, 2, 107, 986, 10); -- Fencer
INSERT INTO `blue_traits` VALUES (34, 4, 107, 903, 550); -- Fencer II
INSERT INTO `blue_traits` VALUES (34, 4, 107, 904, 7); -- Fencer  II
INSERT INTO `blue_traits` VALUES (34, 4, 107, 986, 12); -- Fencer II
INSERT INTO `blue_traits` VALUES (34, 6, 107, 903, 600); -- Fencer III
INSERT INTO `blue_traits` VALUES (34, 6, 107, 904, 10); -- Fencer III
INSERT INTO `blue_traits` VALUES (34, 6, 107, 986, 14); -- Fencer III
INSERT INTO `blue_traits` VALUES (34, 8, 107, 903, 650); -- Fencer IV
INSERT INTO `blue_traits` VALUES (34, 8, 107, 904, 12); -- Fencer IV
INSERT INTO `blue_traits` VALUES (34, 8, 107, 986, 15); -- Fencer IV
INSERT INTO `blue_traits` VALUES (35, 2, 25, 485, 10); -- Shield Mastery
INSERT INTO `blue_traits` VALUES (35, 4, 25, 485, 20); -- Shield Mastery II 
INSERT INTO `blue_traits` VALUES (35, 6, 25, 485, 30); -- Shield Mastery III
INSERT INTO `blue_traits` VALUES (35, 8, 25, 485, 40); -- Shield Mastery IV