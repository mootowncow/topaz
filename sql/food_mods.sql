DROP TABLE IF EXISTS `food_mods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

CREATE TABLE `food_mods` (
    `itemid` smallint(5) unsigned NOT NULL,
    `name` text NOT NULL,
    `mod1` smallint(4) unsigned NOT NULL DEFAULT '0',
    `mod2` smallint(4) unsigned NOT NULL DEFAULT '0',
    `mod3` smallint(4) unsigned NOT NULL DEFAULT '0',
    `mod4` smallint(4) unsigned NOT NULL DEFAULT '0',
    `mod5` smallint(4) unsigned NOT NULL DEFAULT '0',
    `mod6` smallint(4) unsigned NOT NULL DEFAULT '0',
    `mod7` smallint(4) unsigned NOT NULL DEFAULT '0',
    `mod8` smallint(4) unsigned NOT NULL DEFAULT '0',
    `mod9` smallint(4) unsigned NOT NULL DEFAULT '0',
    `mod10` smallint(4) unsigned NOT NULL DEFAULT '0',
    `power1` smallint(4) NOT NULL DEFAULT '0',
    `power2` smallint(4) NOT NULL DEFAULT '0',
    `power3` smallint(4) NOT NULL DEFAULT '0',
    `power4` smallint(4) NOT NULL DEFAULT '0',
    `power5` smallint(4) NOT NULL DEFAULT '0',
    `power6` smallint(4) NOT NULL DEFAULT '0',
    `power7` smallint(4) NOT NULL DEFAULT '0',
    `power8` smallint(4) NOT NULL DEFAULT '0',
    `power9` smallint(4) NOT NULL DEFAULT '0',
    `power10` smallint(4) NOT NULL DEFAULT '0',
    `duration` smallint(4) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`itemid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=1 CHECKSUM=1;

INSERT INTO `food_mods` VALUES (4419,'mushroom_soup',5,8,13,374,27,71,0,0,0,0,15,-1,2,7,-2,2,0,0,0,0,10800);
INSERT INTO `food_mods` VALUES (4333,'witch_soup',5,13,374,27,71,0,0,0,0,0,17,3,8,-2,3,0,0,0,0,0,14400);
INSERT INTO `food_mods` VALUES (4434,'mushroom_risotto',5,13,374,27,71,0,0,0,0,0,20,3,10,-2,3,0,0,0,0,0,10800);
INSERT INTO `food_mods` VALUES (4330,'witch_risotto',5,13,374,27,71,0,0,0,0,0,25,3,11,-3,4,0,0,0,0,0,14400);
INSERT INTO `food_mods` VALUES (4544,'mushroom_stew',5,13,374,27,71,0,0,0,0,0,30,4,15,-3,3,0,0,0,0,0,10800);
INSERT INTO `food_mods` VALUES (4344,'witch_stew',5,13,374,27,71,0,0,0,0,0,35,4,16,-3,4,0,0,0,0,0,14400);
INSERT INTO `food_mods` VALUES (5676,'mushroom_saute',5,13,374,27,71,0,0,0,0,0,40,4,20,-3,4,0,0,0,0,0,10800);
INSERT INTO `food_mods` VALUES (5677,'patriarch_saute',5,13,374,27,71,0,0,0,0,0,45,5,22,-4,4,0,0,0,0,0,14400);

-- Template
-- INSERT INTO `food_mods` VALUES (5677,'serving_of_patriarch_saute',mod,0,0,0,0,0,0,0,0,0,power,0,0,0,0,0,0,0,0,0,duration);

/*!40101 SET character_set_client = @saved_cs_client */;
