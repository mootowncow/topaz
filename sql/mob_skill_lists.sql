-- phpMyAdmin SQL Dump
-- version 3.3.8
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Ven 03 Février 2012    22:54
-- Version du serveur: 6.0.0
-- Version de PHP: 5.2.9-2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `tpzdb`
--

-- --------------------------------------------------------

--
-- Structure de la table `mob_skill_lists`
--

DROP TABLE IF EXISTS `mob_skill_lists`;
CREATE TABLE IF NOT EXISTS `mob_skill_lists` (
  `skill_list_name` varchar(40) DEFAULT NULL,
  `skill_list_id` smallint(5) unsigned NOT NULL,
  `mob_skill_id` smallint(3) unsigned NOT NULL,
  PRIMARY KEY (`skill_list_id`,`mob_skill_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `mob_skill_lists`
--

INSERT INTO `mob_skill_lists` VALUES ('Acrolith',1,2070); -- dismemberment
INSERT INTO `mob_skill_lists` VALUES ('Acrolith',1,2071); -- dire_straight
INSERT INTO `mob_skill_lists` VALUES ('Acrolith',1,2072); -- earth_shatter
INSERT INTO `mob_skill_lists` VALUES ('Acrolith',1,2073); -- sinker_drill
INSERT INTO `mob_skill_lists` VALUES ('Acrolith',1,2074); -- detonating_grip
INSERT INTO `mob_skill_lists` VALUES ('Adamantoise',2,804);
INSERT INTO `mob_skill_lists` VALUES ('Adamantoise',2,805);
INSERT INTO `mob_skill_lists` VALUES ('Adamantoise',2,806);
INSERT INTO `mob_skill_lists` VALUES ('Adamantoise',2,807);
INSERT INTO `mob_skill_lists` VALUES ('Adamantoise',2,808);
INSERT INTO `mob_skill_lists` VALUES ('Adamantoise',2,809);
INSERT INTO `mob_skill_lists` VALUES ('Aern',3,1378);
INSERT INTO `mob_skill_lists` VALUES ('Aern',3,1379);
INSERT INTO `mob_skill_lists` VALUES ('Aern',3,1380);
INSERT INTO `mob_skill_lists` VALUES ('Aern',3,1381);
INSERT INTO `mob_skill_lists` VALUES ('Aern',3,1382);
INSERT INTO `mob_skill_lists` VALUES ('Aern',3,1387);
INSERT INTO `mob_skill_lists` VALUES ('Ahriman',4,548);
INSERT INTO `mob_skill_lists` VALUES ('Ahriman',4,549);
INSERT INTO `mob_skill_lists` VALUES ('Ahriman',4,550);
INSERT INTO `mob_skill_lists` VALUES ('Ahriman',4,551);
INSERT INTO `mob_skill_lists` VALUES ('Ahriman',4,552);
INSERT INTO `mob_skill_lists` VALUES ('Ahriman',4,553);
INSERT INTO `mob_skill_lists` VALUES ('Ahriman',4,555);
INSERT INTO `mob_skill_lists` VALUES ('Ahriman',4,557);
INSERT INTO `mob_skill_lists` VALUES ('Amoeban',5,2631);
INSERT INTO `mob_skill_lists` VALUES ('Amoeban',5,2632);
-- INSERT INTO `mob_skill_lists` VALUES ('Amoeban',5,2633);
INSERT INTO `mob_skill_lists` VALUES ('Amphiptere',6,2427);
INSERT INTO `mob_skill_lists` VALUES ('Amphiptere',6,2428);
INSERT INTO `mob_skill_lists` VALUES ('Amphiptere',6,2429); -- feral_peck
INSERT INTO `mob_skill_lists` VALUES ('Amphiptere',6,2430); -- warped_wail
INSERT INTO `mob_skill_lists` VALUES ('Amphiptere',6,2431);
INSERT INTO `mob_skill_lists` VALUES ('Amphiptere',6,2432);
INSERT INTO `mob_skill_lists` VALUES ('Amphiptere',6,2433); -- calamitous_wind
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Archery',7,1200);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Axe',8,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Axe',8,1192);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Club',9,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Club',9,1198);
INSERT INTO `mob_skill_lists` VALUES ('Prankster_Maverix',10,513);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Dagger',11,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Dagger',11,1189);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Greataxe',12,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Greataxe',12,1193);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Greatkatana',13,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Greatkatana',13,1197);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Greatsword',14,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Greatsword',14,1191);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Handtohand',15,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Handtohand',15,1188);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Horn',16,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Katana',17,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Katana',17,1196);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Marksmanship',18,1201);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Polearm',19,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Polearm',19,1195);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Scythe',20,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Scythe',20,1194);
INSERT INTO `mob_skill_lists` VALUES ('Demoiselle_Desolee',21,659);
INSERT INTO `mob_skill_lists` VALUES ('Gwyllgi',22,466);
INSERT INTO `mob_skill_lists` VALUES ('Gwyllgi',22,470);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Staff',23,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Staff',23,1199);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Sword',24,405);
INSERT INTO `mob_skill_lists` VALUES ('AnimatedWeapon-Sword',24,1190);
INSERT INTO `mob_skill_lists` VALUES ('Antica',25,791);
INSERT INTO `mob_skill_lists` VALUES ('Antica',25,792);
INSERT INTO `mob_skill_lists` VALUES ('Antica',25,793);
INSERT INTO `mob_skill_lists` VALUES ('Antica',25,794);
INSERT INTO `mob_skill_lists` VALUES ('Antica',25,795);
INSERT INTO `mob_skill_lists` VALUES ('Antica',25,796);
INSERT INTO `mob_skill_lists` VALUES ('Antica',25,789);
INSERT INTO `mob_skill_lists` VALUES ('Antica',25,790);
INSERT INTO `mob_skill_lists` VALUES ('Antlion',26,275);
INSERT INTO `mob_skill_lists` VALUES ('Antlion',26,276);
INSERT INTO `mob_skill_lists` VALUES ('Antlion',26,277);
INSERT INTO `mob_skill_lists` VALUES ('Antlion',26,279);
INSERT INTO `mob_skill_lists` VALUES ('Apkallu',27,1713);
INSERT INTO `mob_skill_lists` VALUES ('Apkallu',27,1714);
INSERT INTO `mob_skill_lists` VALUES ('Apkallu',27,1715);
INSERT INTO `mob_skill_lists` VALUES ('Apkallu',27,1716);
INSERT INTO `mob_skill_lists` VALUES ('Apkallu',27,1717);
-- 28 - 31: Automaton
INSERT INTO `mob_skill_lists` VALUES ('Acolnahuacatl',32,653);
INSERT INTO `mob_skill_lists` VALUES ('Splacknuck',33,518);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Carbuncle',34,906);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Carbuncle',34,907);
-- INSERT INTO `mob_skill_lists` VALUES ('Avatar-Carbuncle',34,908);
-- INSERT INTO `mob_skill_lists` VALUES ('Avatar-Carbuncle',34,909);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Carbuncle',34,910);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Carbuncle',34,911);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Carbuncle',34,912);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Diabolos',35,1903); -- (Shrouded Maw COP Fight) camisado
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Diabolos',35,1905); --noctoshield
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Diabolos',35,1906); --ultimate_terror
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Diabolos',35,1908);  --nightmare
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',36,831);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',36,832);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',36,833);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',36,834);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',36,835);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',36,836);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',36,837);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Garuda',37,867);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Garuda',37,868);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Garuda',37,869);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Garuda',37,870);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Garuda',37,871);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Garuda',37,872);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Garuda',37,873);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Garuda',37,874);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ifrit',38,840);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ifrit',38,841);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ifrit',38,842);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ifrit',38,843);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ifrit',38,844);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ifrit',38,845);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ifrit',38,846);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ifrit',38,847);
-- INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ixion',39,1542);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ixion',39,2334);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ixion',39,2335);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ixion',39,2336);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ixion',39,2337);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ixion',39,2338);
--INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ixion',39,2369); -- scintillant_lance
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Leviathan',40,858);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Leviathan',40,859);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Leviathan',40,860);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Leviathan',40,861);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Leviathan',40,862);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Leviathan',40,863);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Leviathan',40,864);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Leviathan',40,865);
-- INSERT INTO `mob_skill_lists` VALUES ('Avatar-Odin',41,2126);
-- INSERT INTO `mob_skill_lists` VALUES ('Avatar-Odin',41,2556);
-- INSERT INTO `mob_skill_lists` VALUES ('Avatar-Odin',41,2557);
-- INSERT INTO `mob_skill_lists` VALUES ('Avatar-Odin',41,2558);
-- INSERT INTO `mob_skill_lists` VALUES ('Avatar-Odin',41,2559);
-- INSERT INTO `mob_skill_lists` VALUES ('Avatar-Odin',41,2560);
-- INSERT INTO `mob_skill_lists` VALUES ('Avatar-Odin',41,2561);
-- 42: Dark Rider
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ramuh',43,885);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ramuh',43,886);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ramuh',43,887);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ramuh',43,888);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ramuh',43,889);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ramuh',43,890);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ramuh',43,891);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ramuh',43,892);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Shiva',44,876);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Shiva',44,877);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Shiva',44,878);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Shiva',44,879);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Shiva',44,880);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Shiva',44,881);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Shiva',44,882);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Shiva',44,883);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Titan',45,849);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Titan',45,850);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Titan',45,851);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Titan',45,852);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Titan',45,853);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Titan',45,854);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Titan',45,855);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Titan',45,856);
INSERT INTO `mob_skill_lists` VALUES ('Bat',46,1401); -- soul_accretion
INSERT INTO `mob_skill_lists` VALUES ('Bat',46,392); -- ultrasonics
INSERT INTO `mob_skill_lists` VALUES ('Bat',46,394); -- blood_drain
INSERT INTO `mob_skill_lists` VALUES ('Bat',46,1155); -- subsonics
INSERT INTO `mob_skill_lists` VALUES ('Bat',46,1156); -- marrow_drain
INSERT INTO `mob_skill_lists` VALUES ('Bats',47,393);
INSERT INTO `mob_skill_lists` VALUES ('Bats',47,395);
INSERT INTO `mob_skill_lists` VALUES ('Bee',48,334);
INSERT INTO `mob_skill_lists` VALUES ('Bee',48,335);
INSERT INTO `mob_skill_lists` VALUES ('Bee',48,336);
INSERT INTO `mob_skill_lists` VALUES ('Beetle',49,338);
INSERT INTO `mob_skill_lists` VALUES ('Beetle',49,339);
INSERT INTO `mob_skill_lists` VALUES ('Beetle',49,340);
INSERT INTO `mob_skill_lists` VALUES ('Beetle',49,341);
INSERT INTO `mob_skill_lists` VALUES ('Beetle',49,343);
INSERT INTO `mob_skill_lists` VALUES ('Gloom_Eye',50,548);
INSERT INTO `mob_skill_lists` VALUES ('Gloom_Eye',50,549);
INSERT INTO `mob_skill_lists` VALUES ('Behemoth',51,628);
INSERT INTO `mob_skill_lists` VALUES ('Behemoth',51,629);
INSERT INTO `mob_skill_lists` VALUES ('Behemoth',51,630);
INSERT INTO `mob_skill_lists` VALUES ('Behemoth',51,631);
INSERT INTO `mob_skill_lists` VALUES ('Behemoth',51,632);
INSERT INTO `mob_skill_lists` VALUES ('Behemoth',51,633);
-- INSERT INTO `mob_skill_lists` VALUES ('Behemoth',51,634);   chlevnik's death meteor (not a normal meteor attack animation)
INSERT INTO `mob_skill_lists` VALUES ('Bhoot',52,472);
INSERT INTO `mob_skill_lists` VALUES ('Bhoot',52,473);
INSERT INTO `mob_skill_lists` VALUES ('Bhoot',52,474);
INSERT INTO `mob_skill_lists` VALUES ('Bhoot',52,475);
INSERT INTO `mob_skill_lists` VALUES ('Bhoot',52,476);
INSERT INTO `mob_skill_lists` VALUES ('Bhoot',52,477);
INSERT INTO `mob_skill_lists` VALUES ('Bhoot',52,1794); -- Perdition
INSERT INTO `mob_skill_lists` VALUES ('Likho',53,551);
INSERT INTO `mob_skill_lists` VALUES ('Likho',53,555);
INSERT INTO `mob_skill_lists` VALUES ('Omega',54,1533);
INSERT INTO `mob_skill_lists` VALUES ('Omega',54,1534);
INSERT INTO `mob_skill_lists` VALUES ('Omega',54,1535);
INSERT INTO `mob_skill_lists` VALUES ('Omega',54,1536);
INSERT INTO `mob_skill_lists` VALUES ('Omega',54,1537);
INSERT INTO `mob_skill_lists` VALUES ('Omega',54,1538);
INSERT INTO `mob_skill_lists` VALUES ('Omega',54,1539);
INSERT INTO `mob_skill_lists` VALUES ('Bird',55,622);
INSERT INTO `mob_skill_lists` VALUES ('Bird',55,623);
INSERT INTO `mob_skill_lists` VALUES ('Bomb',56,510);
INSERT INTO `mob_skill_lists` VALUES ('Bomb',56,511);
INSERT INTO `mob_skill_lists` VALUES ('Bomb',56,342);
INSERT INTO `mob_skill_lists` VALUES ('Buffalo',57,493);
INSERT INTO `mob_skill_lists` VALUES ('Buffalo',57,494);
INSERT INTO `mob_skill_lists` VALUES ('Buffalo',57,495);
INSERT INTO `mob_skill_lists` VALUES ('Buffalo',57,496);
INSERT INTO `mob_skill_lists` VALUES ('Buffalo',57,497);
INSERT INTO `mob_skill_lists` VALUES ('Buffalo',57,1364); -- Mighty Snort
INSERT INTO `mob_skill_lists` VALUES ('Bugard',58,382);
INSERT INTO `mob_skill_lists` VALUES ('Bugard',58,383);
INSERT INTO `mob_skill_lists` VALUES ('Bugard',58,384);
INSERT INTO `mob_skill_lists` VALUES ('Bugard',58,385);
INSERT INTO `mob_skill_lists` VALUES ('Bugard',58,386);
INSERT INTO `mob_skill_lists` VALUES ('Bugard',58,387);
INSERT INTO `mob_skill_lists` VALUES ('Bugard',58,1363); -- hungry_crunch
INSERT INTO `mob_skill_lists` VALUES ('Bugbear',59,357); -- heavy_blow
INSERT INTO `mob_skill_lists` VALUES ('Bugbear',59,358); -- heavy_whisk
INSERT INTO `mob_skill_lists` VALUES ('Bugbear',59,359); -- bionic_boost
INSERT INTO `mob_skill_lists` VALUES ('Bugbear',59,360); -- flying_hip_press
INSERT INTO `mob_skill_lists` VALUES ('Bugbear',59,361); -- earth_shock
INSERT INTO `mob_skill_lists` VALUES ('CaitSith',60,2448);
INSERT INTO `mob_skill_lists` VALUES ('CaitSith',60,2449);
INSERT INTO `mob_skill_lists` VALUES ('CaitSith',60,2450);
INSERT INTO `mob_skill_lists` VALUES ('CaitSith',60,2451);
INSERT INTO `mob_skill_lists` VALUES ('CaitSith',60,2452);
INSERT INTO `mob_skill_lists` VALUES ('CaitSith',60,2453);
INSERT INTO `mob_skill_lists` VALUES ('CaitSith',60,2454);
INSERT INTO `mob_skill_lists` VALUES ('CaitSith',60,2455);
INSERT INTO `mob_skill_lists` VALUES ('CaitSith',60,2456);
INSERT INTO `mob_skill_lists` VALUES ('CaitSith',60,2457);
INSERT INTO `mob_skill_lists` VALUES ('Cardian',61,330);
INSERT INTO `mob_skill_lists` VALUES ('Cardian',61,333);
INSERT INTO `mob_skill_lists` VALUES ('Cardian',61,683);
INSERT INTO `mob_skill_lists` VALUES ('Cardian',61,684);
INSERT INTO `mob_skill_lists` VALUES ('Cerberus',62,1785);
INSERT INTO `mob_skill_lists` VALUES ('Cerberus',62,1786);
INSERT INTO `mob_skill_lists` VALUES ('Cerberus',62,1787);
INSERT INTO `mob_skill_lists` VALUES ('Cerberus',62,1788);
INSERT INTO `mob_skill_lists` VALUES ('Cerberus',62,1789);
INSERT INTO `mob_skill_lists` VALUES ('Cerberus',62,1790);
INSERT INTO `mob_skill_lists` VALUES ('Chariot',63,2054);
INSERT INTO `mob_skill_lists` VALUES ('Chariot',63,2055);
INSERT INTO `mob_skill_lists` VALUES ('Chariot',63,2056);
-- 64: Chigoe
INSERT INTO `mob_skill_lists` VALUES ('Clionid',65,2562);
INSERT INTO `mob_skill_lists` VALUES ('Clionid',65,2563);
INSERT INTO `mob_skill_lists` VALUES ('Clot',66,431);
INSERT INTO `mob_skill_lists` VALUES ('Clot',66,432);
INSERT INTO `mob_skill_lists` VALUES ('Clot',66,433);
-- 67: Clot
INSERT INTO `mob_skill_lists` VALUES ('Cluster',68,567);
INSERT INTO `mob_skill_lists` VALUES ('Cluster',68,568);
INSERT INTO `mob_skill_lists` VALUES ('Cluster',68,569);
INSERT INTO `mob_skill_lists` VALUES ('Cluster',68,570);
INSERT INTO `mob_skill_lists` VALUES ('Cluster',68,571);
INSERT INTO `mob_skill_lists` VALUES ('Cluster',68,572);
INSERT INTO `mob_skill_lists` VALUES ('Cluster',68,573);
-- INSERT INTO `mob_skill_lists` VALUES ('Cluster',68,574);
-- INSERT INTO `mob_skill_lists` VALUES ('Cluster',68,575);
INSERT INTO `mob_skill_lists` VALUES ('Cluster',69,567);
INSERT INTO `mob_skill_lists` VALUES ('Cluster',69,568);
INSERT INTO `mob_skill_lists` VALUES ('Cluster',69,569);
INSERT INTO `mob_skill_lists` VALUES ('Cluster',69,570);
-- INSERT INTO `mob_skill_lists` VALUES ('Cluster',69,571);
-- INSERT INTO `mob_skill_lists` VALUES ('Cluster',69,572);
-- INSERT INTO `mob_skill_lists` VALUES ('Cluster',69,573);
-- INSERT INTO `mob_skill_lists` VALUES ('Cluster',69,574);
-- INSERT INTO `mob_skill_lists` VALUES ('Cluster',69,575);
INSERT INTO `mob_skill_lists` VALUES ('Cockatrice',70,406);
INSERT INTO `mob_skill_lists` VALUES ('Cockatrice',70,407);
INSERT INTO `mob_skill_lists` VALUES ('Cockatrice',70,408);
INSERT INTO `mob_skill_lists` VALUES ('Cockatrice',70,410);
INSERT INTO `mob_skill_lists` VALUES ('Cockatrice',70,411);
INSERT INTO `mob_skill_lists` VALUES ('Coeurl',71,652);
INSERT INTO `mob_skill_lists` VALUES ('Coeurl',71,653);
INSERT INTO `mob_skill_lists` VALUES ('Colibri',72,1699);
INSERT INTO `mob_skill_lists` VALUES ('Colibri',72,1700);
INSERT INTO `mob_skill_lists` VALUES ('Colibri',72,1701);
INSERT INTO `mob_skill_lists` VALUES ('Myradrosh',73,1699);
INSERT INTO `mob_skill_lists` VALUES ('Myradrosh',73,1701);
INSERT INTO `mob_skill_lists` VALUES ('Corse',74,530);
INSERT INTO `mob_skill_lists` VALUES ('Corse',74,531);
INSERT INTO `mob_skill_lists` VALUES ('Corse',74,532);
INSERT INTO `mob_skill_lists` VALUES ('Corse',74,533);
INSERT INTO `mob_skill_lists` VALUES ('Crab',75,442);
INSERT INTO `mob_skill_lists` VALUES ('Crab',75,443);
INSERT INTO `mob_skill_lists` VALUES ('Crab',75,444);
INSERT INTO `mob_skill_lists` VALUES ('Crab',75,445);
INSERT INTO `mob_skill_lists` VALUES ('Crab',75,448);
INSERT INTO `mob_skill_lists` VALUES ('Crab',76,442);
INSERT INTO `mob_skill_lists` VALUES ('Crab',76,443);
INSERT INTO `mob_skill_lists` VALUES ('Crab',76,444);
INSERT INTO `mob_skill_lists` VALUES ('Crab',76,445);
INSERT INTO `mob_skill_lists` VALUES ('Crab',76,448);
INSERT INTO `mob_skill_lists` VALUES ('Crab',77,442);
INSERT INTO `mob_skill_lists` VALUES ('Crab',77,443);
INSERT INTO `mob_skill_lists` VALUES ('Crab',77,444);
INSERT INTO `mob_skill_lists` VALUES ('Crab',77,445);
INSERT INTO `mob_skill_lists` VALUES ('Crab',77,448);
INSERT INTO `mob_skill_lists` VALUES ('Craver',78,1229);
INSERT INTO `mob_skill_lists` VALUES ('Craver',78,1230);
INSERT INTO `mob_skill_lists` VALUES ('Craver',78,1231);
INSERT INTO `mob_skill_lists` VALUES ('Craver',78,1232);
INSERT INTO `mob_skill_lists` VALUES ('Craver',78,1233);
INSERT INTO `mob_skill_lists` VALUES ('Crawler',79,344);
INSERT INTO `mob_skill_lists` VALUES ('Crawler',79,345);
INSERT INTO `mob_skill_lists` VALUES ('Crawler',79,346);
INSERT INTO `mob_skill_lists` VALUES ('Dhalmel',80,280);
INSERT INTO `mob_skill_lists` VALUES ('Dhalmel',80,281);
INSERT INTO `mob_skill_lists` VALUES ('Dhalmel',80,284);
INSERT INTO `mob_skill_lists` VALUES ('Dhalmel',80,285);
INSERT INTO `mob_skill_lists` VALUES ('Dhalmel',80,286);
INSERT INTO `mob_skill_lists` VALUES ('Dhalmel',80,287);
INSERT INTO `mob_skill_lists` VALUES ('Diremite',81,362);
INSERT INTO `mob_skill_lists` VALUES ('Diremite',81,363);
INSERT INTO `mob_skill_lists` VALUES ('Diremite',81,364);
INSERT INTO `mob_skill_lists` VALUES ('Diremite',81,365);
INSERT INTO `mob_skill_lists` VALUES ('Djinn',82,2216);
INSERT INTO `mob_skill_lists` VALUES ('Djinn',82,2217);
INSERT INTO `mob_skill_lists` VALUES ('Djinn',82,2218);
INSERT INTO `mob_skill_lists` VALUES ('Djinn',82,2219);
INSERT INTO `mob_skill_lists` VALUES ('Djinn',82,2220);
INSERT INTO `mob_skill_lists` VALUES ('Doll',83,534);
INSERT INTO `mob_skill_lists` VALUES ('Doll',83,535);
INSERT INTO `mob_skill_lists` VALUES ('Doll',83,536);
INSERT INTO `mob_skill_lists` VALUES ('Doll',83,537);
INSERT INTO `mob_skill_lists` VALUES ('Doll',83,538);
INSERT INTO `mob_skill_lists` VALUES ('Doll',83,539);
INSERT INTO `mob_skill_lists` VALUES ('Doll',83,541);
INSERT INTO `mob_skill_lists` VALUES ('Doll',83,543);
INSERT INTO `mob_skill_lists` VALUES ('Doll',84,534);
INSERT INTO `mob_skill_lists` VALUES ('Doll',84,535);
INSERT INTO `mob_skill_lists` VALUES ('Doll',84,536);
INSERT INTO `mob_skill_lists` VALUES ('Doll',84,537);
INSERT INTO `mob_skill_lists` VALUES ('Doll',84,538);
INSERT INTO `mob_skill_lists` VALUES ('Doll',84,539);
INSERT INTO `mob_skill_lists` VALUES ('Doll',84,541);
INSERT INTO `mob_skill_lists` VALUES ('Doll',84,543);
INSERT INTO `mob_skill_lists` VALUES ('Doll',85,534);
INSERT INTO `mob_skill_lists` VALUES ('Doll',85,535);
INSERT INTO `mob_skill_lists` VALUES ('Doll',85,536);
INSERT INTO `mob_skill_lists` VALUES ('Doll',85,537);
INSERT INTO `mob_skill_lists` VALUES ('Doll',85,538);
INSERT INTO `mob_skill_lists` VALUES ('Doll',85,539);
INSERT INTO `mob_skill_lists` VALUES ('Doll',85,541);
INSERT INTO `mob_skill_lists` VALUES ('Doll',85,543);
INSERT INTO `mob_skill_lists` VALUES ('Doomed',86,486); -- whip_tongue
INSERT INTO `mob_skill_lists` VALUES ('Doomed',86,488); -- acid_breath
INSERT INTO `mob_skill_lists` VALUES ('Doomed',86,489); -- stinking_gas
INSERT INTO `mob_skill_lists` VALUES ('Doomed',86,490); -- undead_mold
INSERT INTO `mob_skill_lists` VALUES ('Doomed',86,491); -- call_of_the_grave
INSERT INTO `mob_skill_lists` VALUES ('Doomed',86,492); -- abyss_blast
INSERT INTO `mob_skill_lists` VALUES ('Dragon',87,642);
INSERT INTO `mob_skill_lists` VALUES ('Dragon',87,643);
INSERT INTO `mob_skill_lists` VALUES ('Dragon',87,644);
INSERT INTO `mob_skill_lists` VALUES ('Dragon',87,645);
INSERT INTO `mob_skill_lists` VALUES ('Dragon',87,646);
INSERT INTO `mob_skill_lists` VALUES ('Dragon',87,647);
INSERT INTO `mob_skill_lists` VALUES ('Dragon',87,648);
INSERT INTO `mob_skill_lists` VALUES ('Dragon',87,649);
INSERT INTO `mob_skill_lists` VALUES ('Dragon',87,650);
INSERT INTO `mob_skill_lists` VALUES ('Dragon',87,651);
INSERT INTO `mob_skill_lists` VALUES ('Bloody_Bones',88,478);
INSERT INTO `mob_skill_lists` VALUES ('Bloody_Bones',88,479);
INSERT INTO `mob_skill_lists` VALUES ('Bloody_Bones',88,484);
INSERT INTO `mob_skill_lists` VALUES ('Bloody_Bones',88,485);
INSERT INTO `mob_skill_lists` VALUES ('Bloody_Bones',88,1665); -- Marrow Drain
INSERT INTO `mob_skill_lists` VALUES ('Bloody_Bones',88,1795); -- Malediction
INSERT INTO `mob_skill_lists` VALUES ('Draugar',89,478);
INSERT INTO `mob_skill_lists` VALUES ('Draugar',89,479);
INSERT INTO `mob_skill_lists` VALUES ('Draugar',89,484);
INSERT INTO `mob_skill_lists` VALUES ('Draugar',89,485);
INSERT INTO `mob_skill_lists` VALUES ('Draugar',89,1665); -- Marrow Drain
INSERT INTO `mob_skill_lists` VALUES ('Draugar',89,1795); -- Malediction
INSERT INTO `mob_skill_lists` VALUES ('Dvergr',90,2113); -- hellsnap
INSERT INTO `mob_skill_lists` VALUES ('Dvergr',90,2114); -- hellclap
INSERT INTO `mob_skill_lists` VALUES ('Dvergr',90,2115); -- cackle
INSERT INTO `mob_skill_lists` VALUES ('Dvergr',90,2116); -- necrobane
INSERT INTO `mob_skill_lists` VALUES ('Dvergr',90,2117); -- necropurge
INSERT INTO `mob_skill_lists` VALUES ('Dvergr',90,2118); -- bilgestorm
INSERT INTO `mob_skill_lists` VALUES ('Dvergr',90,2119); -- thundris_shriek
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,594);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,596);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1171);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1172);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1173);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1174);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1718);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1720);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1723);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1743);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1745);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1746);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1758);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1759);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1922);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1923);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,1930);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,2041);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,2045);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,2113);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,2114);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,2116);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,2117);
INSERT INTO `mob_skill_lists` VALUES ('PandemoniumLamp',91,2119);
INSERT INTO `mob_skill_lists` VALUES ('DynamisStatue-Goblin',92,1114); -- seismostomp
INSERT INTO `mob_skill_lists` VALUES ('DynamisStatue-Goblin',92,1115); -- torpid_glare
INSERT INTO `mob_skill_lists` VALUES ('DynamisStatue-Orc',93,1110); -- seismostomp
INSERT INTO `mob_skill_lists` VALUES ('DynamisStatue-Orc',93,1111); -- numbing_glare
INSERT INTO `mob_skill_lists` VALUES ('DynamisStatue-Quadav',94,1112); -- seismostomp
INSERT INTO `mob_skill_lists` VALUES ('DynamisStatue-Quadav',94,1117); -- lead_breath
INSERT INTO `mob_skill_lists` VALUES ('DynamisStatue-Yagudo',95,1116); -- seismostomp
INSERT INTO `mob_skill_lists` VALUES ('DynamisStatue-Yagudo',95,1113); -- tormentful_glare
INSERT INTO `mob_skill_lists` VALUES ('Nandi',96,287);
INSERT INTO `mob_skill_lists` VALUES ('IceLizard',97,366);
INSERT INTO `mob_skill_lists` VALUES ('IceLizard',97,368);
INSERT INTO `mob_skill_lists` VALUES ('IceLizard',97,369);
INSERT INTO `mob_skill_lists` VALUES ('IceLizard',97,370);
INSERT INTO `mob_skill_lists` VALUES ('IceLizard',97,371);
INSERT INTO `mob_skill_lists` VALUES ('IceLizard',97,372);
INSERT INTO `mob_skill_lists` VALUES ('IceLizard',97,373);
INSERT INTO `mob_skill_lists` VALUES ('IceLizard',97,621);
INSERT INTO `mob_skill_lists` VALUES ('Eft',98,515);
INSERT INTO `mob_skill_lists` VALUES ('Eft',98,516);
INSERT INTO `mob_skill_lists` VALUES ('Eft',98,517);
INSERT INTO `mob_skill_lists` VALUES ('Eft',98,518);
INSERT INTO `mob_skill_lists` VALUES ('Eft',98,519);
-- 99 to 106: Elementals
INSERT INTO `mob_skill_lists` VALUES ('Eruca',107,344);
INSERT INTO `mob_skill_lists` VALUES ('Eruca',107,346);
INSERT INTO `mob_skill_lists` VALUES ('Eruca',107,1791);
INSERT INTO `mob_skill_lists` VALUES ('Eruca',108,344);
INSERT INTO `mob_skill_lists` VALUES ('Eruca',108,346);
INSERT INTO `mob_skill_lists` VALUES ('Eruca',108,1791);
INSERT INTO `mob_skill_lists` VALUES ('Euvhi',109,1447); -- vertical_cleave
INSERT INTO `mob_skill_lists` VALUES ('Euvhi',109,1448);
INSERT INTO `mob_skill_lists` VALUES ('Euvhi',109,1449);
INSERT INTO `mob_skill_lists` VALUES ('Euvhi',109,1450);
INSERT INTO `mob_skill_lists` VALUES ('Euvhi',109,1451);
INSERT INTO `mob_skill_lists` VALUES ('Euvhi',109,1452);
INSERT INTO `mob_skill_lists` VALUES ('Euvhi',109,1453); -- nutrient_aborption
INSERT INTO `mob_skill_lists` VALUES ('EvilWeapon',110,513);
INSERT INTO `mob_skill_lists` VALUES ('EvilWeapon',110,514);
INSERT INTO `mob_skill_lists` VALUES ('Konjac',111,433); -- digest
INSERT INTO `mob_skill_lists` VALUES ('Flan',112,1821);
INSERT INTO `mob_skill_lists` VALUES ('Flan',112,1822);
INSERT INTO `mob_skill_lists` VALUES ('Flan',112,1824);
-- INSERT INTO `mob_skill_lists` VALUES ('Flan',112,1826);
-- INSERT INTO `mob_skill_lists` VALUES ('Flan',112,1827);
INSERT INTO `mob_skill_lists` VALUES ('Fly',113,659);
INSERT INTO `mob_skill_lists` VALUES ('Fly',113,660);
INSERT INTO `mob_skill_lists` VALUES ('Flytrap',114,434);
INSERT INTO `mob_skill_lists` VALUES ('Flytrap',114,435);
INSERT INTO `mob_skill_lists` VALUES ('Flytrap',114,436);
INSERT INTO `mob_skill_lists` VALUES ('Fomor',115,246);
INSERT INTO `mob_skill_lists` VALUES ('Fomor',115,247);
INSERT INTO `mob_skill_lists` VALUES ('Fomor',115,248);
INSERT INTO `mob_skill_lists` VALUES ('Fomor',115,249);
INSERT INTO `mob_skill_lists` VALUES ('Fomor',115,250);
INSERT INTO `mob_skill_lists` VALUES ('Fomor',115,251);
INSERT INTO `mob_skill_lists` VALUES ('Fomor',115,252);
INSERT INTO `mob_skill_lists` VALUES ('Fomor',115,253);
INSERT INTO `mob_skill_lists` VALUES ('Funguar',116,308);
INSERT INTO `mob_skill_lists` VALUES ('Funguar',116,309);
INSERT INTO `mob_skill_lists` VALUES ('Funguar',116,310);
INSERT INTO `mob_skill_lists` VALUES ('Funguar',116,311);
INSERT INTO `mob_skill_lists` VALUES ('Funguar',116,312);
INSERT INTO `mob_skill_lists` VALUES ('Funguar',116,314);
INSERT INTO `mob_skill_lists` VALUES ('Funguar',116,315);
INSERT INTO `mob_skill_lists` VALUES ('Funguar',116,2208);
-- 117: Gruesome Gargouille
INSERT INTO `mob_skill_lists` VALUES ('Gargoyle',118,2421);
INSERT INTO `mob_skill_lists` VALUES ('Gargoyle',118,2422);
INSERT INTO `mob_skill_lists` VALUES ('Gargoyle',118,2423);
INSERT INTO `mob_skill_lists` VALUES ('Gargoyle',118,2424);
INSERT INTO `mob_skill_lists` VALUES ('Gargoyle',118,2425);
INSERT INTO `mob_skill_lists` VALUES ('Gargoyle',118,2426);
INSERT INTO `mob_skill_lists` VALUES ('Magnotaur',119,498); -- triclip
INSERT INTO `mob_skill_lists` VALUES ('Magnotaur',119,499); -- back_swish
INSERT INTO `mob_skill_lists` VALUES ('Gear',120,2038);
INSERT INTO `mob_skill_lists` VALUES ('Gear',120,2039);
INSERT INTO `mob_skill_lists` VALUES ('Gear',120,2040);
INSERT INTO `mob_skill_lists` VALUES ('Gear',120,2041);
INSERT INTO `mob_skill_lists` VALUES ('Ghost',121,472);
INSERT INTO `mob_skill_lists` VALUES ('Ghost',121,473);
INSERT INTO `mob_skill_lists` VALUES ('Ghost',121,474);
INSERT INTO `mob_skill_lists` VALUES ('Ghost',121,475);
INSERT INTO `mob_skill_lists` VALUES ('Ghost',121,476);
INSERT INTO `mob_skill_lists` VALUES ('Ghost',121,477);
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',122,1441); -- actinic_burst
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',122,1442); -- Core Meltdown
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',122,1443);
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',122,1444);
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',122,1445);
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',122,1446); -- sickle_slash
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',123,1441);
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',123,1443);
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',123,1444);
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',123,1445);
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',123,1446);
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',124,1441);
INSERT INTO `mob_skill_lists` VALUES ('Ghrah',124,1444);
INSERT INTO `mob_skill_lists` VALUES ('GiantBird',125,399); -- Scratch
INSERT INTO `mob_skill_lists` VALUES ('GiantBird',125,400); -- Triple Attack
INSERT INTO `mob_skill_lists` VALUES ('GiantBird',125,401); -- Gliding Spike
INSERT INTO `mob_skill_lists` VALUES ('GiantBird',125,402); -- Feather Barrier
INSERT INTO `mob_skill_lists` VALUES ('GiantBird',125,403); -- Stormwind
INSERT INTO `mob_skill_lists` VALUES ('Gigas',126,662);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',126,663);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',126,664);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',126,665);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',126,666);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',126,667);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',127,662);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',127,663);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',127,664);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',127,665);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',127,666);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',127,667);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',128,662);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',128,663);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',128,664);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',128,665);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',128,666);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',128,667);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',129,662);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',129,663);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',129,664);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',129,665);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',129,666);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',129,667);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',130,662);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',130,663);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',130,664);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',130,665);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',130,666);
INSERT INTO `mob_skill_lists` VALUES ('Gigas',130,667);
INSERT INTO `mob_skill_lists` VALUES ('Gnat',131,2158);
INSERT INTO `mob_skill_lists` VALUES ('Gnat',131,2159);
INSERT INTO `mob_skill_lists` VALUES ('Gnat',131,2160);
INSERT INTO `mob_skill_lists` VALUES ('Gnat',131,2161);
INSERT INTO `mob_skill_lists` VALUES ('Gnat',131,2162); -- emetic_discharge
INSERT INTO `mob_skill_lists` VALUES ('Gnole',132,2170); -- fevered_pitch
INSERT INTO `mob_skill_lists` VALUES ('Gnole',132,2171); -- call_of_the_moon
INSERT INTO `mob_skill_lists` VALUES ('Gnole',132,2172); -- call_of_the_moon_down 4 legs
INSERT INTO `mob_skill_lists` VALUES ('Gnole',132,2173); -- plenilune_embrace
INSERT INTO `mob_skill_lists` VALUES ('Gnole',132,2174); -- plenilune_embrace_down 4 legs
INSERT INTO `mob_skill_lists` VALUES ('Gnole',132,2175); -- nox_blast
INSERT INTO `mob_skill_lists` VALUES ('Gnole',132,2176); -- asuran_claws
INSERT INTO `mob_skill_lists` VALUES ('Gnole',132,2177); -- cacophony
INSERT INTO `mob_skill_lists` VALUES ('Goblin',133,590);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',133,591);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',133,592);
INSERT INTO `mob_skill_lists` VALUES ('God',134,1491);
INSERT INTO `mob_skill_lists` VALUES ('God',134,1492);
INSERT INTO `mob_skill_lists` VALUES ('God',134,1493);
INSERT INTO `mob_skill_lists` VALUES ('God',134,1494);
INSERT INTO `mob_skill_lists` VALUES ('God',134,1495);
INSERT INTO `mob_skill_lists` VALUES ('God',134,1496);
INSERT INTO `mob_skill_lists` VALUES ('God',134,1497);
INSERT INTO `mob_skill_lists` VALUES ('God',134,1498);
INSERT INTO `mob_skill_lists` VALUES ('God',134,1499);
INSERT INTO `mob_skill_lists` VALUES ('Golem',135,674);
INSERT INTO `mob_skill_lists` VALUES ('Golem',135,675); -- heavy_strike
INSERT INTO `mob_skill_lists` VALUES ('Golem',135,676);
INSERT INTO `mob_skill_lists` VALUES ('Golem',135,677);
INSERT INTO `mob_skill_lists` VALUES ('Golem',135,678);
INSERT INTO `mob_skill_lists` VALUES ('Golem',135,679);
INSERT INTO `mob_skill_lists` VALUES ('Golem',135,680);
INSERT INTO `mob_skill_lists` VALUES ('Golem',135,681);
INSERT INTO `mob_skill_lists` VALUES ('Golem',135,682);
INSERT INTO `mob_skill_lists` VALUES ('Goobbue',136,581);
INSERT INTO `mob_skill_lists` VALUES ('Goobbue',136,583);
INSERT INTO `mob_skill_lists` VALUES ('Goobbue',136,584);
INSERT INTO `mob_skill_lists` VALUES ('Goobbue',136,586);
INSERT INTO `mob_skill_lists` VALUES ('Goobbue',136,587);
INSERT INTO `mob_skill_lists` VALUES ('Gorger',137,741);
INSERT INTO `mob_skill_lists` VALUES ('Gorger',137,744);
INSERT INTO `mob_skill_lists` VALUES ('Gorger',137,747);
INSERT INTO `mob_skill_lists` VALUES ('Gorger',137,750);
INSERT INTO `mob_skill_lists` VALUES ('Gorger',137,752);
INSERT INTO `mob_skill_lists` VALUES ('Gorger_NM',138,742); -- quadratic_continuum
INSERT INTO `mob_skill_lists` VALUES ('Gorger_NM',138,745); -- spirit_absorption
INSERT INTO `mob_skill_lists` VALUES ('Gorger_NM',138,748); -- vanity_drive
INSERT INTO `mob_skill_lists` VALUES ('Gorger_NM',138,750); -- stygian_flatus
INSERT INTO `mob_skill_lists` VALUES ('Gorger_NM',138,753); -- promyvion_barrier
INSERT INTO `mob_skill_lists` VALUES ('Gorger_NM',138,755); -- fission
INSERT INTO `mob_skill_lists` VALUES ('Hecteyes-COP',139,437);	-- COP
INSERT INTO `mob_skill_lists` VALUES ('Hecteyes-COP',139,438);
INSERT INTO `mob_skill_lists` VALUES ('Hecteyes-COP',139,439);
INSERT INTO `mob_skill_lists` VALUES ('Hecteyes-COP',139,440);
INSERT INTO `mob_skill_lists` VALUES ('Hippogryph',140,576); -- back_heel
INSERT INTO `mob_skill_lists` VALUES ('Hippogryph',140,578); -- nihility_song
INSERT INTO `mob_skill_lists` VALUES ('Hippogryph',140,579); -- choke_breath
INSERT INTO `mob_skill_lists` VALUES ('Hippogryph',140,580); -- fantod
INSERT INTO `mob_skill_lists` VALUES ('Hippogryph',140,2828); -- jettatura
INSERT INTO `mob_skill_lists` VALUES ('Hippogryph',141,576); -- back_heel
INSERT INTO `mob_skill_lists` VALUES ('Hippogryph',141,578); -- nihility_song
INSERT INTO `mob_skill_lists` VALUES ('Hippogryph',141,579); -- choke_breath
INSERT INTO `mob_skill_lists` VALUES ('Hippogryph',141,580); -- fantod
INSERT INTO `mob_skill_lists` VALUES ('Hippogryph',141,1330); -- hoof_volley
INSERT INTO `mob_skill_lists` VALUES ('Hippogryph',141,2828); -- jettatura
INSERT INTO `mob_skill_lists` VALUES ('Hound',142,465);
INSERT INTO `mob_skill_lists` VALUES ('Hound',142,466);
INSERT INTO `mob_skill_lists` VALUES ('Hound',142,467);
INSERT INTO `mob_skill_lists` VALUES ('Hound',142,468);
INSERT INTO `mob_skill_lists` VALUES ('Hound',142,469);
INSERT INTO `mob_skill_lists` VALUES ('Hound',142,470);
INSERT INTO `mob_skill_lists` VALUES ('Hound',143,465);
INSERT INTO `mob_skill_lists` VALUES ('Hound',143,466);
INSERT INTO `mob_skill_lists` VALUES ('Hound',143,467);
INSERT INTO `mob_skill_lists` VALUES ('Hound',143,468);
INSERT INTO `mob_skill_lists` VALUES ('Hound',143,469);
INSERT INTO `mob_skill_lists` VALUES ('Hound',143,470);
INSERT INTO `mob_skill_lists` VALUES ('Hpemde',144,1365); -- tail_thrust
INSERT INTO `mob_skill_lists` VALUES ('Hpemde',144,1366);
INSERT INTO `mob_skill_lists` VALUES ('Hpemde',144,1367);
INSERT INTO `mob_skill_lists` VALUES ('Hpemde',144,1368);
INSERT INTO `mob_skill_lists` VALUES ('Hpemde',144,1369); -- ichor_stream
INSERT INTO `mob_skill_lists` VALUES ('Scylla',145,2435); -- severing_fang
INSERT INTO `mob_skill_lists` VALUES ('Scylla',145,2436); -- zero_smash
INSERT INTO `mob_skill_lists` VALUES ('Scylla',145,2438); -- frozen_mist
INSERT INTO `mob_skill_lists` VALUES ('Scylla',145,2439); -- hydro_wave
INSERT INTO `mob_skill_lists` VALUES ('Gowam',146,33); -- burning blade
INSERT INTO `mob_skill_lists` VALUES ('Gowam',146,35); -- flat balde
INSERT INTO `mob_skill_lists` VALUES ('Gowam',146,36); -- shinning blade
INSERT INTO `mob_skill_lists` VALUES ('Gowam',146,37); -- sereph blade
INSERT INTO `mob_skill_lists` VALUES ('Gowam',146,38); -- circle blade
INSERT INTO `mob_skill_lists` VALUES ('Gowam',146,40); -- vorpal blade
-- 147: Humanoid-Galka
INSERT INTO `mob_skill_lists` VALUES ('Warabouc',148,383); -- tusk
INSERT INTO `mob_skill_lists` VALUES ('Warabouc',148,385); -- bone_crunch
INSERT INTO `mob_skill_lists` VALUES ('Humanoid-Hume',149,1390);
INSERT INTO `mob_skill_lists` VALUES ('Humanoid-Hume',149,1391);
INSERT INTO `mob_skill_lists` VALUES ('Humanoid-Hume',149,1392);
INSERT INTO `mob_skill_lists` VALUES ('Humanoid-Hume',149,1393);
INSERT INTO `mob_skill_lists` VALUES ('Humanoid-Hume',149,1394);
INSERT INTO `mob_skill_lists` VALUES ('Humanoid-Hume',149,1395);
INSERT INTO `mob_skill_lists` VALUES ('Humanoid-Hume',149,1397);
-- INSERT INTO `mob_skill_lists` VALUES ('Humanoid-Hume',149,1398);
INSERT INTO `mob_skill_lists` VALUES ('Humanoid-Hume',149,1399);
INSERT INTO `mob_skill_lists` VALUES ('Gears3',150,2043); -- artificial_gravity_3
INSERT INTO `mob_skill_lists` VALUES ('Gears3',150,2044); -- antigravity_3
INSERT INTO `mob_skill_lists` VALUES ('Gears3',150,2045); -- rail_cannon_3
INSERT INTO `mob_skill_lists` VALUES ('Gears3',150,2052); -- restoral
INSERT INTO `mob_skill_lists` VALUES ('Gears3',150,2053); -- heavy_armature
INSERT INTO `mob_skill_lists` VALUES ('Gears2',151,2046);
INSERT INTO `mob_skill_lists` VALUES ('Gears2',151,2047);
INSERT INTO `mob_skill_lists` VALUES ('Gears2',151,2048);
INSERT INTO `mob_skill_lists` VALUES ('Gears2',151,2053);
INSERT INTO `mob_skill_lists` VALUES ('Gears2',151,2061);
INSERT INTO `mob_skill_lists` VALUES ('Gears1',152,2049);
INSERT INTO `mob_skill_lists` VALUES ('Gears1',152,2050);
INSERT INTO `mob_skill_lists` VALUES ('Gears1',152,2051);
INSERT INTO `mob_skill_lists` VALUES ('Gears1',152,2053);
INSERT INTO `mob_skill_lists` VALUES ('Gears1',152,2062);
INSERT INTO `mob_skill_lists` VALUES ('Shamarhaan',153,3);
INSERT INTO `mob_skill_lists` VALUES ('Shamarhaan',153,4);
INSERT INTO `mob_skill_lists` VALUES ('Shamarhaan',153,5);
INSERT INTO `mob_skill_lists` VALUES ('Shamarhaan',153,6);
INSERT INTO `mob_skill_lists` VALUES ('Shamarhaan',153,7);
-- 154 random mobs?
INSERT INTO `mob_skill_lists` VALUES ('Asterion_50',155,499); -- back_swish
INSERT INTO `mob_skill_lists` VALUES ('Asterion_50',155,501); -- frightful_roar
INSERT INTO `mob_skill_lists` VALUES ('Asterion_0',156,499); -- back_swish
INSERT INTO `mob_skill_lists` VALUES ('Asterion_0',156,500); -- mow
INSERT INTO `mob_skill_lists` VALUES ('Asterion_0',156,501); -- frightful_roar
INSERT INTO `mob_skill_lists` VALUES ('Asterion_0',156,502); -- mortal_ray
INSERT INTO `mob_skill_lists` VALUES ('Toadcushion',157,310); -- queasyshroom
INSERT INTO `mob_skill_lists` VALUES ('Toadcushion',157,311); -- numbshroom
INSERT INTO `mob_skill_lists` VALUES ('Toadcushion',157,312); -- shakeshroom
INSERT INTO `mob_skill_lists` VALUES ('Toadcushion',157,315); -- dark_spore
INSERT INTO `mob_skill_lists` VALUES ('Toadsquab',158,309); -- spore
INSERT INTO `mob_skill_lists` VALUES ('Toadsquab',158,310); -- queasyshroom
INSERT INTO `mob_skill_lists` VALUES ('Toadsquab',158,311); -- numbshroom
INSERT INTO `mob_skill_lists` VALUES ('Toadsquab',158,312); -- shakeshroom
INSERT INTO `mob_skill_lists` VALUES ('Toadpillow',159,308); -- frogkick
INSERT INTO `mob_skill_lists` VALUES ('Toadpillow',159,310); -- queasyshroom
INSERT INTO `mob_skill_lists` VALUES ('Toadpillow',159,311); -- numbshroom
INSERT INTO `mob_skill_lists` VALUES ('Toadpillow',159,312); -- shakeshroom
INSERT INTO `mob_skill_lists` VALUES ('Toadbolster',160,310); -- queasyshroom
INSERT INTO `mob_skill_lists` VALUES ('Toadbolster',160,311); -- numbshroom
INSERT INTO `mob_skill_lists` VALUES ('Toadbolster',160,312); -- shakeshroom
INSERT INTO `mob_skill_lists` VALUES ('Toadbolster',160,314); -- silence_gas
INSERT INTO `mob_skill_lists` VALUES ('Coeurl_CoP',161,480); -- petrifactive_breath
INSERT INTO `mob_skill_lists` VALUES ('Coeurl_CoP',161,482); -- pounce
INSERT INTO `mob_skill_lists` VALUES ('Coeurl_CoP',161,652); -- blaster
INSERT INTO `mob_skill_lists` VALUES ('Coeurl_CoP',161,653); -- chaotic_eye
INSERT INTO `mob_skill_lists` VALUES ('Coeurl_CoP',161,1336); -- frenzied_rage
INSERT INTO `mob_skill_lists` VALUES ('Coeurl_CoP',161,483); -- charged_whisker
INSERT INTO `mob_skill_lists` VALUES ('Coeurl_WoTG',162,652); -- blaster
INSERT INTO `mob_skill_lists` VALUES ('Coeurl_WoTG',162,653); -- chaotic_eye
INSERT INTO `mob_skill_lists` VALUES ('Coeurl_WoTG',162,483); -- charged_whisker
INSERT INTO `mob_skill_lists` VALUES ('Striking_Bull',163,69); -- Rampage
INSERT INTO `mob_skill_lists` VALUES ('Striking_Bull',163,70); -- Calamity
INSERT INTO `mob_skill_lists` VALUES ('Striking_Bull',163,71); -- Mistral Axe
INSERT INTO `mob_skill_lists` VALUES ('Striking_Bull',163,72); -- Decimnation
INSERT INTO `mob_skill_lists` VALUES ('Hydra',164,1828);
INSERT INTO `mob_skill_lists` VALUES ('Hydra',164,1829);
INSERT INTO `mob_skill_lists` VALUES ('Hydra',164,1830);
INSERT INTO `mob_skill_lists` VALUES ('Hydra',164,1831);
INSERT INTO `mob_skill_lists` VALUES ('Hydra',164,1832);
INSERT INTO `mob_skill_lists` VALUES ('Hydra',164,1834);
INSERT INTO `mob_skill_lists` VALUES ('Hydra',164,1835);
INSERT INTO `mob_skill_lists` VALUES ('Hydra',164,1836);
INSERT INTO `mob_skill_lists` VALUES ('Imp',165,1709);
INSERT INTO `mob_skill_lists` VALUES ('Imp',165,1710);
INSERT INTO `mob_skill_lists` VALUES ('Imp',165,1711);
INSERT INTO `mob_skill_lists` VALUES ('Imp',166,1709);
INSERT INTO `mob_skill_lists` VALUES ('Imp',166,1710);
INSERT INTO `mob_skill_lists` VALUES ('Imp',166,1711);
INSERT INTO `mob_skill_lists` VALUES ('Karakul',167,260);
INSERT INTO `mob_skill_lists` VALUES ('Karakul',167,261);
INSERT INTO `mob_skill_lists` VALUES ('Karakul',167,262);
INSERT INTO `mob_skill_lists` VALUES ('Karakul',167,264);
INSERT INTO `mob_skill_lists` VALUES ('Karakul',167,1837);
INSERT INTO `mob_skill_lists` VALUES ('Khimaira',168,2022);
INSERT INTO `mob_skill_lists` VALUES ('Khimaira',168,2023);
INSERT INTO `mob_skill_lists` VALUES ('Khimaira',168,2024);
INSERT INTO `mob_skill_lists` VALUES ('Khimaira',168,2025);
INSERT INTO `mob_skill_lists` VALUES ('Khimaira',168,2026);
INSERT INTO `mob_skill_lists` VALUES ('Khimaira',168,2027);
INSERT INTO `mob_skill_lists` VALUES ('Khimaira',168,2028);
-- INSERT INTO `mob_skill_lists` VALUES ('Khimaira',168,2698);
INSERT INTO `mob_skill_lists` VALUES ('Kindred',169,559);
INSERT INTO `mob_skill_lists` VALUES ('Kindred',169,560);
INSERT INTO `mob_skill_lists` VALUES ('Kindred',169,563);
INSERT INTO `mob_skill_lists` VALUES ('Kindred',169,1148);
INSERT INTO `mob_skill_lists` VALUES ('Ladybug',170,2178); -- sudden_lunge
INSERT INTO `mob_skill_lists` VALUES ('Ladybug',170,2179); -- noisome_powder
INSERT INTO `mob_skill_lists` VALUES ('Ladybug',170,2180); -- nepenthean_hum
INSERT INTO `mob_skill_lists` VALUES ('Ladybug',170,2181); -- spiral_spin
INSERT INTO `mob_skill_lists` VALUES ('Ladybug',170,2182); -- spiral_burst 
INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1752); -- gusting_gouge
INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1753); -- hysteric_barrage
INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1754); -- dukkeripen_heal
INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1755); -- dukkeripen_shadow
INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1756); -- dukkeripen_para
-- INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1756); -- dukkeripen
-- INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1757); -- dukkeripen
INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1758); -- tail_slap
INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1759); -- hypnotic_sway
INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1761); -- arrow_deluge
-- INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1809); -- pw_shadow_thrust
-- INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1811); -- ?
-- INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1812); -- pw_pinning_shot
-- INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1813); -- pw_calcifying_deluge
-- INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1814); -- pw_gorgon_dance
INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1762); -- belly_dance
INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1929); -- pole_swing
INSERT INTO `mob_skill_lists` VALUES ('Lamiae',171,1930); -- tidal_slash
INSERT INTO `mob_skill_lists` VALUES ('Leech',172,414);
INSERT INTO `mob_skill_lists` VALUES ('Leech',172,415);
INSERT INTO `mob_skill_lists` VALUES ('Leech',172,416);
INSERT INTO `mob_skill_lists` VALUES ('Leech',172,417);
INSERT INTO `mob_skill_lists` VALUES ('Leech',172,418);
INSERT INTO `mob_skill_lists` VALUES ('Leech',172,420);
INSERT INTO `mob_skill_lists` VALUES ('Leech',172,421);
INSERT INTO `mob_skill_lists` VALUES ('Leech',172,423);
INSERT INTO `mob_skill_lists` VALUES ('Limule',173,2564);
INSERT INTO `mob_skill_lists` VALUES ('Limule',173,2565);
INSERT INTO `mob_skill_lists` VALUES ('Lizard',174,366);
INSERT INTO `mob_skill_lists` VALUES ('Lizard',174,367);
INSERT INTO `mob_skill_lists` VALUES ('Lizard',174,368);
INSERT INTO `mob_skill_lists` VALUES ('Lizard',174,369);
INSERT INTO `mob_skill_lists` VALUES ('Lizard',174,370);
INSERT INTO `mob_skill_lists` VALUES ('Lizard',174,371);
INSERT INTO `mob_skill_lists` VALUES ('Lizard',174,372);
INSERT INTO `mob_skill_lists` VALUES ('Lizard',174,373);
INSERT INTO `mob_skill_lists` VALUES ('MagicPot',175,520);
INSERT INTO `mob_skill_lists` VALUES ('MagicPot',175,521);
INSERT INTO `mob_skill_lists` VALUES ('MagicPot',175,522);
INSERT INTO `mob_skill_lists` VALUES ('MagicPot',175,523);
INSERT INTO `mob_skill_lists` VALUES ('MagicPot',175,524);
INSERT INTO `mob_skill_lists` VALUES ('MagicPot',175,525);
INSERT INTO `mob_skill_lists` VALUES ('MamoolJa',176,1731); -- forceful_blow
INSERT INTO `mob_skill_lists` VALUES ('MamoolJa',176,1732); -- somersault_kick(melee)
INSERT INTO `mob_skill_lists` VALUES ('MamoolJa',176,1733); -- firespit(physical)
INSERT INTO `mob_skill_lists` VALUES ('MamoolJa',176,1734); -- warm up
-- INSERT INTO `mob_skill_lists` VALUES ('MamoolJa',176,1735);
-- INSERT INTO `mob_skill_lists` VALUES ('MamoolJa',176,1736);
INSERT INTO `mob_skill_lists` VALUES ('MamoolJa',176,1737); -- Vorpal Blade | BLU
INSERT INTO `mob_skill_lists` VALUES ('MamoolJa',176,1738); -- Groundburst(NM only)
INSERT INTO `mob_skill_lists` VALUES ('MamoolJa',176,1839); -- rushing_slash | slashing weapons
INSERT INTO `mob_skill_lists` VALUES ('MamoolJa',176,1840); -- rushing_stab | Piercing weapons
INSERT INTO `mob_skill_lists` VALUES ('Mamool_Ja_Knight',177,2094); -- fire_angon
INSERT INTO `mob_skill_lists` VALUES ('Mamool_Ja_Knight',177,2095); -- batterhorn
INSERT INTO `mob_skill_lists` VALUES ('Mamool_Ja_Knight',177,2096); -- clobber
INSERT INTO `mob_skill_lists` VALUES ('Mamool_Ja_Knight',177,2097); -- granite_skin
INSERT INTO `mob_skill_lists` VALUES ('Mamool_Ja_Knight',177,2098); -- blazing_angon
INSERT INTO `mob_skill_lists` VALUES ('Mamool_Ja_Knight',177,2101); -- demoralizing_roar
INSERT INTO `mob_skill_lists` VALUES ('Mamool_Ja_Knight',177,2102); -- boiling_blood
INSERT INTO `mob_skill_lists` VALUES ('Mandragora',178,300);
INSERT INTO `mob_skill_lists` VALUES ('Mandragora',178,301);
INSERT INTO `mob_skill_lists` VALUES ('Mandragora',178,302);
INSERT INTO `mob_skill_lists` VALUES ('Mandragora',178,304);
INSERT INTO `mob_skill_lists` VALUES ('Mandragora',178,305);
INSERT INTO `mob_skill_lists` VALUES ('Mandragora',178,306);
INSERT INTO `mob_skill_lists` VALUES ('Manticore',179,797);
INSERT INTO `mob_skill_lists` VALUES ('Manticore',179,798);
INSERT INTO `mob_skill_lists` VALUES ('Manticore',179,799);
INSERT INTO `mob_skill_lists` VALUES ('Manticore',179,800);
INSERT INTO `mob_skill_lists` VALUES ('Manticore',179,801);
INSERT INTO `mob_skill_lists` VALUES ('Manticore',179,802);
INSERT INTO `mob_skill_lists` VALUES ('Manticore',179,803);
INSERT INTO `mob_skill_lists` VALUES ('Marid',180,1703);
INSERT INTO `mob_skill_lists` VALUES ('Marid',180,1704);
INSERT INTO `mob_skill_lists` VALUES ('Marid',180,1705);
INSERT INTO `mob_skill_lists` VALUES ('Marid',180,1706);
INSERT INTO `mob_skill_lists` VALUES ('Marid',180,1707);
INSERT INTO `mob_skill_lists` VALUES ('Marid',180,1708);
INSERT INTO `mob_skill_lists` VALUES ('MemoryReceptacle',181,542);
INSERT INTO `mob_skill_lists` VALUES ('Merrow',182,1765); -- Gusting Gouge
INSERT INTO `mob_skill_lists` VALUES ('Merrow',182,1766); -- Hysteric Barrage
INSERT INTO `mob_skill_lists` VALUES ('Merrow',182,1768); -- Dukkeripen Shadows
INSERT INTO `mob_skill_lists` VALUES ('Merrow',182,1769); -- Dukkeripen Paralyze
INSERT INTO `mob_skill_lists` VALUES ('Merrow',182,1770); -- Dukkeripen Heal
INSERT INTO `mob_skill_lists` VALUES ('Merrow',182,1771); -- Tail Slap
INSERT INTO `mob_skill_lists` VALUES ('Merrow',182,1772); -- Torrent
INSERT INTO `mob_skill_lists` VALUES ('Merrow',182,1775); -- Rising Swell
INSERT INTO `mob_skill_lists` VALUES ('Merrow',182,1930); -- Tidal Slash
INSERT INTO `mob_skill_lists` VALUES ('Mimic',183,588);
INSERT INTO `mob_skill_lists` VALUES ('Moblin',184,1081);
INSERT INTO `mob_skill_lists` VALUES ('Moblin',184,1082);
INSERT INTO `mob_skill_lists` VALUES ('Moblin',184,1083);
INSERT INTO `mob_skill_lists` VALUES ('Moblin',184,1084);
INSERT INTO `mob_skill_lists` VALUES ('Moblin',184,1085);
INSERT INTO `mob_skill_lists` VALUES ('Moblin',184,1086);
INSERT INTO `mob_skill_lists` VALUES ('Moblin',184,1087);
INSERT INTO `mob_skill_lists` VALUES ('Moblin',184,1088);
-- 185: Moogle
INSERT INTO `mob_skill_lists` VALUES ('Morbol',186,316);
INSERT INTO `mob_skill_lists` VALUES ('Morbol',186,317);
INSERT INTO `mob_skill_lists` VALUES ('Morbol',186,319);
INSERT INTO `mob_skill_lists` VALUES ('Morbol',186,320);
-- INSERT INTO `mob_skill_lists` VALUES ('Morbol',186,726);
INSERT INTO `mob_skill_lists` VALUES ('Murex',187,2629);
-- INSERT INTO `mob_skill_lists` VALUES ('Murex',187,2630);
INSERT INTO `mob_skill_lists` VALUES ('Opo-opo',188,288);
INSERT INTO `mob_skill_lists` VALUES ('Opo-opo',188,290);
INSERT INTO `mob_skill_lists` VALUES ('Opo-opo',188,291);
INSERT INTO `mob_skill_lists` VALUES ('Opo-opo',188,289);
INSERT INTO `mob_skill_lists` VALUES ('Opo-opo',188,292);
INSERT INTO `mob_skill_lists` VALUES ('Opo-opo',188,294);
INSERT INTO `mob_skill_lists` VALUES ('Opo-opo',188,295);
INSERT INTO `mob_skill_lists` VALUES ('Orc',189,605);
INSERT INTO `mob_skill_lists` VALUES ('Orc',189,606);
INSERT INTO `mob_skill_lists` VALUES ('Orc',189,607);
INSERT INTO `mob_skill_lists` VALUES ('Orc',189,608);
INSERT INTO `mob_skill_lists` VALUES ('Orc',189,609);
INSERT INTO `mob_skill_lists` VALUES ('Orc',189,766);
INSERT INTO `mob_skill_lists` VALUES ('OrcishWarmachine',190,635);
INSERT INTO `mob_skill_lists` VALUES ('OrcishWarmachine',190,636);
INSERT INTO `mob_skill_lists` VALUES ('OrcishWarmachine',190,637);
INSERT INTO `mob_skill_lists` VALUES ('OrcishWarmachine',190,638);
INSERT INTO `mob_skill_lists` VALUES ('OrcishWarmachine',190,639);
INSERT INTO `mob_skill_lists` VALUES ('Orobon',191,1693); -- gnash
INSERT INTO `mob_skill_lists` VALUES ('Orobon',191,1694); -- vile_belch
INSERT INTO `mob_skill_lists` VALUES ('Orobon',191,1695); -- hypnic_lamp
INSERT INTO `mob_skill_lists` VALUES ('Orobon',191,1696); -- seismic_tail
INSERT INTO `mob_skill_lists` VALUES ('Orobon',191,1697); -- seaspray
INSERT INTO `mob_skill_lists` VALUES ('Peiste',192,2152); -- aqua_fortis
INSERT INTO `mob_skill_lists` VALUES ('Peiste',192,2153); -- regurgitation
INSERT INTO `mob_skill_lists` VALUES ('Peiste',192,2154); -- delta_thrust
INSERT INTO `mob_skill_lists` VALUES ('Peiste',192,2155); -- torpefying_charge
INSERT INTO `mob_skill_lists` VALUES ('Peiste',192,2156); -- grim_glower
INSERT INTO `mob_skill_lists` VALUES ('Peiste',192,2157); -- calcifying_mist
INSERT INTO `mob_skill_lists` VALUES ('PetWyvern',193,894);
INSERT INTO `mob_skill_lists` VALUES ('PetWyvern',193,895);
INSERT INTO `mob_skill_lists` VALUES ('PetWyvern',193,896);
INSERT INTO `mob_skill_lists` VALUES ('PetWyvern',193,897);
INSERT INTO `mob_skill_lists` VALUES ('PetWyvern',193,898);
INSERT INTO `mob_skill_lists` VALUES ('PetWyvern',193,899);
INSERT INTO `mob_skill_lists` VALUES ('PetWyvern',193,900);
INSERT INTO `mob_skill_lists` VALUES ('PetWyvern',193,901);
INSERT INTO `mob_skill_lists` VALUES ('PetWyvern',193,902);
INSERT INTO `mob_skill_lists` VALUES ('PetWyvern',193,903);
INSERT INTO `mob_skill_lists` VALUES ('PetWyvern',193,904);
INSERT INTO `mob_skill_lists` VALUES ('PetWyvern',193,905);
INSERT INTO `mob_skill_lists` VALUES ('Phuabo',194,1353); -- aerial_collision
INSERT INTO `mob_skill_lists` VALUES ('Phuabo',194,1354);
INSERT INTO `mob_skill_lists` VALUES ('Phuabo',194,1355);
INSERT INTO `mob_skill_lists` VALUES ('Phuabo',194,1356);
INSERT INTO `mob_skill_lists` VALUES ('Phuabo',194,1357);
INSERT INTO `mob_skill_lists` VALUES ('Phuabo',194,1358); -- plasma_charge
INSERT INTO `mob_skill_lists` VALUES ('Pixie',195,2193); -- zephyr_arrow
INSERT INTO `mob_skill_lists` VALUES ('Pixie',195,2194); -- lethe_arrows
INSERT INTO `mob_skill_lists` VALUES ('Pixie',195,2195); -- spring_breeze
INSERT INTO `mob_skill_lists` VALUES ('Pixie',195,2196); -- summer_breeze
INSERT INTO `mob_skill_lists` VALUES ('Pixie',195,2197); -- autumn_breeze
INSERT INTO `mob_skill_lists` VALUES ('Pixie',195,2198); -- winter_breeze
INSERT INTO `mob_skill_lists` VALUES ('Pixie',195,2199); -- cyclonic_turmoil
INSERT INTO `mob_skill_lists` VALUES ('Pixie',195,2200); -- cyclonic_torrent
INSERT INTO `mob_skill_lists` VALUES ('Poroggo',196,1957);
INSERT INTO `mob_skill_lists` VALUES ('Poroggo',196,1958);
INSERT INTO `mob_skill_lists` VALUES ('Poroggo',196,1959);
INSERT INTO `mob_skill_lists` VALUES ('Poroggo',196,1960);
INSERT INTO `mob_skill_lists` VALUES ('Poroggo',196,1961);
INSERT INTO `mob_skill_lists` VALUES ('Poroggo',196,1962);
INSERT INTO `mob_skill_lists` VALUES ('Pugil',197,449);
INSERT INTO `mob_skill_lists` VALUES ('Pugil',197,450);
INSERT INTO `mob_skill_lists` VALUES ('Pugil',197,451);
INSERT INTO `mob_skill_lists` VALUES ('Pugil',197,452);
INSERT INTO `mob_skill_lists` VALUES ('Pugil',197,453);
INSERT INTO `mob_skill_lists` VALUES ('Pugil',197,454);
INSERT INTO `mob_skill_lists` VALUES ('Puk',198,1718); -- crosswind
INSERT INTO `mob_skill_lists` VALUES ('Puk',198,1720); -- wind_shear
INSERT INTO `mob_skill_lists` VALUES ('Puk',198,1721); -- obfuscate
INSERT INTO `mob_skill_lists` VALUES ('Puk',198,1722); -- zephyr_mantle
INSERT INTO `mob_skill_lists` VALUES ('Puk',198,1723); -- ill_wind
INSERT INTO `mob_skill_lists` VALUES ('Puk',198,1724); -- white_wind
INSERT INTO `mob_skill_lists` VALUES ('Qiqirn',199,1725);
INSERT INTO `mob_skill_lists` VALUES ('Qiqirn',199,1726);
INSERT INTO `mob_skill_lists` VALUES ('Qiqirn',199,1727);
INSERT INTO `mob_skill_lists` VALUES ('Qiqirn',199,1728);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',200,611);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',200,612);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',200,613);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',200,614);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',200,762);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',201,611);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',201,612);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',201,613);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',201,614);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',201,762);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',202,611);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',202,612);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',202,613);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',202,614);
INSERT INTO `mob_skill_lists` VALUES ('Quadav',202,762);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',203,1778);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',203,1779);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',203,1780);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',203,1781);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',203,1782);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',203,1783);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',204,1778);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',204,1779);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',204,1780);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',204,1781);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',204,1782);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',204,1783);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',205,1778);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',205,1779);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',205,1780);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',205,1781);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',205,1782);
INSERT INTO `mob_skill_lists` VALUES ('Qutrub',205,1783);
INSERT INTO `mob_skill_lists` VALUES ('Rabbit',206,257);
INSERT INTO `mob_skill_lists` VALUES ('Rabbit',206,258);
INSERT INTO `mob_skill_lists` VALUES ('Rabbit',206,259);
INSERT INTO `mob_skill_lists` VALUES ('Rafflesia',207,2163); -- Seedspray
INSERT INTO `mob_skill_lists` VALUES ('Rafflesia',207,2164); -- Viscid Emission
INSERT INTO `mob_skill_lists` VALUES ('Rafflesia',207,2165); -- Rotten Stench
INSERT INTO `mob_skill_lists` VALUES ('Rafflesia',207,2166); -- Floral Bouquet
INSERT INTO `mob_skill_lists` VALUES ('Rafflesia',207,2167); -- Bloody Caress
INSERT INTO `mob_skill_lists` VALUES ('Ram',208,265);
INSERT INTO `mob_skill_lists` VALUES ('Ram',208,266);
INSERT INTO `mob_skill_lists` VALUES ('Ram',208,267);
INSERT INTO `mob_skill_lists` VALUES ('Ram',208,268);
INSERT INTO `mob_skill_lists` VALUES ('Ram',208,269);
INSERT INTO `mob_skill_lists` VALUES ('Rampart',209,2032);
INSERT INTO `mob_skill_lists` VALUES ('Rampart',209,2033);
--INSERT INTO `mob_skill_lists` VALUES ('Rampart',209,2034); -- reinforcements
INSERT INTO `mob_skill_lists` VALUES ('Rampart',209,2035);
INSERT INTO `mob_skill_lists` VALUES ('Rampart',209,2036);
INSERT INTO `mob_skill_lists` VALUES ('Raptor',210,374);
INSERT INTO `mob_skill_lists` VALUES ('Raptor',210,376);
INSERT INTO `mob_skill_lists` VALUES ('Raptor',210,379);
INSERT INTO `mob_skill_lists` VALUES ('Raptor',210,380);
INSERT INTO `mob_skill_lists` VALUES ('Ruszor',211,2435); -- severing_fang
INSERT INTO `mob_skill_lists` VALUES ('Ruszor',211,2436); -- zero_smash
INSERT INTO `mob_skill_lists` VALUES ('Ruszor',211,2437); -- aqua_blast
INSERT INTO `mob_skill_lists` VALUES ('Ruszor',211,2438); -- frozen_mist
INSERT INTO `mob_skill_lists` VALUES ('Ruszor',211,2439); -- hydro_wave
INSERT INTO `mob_skill_lists` VALUES ('Sabotender',212,321);
INSERT INTO `mob_skill_lists` VALUES ('Sabotender',212,322);
INSERT INTO `mob_skill_lists` VALUES ('Sabotender',212,324);
INSERT INTO `mob_skill_lists` VALUES ('Sahagin',213,771);
INSERT INTO `mob_skill_lists` VALUES ('Sahagin',213,774);
INSERT INTO `mob_skill_lists` VALUES ('Sahagin',213,777);
INSERT INTO `mob_skill_lists` VALUES ('Sahagin',213,780);
INSERT INTO `mob_skill_lists` VALUES ('LambtonWorm',214,2187); -- dustvoid
INSERT INTO `mob_skill_lists` VALUES ('LambtonWorm',214,2188); -- slaverous_gale
INSERT INTO `mob_skill_lists` VALUES ('LambtonWorm',214,2189); -- aeolian_void
INSERT INTO `mob_skill_lists` VALUES ('LambtonWorm',214,2190); -- extreme_purgation
INSERT INTO `mob_skill_lists` VALUES ('LambtonWorm',214,2191); -- desiccation
INSERT INTO `mob_skill_lists` VALUES ('Sandworm',215,2187); -- dustvoid
INSERT INTO `mob_skill_lists` VALUES ('Sandworm',215,2188); -- slaverous_gale
INSERT INTO `mob_skill_lists` VALUES ('Sandworm',215,2189); -- aeolian_void
INSERT INTO `mob_skill_lists` VALUES ('Sandworm',215,2190); -- extreme_purgation
INSERT INTO `mob_skill_lists` VALUES ('Sandworm',215,2191); -- desiccation
INSERT INTO `mob_skill_lists` VALUES('Sandworm', 215, 2192); -- doomvoid
INSERT INTO `mob_skill_lists` VALUES ('Sapling',216,685);
INSERT INTO `mob_skill_lists` VALUES ('Sapling',216,686);
INSERT INTO `mob_skill_lists` VALUES ('Sapling',216,687);
INSERT INTO `mob_skill_lists` VALUES ('Scorpion',217,348);
INSERT INTO `mob_skill_lists` VALUES ('Scorpion',217,349);
INSERT INTO `mob_skill_lists` VALUES ('Scorpion',217,350);
INSERT INTO `mob_skill_lists` VALUES ('Scorpion',217,351);
INSERT INTO `mob_skill_lists` VALUES ('Scorpion',217,353);
INSERT INTO `mob_skill_lists` VALUES ('Scorpion',217,354);
INSERT INTO `mob_skill_lists` VALUES ('Scorpion',217,355);
INSERT INTO `mob_skill_lists` VALUES ('Scorpion',217,356);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',218,456);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',218,458);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',218,459);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',218,460);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',218,461);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',218,462);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',218,463);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',219,456);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',219,458);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',219,459);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',219,460);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',219,461);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',219,462);
INSERT INTO `mob_skill_lists` VALUES ('SeaMonk',219,463);
INSERT INTO `mob_skill_lists` VALUES ('Seether',220,1253);
INSERT INTO `mob_skill_lists` VALUES ('Seether',220,1254);
INSERT INTO `mob_skill_lists` VALUES ('Seether',220,1255);
INSERT INTO `mob_skill_lists` VALUES ('Seether',220,1256);
INSERT INTO `mob_skill_lists` VALUES ('Seether',220,1258);
INSERT INTO `mob_skill_lists` VALUES ('Shadow',221,255);
INSERT INTO `mob_skill_lists` VALUES ('Shadow',222,255);
INSERT INTO `mob_skill_lists` VALUES ('Shadow',223,255);
INSERT INTO `mob_skill_lists` VALUES ('ShadowLord',224,668);
INSERT INTO `mob_skill_lists` VALUES ('ShadowLord',224,671);
INSERT INTO `mob_skill_lists` VALUES ('ShadowLord',224,672);
INSERT INTO `mob_skill_lists` VALUES ('ShadowLord',224,673);
INSERT INTO `mob_skill_lists` VALUES ('ShadowLord',225,669);
INSERT INTO `mob_skill_lists` VALUES ('Sheep',226,260);
INSERT INTO `mob_skill_lists` VALUES ('Sheep',226,261);
INSERT INTO `mob_skill_lists` VALUES ('Sheep',226,262);
INSERT INTO `mob_skill_lists` VALUES ('Sheep',226,264);
INSERT INTO `mob_skill_lists` VALUES ('Skeleton',227,478);
INSERT INTO `mob_skill_lists` VALUES ('Skeleton',227,479);
INSERT INTO `mob_skill_lists` VALUES ('Skeleton',227,484);
INSERT INTO `mob_skill_lists` VALUES ('Skeleton',227,485);
INSERT INTO `mob_skill_lists` VALUES ('Slime',228,431);
INSERT INTO `mob_skill_lists` VALUES ('Slime',228,432);
INSERT INTO `mob_skill_lists` VALUES ('Slime',228,433);
INSERT INTO `mob_skill_lists` VALUES ('Slime',229,431);
INSERT INTO `mob_skill_lists` VALUES ('Slime',229,432);
INSERT INTO `mob_skill_lists` VALUES ('Slime',229,433);
INSERT INTO `mob_skill_lists` VALUES ('Slime',230,431);
INSERT INTO `mob_skill_lists` VALUES ('Slime',230,432);
INSERT INTO `mob_skill_lists` VALUES ('Slime',230,433);
INSERT INTO `mob_skill_lists` VALUES ('Slug',231,2183); -- fuscous_ooze
INSERT INTO `mob_skill_lists` VALUES ('Slug',231,2184); -- purulent_ooze
INSERT INTO `mob_skill_lists` VALUES ('Slug',231,2185); -- corrosive_ooze
INSERT INTO `mob_skill_lists` VALUES ('Snoll',232,1644);
INSERT INTO `mob_skill_lists` VALUES ('Snoll',232,1645);
INSERT INTO `mob_skill_lists` VALUES ('Snoll',232,1646);
INSERT INTO `mob_skill_lists` VALUES ('Snoll',232,1647);
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer',233,1963); -- Mind Blast
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer',233,1964); -- Immortal Mind
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer',233,1965); -- Immortal Shield
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer',233,1966); -- Mind Purge
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer',233,1967); -- Tribulation
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer',233,1968); -- Immortal Anathema
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer_NM',234,1963); -- Mind Blast
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer_NM',234,1964); -- Immortal Mind
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer_NM',234,1965); -- Immortal Shield
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer_NM',234,1966); -- Mind Purge
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer_NM',234,1967); -- Tribulation
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer_NM',234,1968); -- Immortal Anathema
INSERT INTO `mob_skill_lists` VALUES ('Soulflayer_NM',234,1969); -- Reprobation
INSERT INTO `mob_skill_lists` VALUES ('Spheroid_COP_MISSION',235,561); -- electromagnetic_field
INSERT INTO `mob_skill_lists` VALUES ('Spheroid_COP_MISSION',235,562); -- reactive_armor
INSERT INTO `mob_skill_lists` VALUES ('Spheroid_COP_MISSION',235,984); -- electrocharge
INSERT INTO `mob_skill_lists` VALUES ('Spider',236,810);
INSERT INTO `mob_skill_lists` VALUES ('Spider',236,811);
INSERT INTO `mob_skill_lists` VALUES ('Spider',236,812);
INSERT INTO `mob_skill_lists` VALUES ('Structure_Exoplate',237,990);
INSERT INTO `mob_skill_lists` VALUES ('Structure_Exoplate',237,991);
INSERT INTO `mob_skill_lists` VALUES ('Structure_Exoplate',237,992);
INSERT INTO `mob_skill_lists` VALUES ('Structure_Exoplate',237,993);
INSERT INTO `mob_skill_lists` VALUES ('Structure_Exoplate',237,994);
INSERT INTO `mob_skill_lists` VALUES ('Structure_Exoplate',237,995);
INSERT INTO `mob_skill_lists` VALUES ('Structure_Exoplate',237,996);
INSERT INTO `mob_skill_lists` VALUES ('Structure_Exoplate',237,997);
INSERT INTO `mob_skill_lists` VALUES ('Structure_Exoplate',237,998);
INSERT INTO `mob_skill_lists` VALUES ('Structure_Exoplate',237,999);
INSERT INTO `mob_skill_lists` VALUES ('Structure_Exoplate',237,1000);
INSERT INTO `mob_skill_lists` VALUES ('Structure_Exoplate',237,1001);
INSERT INTO `mob_skill_lists` VALUES ('Lhe_Lhangavo',238,4); -- Backhand Blow
INSERT INTO `mob_skill_lists` VALUES ('Lhe_Lhangavo',238,5); -- Raging Fists
INSERT INTO `mob_skill_lists` VALUES ('Lhe_Lhangavo',238,8); -- Dragon Kick
INSERT INTO `mob_skill_lists` VALUES ('Lhe_Lhangavo',238,9); -- Asuran Fists
INSERT INTO `mob_skill_lists` VALUES ('Thunderclaw_Thuban',239,378); -- thunderbolt
INSERT INTO `mob_skill_lists` VALUES ('Tauri',240,498);
INSERT INTO `mob_skill_lists` VALUES ('Tauri',240,499);
INSERT INTO `mob_skill_lists` VALUES ('Tauri',240,500);
INSERT INTO `mob_skill_lists` VALUES ('Tauri',240,501);
INSERT INTO `mob_skill_lists` VALUES ('Tauri',240,502);
INSERT INTO `mob_skill_lists` VALUES ('Tauri',240,503);
INSERT INTO `mob_skill_lists` VALUES ('Thinker',241,1242);
INSERT INTO `mob_skill_lists` VALUES ('Thinker',241,1243);
INSERT INTO `mob_skill_lists` VALUES ('Thinker',241,1244);
INSERT INTO `mob_skill_lists` VALUES ('Thinker',241,1245);
INSERT INTO `mob_skill_lists` VALUES ('Thinker',241,1246);
INSERT INTO `mob_skill_lists` VALUES ('Thinker',241,1247);
INSERT INTO `mob_skill_lists` VALUES ('Thinker',241,1248);
INSERT INTO `mob_skill_lists` VALUES ('Thinker',241,1249);
INSERT INTO `mob_skill_lists` VALUES ('Thinker',241,1250);
INSERT INTO `mob_skill_lists` VALUES ('Tiger',242,270);
INSERT INTO `mob_skill_lists` VALUES ('Tiger',242,271);
INSERT INTO `mob_skill_lists` VALUES ('Tiger',242,273);
-- INSERT INTO `mob_skill_lists` VALUES ('Tiger',242,2207);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry',243,783);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry',243,784);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry',243,785);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry',243,786);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry',243,787);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry',243,788);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry',243,920);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry',243,921);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry_no_rancor',244,783);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry_no_rancor',244,784);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry_no_rancor',244,785);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry_no_rancor',244,786);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry_no_rancor',244,787);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry_no_rancor',244,788);
INSERT INTO `mob_skill_lists` VALUES ('Tonberry_no_rancor',244,920);
INSERT INTO `mob_skill_lists` VALUES ('Treant',245,328);
INSERT INTO `mob_skill_lists` VALUES ('Treant',245,329);
INSERT INTO `mob_skill_lists` VALUES ('Treant',245,331);
INSERT INTO `mob_skill_lists` VALUES ('Treant',245,332);
INSERT INTO `mob_skill_lists` VALUES ('Troll',246,1741);
INSERT INTO `mob_skill_lists` VALUES ('Troll',246,1742);
INSERT INTO `mob_skill_lists` VALUES ('Troll',246,1743);
INSERT INTO `mob_skill_lists` VALUES ('Troll',246,1744);
INSERT INTO `mob_skill_lists` VALUES ('Troll',246,1745);
INSERT INTO `mob_skill_lists` VALUES ('Troll',246,1746);
-- INSERT INTO `mob_skill_lists` VALUES ('Troll',246,1748);
INSERT INTO `mob_skill_lists` VALUES ('Troll',246,1749);

INSERT INTO `mob_skill_lists` VALUES ('Troll_Armored',247,1894);
INSERT INTO `mob_skill_lists` VALUES ('Troll_Armored',247,1895);
INSERT INTO `mob_skill_lists` VALUES ('Troll_Armored',247,1896);
INSERT INTO `mob_skill_lists` VALUES ('Troll_Armored',247,1897);
INSERT INTO `mob_skill_lists` VALUES ('Troll_Armored',247,1898);
INSERT INTO `mob_skill_lists` VALUES ('Troll_Armored',247,1899);
-- INSERT INTO `mob_skill_lists` VALUES ('Troll_Armored',247,1748);
INSERT INTO `mob_skill_lists` VALUES ('Troll_Armored',247,1900);
-- 247: Tube
INSERT INTO `mob_skill_lists` VALUES ('Else',248,116); -- penta_thrust
INSERT INTO `mob_skill_lists` VALUES ('Else',248,118); -- skewer
INSERT INTO `mob_skill_lists` VALUES ('Else',248,120); -- impulse_drive
-- 249: free
INSERT INTO `mob_skill_lists` VALUES ('Uragnite_shell',250,1571); -- gas_shell
INSERT INTO `mob_skill_lists` VALUES ('Uragnite_shell',250,1572); -- venom_shell
INSERT INTO `mob_skill_lists` VALUES ('Uragnite',251,1573); -- palsynyxis
INSERT INTO `mob_skill_lists` VALUES ('Uragnite',251,1574); -- painful_whip
INSERT INTO `mob_skill_lists` VALUES ('Uragnite',251,1575); -- suctorial_tentacle
INSERT INTO `mob_skill_lists` VALUES ('Vampyr',252,2106);
INSERT INTO `mob_skill_lists` VALUES ('Vampyr',252,2107);
INSERT INTO `mob_skill_lists` VALUES ('Vampyr',252,2108);
INSERT INTO `mob_skill_lists` VALUES ('Vampyr',252,2109);
INSERT INTO `mob_skill_lists` VALUES ('Vampyr',252,2110);
INSERT INTO `mob_skill_lists` VALUES ('Vampyr',252,2111);
INSERT INTO `mob_skill_lists` VALUES ('Vampyr',252,2112);
-- INSERT INTO `mob_skill_lists` VALUES ('Vampyr',252,2388); -- dirty_breath
-- INSERT INTO `mob_skill_lists` VALUES ('Vampyr',252,2534); -- minax glare
INSERT INTO `mob_skill_lists` VALUES ('Wamoura',253,1951);
INSERT INTO `mob_skill_lists` VALUES ('Wamoura',253,1952);
INSERT INTO `mob_skill_lists` VALUES ('Wamoura',253,1953);
INSERT INTO `mob_skill_lists` VALUES ('Wamoura',253,1954);
INSERT INTO `mob_skill_lists` VALUES ('Wamoura',253,1955);
-- INSERT INTO `mob_skill_lists` VALUES ('Wamoura',253,1956);
INSERT INTO `mob_skill_lists` VALUES ('Wamouracampa',254,1815);
INSERT INTO `mob_skill_lists` VALUES ('Wamouracampa',254,1816);
INSERT INTO `mob_skill_lists` VALUES ('Wamouracampa',254,1817);
INSERT INTO `mob_skill_lists` VALUES ('Wamouracampa',254,1818);
INSERT INTO `mob_skill_lists` VALUES ('Wamouracampa',254,1819);
-- INSERT INTO `mob_skill_lists` VALUES ('Wamouracampa',254,1820);
INSERT INTO `mob_skill_lists` VALUES ('Wanderer',255,388);
INSERT INTO `mob_skill_lists` VALUES ('Wanderer',255,389);
INSERT INTO `mob_skill_lists` VALUES ('Wanderer',255,390);
INSERT INTO `mob_skill_lists` VALUES ('Wanderer',255,391);
INSERT INTO `mob_skill_lists` VALUES ('Weeper',256,1217);
INSERT INTO `mob_skill_lists` VALUES ('Weeper',256,1218);
INSERT INTO `mob_skill_lists` VALUES ('Weeper',256,1219);
INSERT INTO `mob_skill_lists` VALUES ('Weeper',256,1220);
INSERT INTO `mob_skill_lists` VALUES ('Weeper',256,1221);
INSERT INTO `mob_skill_lists` VALUES ('Weeper',256,1222);
INSERT INTO `mob_skill_lists` VALUES ('Weeper',256,1223);
INSERT INTO `mob_skill_lists` VALUES ('Weeper',256,1224);
INSERT INTO `mob_skill_lists` VALUES ('Weeper',256,1225);
INSERT INTO `mob_skill_lists` VALUES ('Weeper',256,1226);
INSERT INTO `mob_skill_lists` VALUES ('Weeper',256,1227);
INSERT INTO `mob_skill_lists` VALUES ('Weeper',256,1228);
INSERT INTO `mob_skill_lists` VALUES ('Wivre',257,2099); -- batterhorn
INSERT INTO `mob_skill_lists` VALUES ('Wivre',257,2100);
INSERT INTO `mob_skill_lists` VALUES ('Wivre',257,2101);
INSERT INTO `mob_skill_lists` VALUES ('Wivre',257,2102);
INSERT INTO `mob_skill_lists` VALUES ('Wivre',257,2103);
INSERT INTO `mob_skill_lists` VALUES ('Worm',258,424);
INSERT INTO `mob_skill_lists` VALUES ('Worm',258,425);
INSERT INTO `mob_skill_lists` VALUES ('Worm',258,426);
INSERT INTO `mob_skill_lists` VALUES ('Worm',258,427);
INSERT INTO `mob_skill_lists` VALUES ('Worm',258,428);
INSERT INTO `mob_skill_lists` VALUES ('Worm',258,429);
-- INSERT INTO `mob_skill_lists` VALUES ('Worm',258,1889);
-- INSERT INTO `mob_skill_lists` VALUES ('OuryuWyrm',259,1297);
INSERT INTO `mob_skill_lists` VALUES ('OuryuWyrm',259,1299); -- typhoon_wing
INSERT INTO `mob_skill_lists` VALUES ('OuryuWyrm',259,1300); -- spike_flail
INSERT INTO `mob_skill_lists` VALUES ('OuryuWyrm',259,1301); -- geotic_breath
INSERT INTO `mob_skill_lists` VALUES ('OuryuWyrm',259,1305); -- absolute_terror
INSERT INTO `mob_skill_lists` VALUES ('OuryuWyrm',259,1306); -- horrid_roar_3
INSERT INTO `mob_skill_lists` VALUES ('OuryuWyrm',259,1302); -- touchdown
INSERT INTO `mob_skill_lists` VALUES ('OuryuWyrm',259,1303); -- ochre_blast
INSERT INTO `mob_skill_lists` VALUES ('OuryuWyrm',259,1304); -- bai_wing
INSERT INTO `mob_skill_lists` VALUES ('FafnirWyrm',260,951);
INSERT INTO `mob_skill_lists` VALUES ('FafnirWyrm',260,952); -- Alliance only targeting version of Spike Flail
INSERT INTO `mob_skill_lists` VALUES ('FafnirWyrm',260,953);
INSERT INTO `mob_skill_lists` VALUES ('FafnirWyrm',260,957);
INSERT INTO `mob_skill_lists` VALUES ('FafnirWyrm',260,958);
INSERT INTO `mob_skill_lists` VALUES ('CynoprosopiWyrm',261,951);
INSERT INTO `mob_skill_lists` VALUES ('CynoprosopiWyrm',261,952);
INSERT INTO `mob_skill_lists` VALUES ('CynoprosopiWyrm',261,953);
INSERT INTO `mob_skill_lists` VALUES ('CynoprosopiWyrm',261,958);
INSERT INTO `mob_skill_lists` VALUES ('KS99_Wyrm',262,951);
INSERT INTO `mob_skill_lists` VALUES ('KS99_Wyrm',262,952);
INSERT INTO `mob_skill_lists` VALUES ('KS99_Wyrm',262,953);
INSERT INTO `mob_skill_lists` VALUES ('KS99_Wyrm',262,957);
INSERT INTO `mob_skill_lists` VALUES ('KS99_Wyrm',262,958);
INSERT INTO `mob_skill_lists` VALUES ('NidhoggWyrm',263,1039); -- Outside alliance targeting version of Hurricane Wing
INSERT INTO `mob_skill_lists` VALUES ('NidhoggWyrm',263,1040); -- Outside alliance targeting version of Spike Flail
INSERT INTO `mob_skill_lists` VALUES ('NidhoggWyrm',263,1041); -- Outside alliance targeting version of Dragon Breath
INSERT INTO `mob_skill_lists` VALUES ('NidhoggWyrm',263,957);
INSERT INTO `mob_skill_lists` VALUES ('NidhoggWyrm',263,1046);
INSERT INTO `mob_skill_lists` VALUES ('Shankha',264,1574); -- painful_whip
INSERT INTO `mob_skill_lists` VALUES ('SimorgWyvern',265,813);
INSERT INTO `mob_skill_lists` VALUES ('SimorgWyvern',265,814);
INSERT INTO `mob_skill_lists` VALUES ('SimorgWyvern',265,815);
INSERT INTO `mob_skill_lists` VALUES ('SimorgWyvern',265,816);
INSERT INTO `mob_skill_lists` VALUES ('SimorgWyvern',265,817);
INSERT INTO `mob_skill_lists` VALUES ('SimorgWyvern',265,818);
INSERT INTO `mob_skill_lists` VALUES ('SimorgWyvern',265,821);
INSERT INTO `mob_skill_lists` VALUES ('Wyvern',266,813);
INSERT INTO `mob_skill_lists` VALUES ('Wyvern',266,814);
INSERT INTO `mob_skill_lists` VALUES ('Wyvern',266,815);
INSERT INTO `mob_skill_lists` VALUES ('Wyvern',266,816);
INSERT INTO `mob_skill_lists` VALUES ('Wyvern',266,817);
INSERT INTO `mob_skill_lists` VALUES ('Wyvern',266,818);
INSERT INTO `mob_skill_lists` VALUES ('Wyvern',266,821);
INSERT INTO `mob_skill_lists` VALUES ('GuivreWyvern',267,813);
INSERT INTO `mob_skill_lists` VALUES ('GuivreWyvern',267,814);
INSERT INTO `mob_skill_lists` VALUES ('GuivreWyvern',267,815);
INSERT INTO `mob_skill_lists` VALUES ('GuivreWyvern',267,816);
INSERT INTO `mob_skill_lists` VALUES ('GuivreWyvern',267,817);
INSERT INTO `mob_skill_lists` VALUES ('GuivreWyvern',267,818);
INSERT INTO `mob_skill_lists` VALUES ('GuivreWyvern',267,821);

INSERT INTO `mob_skill_lists` VALUES ('Kindreds_Vouivre',268,813);
INSERT INTO `mob_skill_lists` VALUES ('Kindreds_Vouivre',268,814);
INSERT INTO `mob_skill_lists` VALUES ('Kindreds_Vouivre',268,815);
INSERT INTO `mob_skill_lists` VALUES ('Kindreds_Vouivre',268,816);
INSERT INTO `mob_skill_lists` VALUES ('Kindreds_Vouivre',268,817);
INSERT INTO `mob_skill_lists` VALUES ('Kindreds_Vouivre',268,818);
INSERT INTO `mob_skill_lists` VALUES ('Kindreds_Vouivre',268,819);
INSERT INTO `mob_skill_lists` VALUES ('Kindreds_Vouivre',268,820);
INSERT INTO `mob_skill_lists` VALUES ('Kindreds_Vouivre',268,821);

INSERT INTO `mob_skill_lists` VALUES ('Xzomit',269,1347); -- dual_strike
INSERT INTO `mob_skill_lists` VALUES ('Xzomit',269,1348);
INSERT INTO `mob_skill_lists` VALUES ('Xzomit',269,1349);
INSERT INTO `mob_skill_lists` VALUES ('Xzomit',269,1350);
INSERT INTO `mob_skill_lists` VALUES ('Xzomit',269,1351);
INSERT INTO `mob_skill_lists` VALUES ('Xzomit',269,1352); -- saline_coat
INSERT INTO `mob_skill_lists` VALUES ('Yagudo',270,617);
INSERT INTO `mob_skill_lists` VALUES ('Yagudo',270,618);
INSERT INTO `mob_skill_lists` VALUES ('Yagudo',270,619);
INSERT INTO `mob_skill_lists` VALUES ('Yagudo',270,620);
INSERT INTO `mob_skill_lists` VALUES ('Yagudo',270,764);
INSERT INTO `mob_skill_lists` VALUES ('Yovra',271,1370); -- vitriolic_barrage
INSERT INTO `mob_skill_lists` VALUES ('Yovra',271,1371);
INSERT INTO `mob_skill_lists` VALUES ('Yovra',271,1372);
INSERT INTO `mob_skill_lists` VALUES ('Yovra',271,1373);
INSERT INTO `mob_skill_lists` VALUES ('Yovra',271,1374);
INSERT INTO `mob_skill_lists` VALUES ('Yovra',271,1375);
INSERT INTO `mob_skill_lists` VALUES ('Yovra',271,1376);
INSERT INTO `mob_skill_lists` VALUES ('Yovra',271,1377); -- fluorescence
INSERT INTO `mob_skill_lists` VALUES ('Zdei',272,1463); -- reactor_cool
INSERT INTO `mob_skill_lists` VALUES ('Zdei',272,1464);
INSERT INTO `mob_skill_lists` VALUES ('Zdei',272,1465);
INSERT INTO `mob_skill_lists` VALUES ('Zdei',272,1466);
INSERT INTO `mob_skill_lists` VALUES ('Zdei',272,1467);
INSERT INTO `mob_skill_lists` VALUES ('Zdei',272,1468);
INSERT INTO `mob_skill_lists` VALUES ('Zdei',272,1469); -- reactor_overload
INSERT INTO `mob_skill_lists` VALUES ('Serket',273,717);
INSERT INTO `mob_skill_lists` VALUES ('Serket',273,719);
INSERT INTO `mob_skill_lists` VALUES ('Serket',273,720);
INSERT INTO `mob_skill_lists` VALUES ('Serket',273,721);
INSERT INTO `mob_skill_lists` VALUES ('Serket',273,722);
INSERT INTO `mob_skill_lists` VALUES ('Serket',273,723);
INSERT INTO `mob_skill_lists` VALUES ('Serket',273,724);
INSERT INTO `mob_skill_lists` VALUES ('KingV',274,353);
INSERT INTO `mob_skill_lists` VALUES ('KingV',274,354);
INSERT INTO `mob_skill_lists` VALUES ('KingV',274,355);
INSERT INTO `mob_skill_lists` VALUES ('KingV',274,719);
INSERT INTO `mob_skill_lists` VALUES ('KingV',274,720);
INSERT INTO `mob_skill_lists` VALUES ('KingV',274,722);
INSERT INTO `mob_skill_lists` VALUES ('KingV',274,723);
-- 275: Matamata
-- 276: Crepuscular Worm
INSERT INTO `mob_skill_lists` VALUES ('Genbu',277,804);
INSERT INTO `mob_skill_lists` VALUES ('Genbu',277,805);
INSERT INTO `mob_skill_lists` VALUES ('Genbu',277,806);
INSERT INTO `mob_skill_lists` VALUES ('Genbu',277,807);
INSERT INTO `mob_skill_lists` VALUES ('Genbu',277,808);
INSERT INTO `mob_skill_lists` VALUES ('Genbu',277,809);
INSERT INTO `mob_skill_lists` VALUES ('Seiryu',278,813);
INSERT INTO `mob_skill_lists` VALUES ('Seiryu',278,814);
INSERT INTO `mob_skill_lists` VALUES ('Seiryu',278,815);
INSERT INTO `mob_skill_lists` VALUES ('Seiryu',278,816);
INSERT INTO `mob_skill_lists` VALUES ('Seiryu',278,817);
INSERT INTO `mob_skill_lists` VALUES ('Seiryu',278,818);
INSERT INTO `mob_skill_lists` VALUES ('Seiryu',278,821);
INSERT INTO `mob_skill_lists` VALUES ('Byakko',279,270);
INSERT INTO `mob_skill_lists` VALUES ('Byakko',279,271);
INSERT INTO `mob_skill_lists` VALUES ('Byakko',279,273);
INSERT INTO `mob_skill_lists` VALUES ('Suzaku',280,922);
INSERT INTO `mob_skill_lists` VALUES ('Suzaku',280,923);
INSERT INTO `mob_skill_lists` VALUES ('Suzaku',280,924);
INSERT INTO `mob_skill_lists` VALUES ('Suzaku',280,926);
INSERT INTO `mob_skill_lists` VALUES ('Suzaku',280,402);
INSERT INTO `mob_skill_lists` VALUES ('Kirin',281,797);
INSERT INTO `mob_skill_lists` VALUES ('Kirin',281,798);
INSERT INTO `mob_skill_lists` VALUES ('Kirin',281,799);
INSERT INTO `mob_skill_lists` VALUES ('Kirin',281,800);
INSERT INTO `mob_skill_lists` VALUES ('Kirin',281,802);
INSERT INTO `mob_skill_lists` VALUES ('Kirin',281,803);
INSERT INTO `mob_skill_lists` VALUES ('Grav_iton',282,783);
INSERT INTO `mob_skill_lists` VALUES ('Grav_iton',282,784);
INSERT INTO `mob_skill_lists` VALUES ('Grav_iton',282,785);
INSERT INTO `mob_skill_lists` VALUES ('Grav_iton',282,786);
INSERT INTO `mob_skill_lists` VALUES ('Grav_iton',282,787);
INSERT INTO `mob_skill_lists` VALUES ('Grav_iton',282,788);
INSERT INTO `mob_skill_lists` VALUES ('Grav_iton',282,920);
INSERT INTO `mob_skill_lists` VALUES ('Grav_iton',282,921);
INSERT INTO `mob_skill_lists` VALUES ('Melusine',283,2198); -- winter_breeze
-- 284: Oupire
INSERT INTO `mob_skill_lists` VALUES ('Gulool',285,1738);
INSERT INTO `mob_skill_lists` VALUES ('Gulool',285,1797);
INSERT INTO `mob_skill_lists` VALUES ('Gulool',285,1798);
INSERT INTO `mob_skill_lists` VALUES ('Gulool',285,1799);
INSERT INTO `mob_skill_lists` VALUES ('Gulool',285,1800);
INSERT INTO `mob_skill_lists` VALUES ('Gulool',285,1801);
INSERT INTO `mob_skill_lists` VALUES ('Vulpangue',286,1718);
INSERT INTO `mob_skill_lists` VALUES ('Vulpangue',286,1721);
INSERT INTO `mob_skill_lists` VALUES ('Vulpangue',286,1722);
INSERT INTO `mob_skill_lists` VALUES ('Vulpangue',286,1723);
INSERT INTO `mob_skill_lists` VALUES ('Vulpangue',286,1724);
INSERT INTO `mob_skill_lists` VALUES ('Vulpangue',286,2360);
INSERT INTO `mob_skill_lists` VALUES ('Chamrosh',287,1699);
INSERT INTO `mob_skill_lists` VALUES ('Chamrosh',287,1700);
INSERT INTO `mob_skill_lists` VALUES ('Chamrosh',287,1701);
INSERT INTO `mob_skill_lists` VALUES ('CheeseHoarder',288,1725);
INSERT INTO `mob_skill_lists` VALUES ('CheeseHoarder',288,1727);
INSERT INTO `mob_skill_lists` VALUES ('CheeseHoarder',288,1728);
INSERT INTO `mob_skill_lists` VALUES ('CheeseHoarder',288,1730);
INSERT INTO `mob_skill_lists` VALUES ('CheeseHoarder',288,2359);
INSERT INTO `mob_skill_lists` VALUES ('BrassBorer',289,1815);
INSERT INTO `mob_skill_lists` VALUES ('BrassBorer',289,1816);
INSERT INTO `mob_skill_lists` VALUES ('BrassBorer',289,1817);
INSERT INTO `mob_skill_lists` VALUES ('BrassBorer',289,1818);
INSERT INTO `mob_skill_lists` VALUES ('BrassBorer',289,1819);
INSERT INTO `mob_skill_lists` VALUES ('BrassBorer',289,1820);
INSERT INTO `mob_skill_lists` VALUES ('Claret',290,431);  -- Fluid_Spread
INSERT INTO `mob_skill_lists` VALUES ('Claret',290,433);  -- Digest
INSERT INTO `mob_skill_lists` VALUES ('Claret',290,1317); -- Mucous_Spread
INSERT INTO `mob_skill_lists` VALUES ('Claret',290,1319); -- Epoxy_Spread
INSERT INTO `mob_skill_lists` VALUES ('Claret',290,2549); -- Fluid_Toss_Claret
-- 291: Ob
INSERT INTO `mob_skill_lists` VALUES ('Velionis',292,478); -- Hell Slash
INSERT INTO `mob_skill_lists` VALUES ('Velionis',292,479); -- Horror Cloud
INSERT INTO `mob_skill_lists` VALUES ('Velionis',292,484); -- Black Cloud
INSERT INTO `mob_skill_lists` VALUES ('Velionis',292,485); -- Blood Saber
INSERT INTO `mob_skill_lists` VALUES ('Velionis',292,1795); -- Malediction
INSERT INTO `mob_skill_lists` VALUES ('LividrootAmooshah',293,316); -- impale
INSERT INTO `mob_skill_lists` VALUES ('LividrootAmooshah',293,317); -- vampiric_lash
INSERT INTO `mob_skill_lists` VALUES ('LividrootAmooshah',293,319); -- bad_breath
INSERT INTO `mob_skill_lists` VALUES ('LividrootAmooshah',293,320); -- sweet_breath
INSERT INTO `mob_skill_lists` VALUES ('LilApkallu',294,1714); -- wing_slap
INSERT INTO `mob_skill_lists` VALUES ('LilApkallu',294,1715); -- beak_lunge
INSERT INTO `mob_skill_lists` VALUES ('LilApkallu',294,1716); -- frigid_shuffle
INSERT INTO `mob_skill_lists` VALUES ('IrizIma',295,1703);
INSERT INTO `mob_skill_lists` VALUES ('IrizIma',295,1704);
INSERT INTO `mob_skill_lists` VALUES ('IrizIma',295,1705);
INSERT INTO `mob_skill_lists` VALUES ('IrizIma',295,1706);
INSERT INTO `mob_skill_lists` VALUES ('IrizIma',295,1707);
INSERT INTO `mob_skill_lists` VALUES ('IrizIma',295,1708);
INSERT INTO `mob_skill_lists` VALUES ('LividrootAmooshahFourth',296,316); -- impale
INSERT INTO `mob_skill_lists` VALUES ('LividrootAmooshahFourth',296,317); -- vampiric_lash
INSERT INTO `mob_skill_lists` VALUES ('LividrootAmooshahFourth',296,319); -- bad_breath
INSERT INTO `mob_skill_lists` VALUES ('LividrootAmooshahFourth',296,320); -- sweet_breath
INSERT INTO `mob_skill_lists` VALUES ('LividrootAmooshahFourth',296,1332); -- extremely_bad_breath
INSERT INTO `mob_skill_lists` VALUES ('IririSamariri',297,1958); -- magic_hammer
INSERT INTO `mob_skill_lists` VALUES ('IririSamariri',297,1959); -- water_bomb
INSERT INTO `mob_skill_lists` VALUES ('IririSamariri',297,1960); -- frog_cheer
INSERT INTO `mob_skill_lists` VALUES ('IririSamariri',297,1961); -- providence
INSERT INTO `mob_skill_lists` VALUES ('IririSamariri',297,1962); -- frog_chorus
INSERT INTO `mob_skill_lists` VALUES ('Anantaboga',298,647); -- Chaos_Blade
INSERT INTO `mob_skill_lists` VALUES ('Anantaboga',298,649); -- Voidsong
INSERT INTO `mob_skill_lists` VALUES ('Anantaboga',298,650); -- Thornsong
INSERT INTO `mob_skill_lists` VALUES ('Anantaboga',298,651); -- Lodesong
INSERT INTO `mob_skill_lists` VALUES ('Anantaboga ',298,1792); -- Nullsong
INSERT INTO `mob_skill_lists` VALUES ('Dextrose',299,1821);
INSERT INTO `mob_skill_lists` VALUES ('Dextrose',299,1822);
-- INSERT INTO `mob_skill_lists` VALUES ('Dextrose',299,1823);
-- INSERT INTO `mob_skill_lists` VALUES ('Dextrose',299,1824);
-- INSERT INTO `mob_skill_lists` VALUES ('Dextrose',299,1826);
INSERT INTO `mob_skill_lists` VALUES ('Reacton',300,510);
INSERT INTO `mob_skill_lists` VALUES ('Reacton',300,511);
INSERT INTO `mob_skill_lists` VALUES ('Verdelet',301,1709);
INSERT INTO `mob_skill_lists` VALUES ('Verdelet',301,1710);
INSERT INTO `mob_skill_lists` VALUES ('Verdelet',301,1711);
INSERT INTO `mob_skill_lists` VALUES ('Wulgaru',302,2071); -- dire_straight
INSERT INTO `mob_skill_lists` VALUES ('Wulgaru',302,2073); -- sinker_drill
INSERT INTO `mob_skill_lists` VALUES ('ZareehklTheJu',303,1778);
INSERT INTO `mob_skill_lists` VALUES ('ZareehklTheJu',303,1779);
INSERT INTO `mob_skill_lists` VALUES ('ZareehklTheJu',303,1780);
INSERT INTO `mob_skill_lists` VALUES ('ZareehklTheJu',303,1781);
INSERT INTO `mob_skill_lists` VALUES ('ZareehklTheJu',303,1782);
INSERT INTO `mob_skill_lists` VALUES ('ZareehklTheJu',303,1783); -- fortifying_wail
INSERT INTO `mob_skill_lists` VALUES ('Big_Bang',304,2218); -- penumbral_impact
INSERT INTO `mob_skill_lists` VALUES ('Gotoh_Zha_the_Redolent',305,1920);
INSERT INTO `mob_skill_lists` VALUES ('Gotoh_Zha_the_Redolent',305,1921);
INSERT INTO `mob_skill_lists` VALUES ('Gotoh_Zha_the_Redolent',305,1922);
INSERT INTO `mob_skill_lists` VALUES ('Gotoh_Zha_the_Redolent',305,1923);
INSERT INTO `mob_skill_lists` VALUES ('Gotoh_Zha_the_Redolent',305,1924);
INSERT INTO `mob_skill_lists` VALUES ('Dea',306,2101);
INSERT INTO `mob_skill_lists` VALUES ('Dea',306,2102);
INSERT INTO `mob_skill_lists` VALUES ('Dea',306,2103);
-- 307: Kalos_Eunomia
INSERT INTO `mob_skill_lists` VALUES ('Khromasoul',308,1894); -- potent_lunge
INSERT INTO `mob_skill_lists` VALUES ('Khromasoul',308,1896); -- rock_smash
INSERT INTO `mob_skill_lists` VALUES ('Khromasoul',308,1897); -- diamondhide
INSERT INTO `mob_skill_lists` VALUES ('Khromasoul',308,1898); -- enervation
INSERT INTO `mob_skill_lists` VALUES ('Khromasoul',308,1899); -- quake_stomp
INSERT INTO `mob_skill_lists` VALUES ('Khromasoul',308,1900); -- healing_stomp
INSERT INTO `mob_skill_lists` VALUES ('Nosferatu',309,2106);
INSERT INTO `mob_skill_lists` VALUES ('Nosferatu',309,2107);
INSERT INTO `mob_skill_lists` VALUES ('Nosferatu',309,2108);
INSERT INTO `mob_skill_lists` VALUES ('Nosferatu',309,2109);
INSERT INTO `mob_skill_lists` VALUES ('Nosferatu',309,2110);
INSERT INTO `mob_skill_lists` VALUES ('Nosferatu',309,2111);
INSERT INTO `mob_skill_lists` VALUES ('Nosferatu',309,2112);
INSERT INTO `mob_skill_lists` VALUES ('ExperimentalLa',310,1753); -- hysteric_barrage
INSERT INTO `mob_skill_lists` VALUES ('ExperimentalLa',310,1754); -- dukkeripen_heal
INSERT INTO `mob_skill_lists` VALUES ('ExperimentalLa',310,1755); -- dukkeripen_shadow
INSERT INTO `mob_skill_lists` VALUES ('ExperimentalLa',310,1756); -- dukkeripen_para
INSERT INTO `mob_skill_lists` VALUES ('ExperimentalLa',310,1758); -- tail_slap
INSERT INTO `mob_skill_lists` VALUES ('ExperimentalLa',310,1759); -- hypnotic_sway
INSERT INTO `mob_skill_lists` VALUES ('ExperimentalLa',310,1762); -- belly_dance
INSERT INTO `mob_skill_lists` VALUES ('ExperimentalLa',310,1929); -- pole_swing
INSERT INTO `mob_skill_lists` VALUES ('ZareehklTheJuAutoattack',311,1777); -- Only use with Sword out
INSERT INTO `mob_skill_lists` VALUES ('Nuhn',312,1977); -- deathgnash
INSERT INTO `mob_skill_lists` VALUES ('Nuhn',312,1978); -- abominable_belch
INSERT INTO `mob_skill_lists` VALUES ('Nuhn',312,1693); -- gnash
INSERT INTO `mob_skill_lists` VALUES ('Nuhn',312,1694); -- vile_belch
INSERT INTO `mob_skill_lists` VALUES ('Nuhn',312,1695); -- hypnic_lamp
INSERT INTO `mob_skill_lists` VALUES ('Nuhn',312,1696); -- seismic_tail
INSERT INTO `mob_skill_lists` VALUES ('Nuhn',312,1697); -- seaspray
INSERT INTO `mob_skill_lists` VALUES ('Nuhn',312,1698); -- leeching_current
INSERT INTO `mob_skill_lists` VALUES ('Tinnin',313,1828);
INSERT INTO `mob_skill_lists` VALUES ('Tinnin',313,1829);
INSERT INTO `mob_skill_lists` VALUES ('Tinnin',313,1830);
INSERT INTO `mob_skill_lists` VALUES ('Tinnin',313,1831);
INSERT INTO `mob_skill_lists` VALUES ('Tinnin',313,1832);
INSERT INTO `mob_skill_lists` VALUES ('Tinnin',313,1834);
INSERT INTO `mob_skill_lists` VALUES ('Tinnin',313,1835);
INSERT INTO `mob_skill_lists` VALUES ('Tinnin',313,1836);
INSERT INTO `mob_skill_lists` VALUES ('Sarameya',314,1785);
INSERT INTO `mob_skill_lists` VALUES ('Sarameya',314,1786);
INSERT INTO `mob_skill_lists` VALUES ('Sarameya',314,1787);
INSERT INTO `mob_skill_lists` VALUES ('Sarameya',314,1788);
INSERT INTO `mob_skill_lists` VALUES ('Sarameya',314,1789);
INSERT INTO `mob_skill_lists` VALUES ('Sarameya',314,1790);
-- INSERT INTO `mob_skill_lists` VALUES ('Tyger',315,688);
INSERT INTO `mob_skill_lists` VALUES ('Tyger',315,2022);
INSERT INTO `mob_skill_lists` VALUES ('Tyger',315,2023);
INSERT INTO `mob_skill_lists` VALUES ('Tyger',315,2024);
INSERT INTO `mob_skill_lists` VALUES ('Tyger',315,2025);
INSERT INTO `mob_skill_lists` VALUES ('Tyger',315,2026);
INSERT INTO `mob_skill_lists` VALUES ('Tyger',315,2027);
INSERT INTO `mob_skill_lists` VALUES ('Tyger',315,2028);
INSERT INTO `mob_skill_lists` VALUES ('Pandemonium',316,2113);
INSERT INTO `mob_skill_lists` VALUES ('Pandemonium',316,2114);
INSERT INTO `mob_skill_lists` VALUES ('Pandemonium',316,2116);
INSERT INTO `mob_skill_lists` VALUES ('Pandemonium',316,2117);
INSERT INTO `mob_skill_lists` VALUES ('Pandemonium',316,2118);
INSERT INTO `mob_skill_lists` VALUES ('Pandemonium',316,2119);
INSERT INTO `mob_skill_lists` VALUES ('Eldertaur',317,498); -- triclip
INSERT INTO `mob_skill_lists` VALUES ('Eldertaur',317,499); -- back_swish
INSERT INTO `mob_skill_lists` VALUES ('Eldertaur',317,500); -- mow
INSERT INTO `mob_skill_lists` VALUES ('Eldertaur',317,501); -- frightful_roar
INSERT INTO `mob_skill_lists` VALUES ('Eldertaur',317,503); -- unblessed_armor
INSERT INTO `mob_skill_lists` VALUES ('Eldertaur',317,1360); -- apocalyptic_ray
INSERT INTO `mob_skill_lists` VALUES ('Mindertaur',318,498); -- triclip
INSERT INTO `mob_skill_lists` VALUES ('Mindertaur',318,499); -- back_swish
INSERT INTO `mob_skill_lists` VALUES ('Mindertaur',318,500); -- mow
INSERT INTO `mob_skill_lists` VALUES ('Mindertaur',318,501); -- frightful_roar
INSERT INTO `mob_skill_lists` VALUES ('Mindertaur',318,1359); -- 
INSERT INTO `mob_skill_lists` VALUES ('Mindertaur',318,503); -- unblessed_armor
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Shiva',319,881);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Shiva',319,882);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Shiva',319,883);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ramuh',320,890);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ramuh',320,891);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ramuh',320,892);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Titan',321,853);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Titan',321,854);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Titan',321,855);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Titan',321,856);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ifrit',322,845);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ifrit',322,846);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Ifrit',322,847);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Leviathan',323,861);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Leviathan',323,863);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Leviathan',323,864);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Leviathan',323,865);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Garuda',324,872);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Garuda',324,873);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Garuda',324,874);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',325,831);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',325,832);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',325,833);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',325,834);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',325,835);
INSERT INTO `mob_skill_lists` VALUES ('Avatar-Fenrir',325,836);
INSERT INTO `mob_skill_lists` VALUES ('TrollGurfurlur',326,1802);
INSERT INTO `mob_skill_lists` VALUES ('TrollGurfurlur',326,1803);
INSERT INTO `mob_skill_lists` VALUES ('TrollGurfurlur',326,1804);
INSERT INTO `mob_skill_lists` VALUES ('TrollGurfurlur',326,1805);
INSERT INTO `mob_skill_lists` VALUES ('TrollGurfurlur',326,1806);
INSERT INTO `mob_skill_lists` VALUES ('TrollGurfurlur',326,1807);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,590); -- (Dynamis Goblin Normal Mob)
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,591);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1081);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1082);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1083);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1084);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1085);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1086);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1087);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1099);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1100);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1101);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1102);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1103);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1104);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1105);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1106);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1107);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1108);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',327,1109);
-- 328: Cottus
INSERT INTO `mob_skill_lists` VALUES ('AbsoluteVirtue',329,1378);
INSERT INTO `mob_skill_lists` VALUES ('AbsoluteVirtue',329,1379);
INSERT INTO `mob_skill_lists` VALUES ('AbsoluteVirtue',329,1380);
INSERT INTO `mob_skill_lists` VALUES ('AbsoluteVirtue',329,1381);
INSERT INTO `mob_skill_lists` VALUES ('AbsoluteVirtue',329,1382);
INSERT INTO `mob_skill_lists` VALUES ('AbsoluteVirtue',329,1383);
INSERT INTO `mob_skill_lists` VALUES ('AbsoluteVirtue',329,1384);
INSERT INTO `mob_skill_lists` VALUES ('AbsoluteVirtue',329,1386);
INSERT INTO `mob_skill_lists` VALUES ('PetGenbu',330,805);
INSERT INTO `mob_skill_lists` VALUES ('PetGenbu',330,806);
INSERT INTO `mob_skill_lists` VALUES ('PetGenbu',330,807);
INSERT INTO `mob_skill_lists` VALUES ('PetGenbu',330,808);
INSERT INTO `mob_skill_lists` VALUES ('PetGenbu',330,809);
INSERT INTO `mob_skill_lists` VALUES ('PetSeiryu',331,814);
INSERT INTO `mob_skill_lists` VALUES ('PetSeiryu',331,815);
INSERT INTO `mob_skill_lists` VALUES ('PetSeiryu',331,816);
INSERT INTO `mob_skill_lists` VALUES ('PetSeiryu',331,817);
INSERT INTO `mob_skill_lists` VALUES ('PetSeiryu',331,818);
INSERT INTO `mob_skill_lists` VALUES ('PetSeiryu',331,821);
INSERT INTO `mob_skill_lists` VALUES ('PetByakko',332,270);
INSERT INTO `mob_skill_lists` VALUES ('PetByakko',332,271);
INSERT INTO `mob_skill_lists` VALUES ('PetByakko',332,273);
INSERT INTO `mob_skill_lists` VALUES ('PetSuzaku',333,399);
INSERT INTO `mob_skill_lists` VALUES ('PetSuzaku',333,400);
INSERT INTO `mob_skill_lists` VALUES ('PetSuzaku',333,401);
INSERT INTO `mob_skill_lists` VALUES ('PetSuzaku',333,402);
INSERT INTO `mob_skill_lists` VALUES ('PetSuzaku',333,403);
-- INSERT INTO `mob_skill_lists` VALUES ('WarlordRojgnojOrc',334,2201);
INSERT INTO `mob_skill_lists` VALUES ('WarlordRojgnojOrc',334,605);
INSERT INTO `mob_skill_lists` VALUES ('WarlordRojgnojOrc',334,606);
INSERT INTO `mob_skill_lists` VALUES ('WarlordRojgnojOrc',334,607);
INSERT INTO `mob_skill_lists` VALUES ('WarlordRojgnojOrc',334,608);
INSERT INTO `mob_skill_lists` VALUES ('WarlordRojgnojOrc',334,609);
INSERT INTO `mob_skill_lists` VALUES ('WarlordRojgnojOrc',334,1066);
INSERT INTO `mob_skill_lists` VALUES ('Maat',335,1028);
INSERT INTO `mob_skill_lists` VALUES ('Maat',335,1033);
INSERT INTO `mob_skill_lists` VALUES ('Maat',335,1034);
INSERT INTO `mob_skill_lists` VALUES ('ZM4-Tonberry',336,783);
INSERT INTO `mob_skill_lists` VALUES ('ZM4-Tonberry',336,784);
INSERT INTO `mob_skill_lists` VALUES ('ZM4-Tonberry',336,785);
INSERT INTO `mob_skill_lists` VALUES ('ZM4-Tonberry',336,786);
INSERT INTO `mob_skill_lists` VALUES ('ZM4-Tonberry',336,787);
INSERT INTO `mob_skill_lists` VALUES ('ZM4-Tonberry',336,788);
INSERT INTO `mob_skill_lists` VALUES ('ZM4-Tonberry',336,920);
INSERT INTO `mob_skill_lists` VALUES ('QuadavNM',337,611);
INSERT INTO `mob_skill_lists` VALUES ('QuadavNM',337,612);
INSERT INTO `mob_skill_lists` VALUES ('QuadavNM',337,613);
INSERT INTO `mob_skill_lists` VALUES ('QuadavNM',337,614);
INSERT INTO `mob_skill_lists` VALUES ('QuadavNM',337,762);
INSERT INTO `mob_skill_lists` VALUES ('Twitherym',338,2950);
INSERT INTO `mob_skill_lists` VALUES ('Twitherym',338,2951);
INSERT INTO `mob_skill_lists` VALUES ('Twitherym',338,2952);
INSERT INTO `mob_skill_lists` VALUES ('Chapuli',339,2945);
INSERT INTO `mob_skill_lists` VALUES ('Chapuli',339,2946);
INSERT INTO `mob_skill_lists` VALUES ('Chapuli',339,2947);
INSERT INTO `mob_skill_lists` VALUES ('Chapuli',339,2948);
INSERT INTO `mob_skill_lists` VALUES ('Chapuli',339,2949);
INSERT INTO `mob_skill_lists` VALUES ('Mantis',340,2751);
INSERT INTO `mob_skill_lists` VALUES ('Mantis',340,2752);
INSERT INTO `mob_skill_lists` VALUES ('Mantis',340,2753);
INSERT INTO `mob_skill_lists` VALUES ('Mantis',340,2754);
INSERT INTO `mob_skill_lists` VALUES ('Mantis',340,2755);
INSERT INTO `mob_skill_lists` VALUES ('Mantis',340,2756);
-- 341: Numbing_Blossom
INSERT INTO `mob_skill_lists` VALUES ('Velkk',342,2988);
INSERT INTO `mob_skill_lists` VALUES ('Velkk',342,2989);
INSERT INTO `mob_skill_lists` VALUES ('Velkk',342,2990);
INSERT INTO `mob_skill_lists` VALUES ('Velkk',342,2991);
INSERT INTO `mob_skill_lists` VALUES ('Velkk',342,2992);
INSERT INTO `mob_skill_lists` VALUES ('Heartwing',343,2983);
INSERT INTO `mob_skill_lists` VALUES ('Heartwing',343,2984);
INSERT INTO `mob_skill_lists` VALUES ('Heartwing',343,2985);
INSERT INTO `mob_skill_lists` VALUES ('Heartwing',343,2986);
INSERT INTO `mob_skill_lists` VALUES ('Cracklaw',344,2957);
INSERT INTO `mob_skill_lists` VALUES ('Cracklaw',344,2958);
INSERT INTO `mob_skill_lists` VALUES ('Cracklaw',344,2959);
INSERT INTO `mob_skill_lists` VALUES ('Cracklaw',344,2960);
INSERT INTO `mob_skill_lists` VALUES ('Cracklaw',344,2961);
INSERT INTO `mob_skill_lists` VALUES ('Bloated_Acuex',345,2974);
INSERT INTO `mob_skill_lists` VALUES ('Bloated_Acuex',345,2975);
INSERT INTO `mob_skill_lists` VALUES ('Bloated_Acuex',345,2976);
INSERT INTO `mob_skill_lists` VALUES ('Goaftrap',346,436);
INSERT INTO `mob_skill_lists` VALUES ('Marolith',347,2927);
INSERT INTO `mob_skill_lists` VALUES ('Marolith',347,2928);
INSERT INTO `mob_skill_lists` VALUES ('Marolith',347,2929);
INSERT INTO `mob_skill_lists` VALUES ('Marolith',347,2930);
INSERT INTO `mob_skill_lists` VALUES ('Matamata',348,2965);
INSERT INTO `mob_skill_lists` VALUES ('Matamata',348,2966);
INSERT INTO `mob_skill_lists` VALUES ('Matamata',348,2967);
INSERT INTO `mob_skill_lists` VALUES ('Matamata',348,2968);
INSERT INTO `mob_skill_lists` VALUES ('Matamata',348,2969);
INSERT INTO `mob_skill_lists` VALUES ('Geyser',349,3256);
INSERT INTO `mob_skill_lists` VALUES ('Iron_Giant',350,2619);
INSERT INTO `mob_skill_lists` VALUES ('Iron_Giant',350,2620);
INSERT INTO `mob_skill_lists` VALUES ('Iron_Giant',350,2621);
INSERT INTO `mob_skill_lists` VALUES ('Iron_Giant',350,2622);
INSERT INTO `mob_skill_lists` VALUES ('Iron_Giant',350,2623);
INSERT INTO `mob_skill_lists` VALUES ('Iron_Giant',350,2624);
INSERT INTO `mob_skill_lists` VALUES ('Iron_Giant',350,2625);
INSERT INTO `mob_skill_lists` VALUES ('Iron_Giant',350,2626);
INSERT INTO `mob_skill_lists` VALUES ('Iron_Giant',350,2627);
INSERT INTO `mob_skill_lists` VALUES ('Kamlanaut (Return to Delkfutt Tower)',351,829);
INSERT INTO `mob_skill_lists` VALUES ('Kamlanaut (Return to Delkfutt Tower)',351,830);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-EV',352,933);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-EV',352,934);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-EV',352,942);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-EV',352,943);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-GK',353,937);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-GK',353,946);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-GK',353,947);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-GK',353,948);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-HM',354,931);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-HM',354,938);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-HM',354,939);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-MR',355,932);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-MR',355,940);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-MR',355,941);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-TT',356,935);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-TT',356,944);
INSERT INTO `mob_skill_lists` VALUES ('ArkAngel-TT',356,945);
-- INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,2141);
-- INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,2142);
-- INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,2143);
-- INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,2144);
-- INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,2145);
-- INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,2146);
-- INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,2147);
-- INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,2348);
-- INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,2349);
INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,275);
INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,276);
INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,277);
INSERT INTO `mob_skill_lists` VALUES ('Ambush_Antlion',357,279);
INSERT INTO `mob_skill_lists` VALUES ('Kindred',358,559);
INSERT INTO `mob_skill_lists` VALUES ('Kindred',358,560);
INSERT INTO `mob_skill_lists` VALUES ('Kindred',358,563);
INSERT INTO `mob_skill_lists` VALUES ('Kindred',358,1148);
INSERT INTO `mob_skill_lists` VALUES ('Kindred',358,1149);
INSERT INTO `mob_skill_lists` VALUES ('Fomor',359,246); -- shackled_fists (h2h only)
INSERT INTO `mob_skill_lists` VALUES ('Fomor',359,247); -- foxfire (1-handed weapons only)
INSERT INTO `mob_skill_lists` VALUES ('Fomor',359,248); -- grim_halo(2-handed weaponls only)
INSERT INTO `mob_skill_lists` VALUES ('Fomor',359,249); -- netherspikes
INSERT INTO `mob_skill_lists` VALUES ('Fomor',359,250); -- carnal_nightmare
INSERT INTO `mob_skill_lists` VALUES ('Fomor',359,251); -- aegis_schism
INSERT INTO `mob_skill_lists` VALUES ('Fomor',359,252); -- dancing_chains
INSERT INTO `mob_skill_lists` VALUES ('Fomor',359,253); -- barbed_crescent
INSERT INTO `mob_skill_lists` VALUES ('YagudoNM',360,617);
INSERT INTO `mob_skill_lists` VALUES ('YagudoNM',360,618);
INSERT INTO `mob_skill_lists` VALUES ('YagudoNM',360,619);
INSERT INTO `mob_skill_lists` VALUES ('YagudoNM',360,620);
INSERT INTO `mob_skill_lists` VALUES ('YagudoNM',360,764);
INSERT INTO `mob_skill_lists` VALUES ('DynamisLord',361,1127);
INSERT INTO `mob_skill_lists` VALUES ('DynamisLord',361,1128);
INSERT INTO `mob_skill_lists` VALUES ('DynamisLord',361,1129);
INSERT INTO `mob_skill_lists` VALUES ('DynamisLord',361,1130);
INSERT INTO `mob_skill_lists` VALUES ('DynamisLord',361,1131);
INSERT INTO `mob_skill_lists` VALUES ('DynamisLord',361,1133);
INSERT INTO `mob_skill_lists` VALUES ('DynamisLord',361,1134);
INSERT INTO `mob_skill_lists` VALUES ('Killer_Jonny',362,408); -- sound_vacuum
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,1943); -- slapstick
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2067); -- knockout
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2301); -- magic_mortar
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,1945);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,1947);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,1948);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2021);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2068);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2745);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2747);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2778);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2779);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2780);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2939);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2940);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2941);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2942);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2943);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Harlequin',363,2944);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,1944);
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,1940); -- chimera_ripper
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,1941); -- string_clipper
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2065); -- cannibal_blade
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2299); -- bone_crusher
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2743); -- string_shredder
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,1945);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,1947);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,1948);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2021);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2068);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2745);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2747);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2778);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2779);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2780);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2939);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2940);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2941);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2942);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2943);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Valoredge',364,2944);
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,1942); -- arcuballista
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2066); -- daze
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2300); -- armor_piercer
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2744); -- armor_shatterer
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,1945);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,1947);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,1948);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2021);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2068);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2745);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2746);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2747);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2778);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2779);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2780);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2939);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2940);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2941);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2942);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2943);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Sharpshot',365,2944);
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,1943); -- slapstick
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2067); -- knockout
INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2301); -- magic_mortar
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,1945);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,1947);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,1948);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2021);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2068);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2745);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2747);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2778);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2779);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2780);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2939);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2940);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2941);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2942);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2943);
-- INSERT INTO `mob_skill_lists` VALUES ('Automaton_Stormwaker',366,2944);
INSERT INTO `mob_skill_lists` VALUES ('Despot',367,536); --panzerfaust
INSERT INTO `mob_skill_lists` VALUES ('Faust',368,539); -- Typhoon
INSERT INTO `mob_skill_lists` VALUES ('Leech',369,414);
INSERT INTO `mob_skill_lists` VALUES ('Leech',369,415);
INSERT INTO `mob_skill_lists` VALUES ('Leech',369,416);
INSERT INTO `mob_skill_lists` VALUES ('Leech',369,417);
INSERT INTO `mob_skill_lists` VALUES ('Leech',369,418);
INSERT INTO `mob_skill_lists` VALUES ('Leech',369,420);
INSERT INTO `mob_skill_lists` VALUES ('Leech',369,421);
INSERT INTO `mob_skill_lists` VALUES ('Leech',369,423);
INSERT INTO `mob_skill_lists` VALUES ('Lesath',370,354); -- wild_rage
INSERT INTO `mob_skill_lists` VALUES ('Marid',371,1705);
INSERT INTO `mob_skill_lists` VALUES ('Crab',372,442);
INSERT INTO `mob_skill_lists` VALUES ('Crab',372,443);
INSERT INTO `mob_skill_lists` VALUES ('Crab',372,444);
INSERT INTO `mob_skill_lists` VALUES ('Crab',372,445);
INSERT INTO `mob_skill_lists` VALUES ('Crab',372,448);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,590); -- (Dynamis Goblin NM)
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,591);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1081);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1082);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1083);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1084);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1085);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1086);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1087);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1099);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1100);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1101);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1102);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1103);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1104);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1105);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1106);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1107);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1108);
INSERT INTO `mob_skill_lists` VALUES ('Goblin',373,1109);
INSERT INTO `mob_skill_lists` VALUES ('Fly',374,660);
INSERT INTO `mob_skill_lists` VALUES ('FlyDark',375,318);
INSERT INTO `mob_skill_lists` VALUES ('FlyDark',375,659);
INSERT INTO `mob_skill_lists` VALUES ('FlyDark',375,660);
INSERT INTO `mob_skill_lists` VALUES ('Raptor',376,374);
INSERT INTO `mob_skill_lists` VALUES ('Raptor',376,378);
INSERT INTO `mob_skill_lists` VALUES ('Raptor',376,379);
INSERT INTO `mob_skill_lists` VALUES ('Raptor',376,380);
INSERT INTO `mob_skill_lists` VALUES ('Raptor',377,374);
INSERT INTO `mob_skill_lists` VALUES ('Raptor',377,377);
INSERT INTO `mob_skill_lists` VALUES ('Raptor',377,379);
INSERT INTO `mob_skill_lists` VALUES ('Raptor',377,380);
INSERT INTO `mob_skill_lists` VALUES ('Prime-Diabolos',378,1903);
INSERT INTO `mob_skill_lists` VALUES ('Prime-Diabolos',378,1904);
INSERT INTO `mob_skill_lists` VALUES ('Prime-Diabolos',378,1905);
INSERT INTO `mob_skill_lists` VALUES ('Prime-Diabolos',378,1906);
INSERT INTO `mob_skill_lists` VALUES ('Prime-Diabolos',378,1907);
INSERT INTO `mob_skill_lists` VALUES ('Prime-Diabolos',378,1908);
INSERT INTO `mob_skill_lists` VALUES ('Prime-Diabolos',378,1909);
INSERT INTO `mob_skill_lists` VALUES ('Prime-Diabolos',378,1910);
--INSERT INTO `mob_skill_lists` VALUES ('Prime-Diabolos',378,1911); -- ruinous_omen
INSERT INTO `mob_skill_lists` VALUES ('Pet-Carbuncle',379,906);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Carbuncle',379,907);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Carbuncle',379,908);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Carbuncle',379,909);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Carbuncle',379,910);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Carbuncle',379,911);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Carbuncle',379,912);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Diabolos',380,1903);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Diabolos',380,1904);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Diabolos',380,1905);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Diabolos',380,1906);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Diabolos',380,1907);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Diabolos',380,1908);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Diabolos',380,1910);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Diabolos',380,1911);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Fenrir',381,831);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Fenrir',381,832);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Fenrir',381,833);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Fenrir',381,834);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Fenrir',381,835);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Fenrir',381,836);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Fenrir',381,837);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Fenrir',381,838);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Garuda',382,867);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Garuda',382,868);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Garuda',382,869);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Garuda',382,870);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Garuda',382,871);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Garuda',382,872);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Garuda',382,873);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Garuda',382,874);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Garuda',382,875);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ifrit',383,840);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ifrit',383,841);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ifrit',383,842);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ifrit',383,843);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ifrit',383,844);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ifrit',383,845);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ifrit',383,846);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ifrit',383,847);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ifrit',383,848);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Leviathan',384,858);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Leviathan',384,859);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Leviathan',384,860);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Leviathan',384,861);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Leviathan',384,862);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Leviathan',384,863);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Leviathan',384,864);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Leviathan',384,865);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Leviathan',384,866);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Odin',385,2126);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ramuh',386,885);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ramuh',386,886);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ramuh',386,887);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ramuh',386,888);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ramuh',386,889);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ramuh',386,890);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ramuh',386,891);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ramuh',386,892);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Ramuh',386,893);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Shiva',387,876);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Shiva',387,877);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Shiva',387,878);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Shiva',387,879);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Shiva',387,880);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Shiva',387,881);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Shiva',387,882);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Shiva',387,883);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Shiva',387,884);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Titan',388,849);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Titan',388,850);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Titan',388,851);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Titan',388,852);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Titan',388,853);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Titan',388,854);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Titan',388,855);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Titan',388,856);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Titan',388,857);
INSERT INTO `mob_skill_lists` VALUES ('Pet-Alexander',389,2143);
INSERT INTO `mob_skill_lists` VALUES ('Ladybug',390,2178);
INSERT INTO `mob_skill_lists` VALUES ('Ladybug',390,2179);
INSERT INTO `mob_skill_lists` VALUES ('Ladybug',390,2180);
INSERT INTO `mob_skill_lists` VALUES ('Ladybug',390,2181);
INSERT INTO `mob_skill_lists` VALUES ('Ladybug',390,2182);
INSERT INTO `mob_skill_lists` VALUES ('VrtraWyrm',391,1309);
INSERT INTO `mob_skill_lists` VALUES ('VrtraWyrm',391,1310);
INSERT INTO `mob_skill_lists` VALUES ('VrtraWyrm',391,1311);
INSERT INTO `mob_skill_lists` VALUES ('VrtraWyrm',391,1312);
INSERT INTO `mob_skill_lists` VALUES ('VrtraWyrm',391,1314);
INSERT INTO `mob_skill_lists` VALUES ('VrtraWyrm',391,1315);
INSERT INTO `mob_skill_lists` VALUES ('VrtraWyrm',391,1316);
-- INSERT INTO `mob_skill_lists` VALUES ('JormungandWyrm',392,1031);
INSERT INTO `mob_skill_lists` VALUES ('JormungandWyrm',392,1289);
INSERT INTO `mob_skill_lists` VALUES ('JormungandWyrm',392,1290);
INSERT INTO `mob_skill_lists` VALUES ('JormungandWyrm',392,1291);
INSERT INTO `mob_skill_lists` VALUES ('JormungandWyrm',392,1292);
INSERT INTO `mob_skill_lists` VALUES ('JormungandWyrm',392,1293);
INSERT INTO `mob_skill_lists` VALUES ('JormungandWyrm',392,1294);
INSERT INTO `mob_skill_lists` VALUES ('JormungandWyrm',392,1295);
INSERT INTO `mob_skill_lists` VALUES ('JormungandWyrm',392,1296);
-- INSERT INTO `mob_skill_lists` VALUES ('TiamatWyrm',393,1277);
INSERT INTO `mob_skill_lists` VALUES ('TiamatWyrm',393,1279);
INSERT INTO `mob_skill_lists` VALUES ('TiamatWyrm',393,1280);
INSERT INTO `mob_skill_lists` VALUES ('TiamatWyrm',393,1281);
INSERT INTO `mob_skill_lists` VALUES ('TiamatWyrm',393,1282);
INSERT INTO `mob_skill_lists` VALUES ('TiamatWyrm',393,1283);
INSERT INTO `mob_skill_lists` VALUES ('TiamatWyrm',393,1284);
INSERT INTO `mob_skill_lists` VALUES ('TiamatWyrm',393,1285);
INSERT INTO `mob_skill_lists` VALUES ('TiamatWyrm',393,1286);
INSERT INTO `mob_skill_lists` VALUES ('Ealdnarche (Celestial Nexus, phase 2)',394,985); -- Stellar Burst
INSERT INTO `mob_skill_lists` VALUES ('Ealdnarche (Celestial Nexus, phase 2)',394,986); -- Vortex
INSERT INTO `mob_skill_lists` VALUES ('Ealdnarche (Celestial Nexus, phase 2)',394,1006); -- Omega Javelin
INSERT INTO `mob_skill_lists` VALUES ('Calcabrina',395,537);
-- 396: Bedrock_Barry
INSERT INTO `mob_skill_lists` VALUES ('Qu_Vho_Deathhurler',397,611);
INSERT INTO `mob_skill_lists` VALUES ('Slumbering_Samwell',398,264);
INSERT INTO `mob_skill_lists` VALUES ('Duke_Focalor',399,559);
INSERT INTO `mob_skill_lists` VALUES ('Tegmine',400,442);
INSERT INTO `mob_skill_lists` VALUES ('Tegmine',400,443);
INSERT INTO `mob_skill_lists` VALUES ('Martinet',401,535);
INSERT INTO `mob_skill_lists` VALUES ('Aqrabuamelu',402,349);
-- 403: Autarch
INSERT INTO `mob_skill_lists` VALUES ('CureRabbit',404,257);
INSERT INTO `mob_skill_lists` VALUES ('CureRabbit',404,258);
INSERT INTO `mob_skill_lists` VALUES ('CureRabbit',404,259);
INSERT INTO `mob_skill_lists` VALUES ('CureRabbit',404,323);
INSERT INTO `mob_skill_lists` VALUES ('SnowRabbit',405,257);
INSERT INTO `mob_skill_lists` VALUES ('SnowRabbit',405,259);
INSERT INTO `mob_skill_lists` VALUES ('SnowRabbit',405,323);
INSERT INTO `mob_skill_lists` VALUES ('SnowRabbit',405,661);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Mandragora',406,2410);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Orc',407,605);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Orc',407,606);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Orc',407,607);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Orc',407,608);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Orc',407,609);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Orc',407,766);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Orc',407,2411);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Quadav',408,611);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Quadav',408,612);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Quadav',408,613);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Quadav',408,614);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Quadav',408,762);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Quadav',408,2412);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Yagudo',409,617);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Yagudo',409,618);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Yagudo',409,619);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Yagudo',409,620);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Yagudo',409,764);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Yagudo',409,2413);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Goblin',410,590);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Goblin',410,591);
INSERT INTO `mob_skill_lists` VALUES ('Seed_Goblin',410,2414);
INSERT INTO `mob_skill_lists` VALUES ('Capricious_Cassie',411,725);
INSERT INTO `mob_skill_lists` VALUES ('Capricious_Cassie',411,726);
INSERT INTO `mob_skill_lists` VALUES ('Capricious_Cassie',411,727);
INSERT INTO `mob_skill_lists` VALUES ('Capricious_Cassie',411,728);
INSERT INTO `mob_skill_lists` VALUES ('Crab_Nightmare',412,442);
INSERT INTO `mob_skill_lists` VALUES ('Crab_Nightmare',412,1590);
INSERT INTO `mob_skill_lists` VALUES ('Crab_Nightmare',412,1591);
INSERT INTO `mob_skill_lists` VALUES ('Crab_Nightmare',412,1592);
INSERT INTO `mob_skill_lists` VALUES ('Crab_Nightmare',412,1593);
INSERT INTO `mob_skill_lists` VALUES ('Capricornus',413,1864);
INSERT INTO `mob_skill_lists` VALUES ('Capricornus',413,450);
INSERT INTO `mob_skill_lists` VALUES ('Capricornus',413,451);
INSERT INTO `mob_skill_lists` VALUES ('Capricornus',413,453);
INSERT INTO `mob_skill_lists` VALUES ('Capricornus',413,454);
INSERT INTO `mob_skill_lists` VALUES ('Capricornus',413,641);
INSERT INTO `mob_skill_lists` VALUES ('Shoggoth',414,438);
INSERT INTO `mob_skill_lists` VALUES ('Shoggoth',414,439);
-- 415 to 435: free
INSERT INTO `mob_skill_lists` VALUES ('Bloodlapper',436,2162);
INSERT INTO `mob_skill_lists` VALUES ('Ghillie_Dhu',437,685);
INSERT INTO `mob_skill_lists` VALUES ('Highlander_Lizard',438,371);
INSERT INTO `mob_skill_lists` VALUES ('Aern_staff',439,1378);
INSERT INTO `mob_skill_lists` VALUES ('Aern_staff',439,1379);
INSERT INTO `mob_skill_lists` VALUES ('Aern_staff',439,1380);
INSERT INTO `mob_skill_lists` VALUES ('Aern_staff',439,1381);
INSERT INTO `mob_skill_lists` VALUES ('Aern_staff',439,1382);
INSERT INTO `mob_skill_lists` VALUES ('Aern_polearm',440,1378);
INSERT INTO `mob_skill_lists` VALUES ('Aern_polearm',440,1379);
INSERT INTO `mob_skill_lists` VALUES ('Aern_polearm',440,1380);
INSERT INTO `mob_skill_lists` VALUES ('Aern_polearm',440,1381);
INSERT INTO `mob_skill_lists` VALUES ('Aern_polearm',440,1382);
INSERT INTO `mob_skill_lists` VALUES ('Aern_polearm',440,1386);
INSERT INTO `mob_skill_lists` VALUES ('Aern_sword',441,1378);
INSERT INTO `mob_skill_lists` VALUES ('Aern_sword',441,1379);
INSERT INTO `mob_skill_lists` VALUES ('Aern_sword',441,1380);
INSERT INTO `mob_skill_lists` VALUES ('Aern_sword',441,1381);
INSERT INTO `mob_skill_lists` VALUES ('Aern_sword',441,1382);
INSERT INTO `mob_skill_lists` VALUES ('Aern_sword',441,1383);
INSERT INTO `mob_skill_lists` VALUES ('Aern_dagger',442,1378);
INSERT INTO `mob_skill_lists` VALUES ('Aern_dagger',442,1379);
INSERT INTO `mob_skill_lists` VALUES ('Aern_dagger',442,1380);
INSERT INTO `mob_skill_lists` VALUES ('Aern_dagger',442,1381);
INSERT INTO `mob_skill_lists` VALUES ('Aern_dagger',442,1382);
INSERT INTO `mob_skill_lists` VALUES ('Aern_dagger',442,1384);
INSERT INTO `mob_skill_lists` VALUES ('Aern_axe',443,1378);
INSERT INTO `mob_skill_lists` VALUES ('Aern_axe',443,1379);
INSERT INTO `mob_skill_lists` VALUES ('Aern_axe',443,1380);
INSERT INTO `mob_skill_lists` VALUES ('Aern_axe',443,1381);
INSERT INTO `mob_skill_lists` VALUES ('Aern_axe',443,1382);
INSERT INTO `mob_skill_lists` VALUES ('Aern_axe',443,1385);
-- 444: Larzos
-- 445: Portia
-- 446: Ragelise
INSERT INTO `mob_skill_lists` VALUES ('Dullahan',447,3218);
INSERT INTO `mob_skill_lists` VALUES ('Dullahan',447,3219);
INSERT INTO `mob_skill_lists` VALUES ('Dullahan',447,3220);
INSERT INTO `mob_skill_lists` VALUES ('Dullahan',447,3221);
INSERT INTO `mob_skill_lists` VALUES ('Fluturini',448,3152);
INSERT INTO `mob_skill_lists` VALUES ('Fluturini',448,3153);
INSERT INTO `mob_skill_lists` VALUES ('Fluturini',448,3154);
INSERT INTO `mob_skill_lists` VALUES ('Fluturini',448,3155);
INSERT INTO `mob_skill_lists` VALUES ('Fluturini',448,3156);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',449,1542);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',449,1543);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',449,1544);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',449,1545);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',449,1546);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',449,1547);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',449,1548);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',449,1549);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',449,1551);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',449,1552);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',449,1553);
INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2566);
INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2567);
INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2568);
INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2569);
INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2570);
INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2571);
INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2572);
INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2573);
INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2634);
INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2635);
-- INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2636);
INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2637);
INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2692);
-- INSERT INTO `mob_skill_lists` VALUES ('Caturae',450,2700);
INSERT INTO `mob_skill_lists` VALUES ('Pteraketos',451,2868);
INSERT INTO `mob_skill_lists` VALUES ('Pteraketos',451,2869);
INSERT INTO `mob_skill_lists` VALUES ('Pteraketos',451,2870);
INSERT INTO `mob_skill_lists` VALUES ('Pteraketos',451,2871);
INSERT INTO `mob_skill_lists` VALUES ('Pteraketos',451,2872);
INSERT INTO `mob_skill_lists` VALUES ('Pteraketos',451,2873);
INSERT INTO `mob_skill_lists` VALUES ('Pteraketos',451,2874);
INSERT INTO `mob_skill_lists` VALUES ('Pteraketos',451,2875);
INSERT INTO `mob_skill_lists` VALUES ('Pteraketos',451,2876);
INSERT INTO `mob_skill_lists` VALUES ('Rockfin',452,3011);
INSERT INTO `mob_skill_lists` VALUES ('Rockfin',452,3012);
INSERT INTO `mob_skill_lists` VALUES ('Rockfin',452,3013);
INSERT INTO `mob_skill_lists` VALUES ('Rockfin',452,3014);
INSERT INTO `mob_skill_lists` VALUES ('Rockfin',452,3015);
INSERT INTO `mob_skill_lists` VALUES ('Rockfin',452,3016);
INSERT INTO `mob_skill_lists` VALUES ('Belladona',453,2880);
INSERT INTO `mob_skill_lists` VALUES ('Belladona',453,2881);
INSERT INTO `mob_skill_lists` VALUES ('Belladona',453,2882);
INSERT INTO `mob_skill_lists` VALUES ('Belladona',453,2883);
INSERT INTO `mob_skill_lists` VALUES ('Belladona',453,2884);
INSERT INTO `mob_skill_lists` VALUES ('Belladona',453,2885);
INSERT INTO `mob_skill_lists` VALUES ('Tulfaire',454,3063);
INSERT INTO `mob_skill_lists` VALUES ('Tulfaire',454,3064);
INSERT INTO `mob_skill_lists` VALUES ('Tulfaire',454,3065);
INSERT INTO `mob_skill_lists` VALUES ('Tulfaire',454,3066);
INSERT INTO `mob_skill_lists` VALUES ('Leafkin',455,2978);
INSERT INTO `mob_skill_lists` VALUES ('Leafkin',455,2979);
INSERT INTO `mob_skill_lists` VALUES ('Leafkin',455,2980);
INSERT INTO `mob_skill_lists` VALUES ('Leafkin',455,2981);
INSERT INTO `mob_skill_lists` VALUES ('Leafkin',455,2982);
INSERT INTO `mob_skill_lists` VALUES ('Colkhab',456,3002);
INSERT INTO `mob_skill_lists` VALUES ('Colkhab',456,3003);
INSERT INTO `mob_skill_lists` VALUES ('Colkhab',456,3004);
INSERT INTO `mob_skill_lists` VALUES ('Colkhab',456,3005);
INSERT INTO `mob_skill_lists` VALUES ('Colkhab',456,3006);
INSERT INTO `mob_skill_lists` VALUES ('Colkhab',456,3007);
INSERT INTO `mob_skill_lists` VALUES ('Kumhau',457,3137);
INSERT INTO `mob_skill_lists` VALUES ('Kumhau',457,3138);
INSERT INTO `mob_skill_lists` VALUES ('Kumhau',457,3139);
INSERT INTO `mob_skill_lists` VALUES ('Kumhau',457,3140);
INSERT INTO `mob_skill_lists` VALUES ('Kumhau',457,3141);
INSERT INTO `mob_skill_lists` VALUES ('Kumhau',457,3142);
INSERT INTO `mob_skill_lists` VALUES ('Raaz',458,3148);
INSERT INTO `mob_skill_lists` VALUES ('Raaz',458,3149);
INSERT INTO `mob_skill_lists` VALUES ('Raaz',458,3150);
INSERT INTO `mob_skill_lists` VALUES ('Raaz',458,3151);
INSERT INTO `mob_skill_lists` VALUES ('Yztarg',459,2922);
INSERT INTO `mob_skill_lists` VALUES ('Yztarg',459,2923);
INSERT INTO `mob_skill_lists` VALUES ('Yztarg',459,2924);
INSERT INTO `mob_skill_lists` VALUES ('Yztarg',459,2925);
INSERT INTO `mob_skill_lists` VALUES ('Yztarg',459,2926);
INSERT INTO `mob_skill_lists` VALUES ('Hurkan',460,3073);
INSERT INTO `mob_skill_lists` VALUES ('Hurkan',460,3074);
INSERT INTO `mob_skill_lists` VALUES ('Hurkan',460,3075);
INSERT INTO `mob_skill_lists` VALUES ('Hurkan',460,3076);
INSERT INTO `mob_skill_lists` VALUES ('Hurkan',460,3077);
INSERT INTO `mob_skill_lists` VALUES ('Achuka',461,3020);
INSERT INTO `mob_skill_lists` VALUES ('Achuka',461,3021);
INSERT INTO `mob_skill_lists` VALUES ('Achuka',461,3022);
INSERT INTO `mob_skill_lists` VALUES ('Achuka',461,3023);
INSERT INTO `mob_skill_lists` VALUES ('Achuka',461,3024);
INSERT INTO `mob_skill_lists` VALUES ('Achuka',461,3025);
INSERT INTO `mob_skill_lists` VALUES ('Achuka',461,3026);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2515);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2839);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2840);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2841);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2842);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2843);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2844);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2852);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2853);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2854);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2856);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2857);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2858);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2859);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2860);
INSERT INTO `mob_skill_lists` VALUES ('Provenance_watcher',462,2861);
INSERT INTO `mob_skill_lists` VALUES ('Panopt',463,3030);
INSERT INTO `mob_skill_lists` VALUES ('Panopt',463,3031);
INSERT INTO `mob_skill_lists` VALUES ('Panopt',463,3032);
INSERT INTO `mob_skill_lists` VALUES ('Panopt',463,3033);
INSERT INTO `mob_skill_lists` VALUES ('Snapweed',464,3097);
INSERT INTO `mob_skill_lists` VALUES ('Snapweed',464,3098);
INSERT INTO `mob_skill_lists` VALUES ('Snapweed',464,3099);
INSERT INTO `mob_skill_lists` VALUES ('Snapweed',464,3101);
INSERT INTO `mob_skill_lists` VALUES ('Yumcax',465,3057);
INSERT INTO `mob_skill_lists` VALUES ('Yumcax',465,3058);
INSERT INTO `mob_skill_lists` VALUES ('Yumcax',465,3059);
INSERT INTO `mob_skill_lists` VALUES ('Yumcax',465,3060);
INSERT INTO `mob_skill_lists` VALUES ('Yumcax',465,3061);
INSERT INTO `mob_skill_lists` VALUES ('Yumcax',465,3062);
INSERT INTO `mob_skill_lists` VALUES ('Muq_Shabeel',466,480); -- petrifactive_breath
INSERT INTO `mob_skill_lists` VALUES ('Gallu',467,2784);
INSERT INTO `mob_skill_lists` VALUES ('Gallu',467,2785);
INSERT INTO `mob_skill_lists` VALUES ('Gallu',467,2786);
INSERT INTO `mob_skill_lists` VALUES ('Gallu',467,2787);
INSERT INTO `mob_skill_lists` VALUES ('Gallu',467,2788);
INSERT INTO `mob_skill_lists` VALUES ('Gallu',467,2789);
INSERT INTO `mob_skill_lists` VALUES ('Gallu',467,2790);
INSERT INTO `mob_skill_lists` VALUES ('Umbril',468,2970);
INSERT INTO `mob_skill_lists` VALUES ('Umbril',468,2971);
INSERT INTO `mob_skill_lists` VALUES ('Umbril',468,2972);
INSERT INTO `mob_skill_lists` VALUES ('Macan_Gadangan',469,652); -- blaster
INSERT INTO `mob_skill_lists` VALUES ('Macan_Gadangan',469,653); -- chaotic_eye
INSERT INTO `mob_skill_lists` VALUES ('Macan_Gadangan',469,480); -- petrifactive_breath
INSERT INTO `mob_skill_lists` VALUES ('Macan_Gadangan',469,483); -- charged_whisker
INSERT INTO `mob_skill_lists` VALUES ('Macan_Gadangan',469,481); -- frenzied_rage
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',470,2519);
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',470,2520);
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',470,2521);
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',470,2522);
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',470,2523);
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',470,2524);
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',470,2525);
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',470,2526);
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',470,2527);
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',470,2528);
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',470,2529);
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',470,2530);
INSERT INTO `mob_skill_lists` VALUES ('Harpeia',471,2725);
INSERT INTO `mob_skill_lists` VALUES ('Harpeia',471,2726);
INSERT INTO `mob_skill_lists` VALUES ('Harpeia',471,2727);
INSERT INTO `mob_skill_lists` VALUES ('Harpeia',471,2728);
INSERT INTO `mob_skill_lists` VALUES ('Harpeia',471,2729);
INSERT INTO `mob_skill_lists` VALUES ('Harpeia',471,2730);
-- INSERT INTO `mob_skill_lists` VALUES ('Harpeia',471,2758);
-- INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2501);
-- INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2555);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2684);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2685);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2686);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2687);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2688);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2689);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2690);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2691);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2714);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2715);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2716);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2717);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2718);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2719);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2720);
INSERT INTO `mob_skill_lists` VALUES ('Naraka',472,2721);
INSERT INTO `mob_skill_lists` VALUES ('Lady_Lilith',473,2675);
INSERT INTO `mob_skill_lists` VALUES ('Lady_Lilith',473,2676);
INSERT INTO `mob_skill_lists` VALUES ('Lady_Lilith',473,2677);
INSERT INTO `mob_skill_lists` VALUES ('Lady_Lilith',473,2678);
INSERT INTO `mob_skill_lists` VALUES ('Lady_Lilith',473,2679);
INSERT INTO `mob_skill_lists` VALUES ('Lady_Lilith',473,2680);
-- 474: Lilith_Ascendant
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2650);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2651);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2652);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2653);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2654);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2655);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2656);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2657);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2658);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2659);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2660);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2661);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2662);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2663);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2664);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2665);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2666);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2667);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2668);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2669);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2670);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2671);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2708);
INSERT INTO `mob_skill_lists` VALUES ('Shinryu',475,2709);
INSERT INTO `mob_skill_lists` VALUES ('Prishe',476,1487);
INSERT INTO `mob_skill_lists` VALUES ('Prishe',476,1488);
INSERT INTO `mob_skill_lists` VALUES ('Prishe',476,1489);
INSERT INTO `mob_skill_lists` VALUES ('Prishe',476,1490);
INSERT INTO `mob_skill_lists` VALUES ('Selhteus',477,1508);
INSERT INTO `mob_skill_lists` VALUES ('Selhteus',477,1509);
INSERT INTO `mob_skill_lists` VALUES ('Selhteus',477,1510);
INSERT INTO `mob_skill_lists` VALUES ('God',478,1500);
INSERT INTO `mob_skill_lists` VALUES ('God',478,1501);
INSERT INTO `mob_skill_lists` VALUES ('God',478,1502);
INSERT INTO `mob_skill_lists` VALUES ('God',478,1503);
INSERT INTO `mob_skill_lists` VALUES ('God',478,1504);
INSERT INTO `mob_skill_lists` VALUES ('God',478,1505);
INSERT INTO `mob_skill_lists` VALUES ('God',478,1506);
INSERT INTO `mob_skill_lists` VALUES ('God',478,1507);
INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',479,628);
INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',479,629);
INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',479,630);
INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',479,631);
INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',479,632);
INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',479,633);
INSERT INTO `mob_skill_lists` VALUES ('Zeid',480,979); -- Power Slash
INSERT INTO `mob_skill_lists` VALUES ('Zeid',480,980); -- Freeze Bite
INSERT INTO `mob_skill_lists` VALUES ('Zeid',480,981); -- GroundStrike
INSERT INTO `mob_skill_lists` VALUES ('Zeid',480,987); -- Shockwave
INSERT INTO `mob_skill_lists` VALUES ('Zeid',480,982); -- Abyssal Drain
INSERT INTO `mob_skill_lists` VALUES ('Zeid',480,983); -- Abyssal strike
INSERT INTO `mob_skill_lists` VALUES ('Zeid',480,1002); -- Summonshadows
INSERT INTO `mob_skill_lists` VALUES ('Ajido-Marujido',481,988); -- Warp In (Works the same as Ealdnarche's)
INSERT INTO `mob_skill_lists` VALUES ('Ajido-Marujido',481,989); -- Warp Out (Works the same as Ealdnarche's)
INSERT INTO `mob_skill_lists` VALUES ('Volker',482,973); -- Red Lotus Blade
INSERT INTO `mob_skill_lists` VALUES ('Volker',482,974); -- Spirits Within
INSERT INTO `mob_skill_lists` VALUES ('Volker',482,975); -- Vorpal Blade
INSERT INTO `mob_skill_lists` VALUES ('Volker',482,976); -- Berserk-Ruf
INSERT INTO `mob_skill_lists` VALUES ('Trion',483,968); -- Red Lotus Blade
INSERT INTO `mob_skill_lists` VALUES ('Trion',483,969); -- Flat blade
INSERT INTO `mob_skill_lists` VALUES ('Trion',483,970); -- Savage blade
INSERT INTO `mob_skill_lists` VALUES ('Trion',483,971); -- Royal Bash
INSERT INTO `mob_skill_lists` VALUES ('Trion',483,972); -- Royal Savior
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',484,2442);
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',484,2443);
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',484,2444);
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',484,2445);
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',484,2446);
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',484,2447);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv1',485,3389);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv1',485,3390);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv1',485,3391);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv1',485,3392);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv1',485,3393);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv1',485,3394);
-- INSERT INTO `mob_skill_lists` VALUES ('Arciela',486,3081);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv2',487,3399);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv2',487,3400);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv2',487,3401);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv2',487,3402);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv2',487,3403);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv2',487,3404);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv2',487,3405);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv2',487,3406);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv2',487,3407);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv2',487,3408);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv2',487,3409);
INSERT INTO `mob_skill_lists` VALUES ('Hadesv2',487,3410);
INSERT INTO `mob_skill_lists` VALUES ('Theodor',488,3380);
INSERT INTO `mob_skill_lists` VALUES ('Theodor',488,3381);
INSERT INTO `mob_skill_lists` VALUES ('Theodor',488,3382);
INSERT INTO `mob_skill_lists` VALUES ('Theodor',488,3383);
INSERT INTO `mob_skill_lists` VALUES ('Theodor',488,3384);
INSERT INTO `mob_skill_lists` VALUES ('Theodor',488,3385);
INSERT INTO `mob_skill_lists` VALUES ('Darrcuiln',489,3168);
INSERT INTO `mob_skill_lists` VALUES ('Darrcuiln',489,3169);
INSERT INTO `mob_skill_lists` VALUES ('Darrcuiln',489,3170);
INSERT INTO `mob_skill_lists` VALUES ('Darrcuiln',489,3171);
INSERT INTO `mob_skill_lists` VALUES ('Darrcuiln',489,3172);
INSERT INTO `mob_skill_lists` VALUES ('Dhokmak',490,3303);
INSERT INTO `mob_skill_lists` VALUES ('Dhokmak',490,3304);
INSERT INTO `mob_skill_lists` VALUES ('Dhokmak',490,3305);
INSERT INTO `mob_skill_lists` VALUES ('Dhokmak',490,3306);
INSERT INTO `mob_skill_lists` VALUES ('Dhokmak',490,3307);
INSERT INTO `mob_skill_lists` VALUES ('Dhokmak',490,3372);
INSERT INTO `mob_skill_lists` VALUES ('Dhokmak',490,3373);
INSERT INTO `mob_skill_lists` VALUES ('Dhokmak',490,3374);
INSERT INTO `mob_skill_lists` VALUES ('Dhokmak',490,3375);
INSERT INTO `mob_skill_lists` VALUES ('Dhokmak',490,3376);
INSERT INTO `mob_skill_lists` VALUES ('Morimar',491,3160);
INSERT INTO `mob_skill_lists` VALUES ('Morimar',491,3161);
INSERT INTO `mob_skill_lists` VALUES ('Morimar',491,3162);
INSERT INTO `mob_skill_lists` VALUES ('Morimar',491,3163);
INSERT INTO `mob_skill_lists` VALUES ('Morimar',491,3164);
INSERT INTO `mob_skill_lists` VALUES ('Sobbing_Eyes',492,437); -- death_ray
INSERT INTO `mob_skill_lists` VALUES ('Sobbing_Eyes',492,438); -- hex_eye
INSERT INTO `mob_skill_lists` VALUES ('Sobbing_Eyes',492,439); -- petro_gaze
INSERT INTO `mob_skill_lists` VALUES ('Sobbing_Eyes',492,440); -- catharsis
INSERT INTO `mob_skill_lists` VALUES ('Ashrakk',493,3363);
INSERT INTO `mob_skill_lists` VALUES ('Ashrakk',493,3364);
INSERT INTO `mob_skill_lists` VALUES ('Ashrakk',493,3365);
INSERT INTO `mob_skill_lists` VALUES ('Ashrakk',493,3366);
INSERT INTO `mob_skill_lists` VALUES ('Ashrakk',493,3367);
INSERT INTO `mob_skill_lists` VALUES ('Ashrakk',493,3368);
INSERT INTO `mob_skill_lists` VALUES ('Sekhmet',494,483);
INSERT INTO `mob_skill_lists` VALUES ('Astral_Flow_Pet',495,839);
INSERT INTO `mob_skill_lists` VALUES ('Astral_Flow_Pet',495,912);
INSERT INTO `mob_skill_lists` VALUES ('Astral_Flow_Pet',495,913);
INSERT INTO `mob_skill_lists` VALUES ('Astral_Flow_Pet',495,914);
INSERT INTO `mob_skill_lists` VALUES ('Astral_Flow_Pet',495,915);
INSERT INTO `mob_skill_lists` VALUES ('Astral_Flow_Pet',495,916);
INSERT INTO `mob_skill_lists` VALUES ('Astral_Flow_Pet',495,917);
INSERT INTO `mob_skill_lists` VALUES ('Astral_Flow_Pet',495,918);
INSERT INTO `mob_skill_lists` VALUES ('ChanequeMandragora',496,2210);
INSERT INTO `mob_skill_lists` VALUES ('Gerjis',497,270); -- roar
INSERT INTO `mob_skill_lists` VALUES ('Gerjis',497,271); -- razor_fang
INSERT INTO `mob_skill_lists` VALUES ('Gerjis',497,273); -- claw_cyclone
INSERT INTO `mob_skill_lists` VALUES ('Gerjis',497,1322); -- gerjis_grip
-- INSERT INTO `mob_skill_lists` VALUES ('Gerjis',497,1681); -- crossthrash
-- 498: Cyranuce_M_Cutauleon
-- 499 to 699: free
INSERT INTO `mob_skill_lists` VALUES ('Mammet',503,347);
INSERT INTO `mob_skill_lists` VALUES ('Mammet',503,419);
INSERT INTO `mob_skill_lists` VALUES ('Mammet',503,422);
INSERT INTO `mob_skill_lists` VALUES ('Mammet',503,441);
INSERT INTO `mob_skill_lists` VALUES ('Mammet',503,447);
INSERT INTO `mob_skill_lists` VALUES ('Mammet',503,457);
INSERT INTO `mob_skill_lists` VALUES ('Mammet',503,464);
INSERT INTO `mob_skill_lists` VALUES ('Mammet',503,471);
INSERT INTO `mob_skill_lists` VALUES ('Mammet',503,487);
INSERT INTO `mob_skill_lists` VALUES ('Mammet',503,540);
INSERT INTO `mob_skill_lists` VALUES ('Demonic_Tiphia',700,334);
INSERT INTO `mob_skill_lists` VALUES ('Demonic_Tiphia',700,335);
INSERT INTO `mob_skill_lists` VALUES ('Demonic_Tiphia',700,336);
-- 701 to 702: free
INSERT INTO `mob_skill_lists` VALUES ('Cactrot_Rapido',703,321);
INSERT INTO `mob_skill_lists` VALUES ('Cactrot_Rapido',703,322);
INSERT INTO `mob_skill_lists` VALUES ('Cactrot_Rapido',703,324);
INSERT INTO `mob_skill_lists` VALUES ('Cactrot_Rapido',703,1120);
INSERT INTO `mob_skill_lists` VALUES ('Fee_special_attack',704,1671); -- ink_jet_alt
INSERT INTO `mob_skill_lists` VALUES ('Effigy_Shield',705,1075);
INSERT INTO `mob_skill_lists` VALUES ('Effigy_Shield',705,1076);
INSERT INTO `mob_skill_lists` VALUES ('Effigy_Shield',705,1077);
INSERT INTO `mob_skill_lists` VALUES ('Effigy_Shield',705,1078);
INSERT INTO `mob_skill_lists` VALUES ('Effigy_Shield',705,762);
INSERT INTO `mob_skill_lists` VALUES ('Effigy_Shield',705,1080);
INSERT INTO `mob_skill_lists` VALUES ('Thinker_NM',706,1243); -- negative_whirl
INSERT INTO `mob_skill_lists` VALUES ('Thinker_NM',706,1244); -- stygian_vapor
INSERT INTO `mob_skill_lists` VALUES ('Thinker_NM',706,1245); -- winds_of_promyvion
INSERT INTO `mob_skill_lists` VALUES ('Thinker_NM',706,1248); -- trinary_absorption
INSERT INTO `mob_skill_lists` VALUES ('Thinker_NM',706,1251); -- trinary_tap
INSERT INTO `mob_skill_lists` VALUES ('Thinker_NM',706,1252); -- shadow_spread
INSERT INTO `mob_skill_lists` VALUES ('Craver_NM',707,1232); -- Murk
INSERT INTO `mob_skill_lists` VALUES ('Craver_NM',707,1233); -- material_fend
INSERT INTO `mob_skill_lists` VALUES ('Craver_NM',707,1234); -- carousel
INSERT INTO `mob_skill_lists` VALUES ('Craver_NM',707,1274); -- impalement
INSERT INTO `mob_skill_lists` VALUES ('Craver_NM',707,1276); -- promyvion_brume
-- INSERT INTO `mob_skill_lists` VALUES ('Propagator',708,741); -- Replaced with list 138
-- INSERT INTO `mob_skill_lists` VALUES ('Propagator',708,744);
-- INSERT INTO `mob_skill_lists` VALUES ('Propagator',708,747);
-- INSERT INTO `mob_skill_lists` VALUES ('Propagator',708,750);
-- INSERT INTO `mob_skill_lists` VALUES ('Propagator',708,752);
-- INSERT INTO `mob_skill_lists` VALUES ('Propagator',708,755);
INSERT INTO `mob_skill_lists` VALUES ('Jagil',709,449);
INSERT INTO `mob_skill_lists` VALUES ('Jagil',709,450);
INSERT INTO `mob_skill_lists` VALUES ('Jagil',709,451);
INSERT INTO `mob_skill_lists` VALUES ('Jagil',709,453);
INSERT INTO `mob_skill_lists` VALUES ('Jagil',709,454);
INSERT INTO `mob_skill_lists` VALUES ('Jagil',709,641);
INSERT INTO `mob_skill_lists` VALUES ('DynamisYagudoNM',710,617);
INSERT INTO `mob_skill_lists` VALUES ('DynamisYagudoNM',710,618);
INSERT INTO `mob_skill_lists` VALUES ('DynamisYagudoNM',710,619);
INSERT INTO `mob_skill_lists` VALUES ('DynamisYagudoNM',710,620);
INSERT INTO `mob_skill_lists` VALUES ('DynamisYagudoNM',710,764);
INSERT INTO `mob_skill_lists` VALUES ('DynamisYagudoNM',710,1067);
INSERT INTO `mob_skill_lists` VALUES ('Petrifying_Pair',711,370); -- baleful_gaze
INSERT INTO `mob_skill_lists` VALUES ('Petrifying_Pair',711,373); -- secretion
INSERT INTO `mob_skill_lists` VALUES ('Sahagin DRG',712,770);
INSERT INTO `mob_skill_lists` VALUES ('Sahagin DRG',712,771);
INSERT INTO `mob_skill_lists` VALUES ('Sahagin DRG',712,774);
INSERT INTO `mob_skill_lists` VALUES ('Sahagin DRG',712,777);
INSERT INTO `mob_skill_lists` VALUES ('Sahagin DRG',712,780);
INSERT INTO `mob_skill_lists` VALUES ('Orc DRG',713,605);
INSERT INTO `mob_skill_lists` VALUES ('Orc DRG',713,606);
INSERT INTO `mob_skill_lists` VALUES ('Orc DRG',713,607);
INSERT INTO `mob_skill_lists` VALUES ('Orc DRG',713,608);
INSERT INTO `mob_skill_lists` VALUES ('Orc DRG',713,609);
INSERT INTO `mob_skill_lists` VALUES ('Orc DRG',713,766);
INSERT INTO `mob_skill_lists` VALUES ('Orc DRG',713,1064);
INSERT INTO `mob_skill_lists` VALUES ('MobWyvern',714,900);
INSERT INTO `mob_skill_lists` VALUES ('MobWyvern',714,901);
INSERT INTO `mob_skill_lists` VALUES ('MobWyvern',714,902);
INSERT INTO `mob_skill_lists` VALUES ('MobWyvern',714,903);
INSERT INTO `mob_skill_lists` VALUES ('MobWyvern',714,904);
INSERT INTO `mob_skill_lists` VALUES ('MobWyvern',714,905);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Ifrit',715,843);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Ifrit',715,844);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Ifrit',715,846);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Titan',716,852);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Titan',716,853);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Titan',716,855);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Levi',717,860);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Levi',717,861);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Levi',717,864);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Garuda',718,869);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Garuda',718,871);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Garuda',718,873);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Shiva',719,878);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Shiva',719,880);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Shiva',719,882);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Ramuh',720,888);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Ramuh',720,889);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Ramuh',720,891);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Carbuncle',721,909);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Carbuncle',721,910);
INSERT INTO `mob_skill_lists` VALUES ('Mob_Avatar_Carbuncle',721,911);
INSERT INTO `mob_skill_lists` VALUES ('Prune',722,325);
INSERT INTO `mob_skill_lists` VALUES ('Prune',722,414);
INSERT INTO `mob_skill_lists` VALUES ('Prune',722,415);
INSERT INTO `mob_skill_lists` VALUES ('Prune',722,416);
INSERT INTO `mob_skill_lists` VALUES ('Prune',722,417);
INSERT INTO `mob_skill_lists` VALUES ('Prune',722,418);
INSERT INTO `mob_skill_lists` VALUES ('Prune',722,420);
INSERT INTO `mob_skill_lists` VALUES ('Prune',722,421);
INSERT INTO `mob_skill_lists` VALUES ('Prune',722,423);
INSERT INTO `mob_skill_lists` VALUES ('Phoedme',723,327);
INSERT INTO `mob_skill_lists` VALUES ('Phoedme',723,414);
INSERT INTO `mob_skill_lists` VALUES ('Phoedme',723,415);
INSERT INTO `mob_skill_lists` VALUES ('Phoedme',723,416);
INSERT INTO `mob_skill_lists` VALUES ('Phoedme',723,417);
INSERT INTO `mob_skill_lists` VALUES ('Phoedme',723,418);
INSERT INTO `mob_skill_lists` VALUES ('Phoedme',723,421);
INSERT INTO `mob_skill_lists` VALUES ('Phoedme',723,420);
INSERT INTO `mob_skill_lists` VALUES ('Phoedme',723,423);
INSERT INTO `mob_skill_lists` VALUES ('Pepper',724,326);
INSERT INTO `mob_skill_lists` VALUES ('Pepper',724,414);
INSERT INTO `mob_skill_lists` VALUES ('Pepper',724,415);
INSERT INTO `mob_skill_lists` VALUES ('Pepper',724,416);
INSERT INTO `mob_skill_lists` VALUES ('Pepper',724,417);
INSERT INTO `mob_skill_lists` VALUES ('Pepper',724,418);
INSERT INTO `mob_skill_lists` VALUES ('Pepper',724,420);
INSERT INTO `mob_skill_lists` VALUES ('Pepper',724,421);
INSERT INTO `mob_skill_lists` VALUES ('Pepper',724,423);
INSERT INTO `mob_skill_lists` VALUES ('Medusa',725,1808);
INSERT INTO `mob_skill_lists` VALUES ('Medusa',725,1809);
INSERT INTO `mob_skill_lists` VALUES ('Medusa',725,1810);
INSERT INTO `mob_skill_lists` VALUES ('Medusa',725,1812);
INSERT INTO `mob_skill_lists` VALUES ('Medusa',725,1813);
INSERT INTO `mob_skill_lists` VALUES ('Medusa',725,1814);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',726,1542);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',726,1543);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',726,1544);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',726,1545);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',726,1546);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',726,1547);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',726,1548);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',726,1549);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',726,1551);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',726,1552);
INSERT INTO `mob_skill_lists` VALUES ('Bahamut',726,1553);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Omega',727,1525);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Omega',727,1526);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Omega',727,1527);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Omega',727,1528);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Omega',727,1529);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Omega',727,1530);
--INSERT INTO `mob_skill_lists` VALUES ('Proto-Omega',727,1532); -- Pod Ejection
INSERT INTO `mob_skill_lists` VALUES ('Proto-Omega',727,1533);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Omega',727,1534);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Omega',727,1536);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Omega',727,1538);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Omega',727,1539);
INSERT INTO `mob_skill_lists` VALUES ('Ultima',728,1259);
INSERT INTO `mob_skill_lists` VALUES ('Ultima',728,1260);
INSERT INTO `mob_skill_lists` VALUES ('Ultima',728,1261);
INSERT INTO `mob_skill_lists` VALUES ('Ultima',728,1262);
INSERT INTO `mob_skill_lists` VALUES ('Ultima',728,1263);
INSERT INTO `mob_skill_lists` VALUES ('Ultima',728,1264);
INSERT INTO `mob_skill_lists` VALUES ('Ultima',728,1265);
INSERT INTO `mob_skill_lists` VALUES ('Ultima',728,1266);
INSERT INTO `mob_skill_lists` VALUES ('Ultima',728,1267);
INSERT INTO `mob_skill_lists` VALUES ('Ultima',728,1268);
INSERT INTO `mob_skill_lists` VALUES ('Ultima',728,1269);
INSERT INTO `mob_skill_lists` VALUES ('Ultima',728,1270);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1259);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1260);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1261);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1262);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1263);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1264);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1265);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1266);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1267);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1268);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1269);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1521);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1522);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1523);
INSERT INTO `mob_skill_lists` VALUES ('Proto-Ultima',729,1540);
INSERT INTO `mob_skill_lists` VALUES ('Tiamat-Flying-Attack',730,1278);
INSERT INTO `mob_skill_lists` VALUES ('Ouryu-Flying-Attack',731,1298);
INSERT INTO `mob_skill_lists` VALUES ('Jormungand-Flying-Attack',732,1288);

-- Jug Pets
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hare', 733, 672);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hare', 733, 673);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hare', 733, 674);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hare', 733, 735);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Mandragora', 734, 675);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Mandragora', 734, 677);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Mandragora', 734, 678);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Mandragora', 734, 679);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Tiger', 735, 680);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Tiger', 735, 681);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Tiger', 735, 682);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lizard', 736, 683);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lizard', 736, 684);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lizard', 736, 685);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lizard', 736, 686);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lizard', 736, 687);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lizard', 736, 688);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Sheep', 737, 689);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Sheep', 737, 690);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Sheep', 737, 691);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Sheep', 737, 692);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab', 738, 693);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab', 738, 694);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab', 738, 695);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab', 738, 696);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab', 738, 697);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Cactuar', 739, 698);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Cactuar', 739, 699);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar', 740, 700);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar', 740, 701);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar', 740, 702);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar', 740, 703);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar', 740, 704);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar', 740, 705);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Funguar', 740, 706);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle', 741, 707);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle', 741, 708);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle', 741, 709);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle', 741, 710);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle', 741, 711);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Fly', 742, 712);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Fly', 742, 713);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Fly', 742, 772);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Antlion', 743, 714);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Antlion', 743, 715);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Antlion', 743, 716);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Antlion', 743, 717);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Flytrap', 744, 718);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Flytrap', 744, 719);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Flytrap', 744, 720);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Eft', 745, 721);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Eft', 745, 722);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Eft', 745, 723);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Eft', 745, 724);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Eft', 745, 725);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Diremite', 746, 726);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Diremite', 746, 727);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Diremite', 746, 728);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Diremite', 746, 729);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Coeurl', 747, 730);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Coeurl', 747, 731);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Leech', 748, 732);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Leech', 748, 733);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Leech', 748, 740);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Leech', 748, 741);
INSERT INTO `mob_skill_lists` VALUES ('Jug_SnowHare', 749, 672);
INSERT INTO `mob_skill_lists` VALUES ('Jug_SnowHare', 749, 674);
INSERT INTO `mob_skill_lists` VALUES ('Jug_SnowHare', 749, 734);
INSERT INTO `mob_skill_lists` VALUES ('Jug_SnowHare', 749, 735);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Ladybug', 750, 736);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Ladybug', 750, 737);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Ladybug', 750, 738);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Raptor', 751, 743);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Raptor', 751, 744);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Raptor', 751, 745);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Slug', 752, 747);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Slug', 752, 748);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hippogryph', 753, 749);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hippogryph', 753, 750);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hippogryph', 753, 751);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hippogryph', 753, 752);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Slime', 754, 792);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Slime', 754, 793);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Slime', 754, 794);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Apkallu', 755, 756);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Apkallu', 755, 757);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Pugil', 756, 758);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Pugil', 756, 759);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Pugil', 756, 760);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Chapuli', 757, 761);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Chapuli', 757, 762);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Tulfaire', 758, 763);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Tulfaire', 758, 764);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Tulfaire', 758, 767);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Raaz', 759, 765);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Raaz', 759, 766);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Snapweed', 760, 768);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Snapweed', 760, 769);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Snapweed', 760, 770);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Snapweed', 760, 771);
INSERT INTO `mob_skill_lists` VALUES ('Jug_FlyHi', 761, 713);
INSERT INTO `mob_skill_lists` VALUES ('Jug_FlyHi', 761, 772);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Acuex', 762, 774);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Acuex', 762, 775);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Colibri', 763, 776);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Spider', 764, 777);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Spider', 764, 778);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Spider', 764, 779);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lynx', 765, 730);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lynx', 765, 731);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lynx', 765, 746);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lynx', 765, 790);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lycopodium', 766, 675);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lycopodium', 766, 677);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lycopodium', 766, 678);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Lycopodium', 766, 679);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Smilodon', 1189, 680);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Smilodon', 1189, 681);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Smilodon', 1189, 682);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Smilodon', 1189, 795);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Smilodon', 1189, 796);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hippogryph_2', 1190, 749);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hippogryph_2', 1190, 750);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hippogryph_2', 1190, 751);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hippogryph_2', 1190, 752);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hippogryph_2', 1190, 797);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Hippogryph_2', 1190, 798);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab_Porter', 1191, 693);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab_Porter', 1191, 694);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab_Porter', 1191, 695);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab_Porter', 1191, 696);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab_Porter', 1191, 697);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab_Porter', 1191, 788);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Crab_Porter', 1191, 789);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle_Yellow', 1192, 707);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle_Yellow', 1192, 708);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle_Yellow', 1192, 709);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle_Yellow', 1192, 710);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle_Yellow', 1192, 711);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Beetle_Yellow', 1192, 791);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Mosquito', 1193, 781);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Mosquito', 1193, 782);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Weevil', 1194, 786);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Weevil', 1194, 787);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Adamantoise', 1197, 753);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Adamantoise', 1197, 754);
INSERT INTO `mob_skill_lists` VALUES ('Jug_Adamantoise', 1197, 755);

-- Qultada (Breaking the Bonds of Fate)
INSERT INTO `mob_skill_lists` VALUES ('QultadaSword',1195,39); -- Spirits Within
INSERT INTO `mob_skill_lists` VALUES ('QultadaSword',1195,42); -- Savage Blade

-- Qultada (Mythic Weapon)
INSERT INTO `mob_skill_lists` VALUES ('Qultada-Mythic',1196,39);    -- Spirits Within
INSERT INTO `mob_skill_lists` VALUES ('Qultada-Mythic',1196,42);    -- Savage Blade
INSERT INTO `mob_skill_lists` VALUES ('Qultada-Mythic',1196,212);   -- Slugshot
INSERT INTO `mob_skill_lists` VALUES ('Qultada-Mythic',1196,3253);  -- Leaden Salute

INSERT INTO `mob_skill_lists` VALUES ('ShikareeWyvernReqOfSin',1198,896);
INSERT INTO `mob_skill_lists` VALUES ('ShikareeWyvernReqOfSin',1198,900);
INSERT INTO `mob_skill_lists` VALUES ('ShikareeWyvernReqOfSin',1198,901);
INSERT INTO `mob_skill_lists` VALUES ('ShikareeWyvernReqOfSin',1198,902);
INSERT INTO `mob_skill_lists` VALUES ('ShikareeWyvernReqOfSin',1198,903);
INSERT INTO `mob_skill_lists` VALUES ('ShikareeWyvernReqOfSin',1198,904);
INSERT INTO `mob_skill_lists` VALUES ('ShikareeWyvernReqOfSin',1198,905);

INSERT INTO `mob_skill_lists` VALUES ('Prickly_Sheep',1199,262); -- Sheep Charge
INSERT INTO `mob_skill_lists` VALUES ('Prickly_Sheep',1199,264); -- Sheep Charge

INSERT INTO `mob_skill_lists` VALUES ('Ob_Valoredge',1200,1940); -- chimera_ripper
INSERT INTO `mob_skill_lists` VALUES ('Ob_Valoredge',1200,1941); -- string_clipper
INSERT INTO `mob_skill_lists` VALUES ('Ob_Valoredge',1200,2065); -- cannibal_blade
INSERT INTO `mob_skill_lists` VALUES ('Ob_Valoredge',1200,2299); -- bone_crusher

INSERT INTO `mob_skill_lists` VALUES ('Ob_Sharpshot',1201,1942); -- arcuballista
INSERT INTO `mob_skill_lists` VALUES ('Ob_Sharpshot',1201,2066); -- daze
INSERT INTO `mob_skill_lists` VALUES ('Ob_Sharpshot',1201,2300); -- armor_piercer


INSERT INTO `mob_skill_lists` VALUES ('Capricornus-MS',1202,641); -- Recoil Dive Only

INSERT INTO `mob_skill_lists` VALUES ('Lamina-Hyakinthos', 767, 2210);
INSERT INTO `mob_skill_lists` VALUES ('Corse_NM_staff',768,530);
INSERT INTO `mob_skill_lists` VALUES ('Corse_NM_staff',768,531);
INSERT INTO `mob_skill_lists` VALUES ('Corse_NM_staff',768,532);
INSERT INTO `mob_skill_lists` VALUES ('Corse_NM_staff',768,533);
INSERT INTO `mob_skill_lists` VALUES ('Corse_NM_staff',768,1326);
INSERT INTO `mob_skill_lists` VALUES ('Corse_NM_staff',768,1329);
INSERT INTO `mob_skill_lists` VALUES ('Platoon_Scorpion',769,354); -- wild_rage
INSERT INTO `mob_skill_lists` VALUES ('Platoon_Scorpion',769,355); -- earth_pounder
INSERT INTO `mob_skill_lists` VALUES ('Hippomaritimus',770,449);
INSERT INTO `mob_skill_lists` VALUES ('Hippomaritimus',770,452);
INSERT INTO `mob_skill_lists` VALUES ('Rambukk',771,267);
INSERT INTO `mob_skill_lists` VALUES ('Koropkkur',772,302);
INSERT INTO `mob_skill_lists` VALUES ('Metal_Shears',773,448);
INSERT INTO `mob_skill_lists` VALUES ('Skirling_Liger',774,270);
INSERT INTO `mob_skill_lists` VALUES ('Skirling_Liger',774,273);
INSERT INTO `mob_skill_lists` VALUES ('Wake_Warder_Wanda',775,442);
INSERT INTO `mob_skill_lists` VALUES ('Wake_Warder_Wanda',775,445);
INSERT INTO `mob_skill_lists` VALUES ('Ashu_Talif_Captain',776,32); -- Fast Blade (assumed)
INSERT INTO `mob_skill_lists` VALUES ('Ashu_Talif_Captain',776,33); -- Burning Blade (assumed)
INSERT INTO `mob_skill_lists` VALUES ('Ashu_Talif_Captain',776,34); -- Red Lotus Blade (seen in video: https://youtu.be/kw_lhwEGSYs?t=4m45s)
INSERT INTO `mob_skill_lists` VALUES ('Ashu_Talif_Captain',776,35); -- Flat Blade (seen in video: https://youtu.be/kw_lhwEGSYs?t=4m20s)
INSERT INTO `mob_skill_lists` VALUES ('Ashu_Talif_Captain',776,36); -- Shining Blade (assumed)
INSERT INTO `mob_skill_lists` VALUES ('Ashu_Talif_Captain',776,37); -- Seraph Blade (seen in video: https://youtu.be/kw_lhwEGSYs?t=5m35s)
INSERT INTO `mob_skill_lists` VALUES ('Ashu_Talif_Captain',776,38); -- Circle Blade (assumed)INSERT INTO `mob_skill_lists` VALUES ('Ashu_Talif_Captain',776,41); -- Swift Blade (seen in video: https://youtu.be/kw_lhwEGSYs?t=5m11s)
INSERT INTO `mob_skill_lists` VALUES ('Ashu_Talif_Captain',776,254); -- Vulcan Shot
-- Ashu Talif Crew use standard Fomor skills tied to their job.

-- Gessho v1 (Aht Urhgan Mission 15: The Black Coffin)
INSERT INTO `mob_skill_lists` VALUES ('Gessho_I',777,1936); -- Shibaraku - 500-2000 AoE damage and knockback, blockable by shadows
INSERT INTO `mob_skill_lists` VALUES ('Gessho_I',777,1998); -- Hane Fubuki - Feather Storm; ranged attack and Poison
INSERT INTO `mob_skill_lists` VALUES ('Gessho_I',777,1999); -- Hiden Sokyaku - Double Kick; knockback and Stun
INSERT INTO `mob_skill_lists` VALUES ('Gessho_I',777,2000); -- Shiko no Mitate - Parry; Defense Boost on self
INSERT INTO `mob_skill_lists` VALUES ('Gessho_I',777,2001); -- Happobarai - Sweep; 300-1200 AoE damage and Stun, blockable by shadows
INSERT INTO `mob_skill_lists` VALUES ('Gessho_I',777,2002); -- Rinpyotosha - Warcry effect

-- Gessho v2 (Aht Urhgan Mission 35: Legacy of the Lost)
INSERT INTO `mob_skill_lists` VALUES ('Gessho_II',778,1936); -- Shibaraku - 500-2000 AoE damage and knockback, blockable by shadows
INSERT INTO `mob_skill_lists` VALUES ('Gessho_II',778,1998); -- Hane Fubuki - Feather Storm; ranged attack and Poison
INSERT INTO `mob_skill_lists` VALUES ('Gessho_II',778,1999); -- Hiden Sokyaku - Double Kick; knockback and Stun
INSERT INTO `mob_skill_lists` VALUES ('Gessho_II',778,2000); -- Shiko no Mitate - Parry; Defense Boost on self
INSERT INTO `mob_skill_lists` VALUES ('Gessho_II',778,2001); -- Happobarai - Sweep; 300-1200 AoE damage and Stun, blockable by shadows
INSERT INTO `mob_skill_lists` VALUES ('Gessho_II',778,2002); -- Rinpyotosha - Warcry effect
-- INSERT INTO `mob_skill_lists` VALUES ('Gessho_II',778,2269) -- Kamaitachi (Below 50%): AoE physical damage + major knockback and dispel all. Dispel effect can be avoided by shield blocks and utsusemi.
-- INSERT INTO `mob_skill_lists` VALUES ('Gessho_II',778,3276) -- Kagedourou (Above 50%): Summons multiple clones.
-- Clones will depop once sufficient damage is done to Gessho. Clones themselves can be defeated as well.
-- INSERT INTO `mob_skill_lists` VALUES ('Gessho_II',778,3277) -- Karakuridourou (Above 50%): Summons multiple clones.
-- INSERT INTO `mob_skill_lists` VALUES ('Gessho_II',778,3278) -- Tsujikaze (Below 50%): AoE magical damage + silence, defense down, and magic defense down. ~14.9' range.

INSERT INTO `mob_skill_lists` VALUES ('Khimaira_13',779,2022); -- Tenebrous Mist: TP is reset to 0.
INSERT INTO `mob_skill_lists` VALUES ('Khimaira_13',779,2023); -- Thunderstrike: AoE DMG + Stun. Removes Utsusemi.
INSERT INTO `mob_skill_lists` VALUES ('Khimaira_13',779,2024); -- Tourbillion: AoE DMG + Knockback. Removes Utsusemi.
INSERT INTO `mob_skill_lists` VALUES ('Khimaira_13',779,2025); -- Dreadstorm: AoE DMG + terrorize. Removes Utsusemi.
INSERT INTO `mob_skill_lists` VALUES ('Lancelord_Gaheel_Ja',780,2094); -- Flame Angon - AoE fire damage (50-100)
INSERT INTO `mob_skill_lists` VALUES ('Lancelord_Gaheel_Ja',780,2098); -- Blazing Angon - AoE fire damage (150-300)
INSERT INTO `mob_skill_lists` VALUES ('Lancelord_Gaheel_Ja',780,2099); -- Batterhorn - 2-hit frontal AOE, absorbed by Utsusemi.
INSERT INTO `mob_skill_lists` VALUES ('Lancelord_Gaheel_Ja',780,2100); -- Clobber - Targeted AoE physical damage
INSERT INTO `mob_skill_lists` VALUES ('Lancelord_Gaheel_Ja',780,2103); -- Granite Skin - Parry/Guard skill increase, cannot be dispelled
INSERT INTO `mob_skill_lists` VALUES ('Naja_Salaheem',781,165); -- Skullbreaker (Mission version uses skull
INSERT INTO `mob_skill_lists` VALUES ('Naja_Salaheem',781,168); -- Hexa Strike
INSERT INTO `mob_skill_lists` VALUES ('Naja_Salaheem',781,169); -- Black Halo
-- INSERT INTO `mob_skill_lists` VALUES ('Trust_NajaSalaheem',?,2140); -- Peacebreaker
-- INSERT INTO `mob_skill_lists` VALUES ('Trust_NajaSalaheem',?,168); -- Hexa Strike
-- INSERT INTO `mob_skill_lists` VALUES ('Trust_NajaSalaheem',?,169); -- Black Halo
-- Confirmed on retail, each version of her uses a different "breaker" ws.
-- INSERT INTO `mob_skill_lists` VALUES ('UnityLeader_NajaSalaheem',?,3503); -- Justicebreaker
-- INSERT INTO `mob_skill_lists` VALUES ('UnityLeader_NajaSalaheem',?,168); -- Hexa Strike
-- INSERT INTO `mob_skill_lists` VALUES ('UnityLeader_NajaSalaheem',?,169); -- Black Halo
INSERT INTO `mob_skill_lists` VALUES ('Amnaf_blu',782,38); -- Circle Blade
-- Flayer version of Amnaf uses standard soulflayer skills.

-- While I never once saw any other WS from Raubahn, he may have others.
INSERT INTO `mob_skill_lists` VALUES ('Raubahn',783,37); -- Seraph Blade
INSERT INTO `mob_skill_lists` VALUES ('Raubahn',783,38); -- Circle Blade

-- Razfahd uses only Perfect Defense, which is forced by mobscript at 50% HP so he needs no list.
INSERT INTO `mob_skill_lists` VALUES ('Alexander',784,2141); -- Radiant Sacrament  "Offer thy worship..."
INSERT INTO `mob_skill_lists` VALUES ('Alexander',784,2142); -- Mega Holy          "My radiance...shall guide thee..."
INSERT INTO `mob_skill_lists` VALUES ('Alexander',784,2144); -- Divine Spear       "My divine flames...shall melt thy flesh...sear thy bones...unshackle thy soul..."
INSERT INTO `mob_skill_lists` VALUES ('Alexander',784,2145); -- Gospel of the Lost "Bask in my Glory"
INSERT INTO `mob_skill_lists` VALUES ('Alexander',784,2146); -- Void of Repentance "Repent thy irreverence..."
-- Divine Judgement (2147) is forced once by mobscript at 50% HP.
-- Per wiki, Alexander may use Perfect Defense (2143) as a regular skill at 10%
-- From info on both wiki's, I am assuming this is also the case for Divine Judgement.
INSERT INTO `mob_skill_lists` VALUES ('Alexander_LowHP',785,2141); -- Radiant Sacrament  "Offer thy worship..."
INSERT INTO `mob_skill_lists` VALUES ('Alexander_LowHP',785,2142); -- Mega Holy          "My radiance...shall guide thee..."
INSERT INTO `mob_skill_lists` VALUES ('Alexander_LowHP',785,2143); -- Perfect Defense    "Cease thy struggles..."
INSERT INTO `mob_skill_lists` VALUES ('Alexander_LowHP',785,2144); -- Divine Spear       "My divine flames...shall melt thy flesh...sear thy bones...unshackle thy soul..."
INSERT INTO `mob_skill_lists` VALUES ('Alexander_LowHP',785,2145); -- Gospel of the Lost "Bask in my Glory"
INSERT INTO `mob_skill_lists` VALUES ('Alexander_LowHP',785,2146); -- Void of Repentance "Repent thy irreverence..."
INSERT INTO `mob_skill_lists` VALUES ('Alexander_LowHP',785,2147); -- Divine Judgement   "Accept thy destruction..."
INSERT INTO `mob_skill_lists` VALUES ('Alkonost',786,576); -- back heel
INSERT INTO `mob_skill_lists` VALUES ('Alkonost',786,578); -- nihlity song
-- INSERT INTO `mob_skill_lists` VALUES ('Alkonost',786,579); -- choke breath
-- INSERT INTO `mob_skill_lists` VALUES ('Alkonost',786,580); -- fantod
INSERT INTO `mob_skill_lists` VALUES ('Alkonost',786,1330); -- hoof volley
INSERT INTO `mob_skill_lists` VALUES ('Alkonost',786,2828); -- jettatura
-- 787: free
-- 788: free
INSERT INTO `mob_skill_lists` VALUES ('Bakka',789,1711); -- frentic rip
INSERT INTO `mob_skill_lists` VALUES ('Bakka',789,2003); -- grating tantra
INSERT INTO `mob_skill_lists` VALUES ('Bakka',789,2004); -- stifling tantra
INSERT INTO `mob_skill_lists` VALUES ('Balaur_Pre_50',790,819); -- blizzard breath
INSERT INTO `mob_skill_lists` VALUES ('Balaur_Pre_50',790,820); -- thunder breath
INSERT INTO `mob_skill_lists` VALUES ('Balaur_Post_50',791,819); -- blizzard breath -- chance of ice spikes effect
INSERT INTO `mob_skill_lists` VALUES ('Balaur_Post_50',791,820); -- thunder breath -- chance of shock spikes effect
INSERT INTO `mob_skill_lists` VALUES ('Balaur_Post_50',791,821); -- radiant breath
INSERT INTO `mob_skill_lists` VALUES ('Balaur_Post_50',791,822); -- chaos breath -- chance of dread spikes effect
-- INSERT INTO `mob_skill_lists` VALUES ('Balaur_Post_50',791,2222); -- hurricane breath
INSERT INTO `mob_skill_lists` VALUES ('Bloodeye_Vileberry',792,783); -- Words_of_Bane
INSERT INTO `mob_skill_lists` VALUES ('Bloodeye_Vileberry',792,784); -- Sigh
INSERT INTO `mob_skill_lists` VALUES ('Bloodeye_Vileberry',792,785); -- Light_of_Penance
INSERT INTO `mob_skill_lists` VALUES ('Bloodeye_Vileberry',792,786); -- Lateral_Slash
INSERT INTO `mob_skill_lists` VALUES ('Bloodeye_Vileberry',792,787); -- Vertical_Slash
INSERT INTO `mob_skill_lists` VALUES ('Bloodeye_Vileberry',792,788); -- Throat_Stab
INSERT INTO `mob_skill_lists` VALUES ('Bloodeye_Vileberry',792,920); -- Everyones_Grudge
INSERT INTO `mob_skill_lists` VALUES ('Bloodeye_Vileberry',792,921); -- Everyones_Rancor
INSERT INTO `mob_skill_lists` VALUES ('Bloodeye_Vileberry',792,2393); -- ritual bind
INSERT INTO `mob_skill_lists` VALUES ('Bloodguzzler',793,415); -- acid mist
INSERT INTO `mob_skill_lists` VALUES ('Bombadeel',794,581); -- blow
INSERT INTO `mob_skill_lists` VALUES ('Bombadeel',794,583); -- beatdown
INSERT INTO `mob_skill_lists` VALUES ('Bombadeel',794,584); -- uppercut
INSERT INTO `mob_skill_lists` VALUES ('Clingy_Clare',795,317); -- vampiric lash
INSERT INTO `mob_skill_lists` VALUES ('Clingy_Clare',795,319); -- bad breath
INSERT INTO `mob_skill_lists` VALUES ('Clingy_Clare',795,320); -- sweet breath
INSERT INTO `mob_skill_lists` VALUES ('Eccentric_Eve',796,319); -- bad breath
INSERT INTO `mob_skill_lists` VALUES ('Eccentric_Eve',796,726); -- drain whip
INSERT INTO `mob_skill_lists` VALUES ('Eccentric_Eve',796,1332); -- extremely bad breath
INSERT INTO `mob_skill_lists` VALUES ('Eccentric_Eve',796,2574); -- tainting breath
INSERT INTO `mob_skill_lists` VALUES ('Eccentric_Eve',796,2575); -- thousand spears
INSERT INTO `mob_skill_lists` VALUES ('Fear_Gorta',797,220); -- curse
INSERT INTO `mob_skill_lists` VALUES ('Fear_Gorta',797,1339); -- bane
INSERT INTO `mob_skill_lists` VALUES ('Fear_Gorta',797,1794); -- perdition
INSERT INTO `mob_skill_lists` VALUES ('Fistule',798,2514); -- cytokinesis -- spawns 2 pulsules unless previous Pustules have been left alive at 1/6th of fistules HP (83%, 66%, 49%, 33%, 16%), regardless of TP.
INSERT INTO `mob_skill_lists` VALUES ('Fistule',798,2550); -- dissolve -- When Guimauve or Bloodguzzler is brought into range, Fistule uses Dissolve and the lesser NM will be defeated making fistule targetable.
INSERT INTO `mob_skill_lists` VALUES ('Fistule',798,2551); -- mucus spread
INSERT INTO `mob_skill_lists` VALUES ('Fistule',798,2552); -- epoxy spread
INSERT INTO `mob_skill_lists` VALUES ('Gangly_Gean',799,328); -- drill branch
INSERT INTO `mob_skill_lists` VALUES ('Gangly_Gean',799,332); -- entangle -- adds endrain effect when used
INSERT INTO `mob_skill_lists` VALUES ('Hexenpilz',800,314); -- silence gas
INSERT INTO `mob_skill_lists` VALUES ('Hexenpilz',800,315); -- dark spore
INSERT INTO `mob_skill_lists` VALUES ('Keratyrannos',801,2099); -- batterhorn
INSERT INTO `mob_skill_lists` VALUES ('Keratyrannos',801,2100); -- clobber
INSERT INTO `mob_skill_lists` VALUES ('Keratyrannos',801,2102); -- boiling blood
INSERT INTO `mob_skill_lists` VALUES ('Keratyrannos',801,2104); -- crippling slam
INSERT INTO `mob_skill_lists` VALUES ('Khalamari',802,1347); -- dual strike
INSERT INTO `mob_skill_lists` VALUES ('Khalamari',802,1348); -- mantle pierce
INSERT INTO `mob_skill_lists` VALUES ('Khalamari',802,1349); -- siphon discharge
INSERT INTO `mob_skill_lists` VALUES ('Khalamari',802,1350); -- ink cloud
INSERT INTO `mob_skill_lists` VALUES ('Kukulkan',803,2152); -- aqua fortis
INSERT INTO `mob_skill_lists` VALUES ('Kukulkan',803,2153); -- regurgitation
INSERT INTO `mob_skill_lists` VALUES ('Kukulkan',803,2154); -- delta thrust
INSERT INTO `mob_skill_lists` VALUES ('Kukulkan',803,2155); -- torpefying charge
INSERT INTO `mob_skill_lists` VALUES ('Kukulkan',803,2156); -- grim glower
INSERT INTO `mob_skill_lists` VALUES ('Kukulkan',803,2157); -- calcifying mist
INSERT INTO `mob_skill_lists` VALUES ('Kukulkan',803,2392); -- oppressive gaze -- augments additional effect poison 100 hp/tic while under effect
INSERT INTO `mob_skill_lists` VALUES ('Lentor',804,2185); -- Corrosive Ooze
INSERT INTO `mob_skill_lists` VALUES ('Lentor',804,2186); -- Mucilaginous Ooze -- (60 seconds of encumbrance)
INSERT INTO `mob_skill_lists` VALUES ('Raskovnik',805,2164); -- Viscid Emission
INSERT INTO `mob_skill_lists` VALUES ('Raskovnik',805,2167); -- Bloody Caress
INSERT INTO `mob_skill_lists` VALUES ('Raskovnik',805,2169); -- Soothing Aroma (only after down to 50% hp)
INSERT INTO `mob_skill_lists` VALUES ('Kirtimukha',806,2163); -- Seedspray
INSERT INTO `mob_skill_lists` VALUES ('Kirtimukha',806,2164); -- Viscid Emission
INSERT INTO `mob_skill_lists` VALUES ('Kirtimukha',806,2165); -- Rotten Stench
INSERT INTO `mob_skill_lists` VALUES ('Kirtimukha',806,2166); -- Floral Bouquet
INSERT INTO `mob_skill_lists` VALUES ('Kirtimukha',806,2168); -- Bloody Caress
INSERT INTO `mob_skill_lists` VALUES ('Kirtimukha',806,2169); -- Soothing Aroma
INSERT INTO `mob_skill_lists` VALUES ('Turul',807,2427); -- tail lash
INSERT INTO `mob_skill_lists` VALUES ('Turul',807,2428); -- bloody beak
INSERT INTO `mob_skill_lists` VALUES ('Turul',807,2429); -- feral peck
INSERT INTO `mob_skill_lists` VALUES ('Turul',807,2430); -- warped wail
INSERT INTO `mob_skill_lists` VALUES ('Turul',807,2431); -- reaving wind
INSERT INTO `mob_skill_lists` VALUES ('Turul',807,2432); -- storm wing
INSERT INTO `mob_skill_lists` VALUES ('Turul',807,2433); -- calamitous wind
INSERT INTO `mob_skill_lists` VALUES ('Akash',808,907); -- poison nails
INSERT INTO `mob_skill_lists` VALUES ('Akash',808,908); -- shining ruby
INSERT INTO `mob_skill_lists` VALUES ('Akash',808,909); -- glittering ruby
INSERT INTO `mob_skill_lists` VALUES ('Akash',808,910); -- meteorite
INSERT INTO `mob_skill_lists` VALUES ('Adamastor',809,664); -- impact roar
INSERT INTO `mob_skill_lists` VALUES ('Adamastor',809,665); -- grand slam
INSERT INTO `mob_skill_lists` VALUES ('Adamastor',809,666); -- power attack
INSERT INTO `mob_skill_lists` VALUES ('Baba_Yaga',810,2193); -- zephyr arrow
INSERT INTO `mob_skill_lists` VALUES ('Baba_Yaga',810,2194); -- lethe arrows
INSERT INTO `mob_skill_lists` VALUES ('Briareus',811,666); -- power attack
INSERT INTO `mob_skill_lists` VALUES ('Briareus',811,1636); -- trebuchet
-- INSERT INTO `mob_skill_lists` VALUES ('Briareus',811,2253); -- Meikyo Shisui
INSERT INTO `mob_skill_lists` VALUES ('Briareus',811,2576); -- mercurial strike
INSERT INTO `mob_skill_lists` VALUES ('Briareus',811,2578); -- colossal slam
INSERT INTO `mob_skill_lists` VALUES ('Carabosse',812,2193); -- zephyr arrow
INSERT INTO `mob_skill_lists` VALUES ('Carabosse',812,2194); -- lethe arrows
INSERT INTO `mob_skill_lists` VALUES ('Carabosse_Post_Benediction',813,2193); -- zephyr arrow  -- group 813 used only after benediction
INSERT INTO `mob_skill_lists` VALUES ('Carabosse_Post_Benediction',813,2194); -- lethe arrows
INSERT INTO `mob_skill_lists` VALUES ('Carabosse_Post_Benediction',813,2195); -- spring breeze
INSERT INTO `mob_skill_lists` VALUES ('Carabosse_Post_Benediction',813,2196); -- summer breeze
INSERT INTO `mob_skill_lists` VALUES ('Carabosse_Post_Benediction',813,2197); -- autumn breeze
INSERT INTO `mob_skill_lists` VALUES ('Carabosse_Post_Benediction',813,2198); -- winter breeze
INSERT INTO `mob_skill_lists` VALUES ('Chasmic_Hornet',814,335); -- pollen
-- INSERT INTO `mob_skill_lists` VALUES ('Chasmic_Hornet',814,1847); -- frenzy pollen
-- INSERT INTO `mob_skill_lists` VALUES ('Chasmic_Hornet',814,2608); -- terminal sting
INSERT INTO `mob_skill_lists` VALUES ('Dozing_Dorian',815,262); -- sheep charge
INSERT INTO `mob_skill_lists` VALUES ('Dozing_Dorian',815,265); -- rage
INSERT INTO `mob_skill_lists` VALUES ('Dozing_Dorian',815,1837); -- feeble bleat
INSERT INTO `mob_skill_lists` VALUES ('Grandgousier',816,658); -- catapult
INSERT INTO `mob_skill_lists` VALUES ('Grandgousier',816,662); -- lightning roar
INSERT INTO `mob_skill_lists` VALUES ('Grandgousier',816,1636); -- trebuchet
INSERT INTO `mob_skill_lists` VALUES ('Hadhayosh',817,628); -- wild horn
INSERT INTO `mob_skill_lists` VALUES ('Hadhayosh',817,629); -- thunderbolt
INSERT INTO `mob_skill_lists` VALUES ('Hadhayosh',817,632); -- flame armor
INSERT INTO `mob_skill_lists` VALUES ('Hadhayosh',817,633); -- howl
-- INSERT INTO `mob_skill_lists` VALUES ('Hadhayosh',817,2390); -- accursed armor
INSERT INTO `mob_skill_lists` VALUES ('Hadhayosh',817,2391); -- amnesic blast
INSERT INTO `mob_skill_lists` VALUES ('Hadhayosh',817,2586); -- ecliptic meteor
-- NOTE: "Meteor" is spell not skill (verified via youtube video) and is cast at 20% and 5% (via script, not spell-List)
INSERT INTO `mob_skill_lists` VALUES ('Keesha_Poppo',818,290); -- spinning claw
INSERT INTO `mob_skill_lists` VALUES ('Keesha_Poppo',818,291); -- claw storm
INSERT INTO `mob_skill_lists` VALUES ('Keesha_Poppo',818,295); -- magic fruit
-- INSERT INTO `mob_skill_lists` VALUES ('Keesha_Poppo',818,2610); -- vacant gaze
INSERT INTO `mob_skill_lists` VALUES ('Lugarhoo',819,2170); -- fevered pitch
INSERT INTO `mob_skill_lists` VALUES ('Lugarhoo',819,2171); -- call of the moon
INSERT INTO `mob_skill_lists` VALUES ('Mangy-tailed_Marvin',820,257); -- foot kick
INSERT INTO `mob_skill_lists` VALUES ('Mangy-tailed_Marvin',820,259); -- whirl claws
INSERT INTO `mob_skill_lists` VALUES ('Mangy-tailed_Marvin',820,323); -- wild carrot
INSERT INTO `mob_skill_lists` VALUES ('Megamaw_Mikey',821,424); -- full-force blow
INSERT INTO `mob_skill_lists` VALUES ('Megantereon',822,270); -- roar
-- INSERT INTO `mob_skill_lists` VALUES ('Megantereon',822,2207); -- Disorienting_Waul
INSERT INTO `mob_skill_lists` VALUES ('Nguruvilu',823,1720); -- Wind_Shear
INSERT INTO `mob_skill_lists` VALUES ('Nguruvilu',823,1721); -- Obfuscate
INSERT INTO `mob_skill_lists` VALUES ('Nguruvilu',823,1722); -- Zephyr_Mantle
INSERT INTO `mob_skill_lists` VALUES ('Nguruvilu',823,1723); -- Ill_Wind
INSERT INTO `mob_skill_lists` VALUES ('Ovni',824,1370); -- vitriolic barrage
INSERT INTO `mob_skill_lists` VALUES ('Ovni',824,1371); -- primal drill
INSERT INTO `mob_skill_lists` VALUES ('Ovni',824,1372); -- concussive oscillation
INSERT INTO `mob_skill_lists` VALUES ('Ovni',824,1373); -- ion shower
-- INSERT INTO `mob_skill_lists` VALUES ('Ovni',824,1374); -- torrential torment
INSERT INTO `mob_skill_lists` VALUES ('Ovni',824,1375); -- asthenic fog
-- INSERT INTO `mob_skill_lists` VALUES ('Ovni',824,1377); -- flourescence
INSERT INTO `mob_skill_lists` VALUES ('Pantagruel',825,663); -- ice roar
INSERT INTO `mob_skill_lists` VALUES ('Pantagruel',825,2367); -- moribund hack
INSERT INTO `mob_skill_lists` VALUES ('Piasa',826,1445); -- damnation dive
-- INSERT INTO `mob_skill_lists` VALUES ('Poroggo_Dom_Juan',827,1957); -- frog song
INSERT INTO `mob_skill_lists` VALUES ('Poroggo_Dom_Juan',827,1959); -- water bomb
INSERT INTO `mob_skill_lists` VALUES ('Toppling_Tuber',828,308); -- frog kick
INSERT INTO `mob_skill_lists` VALUES ('Toppling_Tuber',828,310); -- queazyshroom
INSERT INTO `mob_skill_lists` VALUES ('Toppling_Tuber',828,311); -- numbshroom
-- INSERT INTO `mob_skill_lists` VALUES ('Toppling_Tuber',828,2607); -- agaricus
INSERT INTO `mob_skill_lists` VALUES ('Trudging_Thomas',829,266); -- ram charge
-- INSERT INTO `mob_skill_lists` VALUES ('Trudging_Thomas',829,0); -- Doom Bleat missing from mob_skills.sql in Topaz -- Doom Bleat which is roughly 50% HP down. HP down effect can be erased
INSERT INTO `mob_skill_lists` VALUES ('Abas',830,515); -- toxic spit
INSERT INTO `mob_skill_lists` VALUES ('Adze',831,2158); -- insipid nip
INSERT INTO `mob_skill_lists` VALUES ('Adze',831,2159); -- pandemic nip
INSERT INTO `mob_skill_lists` VALUES ('Adze',831,2160); -- bombilation
INSERT INTO `mob_skill_lists` VALUES ('Adze',831,2161); -- cimicine discharge
INSERT INTO `mob_skill_lists` VALUES ('Adze',831,2162); -- emetic discharge
INSERT INTO `mob_skill_lists` VALUES ('Alectryon',832,406); -- hammer beak
INSERT INTO `mob_skill_lists` VALUES ('Alectryon',832,407); -- poison pick
INSERT INTO `mob_skill_lists` VALUES ('Alectryon',832,408); -- Sound_Vacuum
INSERT INTO `mob_skill_lists` VALUES ('Alectryon',832,410); -- sound blast
INSERT INTO `mob_skill_lists` VALUES ('Alectryon',832,411); -- baleful gaze
-- INSERT INTO `mob_skill_lists` VALUES ('Alectryon',832,1334); -- contamination
INSERT INTO `mob_skill_lists` VALUES ('Bhumi',833,852); -- megalith throw
INSERT INTO `mob_skill_lists` VALUES ('Bhumi',833,853); -- earthen ward
INSERT INTO `mob_skill_lists` VALUES ('Bhumi',833,854); -- stone iv
INSERT INTO `mob_skill_lists` VALUES ('Bhumi',833,855); -- mountain buster
INSERT INTO `mob_skill_lists` VALUES ('NM_Corpselights',834,2511); -- corpse breath
INSERT INTO `mob_skill_lists` VALUES ('Chloris',835,306); -- scream
INSERT INTO `mob_skill_lists` VALUES ('Chloris',835,2210); -- petal pirouette
INSERT INTO `mob_skill_lists` VALUES ('Chloris',835,2387); -- fatal scream
-- INSERT INTO `mob_skill_lists` VALUES ('Chloris',835,2579); -- phaeosynthesis
INSERT INTO `mob_skill_lists` VALUES ('Chukwa',836,806); -- tortoise stomp
INSERT INTO `mob_skill_lists` VALUES ('Cuelebre',837,1303); -- ocher blast
INSERT INTO `mob_skill_lists` VALUES ('Cuelebre',837,1304); -- bai wing
INSERT INTO `mob_skill_lists` VALUES ('Gancanagh',838,2210); -- petal pirouette
-- INSERT INTO `mob_skill_lists` VALUES ('Gancanagh',838,2599); -- tepal twist
-- INSERT INTO `mob_skill_lists` VALUES ('Gancanagh',838,2600); -- bloom fouette
-- INSERT INTO `mob_skill_lists` VALUES ('Gancanagh',838,2601); -- petalback spin
INSERT INTO `mob_skill_lists` VALUES ('Glavoid',839,2187); -- dustvoid
INSERT INTO `mob_skill_lists` VALUES ('Glavoid',839,2188); -- slaverous gale
INSERT INTO `mob_skill_lists` VALUES ('Glavoid',839,2189); -- aeolian void
INSERT INTO `mob_skill_lists` VALUES ('Glavoid',839,2190); -- extreme purgation
INSERT INTO `mob_skill_lists` VALUES ('Glavoid',839,2191); -- desiccation
-- INSERT INTO `mob_skill_lists` VALUES ('Glavoid',839,2605); -- disgorge
INSERT INTO `mob_skill_lists` VALUES ('Hedetet',840,353); -- death scissors
INSERT INTO `mob_skill_lists` VALUES ('Hedetet',840,2221); -- hell scissors
INSERT INTO `mob_skill_lists` VALUES ('Iratham',841,2566); -- diabolic claw
INSERT INTO `mob_skill_lists` VALUES ('Iratham',841,2568); -- deathly diminuendo
INSERT INTO `mob_skill_lists` VALUES ('Iratham',841,2569); -- hellish crescendo
INSERT INTO `mob_skill_lists` VALUES ('Iratham',841,2570); -- afflicting gaze
INSERT INTO `mob_skill_lists` VALUES ('Iratham',841,2571); -- stygian sphere
INSERT INTO `mob_skill_lists` VALUES ('Iratham',841,2572); -- malign invocation
INSERT INTO `mob_skill_lists` VALUES ('Iratham',841,2573); -- shadow wreck
INSERT INTO `mob_skill_lists` VALUES ('Lachrymater',842,1217); -- empty cutter
INSERT INTO `mob_skill_lists` VALUES ('Lachrymater',842,1218); -- vacuous osculation
INSERT INTO `mob_skill_lists` VALUES ('Lachrymater',842,1219); -- hexegon belt
INSERT INTO `mob_skill_lists` VALUES ('Lachrymater',842,1220); -- auroral drape
INSERT INTO `mob_skill_lists` VALUES ('Lachrymater',842,1228); -- memory of the dark
-- INSERT INTO `mob_skill_lists` VALUES ('Lacovie',843,1047); -- tortise song **modified removes 3 buffs**
INSERT INTO `mob_skill_lists` VALUES ('Lacovie',843,2585); -- tetsudo tremor
INSERT INTO `mob_skill_lists` VALUES ('Mictlantecuhtli',844,530); -- memento mori
INSERT INTO `mob_skill_lists` VALUES ('Mictlantecuhtli',844,531); -- silence seal
INSERT INTO `mob_skill_lists` VALUES ('Mictlantecuhtli',844,532); -- envoutement
INSERT INTO `mob_skill_lists` VALUES ('Mictlantecuhtli',844,533); -- danse macabre
INSERT INTO `mob_skill_lists` VALUES ('Mictlantecuhtli',844,1326); -- final retrobution
INSERT INTO `mob_skill_lists` VALUES ('Minhocao',845,2188); -- slaverous gale
INSERT INTO `mob_skill_lists` VALUES ('Minhocao',845,2189); -- aeolian void
INSERT INTO `mob_skill_lists` VALUES ('Minhocao',845,2190); -- extreme purgation
INSERT INTO `mob_skill_lists` VALUES ('Minhocao',845,2191); -- desiccation
INSERT INTO `mob_skill_lists` VALUES ('Minhocao',845,2604); -- gorge
INSERT INTO `mob_skill_lists` VALUES ('Minhocao',845,2605); -- disgorge
INSERT INTO `mob_skill_lists` VALUES ('Muscaliet',846,800); -- heat breath
INSERT INTO `mob_skill_lists` VALUES ('Myrmecoleon',847,2516); -- gravitic horn
INSERT INTO `mob_skill_lists` VALUES ('Ophanim',848,437); -- death ray
INSERT INTO `mob_skill_lists` VALUES ('Ophanim',848,438); -- hex eye
-- INSERT INTO `mob_skill_lists` VALUES ('Ophanim',848,439); -- petro gaze
INSERT INTO `mob_skill_lists` VALUES ('Ophanim',848,440); -- cartharsis
INSERT INTO `mob_skill_lists` VALUES ('Tefenet',849,652); -- blaster
INSERT INTO `mob_skill_lists` VALUES ('Tefenet',849,653); -- chaotic eye
-- INSERT INTO `mob_skill_lists` VALUES ('Tefenet',849,2209); -- blink of peril
-- INSERT INTO `mob_skill_lists` VALUES ('Tefenet',849,2602); -- mortal blast
INSERT INTO `mob_skill_lists` VALUES ('Treble_Noctules',850,1666); -- sonic_boom
INSERT INTO `mob_skill_lists` VALUES ('Treble_Noctules',850,1667); -- jet_stream
INSERT INTO `mob_skill_lists` VALUES ('Treble_Noctules',850,1157); -- slipstream
INSERT INTO `mob_skill_lists` VALUES ('Treble_Noctules',850,1158); -- turbulence
INSERT INTO `mob_skill_lists` VALUES ('Treble_Noctules',850,1341); -- knife edge circle
INSERT INTO `mob_skill_lists` VALUES ('Treble_Noctules',850,1342); -- train fall
INSERT INTO `mob_skill_lists` VALUES ('Vetehinen',851,2564); -- blazing bound
INSERT INTO `mob_skill_lists` VALUES ('Vetehinen',851,2565); -- molting burst
INSERT INTO `mob_skill_lists` VALUES ('Halimede',852,2562); -- acrid stream
INSERT INTO `mob_skill_lists` VALUES ('Halimede',852,2563); -- rime spray
-- INSERT INTO `mob_skill_lists` VALUES ('Siranpa-kamuy',853,1026); -- Arbor Storm
INSERT INTO `mob_skill_lists` VALUES ('Manananggal',854,1778); -- spinal cleave
INSERT INTO `mob_skill_lists` VALUES ('Manananggal',854,1779); -- mangle
INSERT INTO `mob_skill_lists` VALUES ('Manananggal',854,1782); -- animating wail
INSERT INTO `mob_skill_lists` VALUES ('Manananggal',854,1783); -- fortifying wail
INSERT INTO `mob_skill_lists` VALUES ('Aggressor_Antlion',855,275); -- sand blast
INSERT INTO `mob_skill_lists` VALUES ('Aggressor_Antlion',855,277); -- venom spray
INSERT INTO `mob_skill_lists` VALUES ('Aggressor_Antlion',855,279); -- mandibular bite
-- INSERT INTO `mob_skill_lists` VALUES ('Aggressor_Antlion',855,2517); -- quake blast
-- INSERT INTO `mob_skill_lists` VALUES ('Amun',856,439); -- Petro Gaze
INSERT INTO `mob_skill_lists` VALUES ('Amun',856,440); -- Catharsis
INSERT INTO `mob_skill_lists` VALUES ('Berstuk',857,2185); -- corrosive_ooze
-- The incinerate script needs adjustment.. Max HP of NM (30k) and regular mob (way less), and is breath dmg..
-- INSERT INTO `mob_skill_lists` VALUES ('Blazing_Eruca',858,1791); -- incinerate
INSERT INTO `mob_skill_lists` VALUES ('Drekavac',859,472); -- grave reel
INSERT INTO `mob_skill_lists` VALUES ('Gaizkin',860,490); -- undead mold
INSERT INTO `mob_skill_lists` VALUES ('Gaizkin',860,492); -- abyss blast
INSERT INTO `mob_skill_lists` VALUES ('Chahnameeds_Stomach',861,486); -- whip_tongue
INSERT INTO `mob_skill_lists` VALUES ('Chahnameeds_Stomach',861,488); -- acid_breath
INSERT INTO `mob_skill_lists` VALUES ('Chahnameeds_Stomach',861,489); -- stinking_gas
INSERT INTO `mob_skill_lists` VALUES ('Chahnameeds_Stomach',861,491); -- call_of_the_grave
INSERT INTO `mob_skill_lists` VALUES ('Chahnameeds_Stomach',861,492); -- abyss_blast
INSERT INTO `mob_skill_lists` VALUES ('Chahnameeds_Stomach',861,1338); -- infernal_pestilence
INSERT INTO `mob_skill_lists` VALUES ('Granite_Borer',862,1816); -- vitrolic spray
INSERT INTO `mob_skill_lists` VALUES ('Granite_Borer',862,1817); -- thermal pulse
INSERT INTO `mob_skill_lists` VALUES ('Granite_Borer',862,1818); -- cannonball
INSERT INTO `mob_skill_lists` VALUES ('Granite_Borer',862,1819); -- heat barrier
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Cleaver',863,2619); -- Turbine_Cyclone
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Cleaver',863,2620); -- Seismic_Impact
INSERT INTO `mob_skill_lists` VALUES ('Itzpapalotl',864,1951); -- Magma_fan
INSERT INTO `mob_skill_lists` VALUES ('Itzpapalotl',864,1952); -- Erratic_Flutter
INSERT INTO `mob_skill_lists` VALUES ('Itzpapalotl',864,1953); -- Proboscis
INSERT INTO `mob_skill_lists` VALUES ('Itzpapalotl',864,1955); -- Exuviation
INSERT INTO `mob_skill_lists` VALUES ('Itzpapalotl',864,1956); -- fire_break
INSERT INTO `mob_skill_lists` VALUES ('Kampe_base/mode3',865,353); -- death scissors
INSERT INTO `mob_skill_lists` VALUES ('Kampe_mode1',866,348); -- numbing breath
INSERT INTO `mob_skill_lists` VALUES ('Kampe_mode1',866,349); -- cold breath
INSERT INTO `mob_skill_lists` VALUES ('Kampe_mode2',867,354); -- wild rage
INSERT INTO `mob_skill_lists` VALUES ('Kampe_mode2',867,355); -- earth pounder
INSERT INTO `mob_skill_lists` VALUES ('Kharon',868,484); -- black cloud
INSERT INTO `mob_skill_lists` VALUES ('Kharon',868,485); -- blood saber
INSERT INTO `mob_skill_lists` VALUES ('Kharon',868,2766); -- malediction
INSERT INTO `mob_skill_lists` VALUES ('Maahes',869,480); -- Petrifactive_Breath
INSERT INTO `mob_skill_lists` VALUES ('Maahes',869,652); -- blaster
INSERT INTO `mob_skill_lists` VALUES ('Maahes',869,653); -- chaotic eye
-- INSERT INTO `mob_skill_lists` VALUES ('Maahes',869,2209); -- blink of peril
-- INSERT INTO `mob_skill_lists` VALUES ('Maahes',869,2602); -- mortal blast
INSERT INTO `mob_skill_lists` VALUES ('Maahes',869,483); -- charged whisker
INSERT INTO `mob_skill_lists` VALUES ('Mielikki',870,331); -- leafstorm
INSERT INTO `mob_skill_lists` VALUES ('Mielikki',870,332); -- entangle
-- INSERT INTO `mob_skill_lists` VALUES ('Mielikki',870,1026); -- arbor storm
INSERT INTO `mob_skill_lists` VALUES ('Nightshade',871,2210); -- Petal_Pirouette
-- INSERT INTO `mob_skill_lists` VALUES ('Nightshade',871,2601); -- Petalback_spin
INSERT INTO `mob_skill_lists` VALUES ('Pallid_Percy',872,426); -- sandspin
INSERT INTO `mob_skill_lists` VALUES ('Pallid_Percy',872,427); -- tremors
INSERT INTO `mob_skill_lists` VALUES ('Pallid_Percy',872,2645); -- mud stream
INSERT INTO `mob_skill_lists` VALUES ('Svarbhanu',873,646); -- heavy_stomp
INSERT INTO `mob_skill_lists` VALUES ('Svarbhanu',873,648); -- petrosong
INSERT INTO `mob_skill_lists` VALUES ('Svarbhanu',873,649); -- voidsong
INSERT INTO `mob_skill_lists` VALUES ('Smok',874,1279); -- tebbad wing
INSERT INTO `mob_skill_lists` VALUES ('Smok',874,1280); -- spike flail
INSERT INTO `mob_skill_lists` VALUES ('Smok',874,1281); -- firey breath
INSERT INTO `mob_skill_lists` VALUES ('Smok',874,1285); -- absolute terror
INSERT INTO `mob_skill_lists` VALUES ('Smok',874,1286); -- horrid roar
INSERT INTO `mob_skill_lists` VALUES ('Tejas_Pre50',875,842); -- burning strike
INSERT INTO `mob_skill_lists` VALUES ('Tejas_Pre50',875,845); -- fire_iv (bloodpact)
INSERT INTO `mob_skill_lists` VALUES ('Tejas_Pre50',875,846); -- flaming_crush
INSERT INTO `mob_skill_lists` VALUES ('Tejas_Pre50',875,847); -- meteor_strike
-- INSERT INTO `mob_skill_lists` VALUES ('Tejas_Pre50',875,0); -- crimson _howl not in tpz database at all
INSERT INTO `mob_skill_lists` VALUES ('Tejas_post50',876,842); -- burning strike
INSERT INTO `mob_skill_lists` VALUES ('Tejas_post50',876,845); -- fire_iv (bloodpact)
INSERT INTO `mob_skill_lists` VALUES ('Tejas_post50',876,846); -- flaming_crush
INSERT INTO `mob_skill_lists` VALUES ('Tejas_post50',876,847); -- meteor_strike
INSERT INTO `mob_skill_lists` VALUES ('Tejas_post50',876,913); -- inferno
-- INSERT INTO `mob_skill_lists` VALUES ('Tejas_Pre50',876,0); -- crimson _howl not in tpz database at all
INSERT INTO `mob_skill_lists` VALUES ('Titlacauan',877,530); -- Memento_Mori
INSERT INTO `mob_skill_lists` VALUES ('Titlacauan',877,531); -- Silence_Seal
INSERT INTO `mob_skill_lists` VALUES ('Titlacauan',877,533); -- danse macambre
INSERT INTO `mob_skill_lists` VALUES ('Titlacauan',877,1326); -- final retrobution
INSERT INTO `mob_skill_lists` VALUES ('Titlacauan',877,1329); -- gala mancabre
INSERT INTO `mob_skill_lists` VALUES ('Titlacauan',877,2638); -- hadal summons
INSERT INTO `mob_skill_lists` VALUES ('Ulhuadshi',878,2187); -- dustvoid
INSERT INTO `mob_skill_lists` VALUES ('Ulhuadshi',878,2188); -- slavernous_gale
INSERT INTO `mob_skill_lists` VALUES ('Ulhuadshi',878,2189); -- aeolian_void
INSERT INTO `mob_skill_lists` VALUES ('Ulhuadshi',878,2191); -- Desiccation
-- INSERT INTO `mob_skill_lists` VALUES ('Ulhuadshi',878,2641); -- psyche_suction
INSERT INTO `mob_skill_lists` VALUES ('Warbler',879,2158); -- Insepid_nip
INSERT INTO `mob_skill_lists` VALUES ('Warbler',879,2160); -- bombilation
INSERT INTO `mob_skill_lists` VALUES ('Warbler',879,2161); -- Cimicine_Discharge
INSERT INTO `mob_skill_lists` VALUES ('Wherwetrice',880,406); -- hammer_beak
INSERT INTO `mob_skill_lists` VALUES ('Wherwetrice',880,410); -- sound_vaccume
INSERT INTO `mob_skill_lists` VALUES ('Wherwetrice',880,411); -- baleful_gaze
INSERT INTO `mob_skill_lists` VALUES ('Whiro',881,516); -- geist_wall
INSERT INTO `mob_skill_lists` VALUES ('Whiro',881,517); -- numbing_noise
INSERT INTO `mob_skill_lists` VALUES ('Whiro',881,519); -- cyclotail
INSERT INTO `mob_skill_lists` VALUES ('Yaanei',882,2567); -- Stygian_cyclone
INSERT INTO `mob_skill_lists` VALUES ('Yaanei',882,2568); -- Deathly_diminuendo
INSERT INTO `mob_skill_lists` VALUES ('Yaanei',882,2569); -- Hellish_crescendo
INSERT INTO `mob_skill_lists` VALUES ('Yaanei',882,2571); -- Stygian_sphere
INSERT INTO `mob_skill_lists` VALUES ('Yaanei',882,2572); -- Malign_invocation
INSERT INTO `mob_skill_lists` VALUES ('Yaanei',882,2634); -- Interference
INSERT INTO `mob_skill_lists` VALUES ('Yaanei',882,2635); -- Dark_arrivisme
INSERT INTO `mob_skill_lists` VALUES ('Yaanei',882,2637); -- Besiegers_bane
INSERT INTO `mob_skill_lists` VALUES ('Abyssic_Cluster',883,568); -- Formation attack
INSERT INTO `mob_skill_lists` VALUES ('Abyssic_Cluster',883,569); -- refuling
INSERT INTO `mob_skill_lists` VALUES ('Abyssic_Cluster',883,570); -- Circle of Flames
-- INSERT INTO `mob_skill_lists` VALUES ('Abyssic_Cluster',883,571); -- self destruct
INSERT INTO `mob_skill_lists` VALUES ('Amhuluk',884,2431); -- reaving_wind
INSERT INTO `mob_skill_lists` VALUES ('Amhuluk',884,2432); -- storm_wing
INSERT INTO `mob_skill_lists` VALUES ('Amhuluk',884,2433); -- calamitouis_wind
INSERT INTO `mob_skill_lists` VALUES ('Amhuluk',884,2642); -- vermillion_wind
INSERT INTO `mob_skill_lists` VALUES ('Asanbosam',885,392); -- ultrasonics
INSERT INTO `mob_skill_lists` VALUES ('Asanbosam',885,394); -- blood_drain
INSERT INTO `mob_skill_lists` VALUES ('Asanbosam',885,1155); -- suibsonics
INSERT INTO `mob_skill_lists` VALUES ('Asanbosam',885,1156); -- marrow_drain
-- 886 to 887: free
INSERT INTO `mob_skill_lists` VALUES ('Cep-Kamuy',888,1695); -- seismec_tail
INSERT INTO `mob_skill_lists` VALUES ('Cep-Kamuy',888,1696); -- hypnic_lamp
INSERT INTO `mob_skill_lists` VALUES ('Cep-Kamuy',888,1698); -- leeching_current
INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_pre50',889,1693); -- gnash
INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_pre50',889,1694); -- vile_belch
INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_pre50',889,1695); -- sesmec_tail
INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_pre50',889,1696); -- hypnic_lamp
INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_pre50',889,1697); -- seaspray
-- INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_pre50',889,1978); -- abominable_belch
-- INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_pre50',889,2639); -- mayhem_lantern
INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_post50',890,1694); -- vile_belch
INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_post50',890,1695); -- sesmec_tail
INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_post50',890,1696); -- hypnic_lamp
INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_post50',890,1697); -- seaspray
-- INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_post50',890,1977); -- deathgnash
-- INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_post50',890,1978); -- abominable_belch
-- INSERT INTO `mob_skill_lists` VALUES ('Cirein-croin_post50',890,2639); -- mayhem_lantern
INSERT INTO `mob_skill_lists` VALUES ('Funereal_Apkallu',891,1713); -- Yawn
INSERT INTO `mob_skill_lists` VALUES ('Funereal_Apkallu',891,1714); -- Wing_Slap
INSERT INTO `mob_skill_lists` VALUES ('Funereal_Apkallu',891,1715); -- Beak_Lunge
INSERT INTO `mob_skill_lists` VALUES ('Funereal_Apkallu',891,1717); -- Wing_whirl
INSERT INTO `mob_skill_lists` VALUES ('Gukumatz',892,2152); -- aqua fortis
INSERT INTO `mob_skill_lists` VALUES ('Gukumatz',892,2153); -- regurgitation
INSERT INTO `mob_skill_lists` VALUES ('Gukumatz',892,2154); -- delta_thrust
INSERT INTO `mob_skill_lists` VALUES ('Gukumatz',892,2156); -- grim_glower
INSERT INTO `mob_skill_lists` VALUES ('Heqet',893,1959); -- water_bomb
INSERT INTO `mob_skill_lists` VALUES ('Heqet',893,1960); -- frog_cheer
-- INSERT INTO `mob_skill_lists` VALUES ('Heqet',893,1961); -- providence
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Observer',894,2626); -- Auger_Smash
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Observer',894,2627); -- Area_Bombardment
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Pulverizer',895,2619); -- Turbine_Cyclone
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Pulverizer',895,2620); -- Seismic_Impact
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Pulverizer',895,2621); -- Incinerator
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Pulverizer',895,2622); -- Arm_Cannon
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Pulverizer',895,2623); -- Ballistic_Kick
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Pulverizer',895,2624); -- Scapula_Beam
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Pulverizer',895,2625); -- Eradicator
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Pulverizer',895,2626); -- Auger_Smash
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Pulverizer',895,2627); -- Area_Bombardment
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Severer',896,2623); -- Ballistic_Kick
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Severer',896,2624); -- Scapula_Beam
INSERT INTO `mob_skill_lists` VALUES ('Jala',897,863); -- water_iv
INSERT INTO `mob_skill_lists` VALUES ('Jala',897,864); -- spinning_dive
INSERT INTO `mob_skill_lists` VALUES ('Jala',897,865); -- grand_fall
INSERT INTO `mob_skill_lists` VALUES ('Jala',897,866); -- tidal_wave
INSERT INTO `mob_skill_lists` VALUES ('Brothers_DAurphe',898,246); -- shackled_fists
INSERT INTO `mob_skill_lists` VALUES ('Brothers_DAurphe',898,247); -- foxfire
INSERT INTO `mob_skill_lists` VALUES ('Brothers_DAurphe',898,248); -- grim_halo
INSERT INTO `mob_skill_lists` VALUES ('Brothers_DAurphe',898,249); -- netherspikes
INSERT INTO `mob_skill_lists` VALUES ('Brothers_DAurphe',898,250); -- carnal_nightmare
INSERT INTO `mob_skill_lists` VALUES ('Brothers_DAurphe',898,251); -- aegis_schism
INSERT INTO `mob_skill_lists` VALUES ('Brothers_DAurphe',898,252); -- dancing_chains
INSERT INTO `mob_skill_lists` VALUES ('Brothers_DAurphe',898,253); -- barbed_crescent
INSERT INTO `mob_skill_lists` VALUES ('Brothers_DAurphe',898,255); -- dimensional_death
INSERT INTO `mob_skill_lists` VALUES ('Kutharei',899,2566); -- Diabolic_Claw
INSERT INTO `mob_skill_lists` VALUES ('Kutharei',899,2570); -- Afflicting_Gaze
INSERT INTO `mob_skill_lists` VALUES ('Kutharei',899,2571); -- Stygian_Sphere
INSERT INTO `mob_skill_lists` VALUES ('Kutharei',899,2572); -- Malign_Invocation
INSERT INTO `mob_skill_lists` VALUES ('Kutharei',899,2636); -- Banneret_Charge
INSERT INTO `mob_skill_lists` VALUES ('Kutharei',899,2634); -- Interference
INSERT INTO `mob_skill_lists` VALUES ('Manohra',900,622); -- helldive
INSERT INTO `mob_skill_lists` VALUES ('Manohra',900,1580); -- damnation_dive
INSERT INTO `mob_skill_lists` VALUES ('Minax_Bugard',901,383); -- Tusk
INSERT INTO `mob_skill_lists` VALUES ('Minax_Bugard',901,387); -- heavy_bellow
-- INSERT INTO `mob_skill_lists` VALUES ('Minax_Bugard',901,2643); -- tyrant_tusk
INSERT INTO `mob_skill_lists` VALUES ('Nehebkau',902,376); -- foul_breath
INSERT INTO `mob_skill_lists` VALUES ('Nehebkau',902,377); -- frost_breath
INSERT INTO `mob_skill_lists` VALUES ('Nehebkau',902,378); -- thunderbolt_breath
INSERT INTO `mob_skill_lists` VALUES ('Nonno',903,300); -- headbutt
INSERT INTO `mob_skill_lists` VALUES ('Nonno',903,301); -- dream flower
INSERT INTO `mob_skill_lists` VALUES ('Nonno',903,306); -- scream
INSERT INTO `mob_skill_lists` VALUES ('Npfundlwa',904,258); -- dust_cloud
INSERT INTO `mob_skill_lists` VALUES ('Sirrush',905,367); -- fireball
INSERT INTO `mob_skill_lists` VALUES ('Sirrush',905,621); -- snowball
INSERT INTO `mob_skill_lists` VALUES ('Sobek',906,386); -- awful_eye
INSERT INTO `mob_skill_lists` VALUES ('Sobek',906,387); -- heavy_bellow
-- INSERT INTO `mob_skill_lists` VALUES ('Sobek',906,2643); -- tyrant_tusk
-- 907: free
INSERT INTO `mob_skill_lists` VALUES ('Armillaria',908,314); -- silence gas
INSERT INTO `mob_skill_lists` VALUES ('Armillaria',908,315); -- Dark Spore
INSERT INTO `mob_skill_lists` VALUES ('Ayravata',909,1703); -- barrier tusk
INSERT INTO `mob_skill_lists` VALUES ('Ayravata',909,1704); -- silence gas
INSERT INTO `mob_skill_lists` VALUES ('Ayravata',909,1707); -- Voracious Trunk
INSERT INTO `mob_skill_lists` VALUES ('Bukhis',910,1360); -- Apocalyptic Ray
INSERT INTO `mob_skill_lists` VALUES ('Bukhis',910,2389); -- Lethal Triclip
INSERT INTO `mob_skill_lists` VALUES ('Bukhis',910,2533); -- Lithic Ray
INSERT INTO `mob_skill_lists` VALUES ('Bukhis',910,2640); -- Ruinous Scythe
INSERT INTO `mob_skill_lists` VALUES ('Chhir_Batti',911,2219); -- Dark_Wave
-- INSERT INTO `mob_skill_lists` VALUES ('Chhir_Batti',911,2220); -- Tartarean_Storm
-- INSERT INTO `mob_skill_lists` VALUES ('Div-e_Sepid',912,1712); -- Bugle_Call
INSERT INTO `mob_skill_lists` VALUES ('Div-e_Sepid',912,2003); -- Grating_Tantara
INSERT INTO `mob_skill_lists` VALUES ('Div-e_Sepid',912,2004); -- Stifling_Tantara
INSERT INTO `mob_skill_lists` VALUES ('Dvalinn',913,2114); -- hellclap
INSERT INTO `mob_skill_lists` VALUES ('Dvalinn',913,2115); -- Cackle
INSERT INTO `mob_skill_lists` VALUES ('Dvalinn',913,2118); -- Bilgestorm
INSERT INTO `mob_skill_lists` VALUES ('Fulmotondro',914,890); -- Thunder_IV
INSERT INTO `mob_skill_lists` VALUES ('Fulmotondro',914,891); -- chaotic_strike
INSERT INTO `mob_skill_lists` VALUES ('Fulmotondro',914,892); -- thunderstorm
INSERT INTO `mob_skill_lists` VALUES ('Fulmotondro',914,893); -- Judgment Bolt
-- 915: free
INSERT INTO `mob_skill_lists` VALUES ('Hanuman',916,290); -- Spinning Claw
INSERT INTO `mob_skill_lists` VALUES ('Hanuman',916,291); -- Claw_Storm
INSERT INTO `mob_skill_lists` VALUES ('Hanuman',916,295); -- Magic Fruit
-- INSERT INTO `mob_skill_lists` VALUES ('Hanuman',916,2610); -- Vacant_Gaze
INSERT INTO `mob_skill_lists` VALUES ('Hrosshvalur',917,450); -- Aqua Ball
INSERT INTO `mob_skill_lists` VALUES ('Hrosshvalur',917,641); -- Recoil Dive
-- 918: free
INSERT INTO `mob_skill_lists` VALUES ('Iku-Turso',919,462); -- Maelstrom
INSERT INTO `mob_skill_lists` VALUES ('Kadraeth_the_Hatespawn',920,1963); -- Mind_Blast
-- INSERT INTO `mob_skill_lists` VALUES ('Kadraeth_the_Hatespawn',920,1964); -- Immortal Shield
-- INSERT INTO `mob_skill_lists` VALUES ('Kadraeth_the_Hatespawn',920,1965); -- Immortal_Mind
-- INSERT INTO `mob_skill_lists` VALUES ('Kadraeth_the_Hatespawn',920,1969); -- Reprobation
INSERT INTO `mob_skill_lists` VALUES ('Karkadann',921,2335); -- Lightning_spear
INSERT INTO `mob_skill_lists` VALUES ('Karkadann',921,2337); -- Damsel_memento
INSERT INTO `mob_skill_lists` VALUES ('Karkadann',921,2338); -- Rampant_stance
INSERT INTO `mob_skill_lists` VALUES ('Khalkotaur',922,500); -- Mow
INSERT INTO `mob_skill_lists` VALUES ('Khalkotaur',922,1360); -- Apocalyptic Ray
INSERT INTO `mob_skill_lists` VALUES ('Lord_Varney',923,2107); -- Decollation
INSERT INTO `mob_skill_lists` VALUES ('Lord_Varney',923,2109); -- Heliovoid
INSERT INTO `mob_skill_lists` VALUES ('Lord_Varney',923,2110); -- Wings of Gehenna
-- 924: free
INSERT INTO `mob_skill_lists` VALUES ('Quasimodo',925,2424); -- Terror Eye
INSERT INTO `mob_skill_lists` VALUES ('Quasimodo',925,2425); -- Bloody Claw
-- INSERT INTO `mob_skill_lists` VALUES ('Quasimodo',925,2426); -- Shadow Burst
INSERT INTO `mob_skill_lists` VALUES ('Rakshas',926,270); -- Roar
INSERT INTO `mob_skill_lists` VALUES ('Rakshas',926,271); -- Razor Fang
INSERT INTO `mob_skill_lists` VALUES ('Rakshas',926,273); -- Claw Cyclone
-- INSERT INTO `mob_skill_lists` VALUES ('Rakshas',926,1340); -- Crossthrash
-- INSERT INTO `mob_skill_lists` VALUES ('Rakshas',926,1680); -- Predatory_Glare
-- INSERT INTO `mob_skill_lists` VALUES ('Rakshas',926,2207); -- Disorienting_Waul
INSERT INTO `mob_skill_lists` VALUES ('Sedna',927,2437); -- Aqua_Blast
INSERT INTO `mob_skill_lists` VALUES ('Sedna',927,2439); -- Hydro Wave
-- INSERT INTO `mob_skill_lists` VALUES ('Sedna',927,2439); -- Hydro Blast not in Topaz/Custom skill list http://ffxi.gamerescape.com/wiki/Hydro_Blast
INSERT INTO `mob_skill_lists` VALUES ('Seps',928,1720); -- Wind Shear
INSERT INTO `mob_skill_lists` VALUES ('Seps',928,1721); -- Obfuscate
INSERT INTO `mob_skill_lists` VALUES ('Seps',928,1723); -- Ill Wind
-- INSERT INTO `mob_skill_lists` VALUES ('Seps',928,2644); -- Somnial Durance
INSERT INTO `mob_skill_lists` VALUES ('Durinn',929,2113); -- Hellsnap
INSERT INTO `mob_skill_lists` VALUES ('Durinn',929,2114); -- Hellclap
INSERT INTO `mob_skill_lists` VALUES ('Durinn',929,2115); -- Cackle
INSERT INTO `mob_skill_lists` VALUES ('Durinn',929,2116); -- Necrobane
INSERT INTO `mob_skill_lists` VALUES ('Durinn',929,2117); -- Necropurge
INSERT INTO `mob_skill_lists` VALUES ('Durinn',929,2118); -- Bilgestorm
INSERT INTO `mob_skill_lists` VALUES ('Amarok',930,1785); -- Lava_Spit
INSERT INTO `mob_skill_lists` VALUES ('Amarok',930,1786); -- Sulfurous_Breath
INSERT INTO `mob_skill_lists` VALUES ('Amarok',930,1787); -- Scorching_Lash
INSERT INTO `mob_skill_lists` VALUES ('Amarok',930,1788); -- Ululation
INSERT INTO `mob_skill_lists` VALUES ('Amarok',930,1789); -- Magma_Hoplon
-- 931: free
INSERT INTO `mob_skill_lists` VALUES ('Battlerigged_Chariot',932,2054); -- Diffusion_ray
INSERT INTO `mob_skill_lists` VALUES ('Battlerigged_Chariot',932,2055); -- Intertia_stream
INSERT INTO `mob_skill_lists` VALUES ('Bennu',933,399); -- Scratch
INSERT INTO `mob_skill_lists` VALUES ('Bennu',933,400); -- Triple_Attack
INSERT INTO `mob_skill_lists` VALUES ('Bennu',933,401); -- Gliding_Spike
INSERT INTO `mob_skill_lists` VALUES ('Bennu',933,402); -- Feather_Barrier
INSERT INTO `mob_skill_lists` VALUES ('Bennu',933,922); -- Blind_Vortex
INSERT INTO `mob_skill_lists` VALUES ('Bennu',933,923); -- Giga_Scream
-- INSERT INTO `mob_skill_lists` VALUES ('Bennu',933,2703); -- Dread_Wind
INSERT INTO `mob_skill_lists` VALUES ('Calchas',934,722); -- venom_storm
-- 935: free
INSERT INTO `mob_skill_lists` VALUES ('Chickcharney',936,406); -- Hammer_Beak
INSERT INTO `mob_skill_lists` VALUES ('Chickcharney',936,407); -- Poison_Pick
INSERT INTO `mob_skill_lists` VALUES ('Chickcharney',936,408); -- Sound_Vacuum
INSERT INTO `mob_skill_lists` VALUES ('Chickcharney',936,411); -- Baleful_Gaze
-- INSERT INTO `mob_skill_lists` VALUES ('Chickcharney',936,1333); -- Contagion Transfer
INSERT INTO `mob_skill_lists` VALUES ('Cuijatender',937,304); -- Photosynthesis
INSERT INTO `mob_skill_lists` VALUES ('Cuijatender',937,2704); -- ???_Needles
INSERT INTO `mob_skill_lists` VALUES ('Dragua',938,1299); -- Typhoon_Wing
INSERT INTO `mob_skill_lists` VALUES ('Dragua',938,1301); -- Geotic_Breath
INSERT INTO `mob_skill_lists` VALUES ('Dragua',938,1305); -- Absolute_Terror
INSERT INTO `mob_skill_lists` VALUES ('Dragua',938,1306); -- Horrid_Roar_3
-- INSERT INTO `mob_skill_lists` VALUES ('Dragua',938,2702); -- Terra_Wing
INSERT INTO `mob_skill_lists` VALUES ('Emperador_de_Altepa',939,322); -- 1000_Needles
INSERT INTO `mob_skill_lists` VALUES ('Emperador_de_Altepa',939,1625); -- 2000_Needles
INSERT INTO `mob_skill_lists` VALUES ('Emperador_de_Altepa',939,1626); -- 4000_Needles
INSERT INTO `mob_skill_lists` VALUES ('Hazhdiha',940,645); -- Body_Slam
INSERT INTO `mob_skill_lists` VALUES ('Hazhdiha',940,646); -- Heavy_Stomp
INSERT INTO `mob_skill_lists` VALUES ('Hazhdiha',940,647); -- Chaos_Blade
INSERT INTO `mob_skill_lists` VALUES ('Hazhdiha',940,649); -- Voidsong
INSERT INTO `mob_skill_lists` VALUES ('Hazhdiha',940,650); -- Thornsong
INSERT INTO `mob_skill_lists` VALUES ('Hedjedjet',941,353); -- Death_Scissors
INSERT INTO `mob_skill_lists` VALUES ('Hedjedjet',941,354); -- Wild_Rage
INSERT INTO `mob_skill_lists` VALUES ('Hedjedjet',941,356); -- Sharp_Strike
INSERT INTO `mob_skill_lists` VALUES ('Hedjedjet',941,717); -- Venom_Breath
-- INSERT INTO `mob_skill_lists` VALUES ('Hedjedjet',941,2221); -- Hell_Scissors
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Smiter',942,2619); -- Turbine_Cyclone
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Smiter',942,2620); -- Seismic_Impact
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Smiter',942,2622); -- Arm_Cannon
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Smiter',942,2623); -- Ballistic_Kick
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Smiter',942,2624); -- Scapula_Beam
INSERT INTO `mob_skill_lists` VALUES ('Long-Barreled_Chariot',943,2055); -- Intertia_stream
INSERT INTO `mob_skill_lists` VALUES ('Long-Barreled_Chariot',943,2056); -- Discharge
INSERT INTO `mob_skill_lists` VALUES ('Long-Barreled_Chariot',943,2058); -- PW_Homing_missile
INSERT INTO `mob_skill_lists` VALUES ('Orthrus',944,1785); -- Lava_Spit
INSERT INTO `mob_skill_lists` VALUES ('Orthrus',944,1786); -- Sulfurous_Breath
INSERT INTO `mob_skill_lists` VALUES ('Orthrus',944,1787); -- Scorching_Lash
INSERT INTO `mob_skill_lists` VALUES ('Orthrus',944,1788); -- Ululation
INSERT INTO `mob_skill_lists` VALUES ('Orthrus',944,1789); -- Magma_Hoplon
INSERT INTO `mob_skill_lists` VALUES ('Orthrus',944,1790); -- Gates_of_Hades
INSERT INTO `mob_skill_lists` VALUES ('Orthrus_post_50',945,1785); -- Lava_Spit
INSERT INTO `mob_skill_lists` VALUES ('Orthrus_post_50',945,1786); -- Sulfurous_Breath
INSERT INTO `mob_skill_lists` VALUES ('Orthrus_post_50',945,1787); -- Scorching_Lash
INSERT INTO `mob_skill_lists` VALUES ('Orthrus_post_50',945,1788); -- Ululation
INSERT INTO `mob_skill_lists` VALUES ('Orthrus_post_50',945,1789); -- Magma_Hoplon
-- INSERT INTO `mob_skill_lists` VALUES ('Orthrus_post_50',945,2701); -- Acheron_Flame
-- 946: free
INSERT INTO `mob_skill_lists` VALUES ('Rani',947,2566); -- Diabolic_Claw
INSERT INTO `mob_skill_lists` VALUES ('Rani',947,2567); -- Stygian_Cyclone
INSERT INTO `mob_skill_lists` VALUES ('Rani',947,2570); -- Afflicting_Gaze
INSERT INTO `mob_skill_lists` VALUES ('Rani',947,2571); -- Stygian_Sphere
INSERT INTO `mob_skill_lists` VALUES ('Rani',947,2572); -- Malign_Invocation
INSERT INTO `mob_skill_lists` VALUES ('Rani',947,2634); -- Interference
-- INSERT INTO `mob_skill_lists` VALUES ('Rani',947,2700); -- Enthrall
INSERT INTO `mob_skill_lists` VALUES ('Sharabha',948,797); -- Deadly_Hold
INSERT INTO `mob_skill_lists` VALUES ('Sharabha',948,798); -- Tail_Swing
INSERT INTO `mob_skill_lists` VALUES ('Sharabha',948,799); -- Tail_Smash
INSERT INTO `mob_skill_lists` VALUES ('Sharabha',948,802); -- Great_Sandstorm
INSERT INTO `mob_skill_lists` VALUES ('Sharabha',948,803); -- Great_Whirlwind
-- 949: free
INSERT INTO `mob_skill_lists` VALUES ('Tablilla',950,539); -- Typhoon
INSERT INTO `mob_skill_lists` VALUES ('Tablilla',950,541); -- Gravity_Field
INSERT INTO `mob_skill_lists` VALUES ('Vadleany',951,2182); -- Spiral_Spin
INSERT INTO `mob_skill_lists` VALUES ('Waugyl',952,1720); -- Wind_Shear
INSERT INTO `mob_skill_lists` VALUES ('Waugyl',952,1723); -- Ill_Wind
-- INSERT INTO `mob_skill_lists` VALUES ('Waugyl',952,1724); -- White_Wind
INSERT INTO `mob_skill_lists` VALUES ('Anemic_Aloysius',953,424); -- Full-Force_Blow
INSERT INTO `mob_skill_lists` VALUES ('Anemic_Aloysius',953,425); -- Gastric_Bomb
INSERT INTO `mob_skill_lists` VALUES ('Anemic_Aloysius',953,426); -- Sandspin
INSERT INTO `mob_skill_lists` VALUES ('Anemic_Aloysius',953,427); -- Tremors
INSERT INTO `mob_skill_lists` VALUES ('Anemic_Aloysius',953,428); -- MP_Absorption
INSERT INTO `mob_skill_lists` VALUES ('Anemic_Aloysius',953,429); -- Sound_Vacuum
-- INSERT INTO `mob_skill_lists` VALUES ('Anemic_Aloysius',953,1889); -- Spirit_Vacuum
INSERT INTO `mob_skill_lists` VALUES ('Apademak',954,2022); -- Tenebrous_Mist
INSERT INTO `mob_skill_lists` VALUES ('Apademak',954,2023); -- Thunderstrike
INSERT INTO `mob_skill_lists` VALUES ('Apademak',954,2025); -- Dreadstorm
INSERT INTO `mob_skill_lists` VALUES ('Apademak',954,2026); -- Fossilizing_Breath
INSERT INTO `mob_skill_lists` VALUES ('Apademak',954,2027); -- Plague_Swipe
-- INSERT INTO `mob_skill_lists` VALUES ('Apademak',954,2698); -- Lithic_Breath
INSERT INTO `mob_skill_lists` VALUES ('Audumbla',955,493); -- Rampant_Gnaw
INSERT INTO `mob_skill_lists` VALUES ('Audumbla',955,494); -- Big_Horn
INSERT INTO `mob_skill_lists` VALUES ('Audumbla',955,496); -- Rabid_Dance
INSERT INTO `mob_skill_lists` VALUES ('Audumbla',955,497); -- Lowing
-- INSERT INTO `mob_skill_lists` VALUES ('Audumbla',955,1364); -- Mighty_Snort
INSERT INTO `mob_skill_lists` VALUES ('Awahondo',956,362); -- Double_Claw
INSERT INTO `mob_skill_lists` VALUES ('Awahondo',956,363); -- Grapple
INSERT INTO `mob_skill_lists` VALUES ('Awahondo',956,364); -- Filamented_Hold
INSERT INTO `mob_skill_lists` VALUES ('Awahondo',956,365); -- Spinning_Top
INSERT INTO `mob_skill_lists` VALUES ('Blanga',957,2423); -- Triumphant_roar
INSERT INTO `mob_skill_lists` VALUES ('Blanga',957,2424); -- Terror_eye
INSERT INTO `mob_skill_lists` VALUES ('Blanga',957,2425); -- Bloody_claw
INSERT INTO `mob_skill_lists` VALUES ('Chillwing_Hwitti_Pre_50',958,1709); -- Abrasive_Tantara
INSERT INTO `mob_skill_lists` VALUES ('Chillwing_Hwitti_Pre_50',958,1710); -- Deafening_Tantara
INSERT INTO `mob_skill_lists` VALUES ('Chillwing_Hwitti_Post_50',959,1709); -- Abrasive_Tantara
INSERT INTO `mob_skill_lists` VALUES ('Chillwing_Hwitti_Post_50',959,1710); -- Deafening_Tantara
-- INSERT INTO `mob_skill_lists` VALUES ('Chillwing_Hwitti_Post_50',959,2003); -- Grating_Tantara
-- INSERT INTO `mob_skill_lists` VALUES ('Chillwing_Hwitti_Post_50',959,2004); -- Stifling_Tantara
-- 960: free
INSERT INTO `mob_skill_lists` VALUES ('Empousa_Flying',962,2421); -- Dark_orb
INSERT INTO `mob_skill_lists` VALUES ('Empousa_Flying',962,2422); -- Dark_mist
INSERT INTO `mob_skill_lists` VALUES ('Empousa_Ground',961,2423); -- Triumphant_roar
INSERT INTO `mob_skill_lists` VALUES ('Empousa_Ground',961,2424); -- Terror_eye
INSERT INTO `mob_skill_lists` VALUES ('Empousa_Ground',961,2425); -- Bloody_claw
INSERT INTO `mob_skill_lists` VALUES ('Impervious_Chariot',963,2054); -- Diffusion_ray
INSERT INTO `mob_skill_lists` VALUES ('Impervious_Chariot',963,2055); -- Intertia_stream
INSERT INTO `mob_skill_lists` VALUES ('Impervious_Chariot',963,2056); -- Discharge
INSERT INTO `mob_skill_lists` VALUES ('Indrik',964,2337); -- Damsel_memento
INSERT INTO `mob_skill_lists` VALUES ('Indrik',964,2338); -- Rampant_stance
INSERT INTO `mob_skill_lists` VALUES ('Indrik',964,2369); -- Scintillant_lance
-- INSERT INTO `mob_skill_lists` VALUES ('Indrik',964,2370); -- Grace_of_Hera
INSERT INTO `mob_skill_lists` VALUES ('Isgebind',965,1289); -- Gregale_Wing
INSERT INTO `mob_skill_lists` VALUES ('Isgebind',965,1290); -- Spike_Flail
INSERT INTO `mob_skill_lists` VALUES ('Isgebind',965,1291); -- Glacial_Breath
INSERT INTO `mob_skill_lists` VALUES ('Isgebind',965,1295); -- Absolute_Terror
INSERT INTO `mob_skill_lists` VALUES ('Isgebind',965,1296); -- Horrid_Roar_3
INSERT INTO `mob_skill_lists` VALUES ('Koghatu',966,2071); -- Dire_straight
INSERT INTO `mob_skill_lists` VALUES ('Koghatu',966,2073); -- Sinker_drill
INSERT INTO `mob_skill_lists` VALUES ('Kur',967,642); -- Flame_Breath
INSERT INTO `mob_skill_lists` VALUES ('Kur',967,643); -- Poison_Breath
INSERT INTO `mob_skill_lists` VALUES ('Kur',967,644); -- Wind_Breath
INSERT INTO `mob_skill_lists` VALUES ('Kur',967,645); -- Body_Slam
INSERT INTO `mob_skill_lists` VALUES ('Kur',967,646); -- Heavy_Stomp
INSERT INTO `mob_skill_lists` VALUES ('Kur',967,647); -- Chaos_Blade
INSERT INTO `mob_skill_lists` VALUES ('Kur',967,649); -- Voidsong
INSERT INTO `mob_skill_lists` VALUES ('Kur',967,650); -- Thornsong
INSERT INTO `mob_skill_lists` VALUES ('Kur',967,651); -- Lodesong
INSERT INTO `mob_skill_lists` VALUES ('Pantokrator',968,1525); -- Guided_Missile_II
INSERT INTO `mob_skill_lists` VALUES ('Pantokrator',968,1527); -- Laser_Shower
INSERT INTO `mob_skill_lists` VALUES ('Pantokrator',968,1529); -- Hyper_Pulse
INSERT INTO `mob_skill_lists` VALUES ('Pantokrator',968,1530); -- Stun_Cannon
INSERT INTO `mob_skill_lists` VALUES ('Pantokrator',968,1533); -- Pile_Pitch
INSERT INTO `mob_skill_lists` VALUES ('Pantokrator',968,1534); -- Guided_Missile
-- INSERT INTO `mob_skill_lists` VALUES ('Pantokrator',968,1539); -- Rear_Lasers
INSERT INTO `mob_skill_lists` VALUES ('Refitted_Chariot',969,2054); -- Diffusion_ray
INSERT INTO `mob_skill_lists` VALUES ('Refitted_Chariot',969,2055); -- Intertia_stream
INSERT INTO `mob_skill_lists` VALUES ('Refitted_Chariot',969,2056); -- Discharge
INSERT INTO `mob_skill_lists` VALUES ('Resheph',970,362); -- Double_Claw
INSERT INTO `mob_skill_lists` VALUES ('Resheph',970,365); -- Spinning_Top
-- INSERT INTO `mob_skill_lists` VALUES ('Resheph',970,2699); -- Tarsal_Slam
-- 971: free
INSERT INTO `mob_skill_lists` VALUES ('Upas-Kamuy',972,1645); -- Freeze_Rush
INSERT INTO `mob_skill_lists` VALUES ('Upas-Kamuy',972,1646); -- Cold_Wave
INSERT INTO `mob_skill_lists` VALUES ('Veri_Selen',973,813); -- Dispelling_Wind
INSERT INTO `mob_skill_lists` VALUES ('Veri_Selen',973,814); -- Deadly_Drive
INSERT INTO `mob_skill_lists` VALUES ('Veri_Selen',973,815); -- Wind_Wall
INSERT INTO `mob_skill_lists` VALUES ('Veri_Selen',973,816); -- Fang_Rush
INSERT INTO `mob_skill_lists` VALUES ('Veri_Selen',973,817); -- Dread_Shriek
-- INSERT INTO `mob_skill_lists` VALUES ('Veri_Selen',973,2222); -- Hurricane_Breath
INSERT INTO `mob_skill_lists` VALUES ('Yaguarogui_group_1',974,270); -- Roar
-- INSERT INTO `mob_skill_lists` VALUES ('Yaguarogui_group_1',974,2207); -- Disorienting_Waul
INSERT INTO `mob_skill_lists` VALUES ('Yaguarogui_group_2',975,273); -- Claw_Cyclone
-- INSERT INTO `mob_skill_lists` VALUES ('Yaguarogui_group_2',975,1340); -- Crossthrash
INSERT INTO `mob_skill_lists` VALUES ('Alfard',976,1828); -- Pyric_Blast
INSERT INTO `mob_skill_lists` VALUES ('Alfard',976,1830); -- Polar_Blast
INSERT INTO `mob_skill_lists` VALUES ('Alfard',976,1835); -- Serpentine_Tail
INSERT INTO `mob_skill_lists` VALUES ('Alfard',976,1836); -- Nerve_Gas
-- INSERT INTO `mob_skill_lists` VALUES ('Amphitrite',977,506); -- Palsynyxis
-- INSERT INTO `mob_skill_lists` VALUES ('Amphitrite',977,507); -- Painful_Whip
-- INSERT INTO `mob_skill_lists` VALUES ('Amphitrite',977,2693); -- Virulent_Haze
INSERT INTO `mob_skill_lists` VALUES ('Assailer_Chariot',978,2055); -- Intertia_stream
INSERT INTO `mob_skill_lists` VALUES ('Assailer_Chariot',978,2056); -- Discharge
INSERT INTO `mob_skill_lists` VALUES ('Assailer_Chariot',978,2059); -- PW_Discoid
INSERT INTO `mob_skill_lists` VALUES ('Azdaja',979,1309); -- Cyclone_Wing
INSERT INTO `mob_skill_lists` VALUES ('Azdaja',979,1310); -- Spike_Flail
INSERT INTO `mob_skill_lists` VALUES ('Azdaja',979,1311); -- Sable_Breath
-- INSERT INTO `mob_skill_lists` VALUES ('Azdaja',979,2696); -- Baleful_Roar
-- INSERT INTO `mob_skill_lists` VALUES ('Azdaja',979,2697); -- Infinite_Terror
-- INSERT INTO `mob_skill_lists` VALUES ('Bomblix_Flamefinger',980,1119); -- Frag_Bomb
INSERT INTO `mob_skill_lists` VALUES ('Burstrox_Powderpate',981,591); -- Bomb_Toss
INSERT INTO `mob_skill_lists` VALUES ('Deelgeed',982,382); -- Tail_Roll
INSERT INTO `mob_skill_lists` VALUES ('Deelgeed',982,384); -- Scutum
INSERT INTO `mob_skill_lists` VALUES ('Deelgeed',982,386); -- Awful_Eye
-- INSERT INTO `mob_skill_lists` VALUES ('Deelgeed',982,2643); -- Tyrant_Tusk
-- INSERT INTO `mob_skill_lists` VALUES ('Deelgeed',982,2695); -- Torment_Tusk
INSERT INTO `mob_skill_lists` VALUES ('Fleshflayer_Killakriq',983,1081); -- Frypan
INSERT INTO `mob_skill_lists` VALUES ('Fleshflayer_Killakriq',983,1082); -- Smokebomb
INSERT INTO `mob_skill_lists` VALUES ('Fleshflayer_Killakriq',983,1084); -- Crispy_Candle
INSERT INTO `mob_skill_lists` VALUES ('Fleshflayer_Killakriq',983,1086); -- Paralysis_Shower
INSERT INTO `mob_skill_lists` VALUES ('Fleshflayer_Killakriq',983,1088); -- Goblin_Rush
INSERT INTO `mob_skill_lists` VALUES ('Fuath',984,2193); -- Zephyr_Arrow
INSERT INTO `mob_skill_lists` VALUES ('Fuath',984,2194); -- Lethe_Arrows
-- INSERT INTO `mob_skill_lists` VALUES ('Fuath',984,2694); -- Cyclonic_Blight
-- 985: free
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Sunderer',986,2619); -- Turbine_Cyclone
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Sunderer',986,2620); -- Seismic_Impact
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Sunderer',986,2621); -- Incinerator
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Sunderer',986,2622); -- Arm_Cannon
INSERT INTO `mob_skill_lists` VALUES ('Ironclad_Sunderer',986,2624); -- Scapula_Beam
INSERT INTO `mob_skill_lists` VALUES ('Jaculus',987,1718); -- Crosswind
INSERT INTO `mob_skill_lists` VALUES ('Jaculus',987,1720); -- Wind_Shear
INSERT INTO `mob_skill_lists` VALUES ('Jaculus',987,1722); -- Zephyr_Mantle
INSERT INTO `mob_skill_lists` VALUES ('Jaculus',987,1723); -- Ill_Wind
INSERT INTO `mob_skill_lists` VALUES ('Lorelei',988,2193); -- Zephyr_Arrow
INSERT INTO `mob_skill_lists` VALUES ('Lorelei',988,2194); -- Lethe_Arrows
INSERT INTO `mob_skill_lists` VALUES ('Lorelei',988,2200); -- Cyclonic_Torrent
INSERT INTO `mob_skill_lists` VALUES ('Melo_Melo',989,1572); -- Venom_Shell
INSERT INTO `mob_skill_lists` VALUES ('Minaruja',990,813); -- Dispelling_Wind
INSERT INTO `mob_skill_lists` VALUES ('Minaruja',990,814); -- Deadly_Drive
INSERT INTO `mob_skill_lists` VALUES ('Minaruja',990,815); -- Wind_Wall
INSERT INTO `mob_skill_lists` VALUES ('Minaruja',990,816); -- Fang_Rush
INSERT INTO `mob_skill_lists` VALUES ('Minaruja',990,817); -- Dread_Shriek
INSERT INTO `mob_skill_lists` VALUES ('Minaruja',990,818); -- Tail_Crush
-- INSERT INTO `mob_skill_lists` VALUES ('Minaruja',990,819); -- Blizzard_Breath
-- INSERT INTO `mob_skill_lists` VALUES ('Minaruja',990,820); -- Thunder_Breath
INSERT INTO `mob_skill_lists` VALUES ('Minaruja',990,822); -- Chaos_Breath
-- INSERT INTO `mob_skill_lists` VALUES ('Minaruja',990,2222); -- Hurricane_Breath
INSERT INTO `mob_skill_lists` VALUES ('Ningishzida',991,1829); -- Pyric_Bulwark
INSERT INTO `mob_skill_lists` VALUES ('Ningishzida',991,1831); -- Polar_Bulwark
INSERT INTO `mob_skill_lists` VALUES ('Ningishzida',991,1832); -- Barofield
INSERT INTO `mob_skill_lists` VALUES ('Ningishzida',991,1834); -- Trembling
INSERT INTO `mob_skill_lists` VALUES ('Ningishzida',991,1835); -- Serpentine_Tail
INSERT INTO `mob_skill_lists` VALUES ('Raja',992,2567); -- Stygian_Cyclone
INSERT INTO `mob_skill_lists` VALUES ('Raja',992,2571); -- Stygian_Sphere
INSERT INTO `mob_skill_lists` VALUES ('Raja',992,2572); -- Malign_Invocation
INSERT INTO `mob_skill_lists` VALUES ('Raja',992,2692); -- Royal_Decree
-- 993 to 994: free
INSERT INTO `mob_skill_lists` VALUES ('Teugghia',995,2197); -- Autumn_Breeze
-- 996: free
INSERT INTO `mob_skill_lists` VALUES ('Flame_Skimmer',997,318); -- somersault
INSERT INTO `mob_skill_lists` VALUES ('Flame_Skimmer',997,659); -- cuirsed_sphere
INSERT INTO `mob_skill_lists` VALUES ('Flame_Skimmer',997,660); -- venom
INSERT INTO `mob_skill_lists` VALUES ('Flame_Skimmer',997,1324); -- debilitating_drone
INSERT INTO `mob_skill_lists` VALUES ('Hovering_Hotpot',998,521); -- spinning attack
INSERT INTO `mob_skill_lists` VALUES ('Suparna',999,923);
INSERT INTO `mob_skill_lists` VALUES ('Suparna',999,924);
INSERT INTO `mob_skill_lists` VALUES ('Chariot_Armed',1000,2060); -- brainjack
INSERT INTO `mob_skill_lists` VALUES ('Chariot_Battle',1001,2059); -- discoid
INSERT INTO `mob_skill_lists` VALUES ('Chariot_Armored',1002,2054); -- diffusion ray
INSERT INTO `mob_skill_lists` VALUES ('Chariot_Armored',1002,2055); -- inertia stream
INSERT INTO `mob_skill_lists` VALUES ('Chariot_Armored',1002,2056); -- discharge
INSERT INTO `mob_skill_lists` VALUES ('Chariot_Armored',1002,2057); -- mortal revolution
INSERT INTO `mob_skill_lists` VALUES ('Chariot_Bowed',1003,2058); -- homing missle
INSERT INTO `mob_skill_lists` VALUES ('NM_Rocs',1004,402); -- Feather Barrier
INSERT INTO `mob_skill_lists` VALUES ('NM_Rocs',1004,922); -- Blind Vortex
INSERT INTO `mob_skill_lists` VALUES ('NM_Rocs',1004,923); -- Giga Scream
INSERT INTO `mob_skill_lists` VALUES ('NM_Rocs',1004,924); -- Dread Dive
-- INSERT INTO `mob_skill_lists` VALUES ('NM_Rocs',1004,925); -- Feather Barrier (For now using 402. Retail data needed. Diff is likely animation time.)
INSERT INTO `mob_skill_lists` VALUES ('NM_Rocs',1004,926); -- Stormwind
INSERT INTO `mob_skill_lists` VALUES ('Nargun',1005,677); -- Thunder Break
INSERT INTO `mob_skill_lists` VALUES ('Ignamoth',1006,1952); -- erratic_flutter
INSERT INTO `mob_skill_lists` VALUES ('Ignamoth',1006,1956); -- fire_break
INSERT INTO `mob_skill_lists` VALUES ('Ankabut',1007,704);
INSERT INTO `mob_skill_lists` VALUES ('White_Coney',1008,323); -- only Wild Carrot
INSERT INTO `mob_skill_lists` VALUES ('Ophiotaurus',1009,2922); -- Soulshattering Roar
INSERT INTO `mob_skill_lists` VALUES ('Ophiotaurus',1009,2923); -- Calcifying Claw
INSERT INTO `mob_skill_lists` VALUES ('Ophiotaurus',1009,2924); -- Divesting Stampede
INSERT INTO `mob_skill_lists` VALUES ('Ophiotaurus',1009,2925); -- Bonebreaking Barrage
INSERT INTO `mob_skill_lists` VALUES ('Ophiotaurus',1009,3506); -- Hellfire Arrow
INSERT INTO `mob_skill_lists` VALUES ('Ophiotaurus',1009,3507); -- Incensed Pummel
INSERT INTO `mob_skill_lists` VALUES ('Siren',1010,3511); -- Lunatic Voice
INSERT INTO `mob_skill_lists` VALUES ('Siren',1010,3512); -- Sonic Buffet
INSERT INTO `mob_skill_lists` VALUES ('Siren',1010,3513); -- Entice
INSERT INTO `mob_skill_lists` VALUES ('Siren',1010,3514); -- Hysteric Assault
INSERT INTO `mob_skill_lists` VALUES ('Siren',1010,3515); -- Clarsach Call
-- Trusts
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Shantotto',1011,0);
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Naji',1012,33); -- Burning Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Naji',1012,34); -- Red Lotus Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Naji',1012,40); -- Vorpal Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Kupipi',1013,163); -- Starlight
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Kupipi',1013,164); -- Moonlight
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Excenmille',1014,112); -- Double Thrust
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Excenmille',1014,115); -- Leg Sweep
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Excenmille',1014,116); -- Penta Thrust
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ayame',1015,144); -- Tachi: Enpi
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ayame',1015,145); -- Tachi: Hobaku
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ayame',1015,146); -- Tachi: Goten
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ayame',1015,147); -- Tachi: Kagero
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ayame',1015,148); -- Tachi: Jinpu
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ayame',1015,150); -- Tachi: Yukikaze
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ayame',1015,151); -- Tachi: Gekko
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ayame',1015,152); -- Tachi: Kasha
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Nanaa_Mihgo',1016,16);   -- Wasp Sting
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Nanaa_Mihgo',1016,23);   -- Dancing Edge
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Nanaa_Mihgo',1016,3189); -- King Cobra Clamp
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Curilla',1017,34); -- Red Lotus Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Curilla',1017,37); -- Seraph Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Curilla',1017,41); -- Swift Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Volker',1018,34); -- Red Lotus Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Volker',1018,39); -- Spirits Within
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Volker',1018,40); -- Vorpal Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Volker',1018,42); -- Savage Blade
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ajido-Marujido',1019,0);
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Trion',1020,34);   -- Red Lotus Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Trion',1020,42);   -- Savage Blade
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Zeid',1021,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Lion',1022,0);
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Tenzen',1023,1390); -- Amatsu: Torimai
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Tenzen',1023,1391); -- Amatsu: Kazakiri
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Tenzen',1023,1392); -- Amatsu: Yukiarashi
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Tenzen',1023,1393); -- Amatsu: Tsukioboro
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Tenzen',1023,1394); -- Amatsu: Hanaikusa
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Tenzen',1023,1395); -- Amatsu: Tsukikage
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Mihli_Aliapoh',1024,162); -- Brainshaker
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Mihli_Aliapoh',1024,166); -- True Strike
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Mihli_Aliapoh',1024,168); -- Hexastrike

-- Update on October 11, 2021 https://wiki.ffo.jp/html/38404.html
-- He now uses the weapon skills " Sanguine Blade " and " Circle Blade ."
-- Stopped using the weapon skills " Red Lotus " and " Swift Blade ".
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Valaineral',1025,34);  -- Red Lotus Blade
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Valaineral',1025,41);  -- Swift Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Valaineral',1025,38);  -- Circle Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Valaineral',1025,47);  -- Sanguine Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Valaineral',1025,42);  -- Savage Blade
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Valaineral',1025,238); -- Uriel Blade Uses player WS not mob ability for this? Unsure how it works

-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Joachim',1026,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Naja_Salaheem',1026,0);
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Prishe',1028,3234); -- Nullifying Dropkick
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Prishe',1028,3235); -- Auroral Uppercut
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Prishe',1028,3236); -- Knuckle Sandwich
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ulmia',1029,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Shikaree_Z',1030,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Cherukiki',1031,0);
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iron_Eater',1032,80); -- Shield Break
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iron_Eater',1032,83); -- Armor Break
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iron_Eater',1032,88); -- Steel Cyclone
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Gessho',1033,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Gadalar',1034,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Rainemard',1035,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ingrid',1036,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Lehko_Habhoka',1037,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Nashmeira',1038,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Zazarg',1039,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ovjang',1040,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Mnejing',1041,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Sakura',1042,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Luzaf',1043,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Najelith',1044,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Aldo',1045,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Moogle',1046,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Fablinix',1047,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maat',1048,0); -- Combo (Maat)
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maat',1048,1028); -- Shoulder Tackle (Maat)
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maat',1048,0); -- One Inch Punch (Maat)
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maat',1048,0); -- Backhand Blow (Maat)
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maat',1048,0); -- Raging Fists (Maat)
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maat',1048,0); -- Spinning Attack (Maat)
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maat',1048,0); -- Howling Fist (Maat)
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maat',1048,1033); -- Dragon Kick (Maat)
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maat',1048,1034); -- Asuran Fists (Maat)
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maat',1048,0); -- TODO: Bear Killer
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_D_Shantotto',1049,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Star_Sibyl',1050,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Karaha-Baruha',1051,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Cid',1052,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Gilgamesh',1053,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Areuhat',1054,0);
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Semih_Lafihna',1055,3487); -- Sidewinder (Semih Lafihna)
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Semih_Lafihna',1055,3488); -- Arching Arrow (Semih Lafihna)
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Semih_Lafihna',1055,3489); -- Lux Arrow
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Semih_Lafihna',1055,3490); -- Stellar Arrow
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Elivira',1056,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Noillurie',1057,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Lhu_Mhakaracca',1058,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ferreous_Coffin',1059,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Lilisette',1060,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Mumor',1061,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Uka_Totlihn',1062,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Klara',1063,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Romaa_Mihgo',1064,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Kuyin_Hathdenna',1065,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Rahal',1066,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Koru-Moru',1067,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Pieuje_UC',1068,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Invincible_Shield_UC',1069,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Apururu_UC',1070,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Jakoh_Wahcondalo_UC',1071,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Flaviria_UC',1072,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Babban',1073,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Abenzio',1074,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Rughadjeen',1075,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Kukki-Chebukki',1076,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Margret',1077,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Chacharoon',1078,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Lhe_Lhangavo',1079,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Arciela',1080,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Mayakov',1081,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Qultada',1082,0);
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Adelheid',1083,3466); -- Paralyzing Microtube
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Adelheid',1083,3467); -- Silencing Microtube
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Adelheid',1083,3468); -- Binding Microtube
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Adelheid',1083,3469); -- Twirling Dervish
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Amchuchu',1084,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Brygid',1085,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Mildaurion',1086,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Halver',1087,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Rongelouts',1088,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Leonoyne',1089,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maximilian',1090,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Kayeel-Payeel',1091,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Robel-Akbel',1092,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Kupofried',1093,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Selh_teus',1094,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Yoran-Oran_UC',1095,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Sylvie_UC',1096,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Abquhbah',1097,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Balamor',1098,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_August',1099,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Rosulatia',1100,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Teodor',1101,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ullegore',1102,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Makki-Chebukki',1103,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_King_of_Hearts',1104,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Morimar',1105,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Darrcuiln',1106,0);
-- TODO: Verify these
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAHM',1107,41);        -- Swift Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAHM',1107,103);       -- Cross Reaver
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAHM',1107,225);       -- Chant du Cygne
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,40);        -- Vorpal Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,225);       -- Chant du Cygne
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,933);       -- Dominion Slash
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3710);      -- Arrogance Incarnate
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAMR',1109,69);        -- Rampage
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAMR',1109,70);        -- Calamity
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAMR',1109,76);        -- Cloudsplitter
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAMR',1109,932);       -- Havoc Spiral
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AATT',1110,102);       -- Guillotine
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AATT',1110,935);       -- Amon Drive
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAGK',1111,150);       -- Tachi: Yukikaze
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAGK',1111,151);       -- Tachi: Gekko
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAGK',1111,152);       -- Tachi: Kasha
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAGK',1111,156);       -- Tachi: Fudo
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAGK',1111,937);       -- Dragonfall
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha',1112,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ygnas',1113,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Monberaux',1114,0);
-- Reserved for future Trust 6000 (ID: 1115)
-- Reserved for future Trust 6001 (ID: 1116)
-- Reserved for future Trust 6002 (ID: 1117)
-- Reserved for future Trust 6003 (ID: 1118) (Formerly Cornelia)
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Excenmille_S',1119,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ayame_UC',1120,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maat_UC',1121,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Aldo_UC',1122,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Naja_Salaheem_UC',1123,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Lion_II',1124,0);
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Zied_II',1125,56); -- Ground Strike
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Prishe_II',1126,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Nashmeira_II',1127,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Lilisette_II',1128,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Tenzen_II',1129,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Mumor_II',1130,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Ingrid_II',1131,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Arciela_II',1132,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha_II',1133,0);
-- INSERT INTO `mob_skill_lists` VALUES ('TRUST_Shantotto_II',1134,0);
-- Reserved for future Trust 6020 (ID: 1135)
-- Reserved for future Trust 6021 (ID: 1136)
-- Reserved for future Trust 6022 (ID: 1137)

INSERT INTO `mob_skill_lists` VALUES ('Lightning_Wyvern',1138,813); -- Dispelling Wind
INSERT INTO `mob_skill_lists` VALUES ('Lightning_Wyvern',1138,814); -- Deadly Drive
INSERT INTO `mob_skill_lists` VALUES ('Lightning_Wyvern',1138,815); -- Wind Wall
INSERT INTO `mob_skill_lists` VALUES ('Lightning_Wyvern',1138,816); -- Fang RUsh
INSERT INTO `mob_skill_lists` VALUES ('Lightning_Wyvern',1138,817); -- Dread Shriek
INSERT INTO `mob_skill_lists` VALUES ('Lightning_Wyvern',1138,818); -- Tail Crush
INSERT INTO `mob_skill_lists` VALUES ('Lightning_Wyvern',1138,820); -- Thunder Breath
INSERT INTO `mob_skill_lists` VALUES ('Chaos_Wyvern',1139,813); -- Dispelling Wind
INSERT INTO `mob_skill_lists` VALUES ('Chaos_Wyvern',1139,814); -- Deadly Drive
INSERT INTO `mob_skill_lists` VALUES ('Chaos_Wyvern',1139,815); -- Wind Wall
INSERT INTO `mob_skill_lists` VALUES ('Chaos_Wyvern',1139,816); -- Fang Rush
INSERT INTO `mob_skill_lists` VALUES ('Chaos_Wyvern',1139,817); -- Dread Shriek
INSERT INTO `mob_skill_lists` VALUES ('Chaos_Wyvern',1139,818); -- Tail Crush
INSERT INTO `mob_skill_lists` VALUES ('Chaos_Wyvern',1139,822); -- Chaos Breath
INSERT INTO `mob_skill_lists` VALUES ('Blizzard_Wyvern',1140,813); -- Dispelling Wind
INSERT INTO `mob_skill_lists` VALUES ('Blizzard_Wyvern',1140,814); -- Deadly Drive
INSERT INTO `mob_skill_lists` VALUES ('Blizzard_Wyvern',1140,815); -- Wind Wall
INSERT INTO `mob_skill_lists` VALUES ('Blizzard_Wyvern',1140,816); -- Fang Rush
INSERT INTO `mob_skill_lists` VALUES ('Blizzard_Wyvern',1140,817); -- Dread Shriek
INSERT INTO `mob_skill_lists` VALUES ('Blizzard_Wyvern',1140,818); -- Tail Crush
INSERT INTO `mob_skill_lists` VALUES ('Blizzard_Wyvern',1140,819); -- Blizzard Breath
INSERT INTO `mob_skill_lists` VALUES ('Luopan',1141,3045); -- Concentric Pulse
INSERT INTO `mob_skill_lists` VALUES ('Luopan',1141,3051); -- Mending Halation
INSERT INTO `mob_skill_lists` VALUES ('Luopan',1141,3052); -- Radial Arcana
INSERT INTO `mob_skill_lists` VALUES ('Bashe',1142,370); -- Baleful Gaze
INSERT INTO `mob_skill_lists` VALUES ('Kamlanaut (Apoc Nigh)',1143,829); -- Great Wheel
INSERT INTO `mob_skill_lists` VALUES ('Kamlanaut (Apoc Nigh)',1143,830); -- Light Blade
INSERT INTO `mob_skill_lists` VALUES ('Ealdnarche (Apoc Nigh)',1144,985); -- Stellar Burst
INSERT INTO `mob_skill_lists` VALUES ('Ealdnarche (Apoc Nigh)',1144,986); -- Vortex
INSERT INTO `mob_skill_lists` VALUES ('Ealdnarche (Apoc Nigh)',1144,1006); -- Omega Javelin
INSERT INTO `mob_skill_lists` VALUES ('Atori-Tutori_qm',1145,7); -- Howling Fist
INSERT INTO `mob_skill_lists` VALUES ('Atori-Tutori_qm',1145,9); -- Asuran Fists
INSERT INTO `mob_skill_lists` VALUES ('Atori-Tutori_qm',1145,10); -- Final Heaven
INSERT INTO `mob_skill_lists` VALUES ('Atori-Tutori_qm',1145,11); -- Ascetics Fury
INSERT INTO `mob_skill_lists` VALUES ('Atori-Tutori_qm',1145,14); -- Victory Smite
INSERT INTO `mob_skill_lists` VALUES ('KS99_Wyrm-Flying-Attack',1146,950);
INSERT INTO `mob_skill_lists` VALUES ('KS99_Wyrm-Flying',1147,955);
INSERT INTO `mob_skill_lists` VALUES ('KS99_Wyrm-Flying',1147,956);
INSERT INTO `mob_skill_lists` VALUES ('Mind_Hoarder',1148,524);
INSERT INTO `mob_skill_lists` VALUES ('Sluagh',1149,472);
INSERT INTO `mob_skill_lists` VALUES ('Altedour_I_Tavnazia',1150,255); -- dimensional_death
INSERT INTO `mob_skill_lists` VALUES ('Hecteyes-Zilart',1151,437);	-- Zilart
INSERT INTO `mob_skill_lists` VALUES ('Hecteyes-Zilart',1151,438);
INSERT INTO `mob_skill_lists` VALUES ('Hecteyes-Zilart',1151,439);
INSERT INTO `mob_skill_lists` VALUES ('Doll-NM',1152,534); -- No Meltdown
INSERT INTO `mob_skill_lists` VALUES ('Doll-NM',1152,535);
INSERT INTO `mob_skill_lists` VALUES ('Doll-NM',1152,536);
INSERT INTO `mob_skill_lists` VALUES ('Doll-NM',1152,537);
INSERT INTO `mob_skill_lists` VALUES ('Doll-NM',1152,538);
INSERT INTO `mob_skill_lists` VALUES ('Doll-NM',1152,539);
INSERT INTO `mob_skill_lists` VALUES ('Doll-NM',1152,541);
INSERT INTO `mob_skill_lists` VALUES ('DarkSpark',1153,510); -- Berserk
INSERT INTO `mob_skill_lists` VALUES ('BadBreath',1154,319); -- Bad Breath Only
INSERT INTO `mob_skill_lists` VALUES ('Delver',1155,1232); -- Murk
INSERT INTO `mob_skill_lists` VALUES ('Delver',1155,1233); -- material_fend
INSERT INTO `mob_skill_lists` VALUES ('Delver',1155,1234); -- carousel
INSERT INTO `mob_skill_lists` VALUES ('Delver',1155,1274); -- impalement
INSERT INTO `mob_skill_lists` VALUES ('Delver',1155,1275); -- empty_thrash
INSERT INTO `mob_skill_lists` VALUES ('Delver',1155,1276); -- promyvion_brume
INSERT INTO `mob_skill_lists` VALUES ('DynamisStatue-GoblinStompOnly',1156,1114); -- seismostomp
INSERT INTO `mob_skill_lists` VALUES ('DynamisKindredRA',1157,1152); -- Hecatomb Wave
INSERT INTO `mob_skill_lists` VALUES ('Eastern_Sphinx',1158,797);
INSERT INTO `mob_skill_lists` VALUES ('Eastern_Sphinx',1158,798);
INSERT INTO `mob_skill_lists` VALUES ('Eastern_Sphinx',1158,799);
INSERT INTO `mob_skill_lists` VALUES ('Eastern_Sphinx',1158,800);
INSERT INTO `mob_skill_lists` VALUES ('Eastern_Sphinx',1158,802);
INSERT INTO `mob_skill_lists` VALUES ('Eastern_Sphinx',1158,803);
INSERT INTO `mob_skill_lists` VALUES ('Huwasi',1159,678); -- Crystal Rain
INSERT INTO `mob_skill_lists` VALUES ('GiantBirdTwo',1160,399); -- Scratch
INSERT INTO `mob_skill_lists` VALUES ('GiantBirdTwo',1160,400); -- Triple Attack
INSERT INTO `mob_skill_lists` VALUES ('GiantBirdTwo',1160,401); -- Gliding Spike
INSERT INTO `mob_skill_lists` VALUES ('GiantBirdTwo',1160,402); -- Feather barrier
INSERT INTO `mob_skill_lists` VALUES ('GiantBirdTwo',1160,403); -- Stormwind
INSERT INTO `mob_skill_lists` VALUES ('Dahu',1161,802); -- Great_Sandstorm
INSERT INTO `mob_skill_lists` VALUES ('Picolaton',1162,926); -- Stormwind Macan Gadangan

INSERT INTO `mob_skill_lists` VALUES ('Quadav-WOTG',1163,2203); 
INSERT INTO `mob_skill_lists` VALUES ('Quadav-WOTG',1163,2204); 
INSERT INTO `mob_skill_lists` VALUES ('Quadav-WOTG',1163,2223); 
INSERT INTO `mob_skill_lists` VALUES ('Quadav-WOTG',1163,2224); 
INSERT INTO `mob_skill_lists` VALUES ('Quadav-WOTG',1163,2225); 
INSERT INTO `mob_skill_lists` VALUES ('Quadav-WOTG',1163,2226);
INSERT INTO `mob_skill_lists` VALUES ('Quadav-WOTG',1163,2227); 

INSERT INTO `mob_skill_lists` VALUES ('Yagudo-WOTG',1164,618); 
INSERT INTO `mob_skill_lists` VALUES ('Yagudo-WOTG',1164,619); 
INSERT INTO `mob_skill_lists` VALUES ('Yagudo-WOTG',1164,620); 
INSERT INTO `mob_skill_lists` VALUES ('Yagudo-WOTG',1164,2413); 
INSERT INTO `mob_skill_lists` VALUES ('Yagudo-WOTG',1164,2206); 

INSERT INTO `mob_skill_lists` VALUES ('Orc-WOTG',1165,1061); -- Battle Dance
INSERT INTO `mob_skill_lists` VALUES ('Orc-WOTG',1165,2201); 
INSERT INTO `mob_skill_lists` VALUES ('Orc-WOTG',1165,2202); 
INSERT INTO `mob_skill_lists` VALUES ('Orc-WOTG',1165,2263); 
INSERT INTO `mob_skill_lists` VALUES ('Orc-WOTG',1165,2264); 

INSERT INTO `mob_skill_lists` VALUES ('OrcishWarmachine-WOTG',1166,926); 
INSERT INTO `mob_skill_lists` VALUES ('Goblin-WOTG',1167,926); 

INSERT INTO `mob_skill_lists` VALUES ('Cogtooth_Skagnogg',1168,635);
INSERT INTO `mob_skill_lists` VALUES ('Cogtooth_Skagnogg',1168,636);
INSERT INTO `mob_skill_lists` VALUES ('Cogtooth_Skagnogg',1168,637);
INSERT INTO `mob_skill_lists` VALUES ('Cogtooth_Skagnogg',1168,638);
INSERT INTO `mob_skill_lists` VALUES ('Cogtooth_Skagnogg',1168,639);
INSERT INTO `mob_skill_lists` VALUES ('Cogtooth_Skagnogg',1168,2350);
INSERT INTO `mob_skill_lists` VALUES ('Cogtooth_Skagnogg',1168,2351);
INSERT INTO `mob_skill_lists` VALUES ('Cogtooth_Skagnogg',1168,2352);

INSERT INTO `mob_skill_lists` VALUES ('Bhogbiggs_Grenade',1169,2235);
INSERT INTO `mob_skill_lists` VALUES ('Bhogbiggs_Grenade',1169,2236);
INSERT INTO `mob_skill_lists` VALUES ('Bhogbiggs_Grenade',1169,2237);

INSERT INTO `mob_skill_lists` VALUES ('Bhogbiggs_Vial',1170,2371);

INSERT INTO `mob_skill_lists` VALUES ('Head_Butt_Autoattack',1171,3843); 
INSERT INTO `mob_skill_lists` VALUES ('Skull_Smash_only',1172,2267); 

INSERT INTO `mob_skill_lists` VALUES ('Valkeng_Slapstick',1173,1943);
INSERT INTO `mob_skill_lists` VALUES ('Valkeng_Valoredge',1174,1940);
INSERT INTO `mob_skill_lists` VALUES ('Valkeng_Valoredge',1174,1941);
INSERT INTO `mob_skill_lists` VALUES ('Valkeng_Sharpshot',1175,1942);

INSERT INTO `mob_skill_lists` VALUES ('Blighting_Brand',1176,1560); -- Whispers of Ire only
INSERT INTO `mob_skill_lists` VALUES ('Eldritch_Edge',1177,397); -- Flurry of Rage only

INSERT INTO `mob_skill_lists` VALUES('Ulbrecht', 1178, 16);
INSERT INTO `mob_skill_lists` VALUES('Ulbrecht', 1178, 17);
INSERT INTO `mob_skill_lists` VALUES('Ulbrecht', 1178, 18);
INSERT INTO `mob_skill_lists` VALUES('Ulbrecht', 1178, 2314);
INSERT INTO `mob_skill_lists` VALUES('Ulbrecht', 1178, 2315);
INSERT INTO `mob_skill_lists` VALUES('Ulbrecht', 1178, 2316);
INSERT INTO `mob_skill_lists` VALUES('Ulbrecht', 1178, 2317);

--Voidwalker
INSERT INTO `mob_skill_lists` VALUES ('Capricornus',1179,451); -- Splash Breath
INSERT INTO `mob_skill_lists` VALUES ('Capricornus',1179,641); -- Recoil Dive
INSERT INTO `mob_skill_lists` VALUES ('Capricornus',1179,449); -- Intimidate
INSERT INTO `mob_skill_lists` VALUES ('Capricornus',1179,450); -- Aqua Ball
INSERT INTO `mob_skill_lists` VALUES ('Capricornus',1179,454); -- Water Shield
INSERT INTO `mob_skill_lists` VALUES ('Capricornus',1179,453); -- Water Wall

INSERT INTO `mob_skill_lists` VALUES ('Krabkatoa',1180,448); -- Metallic Body
INSERT INTO `mob_skill_lists` VALUES ('Krabkatoa',1180,443); -- Bubble Curtain
INSERT INTO `mob_skill_lists` VALUES ('Krabkatoa',1180,442); -- Bubble Shower
INSERT INTO `mob_skill_lists` VALUES ('Krabkatoa',1180,445); -- Scissor Guard
INSERT INTO `mob_skill_lists` VALUES ('Krabkatoa',1180,2512); -- Venom Shower
INSERT INTO `mob_skill_lists` VALUES ('Krabkatoa',1180,2513); -- Mega Scissor

INSERT INTO `mob_skill_lists` VALUES ('LampreyLord',1181,3907); -- Acid Mist

INSERT INTO `mob_skill_lists` VALUES ('Blobdingnag',1182,2548);  -- Fluid_Spread
INSERT INTO `mob_skill_lists` VALUES ('Blobdingnag',1182,2549);  -- Fluid_Toss
INSERT INTO `mob_skill_lists` VALUES ('Blobdingnag',1182,2550); -- Dissolve

INSERT INTO `mob_skill_lists` VALUES ('FarrucaFly',1183,659);
INSERT INTO `mob_skill_lists` VALUES ('FarrucaFly',1183,660);
INSERT INTO `mob_skill_lists` VALUES ('FarrucaFly',1183,318);

INSERT INTO `mob_skill_lists` VALUES ('Orcus',1184,279);
INSERT INTO `mob_skill_lists` VALUES ('Orcus',1184,2516); -- gravitic_horn
INSERT INTO `mob_skill_lists` VALUES ('Orcus',1184,2517); -- quake_blast

INSERT INTO `mob_skill_lists` VALUES ('LordRuthven',1185,2106);
INSERT INTO `mob_skill_lists` VALUES ('LordRuthven',1185,2107);
INSERT INTO `mob_skill_lists` VALUES ('LordRuthven',1185,2108);
INSERT INTO `mob_skill_lists` VALUES ('LordRuthven',1185,2109);
INSERT INTO `mob_skill_lists` VALUES ('LordRuthven',1185,2110);
INSERT INTO `mob_skill_lists` VALUES ('LordRuthven',1185,2111);
INSERT INTO `mob_skill_lists` VALUES ('LordRuthven',1185,2388); -- dirty_breath
INSERT INTO `mob_skill_lists` VALUES ('LordRuthven',1185,2534); -- minax_glare

INSERT INTO `mob_skill_lists` VALUES ('Dawon',1186,270);
INSERT INTO `mob_skill_lists` VALUES ('Dawon',1186,271);
INSERT INTO `mob_skill_lists` VALUES ('Dawon',1186,273);
INSERT INTO `mob_skill_lists` VALUES ('Dawon',1186,2207); -- disorienting_waul

-- 1187 free

INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',1188,2519); -- dexter_wing
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',1188,2520); -- sinister_wing
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',1188,2521); -- chaos_blast
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',1188,2523); -- dancing_tail
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',1188,2527); -- soul_douse
INSERT INTO `mob_skill_lists` VALUES ('Yilbegan',1188,2529); -- dark_star

-- Custom Content

-- Murgleis
INSERT INTO `mob_skill_lists` VALUES ('Murgleis',2000,44); -- Death Blossom
INSERT INTO `mob_skill_lists` VALUES ('Murgleis',2000,405); -- Dire Whorl
INSERT INTO `mob_skill_lists` VALUES ('Murgleis',2000,1252); -- Shadow Spread
INSERT INTO `mob_skill_lists` VALUES ('Murgleis',2000,530); -- Momento Mori

-- Amano
INSERT INTO `mob_skill_lists` VALUES ('Kogarasumaru',2001,154); -- Tachi: Rana 
INSERT INTO `mob_skill_lists` VALUES ('Kogarasumaru',2001,405); -- Dire Whorl
INSERT INTO `mob_skill_lists` VALUES ('Kogarasumaru',2001,1220); -- Auroral Drape
INSERT INTO `mob_skill_lists` VALUES ('Kogarasumaru',2001,510); -- Berserk
-- Amano Meikyo
INSERT INTO `mob_skill_lists` VALUES ('Kogarasumaru-Meikyo',2002,154); -- Tachi: Rana 

--Burtgang
INSERT INTO `mob_skill_lists` VALUES ('Burtgang',2003,45); -- Atonement
INSERT INTO `mob_skill_lists` VALUES ('Burtgang',2003,405); -- Dire Whorl
INSERT INTO `mob_skill_lists` VALUES ('Burtgang',2003,2142); -- Mega Holy
INSERT INTO `mob_skill_lists` VALUES ('Burtgang',2003,3220); -- Infernal Bulwark

-- Vajra(Goblin Tomb Raider)
INSERT INTO `mob_skill_lists` VALUES ('Goblin_Tomb_Raider',2004,27); -- Mandalic Stab
INSERT INTO `mob_skill_lists` VALUES ('Goblin_Tomb_Raider',2004,590); -- Goblin Rush
INSERT INTO `mob_skill_lists` VALUES ('Goblin_Tomb_Raider',2004,591); -- Bomb Toss

-- Dynamis
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-H2H',3000,246); -- shackled_fists (h2h only)
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-H2H',3000,249); -- netherspikes
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-H2H',3000,250); -- carnal_nightmare
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-H2H',3000,251); -- aegis_schism
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-H2H',3000,252); -- dancing_chains
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-H2H',3000,253); -- barbed_crescent
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-H2H',3000,255); -- dimensional_death

INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-1Hand',3001,247); -- foxfire (1-handed weapons only)
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-1Hand',3001,249); -- netherspikes
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-1Hand',3001,250); -- carnal_nightmare
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-1Hand',3001,251); -- aegis_schism
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-1Hand',3001,252); -- dancing_chains
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-1Hand',3001,253); -- barbed_crescent
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-1Hand',3001,255); -- dimensional_death

INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-2Hand',3002,248); -- grim_halo(2-handed weapons only)
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-2Hand',3002,249); -- netherspikes
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-2Hand',3002,250); -- carnal_nightmare
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-2Hand',3002,251); -- aegis_schism
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-2Hand',3002,252); -- dancing_chains
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-2Hand',3002,253); -- barbed_crescent
INSERT INTO `mob_skill_lists` VALUES ('HydraCorps-2Hand',3002,255); -- dimensional_death

-- COP
INSERT INTO `mob_skill_lists` VALUES ('Fomor-H2H',3500,246); -- shackled_fists (h2h only)
INSERT INTO `mob_skill_lists` VALUES ('Fomor-H2H',3500,249); -- netherspikes
INSERT INTO `mob_skill_lists` VALUES ('Fomor-H2H',3500,250); -- carnal_nightmare
INSERT INTO `mob_skill_lists` VALUES ('Fomor-H2H',3500,251); -- aegis_schism
INSERT INTO `mob_skill_lists` VALUES ('Fomor-H2H',3500,252); -- dancing_chains
INSERT INTO `mob_skill_lists` VALUES ('Fomor-H2H',3500,253); -- barbed_crescent

INSERT INTO `mob_skill_lists` VALUES ('Fomor-1Hand',3501,247); -- foxfire (1-handed weapons only)
INSERT INTO `mob_skill_lists` VALUES ('Fomor-1Hand',3501,249); -- netherspikes
INSERT INTO `mob_skill_lists` VALUES ('Fomor-1Hand',3501,250); -- carnal_nightmare
INSERT INTO `mob_skill_lists` VALUES ('Fomor-1Hand',3501,251); -- aegis_schism
INSERT INTO `mob_skill_lists` VALUES ('Fomor-1Hand',3501,252); -- dancing_chains
INSERT INTO `mob_skill_lists` VALUES ('Fomor-1Hand',3501,253); -- barbed_crescent

INSERT INTO `mob_skill_lists` VALUES ('Fomor-2Hand',3502,248); -- grim_halo(2-handed weaponls only)
INSERT INTO `mob_skill_lists` VALUES ('Fomor-2Hand',3502,249); -- netherspikes
INSERT INTO `mob_skill_lists` VALUES ('Fomor-2Hand',3502,250); -- carnal_nightmare
INSERT INTO `mob_skill_lists` VALUES ('Fomor-2Hand',3502,251); -- aegis_schism
INSERT INTO `mob_skill_lists` VALUES ('Fomor-2Hand',3502,252); -- dancing_chains
INSERT INTO `mob_skill_lists` VALUES ('Fomor-2Hand',3502,253); -- barbed_crescent






--------------------------Boyahda Merit Mobs--------------------------

-- Snaggletooth_Peapuk
INSERT INTO `mob_skill_lists` VALUES ('Snaggletooth_Peapuk',6000,1158); -- Turbulence
INSERT INTO `mob_skill_lists` VALUES ('Snaggletooth_Peapuk',6000,366); -- Tail Blow
INSERT INTO `mob_skill_lists` VALUES ('Snaggletooth_Peapuk',6000,406); -- Hammer Beak
INSERT INTO `mob_skill_lists` VALUES ('Snaggletooth_Peapuk',6000,724); -- Evasion
-- Viseclaw 
INSERT INTO `mob_skill_lists` VALUES ('Viseclaw',6001,448); -- Metallic Body
INSERT INTO `mob_skill_lists` VALUES ('Viseclaw',6001,418);	-- Regeneration
INSERT INTO `mob_skill_lists` VALUES ('Viseclaw',6001,445);	-- Scissor Guard
INSERT INTO `mob_skill_lists` VALUES ('Viseclaw',6001,444);	-- Big Scissors
-- Mourning_Crawler
INSERT INTO `mob_skill_lists` VALUES ('Mourning_Crawler',6002,356); -- Sharp Strike
INSERT INTO `mob_skill_lists` VALUES ('Mourning_Crawler',6002,379); -- Chomp Rush
INSERT INTO `mob_skill_lists` VALUES ('Mourning_Crawler',6002,331); -- Leafstorm
INSERT INTO `mob_skill_lists` VALUES ('Mourning_Crawler',6002,470); -- Methane Breath

-- Alkyoneus
-- Phase 1 WAR
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6003,662); -- lightning roar
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6003,665); -- grand slam
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6003,664); -- impact roar
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6003,2576); -- mercurial strike
-- Phase 2 MNK
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6004,665); -- grand slam
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6004,664); -- impact roar
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6004,662); -- lightning roar
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6004,2578); -- colossal slam
-- Phase 3 RNG
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6005,665); -- grand slam
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6005,664); -- impact roar
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6005,662); -- lightning roar
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6005,1636); -- trebuchet
-- Phase 4 ALL
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6006,2578); -- colossal slam
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6006,1636); -- trebuchet
INSERT INTO `mob_skill_lists` VALUES ('Alkyoneus',6006,2576); -- mercurial strike

-- Marquis Sabnock
-- Phase 1
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Sabnock_hp_under_50',6007,1148); -- Condemnation 
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Sabnock_hp_under_50',6007,1149); -- Quadrastrike
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Sabnock_hp_under_50',6007,2691); -- Dark Sun
-- Phase 2
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Sabnock_hp_under_25',6008,1148); -- Condemnation 
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Sabnock_hp_under_25',6008,1149); -- Quadrastrike
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Sabnock_hp_under_25',6008,2691); -- Dark Sun
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Sabnock_hp_under_25',6008,2690); -- Dark Moon

-- Biast
INSERT INTO `mob_skill_lists` VALUES ('Biast',6009,2437); -- Aqua Blast
INSERT INTO `mob_skill_lists` VALUES ('Biast',6009,645); -- Body Slam
INSERT INTO `mob_skill_lists` VALUES ('Biast',6009,647); -- Chaos Blade
INSERT INTO `mob_skill_lists` VALUES ('Biast',6009,648); -- Petro Eyes
INSERT INTO `mob_skill_lists` VALUES ('Biast',6009,650); -- Thorn Song
-- Mighty Strikes
INSERT INTO `mob_skill_lists` VALUES ('Biast_MS',5999,645); -- Body Slam

-- Novv the Whitehearted
INSERT INTO `mob_skill_lists` VALUES ('Novv_the_Whitehearted',6010,771); -- Hydro Ball
INSERT INTO `mob_skill_lists` VALUES ('Novv_the_Whitehearted',6010,774); -- Bubble Armor
INSERT INTO `mob_skill_lists` VALUES ('Novv_the_Whitehearted',6010,777);  -- Hydro shot
INSERT INTO `mob_skill_lists` VALUES ('Novv_the_Whitehearted',6010,1957); -- Frog Song
INSERT INTO `mob_skill_lists` VALUES ('Novv_the_Whitehearted',6010,1960); -- Frog Cheer

-- Zuug the Shoreleaper
INSERT INTO `mob_skill_lists` VALUES ('Zuug_the_Shoreleaper',6011,771); -- Hydro Ball
INSERT INTO `mob_skill_lists` VALUES ('Zuug_the_Shoreleaper',6011,774); -- Bubble Armor
INSERT INTO `mob_skill_lists` VALUES ('Zuug_the_Shoreleaper',6011,780); -- Spinning Fin
INSERT INTO `mob_skill_lists` VALUES ('Zuug_the_Shoreleaper',6011,770); -- Jumping Thrust
INSERT INTO `mob_skill_lists` VALUES ('Zuug_the_Shoreleaper',6011,2144); -- Divine Spear
-- Spirit Surge
INSERT INTO `mob_skill_lists` VALUES ('Zuug_the_Shoreleaper',6012,770); -- Jumping Thrust

-- Voll the Sharkfinned
INSERT INTO `mob_skill_lists` VALUES ('Voll_the_Sharkfinned',6013,771); -- Hydro Ball
INSERT INTO `mob_skill_lists` VALUES ('Voll_the_Sharkfinned',6013,777); -- Hydro shot
INSERT INTO `mob_skill_lists` VALUES ('Voll_the_Sharkfinned',6013,780); -- Spinning Fin
INSERT INTO `mob_skill_lists` VALUES ('Voll_the_Sharkfinned',6013,3993); -- Sucker Punch
INSERT INTO `mob_skill_lists` VALUES ('Voll_the_Sharkfinned',6013,3496); -- Hollow Smite

-- Worr the Clawfisted
INSERT INTO `mob_skill_lists` VALUES ('Worr_the_Clawfisted',6014,771); -- Hydro Ball
INSERT INTO `mob_skill_lists` VALUES ('Worr_the_Clawfisted',6014,774); -- Bubble Armor
INSERT INTO `mob_skill_lists` VALUES ('Worr_the_Clawfisted',6014,780); -- Spinning Fin
INSERT INTO `mob_skill_lists` VALUES ('Worr_the_Clawfisted',6014,2623);  -- Ballistic Kick
INSERT INTO `mob_skill_lists` VALUES ('Worr_the_Clawfisted',6014,1732);  -- Somersault Kick

-- Pahh the Gullcaller
INSERT INTO `mob_skill_lists` VALUES ('Pahh_the_Gullcaller',6015,771); -- Hydro Ball
INSERT INTO `mob_skill_lists` VALUES ('Pahh_the_Gullcaller',6015,774); -- Bubble Armor
INSERT INTO `mob_skill_lists` VALUES ('Pahh_the_Gullcaller',6015,777);  -- Hydro shot
INSERT INTO `mob_skill_lists` VALUES ('Pahh_the_Gullcaller',6015,780); -- Spinning Fin
-- Wyvern Form
INSERT INTO `mob_skill_lists` VALUES ('Pahh_the_Gullcaller_Wyvern',6016,819); -- Blizzard breath -- chance of ice spikes effect
INSERT INTO `mob_skill_lists` VALUES ('Pahh_the_Gullcaller_Wyvern',6016,820); -- Thunder breath -- chance of shock spikes effect
INSERT INTO `mob_skill_lists` VALUES ('Pahh_the_Gullcaller_Wyvern',6016,822); -- Chaos breath -- chance of dread spikes effect

-- Friar Rush
INSERT INTO `mob_skill_lists` VALUES ('Friar_Rush',6017,3061); -- Firefly Fandango
INSERT INTO `mob_skill_lists` VALUES ('Friar_Rush',6017,510); -- Berserk
INSERT INTO `mob_skill_lists` VALUES ('Friar_Rush',6017,1817);-- Thermal Pulse

-- Carmine-Tailed Janberry
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_50',6018,785); -- light_of_penance
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_50',6018,921); -- everyones_rancor
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_50',6018,788); -- throat_stab
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_50',6018,861); -- spring_water
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_50',6018,862); -- slowga
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_50',6018,863); -- water_iv
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_50',6018,864); -- spinning_dive
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_50',6018,865); -- grand_fall
-- Sub 25%
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_25',6019,785); -- light_of_penance
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_25',6019,921); -- everyones_rancor
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_25',6019,788); -- throat_stab
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_25',6019,863); -- water_iv
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_25',6019,864); -- spinning_dive
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_25',6019,865); -- grand_fall
INSERT INTO `mob_skill_lists` VALUES ('Carmine_Tailed_Janbery_hp_under_25',6019,866); -- Tidal Wave

-- Celeste-eyed Tozberry
INSERT INTO `mob_skill_lists` VALUES ('Celeste_eyed_Tozberry',6020,785); -- light_of_penance
INSERT INTO `mob_skill_lists` VALUES ('Celeste_eyed_Tozberry',6020,921); -- everyones_rancor
INSERT INTO `mob_skill_lists` VALUES ('Celeste_eyed_Tozberry',6020,788); -- throat_stab
INSERT INTO `mob_skill_lists` VALUES ('Celeste_eyed_Tozberry',6020,783); -- Words_of_Bane
INSERT INTO `mob_skill_lists` VALUES ('Celeste_eyed_Tozberry',6020,784); -- Sigh
INSERT INTO `mob_skill_lists` VALUES ('Celeste_eyed_Tozberry',6020,3164); -- 12_blades_of_remorse

-- Bistre-hearted Malberry
INSERT INTO `mob_skill_lists` VALUES ('Bistre_hearted_Malberry',6021,785); -- light_of_penance
INSERT INTO `mob_skill_lists` VALUES ('Bistre_hearted_Malberry',6021,921); -- everyones_rancor
INSERT INTO `mob_skill_lists` VALUES ('Bistre_hearted_Malberry',6021,2665); -- Cataclysmic Vortex
INSERT INTO `mob_skill_lists` VALUES ('Bistre_hearted_Malberry',6021,2529); -- Dark Star
INSERT INTO `mob_skill_lists` VALUES ('Bistre_hearted_Malberry',6021,784); -- Sigh

-- Tawny-fingered Mugberry
INSERT INTO `mob_skill_lists` VALUES ('Tawny_fingered_Mugberry',6022,921); -- everyones_rancor
INSERT INTO `mob_skill_lists` VALUES ('Tawny_fingered_Mugberry',6022,784); -- Sigh
INSERT INTO `mob_skill_lists` VALUES ('Tawny_fingered_Mugberry',6022,786); -- Lateral_Slash
INSERT INTO `mob_skill_lists` VALUES ('Tawny_fingered_Mugberry',6022,787); -- Vertical_Slash
INSERT INTO `mob_skill_lists` VALUES ('Tawny_fingered_Mugberry',6022,2351); -- Tear Grenade
INSERT INTO `mob_skill_lists` VALUES ('Tawny_fingered_Mugberry',6022,1385); -- biotic_boomerang

-- Za'Dha Adamantking
INSERT INTO `mob_skill_lists` VALUES ('ZaDha_Adamantking',6023,2266); -- shell_charge
INSERT INTO `mob_skill_lists` VALUES ('ZaDha_Adamantking',6023,2267); -- skull_smash
INSERT INTO `mob_skill_lists` VALUES ('ZaDha_Adamantking',6023,2378); -- diamond_shell
INSERT INTO `mob_skill_lists` VALUES ('ZaDha_Adamantking',6023,2412); -- thunderous_yowl
INSERT INTO `mob_skill_lists` VALUES ('ZaDha_Adamantking',6023,1074); -- the_wrath_of_gudha (sub 50% hp)
INSERT INTO `mob_skill_lists` VALUES ('ZaDha_Adamantking',6023,2374); -- torment_of_gudha (sub 25% hp)

-- Overlord Bakgodek
INSERT INTO `mob_skill_lists` VALUES ('Overlord_Bakgodek',6024,2263); -- Tornado Edge
INSERT INTO `mob_skill_lists` VALUES ('Overlord_Bakgodek',6024,2201); -- Orcish Counterstance
INSERT INTO `mob_skill_lists` VALUES ('Overlord_Bakgodek',6024,2202); -- Berserker Dance
INSERT INTO `mob_skill_lists` VALUES ('Overlord_Bakgodek',6024,2264); -- Shoulder Charge 
-- Warmachine Form
INSERT INTO `mob_skill_lists` VALUES ('Overlord_Bakgodek_Warmachine',6025,638); -- Blastbomb 
INSERT INTO `mob_skill_lists` VALUES ('Overlord_Bakgodek_Warmachine',6025,637); -- Firebomb 
INSERT INTO `mob_skill_lists` VALUES ('Overlord_Bakgodek_Warmachine',6025,639); -- Fountain 
INSERT INTO `mob_skill_lists` VALUES ('Overlord_Bakgodek_Warmachine',6025,2350); -- Scatter Shell 
INSERT INTO `mob_skill_lists` VALUES ('Overlord_Bakgodek_Warmachine',6025,2411); -- Phantasmal Dance (sub 50% HP)
INSERT INTO `mob_skill_lists` VALUES ('Overlord_Bakgodek_Warmachine',6025,2373); -- Veil of Chaos (sub 25% HP)

-- Tzee Xicu the Manifest
INSERT INTO `mob_skill_lists` VALUES ('Tzee_Xicu_the_Manifest',6026,619); -- Parry
INSERT INTO `mob_skill_lists` VALUES ('Tzee_Xicu_the_Manifest',6026,2413); -- Feather Maelstrom
INSERT INTO `mob_skill_lists` VALUES ('Tzee_Xicu_the_Manifest',6026,2270); -- Shirahadori 
INSERT INTO `mob_skill_lists` VALUES ('Tzee_Xicu_the_Manifest',6026,3257); -- Shibaraku 
INSERT INTO `mob_skill_lists` VALUES ('Tzee_Xicu_the_Manifest',6026,2206); -- Dark Invocation (sub 50% HP)
INSERT INTO `mob_skill_lists` VALUES ('Tzee_Xicu_the_Manifest',6026,2375); -- Vorticose Sands (sub 25% HP)

-- Duke Haborym Vampyr Form
INSERT INTO `mob_skill_lists` VALUES ('Duke_Haborym_Vampyr',6027,2106); -- bloodrake
INSERT INTO `mob_skill_lists` VALUES ('Duke_Haborym_Vampyr',6027,2108); -- nosferatus_kiss
INSERT INTO `mob_skill_lists` VALUES ('Duke_Haborym_Vampyr',6027,2534); -- Minax Glare
INSERT INTO `mob_skill_lists` VALUES ('Duke_Haborym_Vampyr',6027,2111); -- eternal_damnation (sub 50% HP)
INSERT INTO `mob_skill_lists` VALUES ('Duke_Haborym_Vampyr',6027,2112); -- nocturnal_servitude (sub 25% hp)

-- Marquis Allocen
-- Autos
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Allocen_Autos',6028,3264); -- salvation_scythe
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Allocen_Autos',6028,564); -- condemnation_autoattack
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Allocen_Autos',6028,1147); -- demonic_howl_autoattack
-- TP Moves
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Allocen',6029,510); -- Berserk
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Allocen',6029,569); -- Refueling
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Allocen',6029,1377); -- fluorescence
INSERT INTO `mob_skill_lists` VALUES ('Marquis_Allocen',6029,1155); -- Subsonics

-- Antican Legatus
INSERT INTO `mob_skill_lists` VALUES ('Legatus',6030,792); -- sandstorm
INSERT INTO `mob_skill_lists` VALUES ('Legatus',6030,1255); -- occultation
INSERT INTO `mob_skill_lists` VALUES ('Legatus',6030,521); -- spinning_attack
INSERT INTO `mob_skill_lists` VALUES ('Legatus',6030,790); -- shoulder_slam
INSERT INTO `mob_skill_lists` VALUES ('Legatus',6030,2741); -- Entomb(Sub 50% HP)
INSERT INTO `mob_skill_lists` VALUES ('Legatus',6030,2072); -- Earth Shatter(sub 25% HP)

--Salamander
INSERT INTO `mob_skill_lists` VALUES ('Salamander',6031,1791); -- Incinerate
INSERT INTO `mob_skill_lists` VALUES ('Salamander',6031,1956); -- Fire Break
INSERT INTO `mob_skill_lists` VALUES ('Salamander',6031,367); -- Fireball
INSERT INTO `mob_skill_lists` VALUES ('Salamander',6031,2102); -- boiling_blood
INSERT INTO `mob_skill_lists` VALUES ('Salamander',6031,2101); -- demoralizing_roar
INSERT INTO `mob_skill_lists` VALUES ('Salamander',6031,2099); --  batterhorn

-- Kong
INSERT INTO `mob_skill_lists` VALUES ('Kong',6032,7); -- howling_fist
INSERT INTO `mob_skill_lists` VALUES ('Kong',6032,14); -- victory_smite
INSERT INTO `mob_skill_lists` VALUES ('Kong',6032,501); -- frightful_roar
INSERT INTO `mob_skill_lists` VALUES ('Kong',6032,2114); -- hellclap
INSERT INTO `mob_skill_lists` VALUES ('Kong',6032,665); -- grand_slam
INSERT INTO `mob_skill_lists` VALUES ('Kong',6032,607); -- slam_dunk 

--Ancient Vessel
INSERT INTO `mob_skill_lists` VALUES ('AncientVessel',6033,520); -- double_ray
INSERT INTO `mob_skill_lists` VALUES ('AncientVessel',6033,521); -- spinning_attack
INSERT INTO `mob_skill_lists` VALUES ('AncientVessel',6033,523); -- mysterious_light
INSERT INTO `mob_skill_lists` VALUES ('AncientVessel',6033,524); -- mind_drain
INSERT INTO `mob_skill_lists` VALUES ('AncientVessel',6033,525); -- battery_charge

--Hostile Herbivores Auto-attack
INSERT INTO `mob_skill_lists` VALUES ('Fighting_Sheep',6034,3859); -- sheep_charge_autoattack

--Dragonian Berserker
INSERT INTO `mob_skill_lists` VALUES ('Dragonian_Berserker',6035,645); -- body_slam
INSERT INTO `mob_skill_lists` VALUES ('Dragonian_Berserker',6035,646); -- heavy_stomp
INSERT INTO `mob_skill_lists` VALUES ('Dragonian_Berserker',6035,647); -- chaos_blade

--Dragonian Minstrel
INSERT INTO `mob_skill_lists` VALUES ('Dragonian_Minstrel',6036,647); -- chaos_blade
INSERT INTO `mob_skill_lists` VALUES ('Dragonian_Minstrel',6036,649); -- voidsong
INSERT INTO `mob_skill_lists` VALUES ('Dragonian_Minstrel',6036,650); -- thornsong
INSERT INTO `mob_skill_lists` VALUES ('Dragonian_Minstrel',6036,651); -- lodesong

--Gladiatorial Weapon
INSERT INTO `mob_skill_lists` VALUES ('Gladiatorial_Weapon',6037,513); -- smite_of_rage
INSERT INTO `mob_skill_lists` VALUES ('Gladiatorial_Weapon',6037,514); -- whirl_of_rage
INSERT INTO `mob_skill_lists` VALUES ('Gladiatorial_Weapon',6037,1558); -- smite_of_fury
INSERT INTO `mob_skill_lists` VALUES ('Gladiatorial_Weapon',6037,1559); -- flurry_of_rage
INSERT INTO `mob_skill_lists` VALUES ('Gladiatorial_Weapon',6037,1560); -- whispers_of_ire

--Lilisette
--Saber Dance
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',6038,25); -- evisceration
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',6038,29); -- pyrrhic_kleos
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',6038,1745); -- enervation
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',6038,1695); -- hypnic_lamp
--Fan Dance
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',6039,2320); -- curing_waltz_iv
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',6039,418); -- regeneration
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',6039,1745); -- enervation
INSERT INTO `mob_skill_lists` VALUES ('Lilisette',6039,1695); -- hypnic_lamp

--Nagi
INSERT INTO `mob_skill_lists` VALUES ('Nagi',6040,129); -- Blade: Retsu
INSERT INTO `mob_skill_lists` VALUES ('Nagi',6040,132); -- Blade: Chi
INSERT INTO `mob_skill_lists` VALUES ('Nagi',6040,138); -- Blade: Kamu
INSERT INTO `mob_skill_lists` VALUES ('Nagi',6040,247); -- Fox Fire
INSERT INTO `mob_skill_lists` VALUES ('Nagi',6040,250); -- Carnal Nightmare

--Raubahn
INSERT INTO `mob_skill_lists` VALUES ('Tizona',6041,46); -- expiacion
INSERT INTO `mob_skill_lists` VALUES ('Tizona',6041,37); -- Seraph Blade
INSERT INTO `mob_skill_lists` VALUES ('Tizona',6041,38); -- Circle Blade

--Ullikummi
INSERT INTO `mob_skill_lists` VALUES ('Ullikummi',6042,1035); -- Heavy Strike with knockback

INSERT INTO `mob_skill_lists` VALUES ('BatterHornOnly',6043,2099); -- Batter horn only

INSERT INTO `mob_skill_lists` VALUES ('AquaFortisOnly',6044,2152); -- aqua fortis only

--Sugaar
INSERT INTO `mob_skill_lists` VALUES ('Sugaar',6045,2155); -- torpefying_charge
INSERT INTO `mob_skill_lists` VALUES ('Sugaar',6045,2156); -- grim_glower

INSERT INTO `mob_skill_lists` VALUES ('ImpaleOnly',6046,316);

INSERT INTO `mob_skill_lists` VALUES ('WildCarrotOnly',6047,323); -- Wild Carrot

INSERT INTO `mob_skill_lists` VALUES ('HellScissorsOnly',6048,2221); -- Hell Scissors

INSERT INTO `mob_skill_lists` VALUES ('HellbornYawpOnly',6049,2372); -- Hellborn Yawp

--Graoully 
INSERT INTO `mob_skill_lists` VALUES ('Graoully ',6050,642); -- Flame Breath
INSERT INTO `mob_skill_lists` VALUES ('Graoully ',6050,649); -- Voidsong
INSERT INTO `mob_skill_lists` VALUES ('Graoully ',6050,1792); -- Nullsong

INSERT INTO `mob_skill_lists` VALUES ('Dahak',6051,642);
INSERT INTO `mob_skill_lists` VALUES ('Dahak',6051,643);
INSERT INTO `mob_skill_lists` VALUES ('Dahak',6051,644);
INSERT INTO `mob_skill_lists` VALUES ('Dahak',6051,645);
INSERT INTO `mob_skill_lists` VALUES ('Dahak',6051,646);
INSERT INTO `mob_skill_lists` VALUES ('Dahak',6051,647);
INSERT INTO `mob_skill_lists` VALUES ('Dahak',6051,648);
INSERT INTO `mob_skill_lists` VALUES ('Dahak',6051,649);
INSERT INTO `mob_skill_lists` VALUES ('Dahak',6051,650);
INSERT INTO `mob_skill_lists` VALUES ('Dahak',6051,651);
INSERT INTO `mob_skill_lists` VALUES ('Dahak',6051,1792);  -- Nullsong

INSERT INTO `mob_skill_lists` VALUES ('Tikbalang',6052,498);  -- Triclip
INSERT INTO `mob_skill_lists` VALUES ('Tikbalang',6052,502);  -- Mortal Ray
INSERT INTO `mob_skill_lists` VALUES ('JettaturaOnly',6053,2828); -- Jettatura
INSERT INTO `mob_skill_lists` VALUES ('Boompadu',6054,2071); -- dire_straight
INSERT INTO `mob_skill_lists` VALUES ('Boompadu',6054,2072); -- earth_shatter
INSERT INTO `mob_skill_lists` VALUES ('Boompadu',6054,2073); -- sinker_drill

-- Mithran Trackers
INSERT INTO `mob_skill_lists` VALUES ('ShikareeX',6055,18); -- shadowstitch
INSERT INTO `mob_skill_lists` VALUES ('ShikareeX',6055,23); -- dancing_edge
INSERT INTO `mob_skill_lists` VALUES ('ShikareeX',6055,25); -- evisceration
INSERT INTO `mob_skill_lists` VALUES ('ShikareeY',6056,101); -- vorpal_scythe
INSERT INTO `mob_skill_lists` VALUES ('ShikareeY',6056,102); -- guillotine
INSERT INTO `mob_skill_lists` VALUES ('ShikareeY',6056,104); -- spiral_hell
INSERT INTO `mob_skill_lists` VALUES ('ShikareeZ',6057,116); -- penta_thrust
INSERT INTO `mob_skill_lists` VALUES ('ShikareeZ',6057,119); -- wheeling_thrust
INSERT INTO `mob_skill_lists` VALUES ('ShikareeZ',6057,120); -- impulse_drive

INSERT INTO `mob_skill_lists` VALUES ('BlockHeadOnly',6058,368); -- Block Head
INSERT INTO `mob_skill_lists` VALUES ('FragBombOnly',6059,1119); -- Frag Bomb
INSERT INTO `mob_skill_lists` VALUES ('BellyDanceOnly',6060,1762); -- Bely Dance
INSERT INTO `mob_skill_lists` VALUES ('AmorphicSpikesOnly',6061,1824); -- Armophic Spikes
INSERT INTO `mob_skill_lists` VALUES ('FazeOnly',6062,1728); -- Faze

--Zeid Mythic
INSERT INTO `mob_skill_lists` VALUES ('ZeidMythic',6063,979); -- Power Slash
INSERT INTO `mob_skill_lists` VALUES ('ZeidMythic',6063,980); -- Freeze Bite
INSERT INTO `mob_skill_lists` VALUES ('ZeidMythic',6063,981); -- GroundStrike
INSERT INTO `mob_skill_lists` VALUES ('ZeidMythic',6063,987); -- Shockwave
INSERT INTO `mob_skill_lists` VALUES ('ZeidMythicSub50',6064,982); -- Abyssal Drain
INSERT INTO `mob_skill_lists` VALUES ('ZeidMythicSub50',6064,983); -- Abyssal strike

--Iron Eater Mythic
INSERT INTO `mob_skill_lists` VALUES ('IronEaterMythic',6065,85); -- Weapon Break
INSERT INTO `mob_skill_lists` VALUES ('IronEaterMythic',6065,83); -- Armor Break
INSERT INTO `mob_skill_lists` VALUES ('IronEaterMythic',6065,88); -- Steel Cyclone
INSERT INTO `mob_skill_lists` VALUES ('IronEaterMythic',6065,90); -- King's Justice

INSERT INTO `mob_skill_lists` VALUES ('Bloodcrown_Brradhod',6066,609);
INSERT INTO `mob_skill_lists` VALUES ('Bloodcrown_Brradhod',6066,2202);
INSERT INTO `mob_skill_lists` VALUES ('Bloodcrown_Brradhod',6066,2263);
INSERT INTO `mob_skill_lists` VALUES ('Bloodcrown_Brradhod',6066,2264);
INSERT INTO `mob_skill_lists` VALUES ('Bloodcrown_Brradhod',6066,2373);

INSERT INTO `mob_skill_lists` VALUES ('Vidhuwa_The_Wrathborn',6067,1963); -- Mind Blast
INSERT INTO `mob_skill_lists` VALUES ('Vidhuwa_The_Wrathborn',6067,1965); -- Immortal Shield

INSERT INTO `mob_skill_lists` VALUES ('Snoll_Tzar',6068,598); -- Berserk
INSERT INTO `mob_skill_lists` VALUES ('Snoll_Tzar',6068,599); -- Arctic_impact
INSERT INTO `mob_skill_lists` VALUES ('Snoll_Tzar',6068,600); -- Cold_wave
INSERT INTO `mob_skill_lists` VALUES ('Snoll_Tzar',6068,601); -- Hiemal_storm

INSERT INTO `mob_skill_lists` VALUES ('Big_Bomb',6069,510); -- Berserk
INSERT INTO `mob_skill_lists` VALUES ('Big_Bomb',6069,512); -- Heat wave
INSERT INTO `mob_skill_lists` VALUES ('Big_Bomb',6069,342); -- Vulcanian Impact
INSERT INTO `mob_skill_lists` VALUES ('Big_Bomb',6069,596); -- Hellstorm

INSERT INTO `mob_skill_lists` VALUES ('GloeosuccusOnly',6070,436); -- Gloeosuccus
INSERT INTO `mob_skill_lists` VALUES ('TripleAttackOnly',6071,400); -- Triple Attack

INSERT INTO `mob_skill_lists` VALUES ('Gration',6072,1637);  -- power_attack_gration
INSERT INTO `mob_skill_lists` VALUES ('Gration',6072,1640); -- grand_slam_gration

INSERT INTO `mob_skill_lists` VALUES ('PetriBreathOnly',6073,269); -- petribreath
INSERT INTO `mob_skill_lists` VALUES ('BarbedCrescentOnly',6074,253); -- Barbed Crescent
INSERT INTO `mob_skill_lists` VALUES ('SlingBombOnly',6075,567); -- sling_bomb 
INSERT INTO `mob_skill_lists` VALUES ('FirespitOnly',6076,1733); -- Firespit
INSERT INTO `mob_skill_lists` VALUES ('NimbleSnapOnly',6077,1597); -- nimble_snap
INSERT INTO `mob_skill_lists` VALUES ('PainfulWhipOnly',6078,1574); -- Painful_Whip

INSERT INTO `mob_skill_lists` VALUES ('Geush_Urvan_AutoAttack',6079,4232); -- Snort_Autoattack
INSERT INTO `mob_skill_lists` VALUES ('Geush_Urvan',6080,496); -- Rabid_Dance
INSERT INTO `mob_skill_lists` VALUES ('Geush_Urvan',6080,1331); -- Counterstance

INSERT INTO `mob_skill_lists` VALUES ('EarthShockOnly',6081,361); -- Earthshock
INSERT INTO `mob_skill_lists` VALUES ('FrypanOnly',6082,1081); -- Frypan

INSERT INTO `mob_skill_lists` VALUES ('Jailer_of_Hope_Under_25',6083,1353); -- aerial_collision
INSERT INTO `mob_skill_lists` VALUES ('Jailer_of_Hope_Under_25',6083,1355); -- spine_lash
INSERT INTO `mob_skill_lists` VALUES ('Jailer_of_Hope_Under_25',6083,1358); -- plasma_charge

INSERT INTO `mob_skill_lists` VALUES ('Mocking_Colibri',6084,1699); -- Pecking Flurry
INSERT INTO `mob_skill_lists` VALUES ('Mocking_Colibri',6084,1702); -- Wise Crack
INSERT INTO `mob_skill_lists` VALUES ('Blazing_Angon_Only',6085,2098); -- Blazing Angon
INSERT INTO `mob_skill_lists` VALUES ('Zarbzan_Only',6086,1748); -- zarbzan
INSERT INTO `mob_skill_lists` VALUES ('Thermal_Pulse_Only',6087,1817); -- thermal_pulse
INSERT INTO `mob_skill_lists` VALUES ('Arrow_Deluge_Only',6088,1761); -- arrow_deluge

INSERT INTO `mob_skill_lists` VALUES ('LamieNo9s_Avatar',6089,862); -- slowga
INSERT INTO `mob_skill_lists` VALUES ('LamieNo9s_Avatar',6089,861); -- spting_Water
INSERT INTO `mob_skill_lists` VALUES ('LamieNo9s_Avatar',6089,865); -- grand_fall

INSERT INTO `mob_skill_lists` VALUES ('LamieNo9',6090,1759); -- hypnotic_sway
INSERT INTO `mob_skill_lists` VALUES ('LamieNo9',6090,1758); -- tail_slap
INSERT INTO `mob_skill_lists` VALUES ('LamieNo9',6090,1762); -- belly_dance
INSERT INTO `mob_skill_lists` VALUES ('LamieNo9',6090,1929); -- pole_swing

INSERT INTO `mob_skill_lists` VALUES ('Ameretat',6091,1793); -- vampiric_root
INSERT INTO `mob_skill_lists` VALUES ('Ameretat',6091,319); -- bad_breath
INSERT INTO `mob_skill_lists` VALUES ('Ameretat',6091,320); -- sweet_breath

INSERT INTO `mob_skill_lists` VALUES ('Demoralizing_Roar_Only',6092,2101); -- demoralizing_roar
INSERT INTO `mob_skill_lists` VALUES ('Stampede_Only',6093,1705); -- Stampede

INSERT INTO `mob_skill_lists` VALUES ('Nis_Puk',6094,1718); -- crosswind
INSERT INTO `mob_skill_lists` VALUES ('Nis_Puk',6094,1723); -- ill_wind

INSERT INTO `mob_skill_lists` VALUES ('Zikko',6095,2003); -- grating_tantara
INSERT INTO `mob_skill_lists` VALUES ('Zikko',6095,2004); -- stifling_tantara

INSERT INTO `mob_skill_lists` VALUES ('Dark_Ixion_Autos',6096,2328); -- Horn Autoattack
INSERT INTO `mob_skill_lists` VALUES ('Dark_Ixion_Autos',6096,2329); -- Horn Autoattack
INSERT INTO `mob_skill_lists` VALUES ('Dark_Ixion_Autos',6096,2330); -- Horn Autoattack

INSERT INTO `mob_skill_lists` VALUES ('Cemetary_Cherry',6097,328); -- drill_branch
INSERT INTO `mob_skill_lists` VALUES ('Cemetary_Cherry',6097,928); -- pinecone_bomb_cemetary
INSERT INTO `mob_skill_lists` VALUES ('Cemetary_Cherry',6097,929); -- leafstorm_cemetary
INSERT INTO `mob_skill_lists` VALUES ('Cemetary_Cherry',6097,930); -- entangle_cemetary

INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Shiva',6098,881);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Shiva',6098,882);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Shiva',6098,883);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Shiva',6098,884);

INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Ramuh',6099,890);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Ramuh',6099,891);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Ramuh',6099,892);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Ramuh',6099,893);

INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Titan',6100,853);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Titan',6100,854);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Titan',6100,855);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Titan',6100,856);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Titan',6100,857);

INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Ifrit',6101,845);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Ifrit',6101,846);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Ifrit',6101,847);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Ifrit',6101,848);

INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Leviathan',6102,861);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Leviathan',6102,863);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Leviathan',6102,864);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Leviathan',6102,865);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Leviathan',6102,866);

INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Garuda',6103,872);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Garuda',6103,873);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Garuda',6103,874);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Garuda',6103,875);

INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Fenrir',6104,833);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Fenrir',6104,835);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Fenrir',6104,836);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Fenrir',6104,838);
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Fenrir',6104,839);

INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Carbuncle',6105,906); -- healing_ruby
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Carbuncle',6105,907); -- poison_nails
-- INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Carbuncle',6105,908); -- shining_ruby
-- INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Carbuncle',6105,909); -- glittering_ruby
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Carbuncle',6105,910); -- meteorite
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Carbuncle',6105,911); -- healing_ruby_ii
INSERT INTO `mob_skill_lists` VALUES ('MysticAvatar-Carbuncle',6105,912); -- searing_light
INSERT INTO `mob_skill_lists` VALUES ('Lamia_No3',6106,2086); -- grim_reaper
INSERT INTO `mob_skill_lists` VALUES ('Lamia_No3',6106,1758); -- tail_slap
INSERT INTO `mob_skill_lists` VALUES ('Lamia_No3',6106,1759); -- hypnotic_sway
INSERT INTO `mob_skill_lists` VALUES ('Evolved_Apkallu',6107,1714);
INSERT INTO `mob_skill_lists` VALUES ('Evolved_Apkallu',6107,1715);
INSERT INTO `mob_skill_lists` VALUES ('Evolved_Apkallu',6107,1716);
INSERT INTO `mob_skill_lists` VALUES ('Evolved_Apkallu',6107,1717);
INSERT INTO `mob_skill_lists` VALUES ('Evolved_Qutrub',6108,1782);
INSERT INTO `mob_skill_lists` VALUES ('Ferocious_Wamoura',6109,1952); -- erratic_flutter
INSERT INTO `mob_skill_lists` VALUES ('Ferocious_Wamoura',6109,1954); -- erosion_dust
INSERT INTO `mob_skill_lists` VALUES ('Ferocious_Wamoura',6109,1955); -- exuviation
INSERT INTO `mob_skill_lists` VALUES ('Ferocious_Wamoura',6109,1956); -- fire_break
INSERT INTO `mob_skill_lists` VALUES ('Ravaging_Diremite',6110,362);
INSERT INTO `mob_skill_lists` VALUES ('Ravaging_Diremite',6110,363);
INSERT INTO `mob_skill_lists` VALUES ('Ravaging_Diremite',6110,365);
INSERT INTO `mob_skill_lists` VALUES ('GoblinRushOnly',6111,590);
INSERT INTO `mob_skill_lists` VALUES ('Troll_Destroyer',6112,2081); -- hammer-go-round
INSERT INTO `mob_skill_lists` VALUES ('Troll_Destroyer',6112,2082); -- hammerblow
INSERT INTO `mob_skill_lists` VALUES ('Troll_Destroyer',6112,2083); -- drop_hammer
INSERT INTO `mob_skill_lists` VALUES ('Troll_Destroyer',6112,2084); -- seismohammer
INSERT INTO `mob_skill_lists` VALUES ('UnblestJambiyaOnly',6113,1784); -- unblest_jambiya
INSERT INTO `mob_skill_lists` VALUES ('Mahjlaef_the_Paintorn',6114,1963); -- Mind Blast
INSERT INTO `mob_skill_lists` VALUES ('Mahjlaef_the_Paintorn',6114,1964); -- Immortal Mind
INSERT INTO `mob_skill_lists` VALUES ('Mahjlaef_the_Paintorn',6114,1967); -- Tribulation
INSERT INTO `mob_skill_lists` VALUES ('Mahjlaef_the_Paintorn',6114,1968); -- Immortal Anathema

INSERT INTO `mob_skill_lists` VALUES ('Bearclaw_Rabbit',6115,257); -- Follow The White Rabbit ENM
INSERT INTO `mob_skill_lists` VALUES ('Bearclaw_Rabbit',6115,259);
INSERT INTO `mob_skill_lists` VALUES ('Bearclaw_Rabbit',6115,1570); -- wild_carrot_ENM
INSERT INTO `mob_skill_lists` VALUES ('Bearclaw_Rabbit',6115,661);

INSERT INTO `mob_skill_lists` VALUES ('Pasuk',6116,362); -- double_claw
INSERT INTO `mob_skill_lists` VALUES ('Pasuk',6116,363); -- grapple
INSERT INTO `mob_skill_lists` VALUES ('Pasuk',6116,365); -- spinning_top
INSERT INTO `mob_skill_lists` VALUES ('Pasuk',6116,1361); --viscid_secretion

INSERT INTO `mob_skill_lists` VALUES ('Furies',6117,393); -- sonic_boom
INSERT INTO `mob_skill_lists` VALUES ('Furies',6117,395); -- jet_stream
INSERT INTO `mob_skill_lists` VALUES ('Furies',6117,1157); -- slipstream
INSERT INTO `mob_skill_lists` VALUES ('Furies',6117,1158); -- turbulence

INSERT INTO `mob_skill_lists` VALUES ('MamoolJaMage',6118,1920); -- rushing_drub | staff
INSERT INTO `mob_skill_lists` VALUES ('MamoolJaMage',6118,1922); -- somersault_kick(mage)
INSERT INTO `mob_skill_lists` VALUES ('MamoolJaMage',6118,1923); -- Firespit(Magic)

-- MMM Start
INSERT INTO `mob_skill_lists` VALUES ('Kendi',6119,371); -- 
INSERT INTO `mob_skill_lists` VALUES ('Kendi',6119,3851); -- 
INSERT INTO `mob_skill_lists` VALUES ('Kendi',6119,3852); -- 
INSERT INTO `mob_skill_lists` VALUES ('Kendi',6119,3853); -- 
INSERT INTO `mob_skill_lists` VALUES ('Kendi',6119,3854); -- 
INSERT INTO `mob_skill_lists` VALUES ('Kendi',6119,3855); -- 

INSERT INTO `mob_skill_lists` VALUES ('Rahu',6120,376); -- 
INSERT INTO `mob_skill_lists` VALUES ('Rahu',6120,377); -- 
INSERT INTO `mob_skill_lists` VALUES ('Rahu',6120,378); -- 
INSERT INTO `mob_skill_lists` VALUES ('Rahu',6120,3909); -- 
 
INSERT INTO `mob_skill_lists` VALUES ('Tatzelwurm',6121,1594); -- 
INSERT INTO `mob_skill_lists` VALUES ('Tatzelwurm',6121,1595); -- 
INSERT INTO `mob_skill_lists` VALUES ('Tatzelwurm',6121,1596); -- 
INSERT INTO `mob_skill_lists` VALUES ('Tatzelwurm',6121,1597); -- 

INSERT INTO `mob_skill_lists` VALUES ('Tanihwa',6122,1858); -- 
INSERT INTO `mob_skill_lists` VALUES ('Tanihwa',6122,1859); -- 
INSERT INTO `mob_skill_lists` VALUES ('Tanihwa',6122,1860); -- 
INSERT INTO `mob_skill_lists` VALUES ('Tanihwa',6122,1861); -- 
INSERT INTO `mob_skill_lists` VALUES ('Tanihwa',6122,1862); -- 
INSERT INTO `mob_skill_lists` VALUES ('Tanihwa',6122,1863); -- 

INSERT INTO `mob_skill_lists` VALUES ('Artemisia',6123,2579); -- 
INSERT INTO `mob_skill_lists` VALUES ('Artemisia',6123,2599); -- 
INSERT INTO `mob_skill_lists` VALUES ('Artemisia',6123,2600); -- 
INSERT INTO `mob_skill_lists` VALUES ('Artemisia',6123,2601); -- 
INSERT INTO `mob_skill_lists` VALUES ('Artemisia',6123,3847); -- 
INSERT INTO `mob_skill_lists` VALUES ('Artemisia',6123,2387); -- 

INSERT INTO `mob_skill_lists` VALUES ('Dzoavits',6124,3355); -- 
INSERT INTO `mob_skill_lists` VALUES ('Dzoavits',6124,3356); -- 
INSERT INTO `mob_skill_lists` VALUES ('Dzoavits',6124,3357); -- 
INSERT INTO `mob_skill_lists` VALUES ('Dzoavits',6124,3358); -- 
INSERT INTO `mob_skill_lists` VALUES ('Dzoavits',6124,583); -- 

INSERT INTO `mob_skill_lists` VALUES ('Terror_Fly',6125,1622); -- 
INSERT INTO `mob_skill_lists` VALUES ('Terror_Fly',6125,1623); -- 
INSERT INTO `mob_skill_lists` VALUES ('Terror_Fly',6125,318); -- 
INSERT INTO `mob_skill_lists` VALUES ('Terror_Fly',6125,1324); -- 

INSERT INTO `mob_skill_lists` VALUES ('Dicey_Dorcus',6126,723); -- 
INSERT INTO `mob_skill_lists` VALUES ('Dicey_Dorcus',6126,724); -- 
INSERT INTO `mob_skill_lists` VALUES ('Dicey_Dorcus',6126,2221); -- 

INSERT INTO `mob_skill_lists` VALUES ('Nimble_Nelson',6127,661); -- 
INSERT INTO `mob_skill_lists` VALUES ('Nimble_Nelson',6127,3840); -- 
INSERT INTO `mob_skill_lists` VALUES ('Nimble_Nelson',6127,3841); -- 
INSERT INTO `mob_skill_lists` VALUES ('Nimble_Nelson',6127,3842); -- 
INSERT INTO `mob_skill_lists` VALUES ('Nimble_Nelson',6127,2612); -- Wild Carrot MMM

INSERT INTO `mob_skill_lists` VALUES ('Gorib',6128,480); -- 
INSERT INTO `mob_skill_lists` VALUES ('Gorib',6128,483); -- 
INSERT INTO `mob_skill_lists` VALUES ('Gorib',6128,2760); -- 
INSERT INTO `mob_skill_lists` VALUES ('Gorib',6128,2209); -- 

INSERT INTO `mob_skill_lists` VALUES ('Seua_Peek',6129,1680); -- 
INSERT INTO `mob_skill_lists` VALUES ('Seua_Peek',6129,2207); -- 

INSERT INTO `mob_skill_lists` VALUES ('Purushamriga',6130,1561); -- 
INSERT INTO `mob_skill_lists` VALUES ('Purushamriga',6130,1562); -- 
INSERT INTO `mob_skill_lists` VALUES ('Purushamriga',6130,1563); -- 
INSERT INTO `mob_skill_lists` VALUES ('Purushamriga',6130,1564); -- 
INSERT INTO `mob_skill_lists` VALUES ('Purushamriga',6130,1565); -- 
INSERT INTO `mob_skill_lists` VALUES ('Purushamriga',6130,1566); -- 
-- MMM End

-- ANNM Start

INSERT INTO `mob_skill_lists` VALUES ('Aqua_Fortis_Autoattack',6131,2211); 

INSERT INTO `mob_skill_lists` VALUES ('Simorg',6132,819); -- blizzard breath -- chance of ice spikes effect
INSERT INTO `mob_skill_lists` VALUES ('Simorg',6132,820); -- thunder breath -- chance of shock spikes effect
INSERT INTO `mob_skill_lists` VALUES ('Simorg',6132,822); -- chaos breath -- chance of dread spikes effect
INSERT INTO `mob_skill_lists` VALUES ('Simorg',6132,2222); -- hurricane breath
INSERT INTO `mob_skill_lists` VALUES ('Simorg',6132,813); -- Dispelling Wind
INSERT INTO `mob_skill_lists` VALUES ('Simorg',6132,814); -- Deadly Drive
INSERT INTO `mob_skill_lists` VALUES ('Simorg',6132,815); -- Wind Wall
INSERT INTO `mob_skill_lists` VALUES ('Simorg',6132,816); -- Fang Rush
INSERT INTO `mob_skill_lists` VALUES ('Simorg',6132,817); -- Dread Shriek
INSERT INTO `mob_skill_lists` VALUES ('Simorg',6132,818); -- Tail Crush

INSERT INTO `mob_skill_lists` VALUES ('Iqi-Balam',6133,652); -- blaster
INSERT INTO `mob_skill_lists` VALUES ('Iqi-Balam',6133,653); -- chaotic_eye
INSERT INTO `mob_skill_lists` VALUES ('Iqi-Balam',6133,2209); -- blink of peril

INSERT INTO `mob_skill_lists` VALUES ('Scythefang_Liger',6134,271); -- Zilart + WotG TP moves without Roar
INSERT INTO `mob_skill_lists` VALUES ('Scythefang_Liger',6134,273); 
INSERT INTO `mob_skill_lists` VALUES ('Scythefang_Liger',6134,1680); 
INSERT INTO `mob_skill_lists` VALUES ('Scythefang_Liger',6134,1681); 
INSERT INTO `mob_skill_lists` VALUES ('Scythefang_Liger',6134,2207); 

-- ANNM End

-- Maybe needs skllID 1-9
INSERT INTO `mob_skill_lists` VALUES ('Raogrimm',6135,1); -- combo
INSERT INTO `mob_skill_lists` VALUES ('Raogrimm',6135,2); -- shoulder_attack
INSERT INTO `mob_skill_lists` VALUES ('Raogrimm',6135,7); -- howling fists
INSERT INTO `mob_skill_lists` VALUES ('Raogrimm',6135,8); -- dragon kick
INSERT INTO `mob_skill_lists` VALUES ('Raogrimm',6135,9); -- asuran_fists

INSERT INTO `mob_skill_lists` VALUES ('Nashmeira',6136,3243); -- Imperial Authority

INSERT INTO `mob_skill_lists` VALUES ('Balpah',6137,69); -- Rampage
INSERT INTO `mob_skill_lists` VALUES ('Balpah',6137,71); -- Mistral Axe
INSERT INTO `mob_skill_lists` VALUES ('Balpah',6137,72); -- Decimation
INSERT INTO `mob_skill_lists` VALUES ('Balpah',6137,74); -- Primal Rend

------------------------------- Nakuals -------------------------------

-- Harkun
INSERT INTO `mob_skill_lists` VALUES ('Hurkan_Autos',6138,3069); -- waktza_auto_one
INSERT INTO `mob_skill_lists` VALUES ('Hurkan_Autos',6138,3070); -- waktza_auto_two
INSERT INTO `mob_skill_lists` VALUES ('Hurkan_Autos',6138,3071); -- waktza_auto_three

INSERT INTO `mob_skill_lists` VALUES ('Hurkan',6139,3072); -- crashing_thunder
INSERT INTO `mob_skill_lists` VALUES ('Hurkan',6139,3073); -- reverberating_cry
INSERT INTO `mob_skill_lists` VALUES ('Hurkan',6139,3074); -- brownout
INSERT INTO `mob_skill_lists` VALUES ('Hurkan',6139,3075); -- reverse_current
INSERT INTO `mob_skill_lists` VALUES ('Hurkan',6139,3076); -- sparkstorm
INSERT INTO `mob_skill_lists` VALUES ('Hurkan',6139,3077); -- static_prison

-- Kumhau
INSERT INTO `mob_skill_lists` VALUES ('Kumhau_Autos',6140,3134); -- cehuetzi_auto_one
INSERT INTO `mob_skill_lists` VALUES ('Kumhau_Autos',6140,3135); -- cehuetzi_auto_two
INSERT INTO `mob_skill_lists` VALUES ('Kumhau_Autos',6140,3136); -- cehuetzi_auto_three

INSERT INTO `mob_skill_lists` VALUES ('Kumhau',6141,3137); -- polar_roar
INSERT INTO `mob_skill_lists` VALUES ('Kumhau',6141,3138); -- brain_freeze
INSERT INTO `mob_skill_lists` VALUES ('Kumhau',6141,3139); -- biting_abrogation
INSERT INTO `mob_skill_lists` VALUES ('Kumhau',6141,3140); -- permafrost_requiem
INSERT INTO `mob_skill_lists` VALUES ('Kumhau',6141,3141); -- glacial_tomb
INSERT INTO `mob_skill_lists` VALUES ('Kumhau',6141,3142); -- glassy_nova

INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',6142,628);
INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',6142,629);
INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',6142,630);
INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',6142,631);
INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',6142,632);
INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',6142,633);
INSERT INTO `mob_skill_lists` VALUES ('King_Behemoth',6142,2586); -- Ecliptic Meteor

-- Colkhab
INSERT INTO `mob_skill_lists` VALUES ('Colkhab_Autos',6143,2999); -- bztavian_auto_one
INSERT INTO `mob_skill_lists` VALUES ('Colkhab_Autos',6143,3000); -- bztavian_auto_two
INSERT INTO `mob_skill_lists` VALUES ('Colkhab_Autos',6143,3001); -- bztavian_auto_three

INSERT INTO `mob_skill_lists` VALUES ('Colkhab',6144,3002); -- mandibular_lashing
INSERT INTO `mob_skill_lists` VALUES ('Colkhab',6144,3003); -- vespine_hurricane
INSERT INTO `mob_skill_lists` VALUES ('Colkhab',6144,3004); -- stinger_volley
INSERT INTO `mob_skill_lists` VALUES ('Colkhab',6144,3005); -- droning_whirlwind
INSERT INTO `mob_skill_lists` VALUES ('Colkhab',6144,3006); -- incisive_denouement
INSERT INTO `mob_skill_lists` VALUES ('Colkhab',6144,3007); -- incisive_apotheosis

INSERT INTO `mob_skill_lists` VALUES ('Empyreal_Arrow_Only',6145,199); -- Empyreal Arrow Only

-- Achuka
INSERT INTO `mob_skill_lists` VALUES ('Achuka_Autos',6146,3017); -- gabbrath_auto_one
INSERT INTO `mob_skill_lists` VALUES ('Achuka_Autos',6146,3018); -- gabbrath_auto_two
INSERT INTO `mob_skill_lists` VALUES ('Achuka_Autos',6146,3019); -- gabbrath_auto_three

INSERT INTO `mob_skill_lists` VALUES ('Achuka',6147,3020); -- blistering_roar
INSERT INTO `mob_skill_lists` VALUES ('Achuka',6147,3021); -- searing_serration
INSERT INTO `mob_skill_lists` VALUES ('Achuka',6147,3022); -- volcanic_stasis
INSERT INTO `mob_skill_lists` VALUES ('Achuka',6147,3023); -- tyrannical_blow
INSERT INTO `mob_skill_lists` VALUES ('Achuka',6147,3024); -- batholithic_shell
INSERT INTO `mob_skill_lists` VALUES ('Achuka',6147,3025); -- pyroclastic_surge
INSERT INTO `mob_skill_lists` VALUES ('Achuka',6147,3026); -- incinerating_lahar

-- Yumcax
INSERT INTO `mob_skill_lists` VALUES ('Yumcax_Autos',6148,3054); -- yggdreant_auto_one
INSERT INTO `mob_skill_lists` VALUES ('Yumcax_Autos',6148,3055); -- yggdreant_auto_two
INSERT INTO `mob_skill_lists` VALUES ('Yumcax_Autos',6148,3056); -- yggdreant_auto_three

INSERT INTO `mob_skill_lists` VALUES ('Yumcax',6149,3057); -- root_of_the_problem
INSERT INTO `mob_skill_lists` VALUES ('Yumcax',6149,3058); -- potted_plant
INSERT INTO `mob_skill_lists` VALUES ('Yumcax',6149,3059); -- uproot
INSERT INTO `mob_skill_lists` VALUES ('Yumcax',6149,3060); -- canopierce
INSERT INTO `mob_skill_lists` VALUES ('Yumcax',6149,3061); -- firefly_fandango
INSERT INTO `mob_skill_lists` VALUES ('Yumcax',6149,3062); -- tiiimbeeer

-- Tchakka
INSERT INTO `mob_skill_lists` VALUES ('Tchakka_Autos',6150,3008); -- rockfin_auto_one
INSERT INTO `mob_skill_lists` VALUES ('Tchakka_Autos',6150,3009); -- rockfin_auto_two
INSERT INTO `mob_skill_lists` VALUES ('Tchakka_Autos',6150,3010); -- rockfin_auto_three

INSERT INTO `mob_skill_lists` VALUES ('Tchakka',6151,3011); -- protolithic_puncture
INSERT INTO `mob_skill_lists` VALUES ('Tchakka',6151,3012); -- aquatic_lance
INSERT INTO `mob_skill_lists` VALUES ('Tchakka',6151,3013); -- pelagic_cleaver
INSERT INTO `mob_skill_lists` VALUES ('Tchakka',6151,3014); -- carcharian_verve
INSERT INTO `mob_skill_lists` VALUES ('Tchakka',6151,3015); -- tidal_guillotine
INSERT INTO `mob_skill_lists` VALUES ('Tchakka',6151,3016); -- marine_mayhem

INSERT INTO `mob_skill_lists` VALUES ('Cherukiki-Mythic',6152,167); -- judgment
INSERT INTO `mob_skill_lists` VALUES ('Cherukiki-Mythic',6152,168); -- hexa_strike
INSERT INTO `mob_skill_lists` VALUES ('Cherukiki-Mythic',6152,169); -- black_halo
INSERT INTO `mob_skill_lists` VALUES ('Cherukiki-Mythic',6152,250); -- carnal_nightmare
INSERT INTO `mob_skill_lists` VALUES ('Cherukiki-Mythic',6152,252); -- dancing_chains

-- Next available ID: 1203
-- Next custom ID: 6153

