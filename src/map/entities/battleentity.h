/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#ifndef _BATTLEENTITY_H
#define _BATTLEENTITY_H

#include <set>
#include <vector>
#include <unordered_map>
#include <mutex>

#include "baseentity.h"
#include "../map.h"
#include "../trait.h"
#include "../party.h"
#include "../alliance.h"
#include "../modifier.h"

enum ECOSYSTEM
{
    SYSTEM_ERROR = 0,
    SYSTEM_AMORPH = 1,
    SYSTEM_AQUAN = 2,
    SYSTEM_ARCANA = 3,
    SYSTEM_ARCHAICMACHINE = 4,
    SYSTEM_AVATAR = 5,
    SYSTEM_BEAST = 6,
    SYSTEM_BEASTMEN = 7,
    SYSTEM_BIRD = 8,
    SYSTEM_DEMON = 9,
    SYSTEM_DRAGON = 10,
    SYSTEM_ELEMENTAL = 11,
    SYSTEM_EMPTY = 12,
    SYSTEM_HUMANOID = 13,
    SYSTEM_LIZARD = 14,
    SYSTEM_LUMORIAN = 15,
    SYSTEM_LUMINION = 16,
    SYSTEM_PLANTOID = 17,
    SYSTEM_UNCLASSIFIED = 18,
    SYSTEM_UNDEAD = 19,
    SYSTEM_VERMIN = 20,
    SYSTEM_VORAGEAN = 21,
};

enum JOBTYPE
{
    JOB_NON = 0,
    JOB_WAR = 1,
    JOB_MNK = 2,
    JOB_WHM = 3,
    JOB_BLM = 4,
    JOB_RDM = 5,
    JOB_THF = 6,
    JOB_PLD = 7,
    JOB_DRK = 8,
    JOB_BST = 9,
    JOB_BRD = 10,
    JOB_RNG = 11,
    JOB_SAM = 12,
    JOB_NIN = 13,
    JOB_DRG = 14,
    JOB_SMN = 15,
    JOB_BLU = 16,
    JOB_COR = 17,
    JOB_PUP = 18,
    JOB_DNC = 19,
    JOB_SCH = 20,
    JOB_GEO = 21,
    JOB_RUN = 22
};

#define MAX_JOBTYPE		23

enum SKILLTYPE
{
    SKILL_NONE = 0,
    SKILL_HAND_TO_HAND = 1,
    SKILL_DAGGER = 2,
    SKILL_SWORD = 3,
    SKILL_GREAT_SWORD = 4,
    SKILL_AXE = 5,
    SKILL_GREAT_AXE = 6,
    SKILL_SCYTHE = 7,
    SKILL_POLEARM = 8,
    SKILL_KATANA = 9,
    SKILL_GREAT_KATANA = 10,
    SKILL_CLUB = 11,
    SKILL_STAFF = 12,
    // 13~21 unused
    SKILL_AUTOMATON_MELEE = 22,
    SKILL_AUTOMATON_RANGED = 23,
    SKILL_AUTOMATON_MAGIC = 24,
    SKILL_ARCHERY = 25,
    SKILL_MARKSMANSHIP = 26,
    SKILL_THROWING = 27,
    SKILL_GUARD = 28,
    SKILL_EVASION = 29,
    SKILL_SHIELD = 30,
    SKILL_PARRY = 31,
    SKILL_DIVINE_MAGIC = 32,
    SKILL_HEALING_MAGIC = 33,
    SKILL_ENHANCING_MAGIC = 34,
    SKILL_ENFEEBLING_MAGIC = 35,
    SKILL_ELEMENTAL_MAGIC = 36,
    SKILL_DARK_MAGIC = 37,
    SKILL_SUMMONING_MAGIC = 38,
    SKILL_NINJUTSU = 39,
    SKILL_SINGING = 40,
    SKILL_STRING_INSTRUMENT = 41,
    SKILL_WIND_INSTRUMENT = 42,
    SKILL_BLUE_MAGIC = 43,
    SKILL_GEOMANCY = 44,
    SKILL_HANDBELL = 45,
    // 46-47 unused
    SKILL_FISHING = 48,
    SKILL_WOODWORKING = 49,
    SKILL_SMITHING = 50,
    SKILL_GOLDSMITHING = 51,
    SKILL_CLOTHCRAFT = 52,
    SKILL_LEATHERCRAFT = 53,
    SKILL_BONECRAFT = 54,
    SKILL_ALCHEMY = 55,
    SKILL_COOKING = 56,
    SKILL_SYNERGY = 57,
    SKILL_RID = 58,
    SKILL_DIG = 59
};

#define MAX_SKILLTYPE	64

enum SUBSKILLTYPE
{
    SUBSKILL_XBO = 0,
    SUBSKILL_GUN = 1,
    SUBSKILL_CNN = 2,
    SUBSKILL_SHURIKEN = 3,

    SUBSKILL_ANI = 10, // Animators(PUP)

    SUBSKILL_SHEEP = 21,
    SUBSKILL_HARE = 22,
    SUBSKILL_CRAB = 23,
    SUBSKILL_CARRIE = 24,
    SUBSKILL_HOMUNCULUS = 25,
    SUBSKILL_FLYTRAP = 26,
    SUBSKILL_TIGER = 27,
    SUBSKILL_BILL = 28,
    SUBSKILL_EFT = 29,
    SUBSKILL_LIZARD = 30,
    SUBSKILL_MAYFLY = 31,
    SUBSKILL_FUNGUAR = 32,
    SUBSKILL_BEETLE = 33,
    SUBSKILL_ANTLION = 34,
    SUBSKILL_DIREMITE_FAMILIAR = 35,
    SUBSKILL_MELODIA = 36,
    SUBSKILL_STEFFI = 37,
    SUBSKILL_BEN = 38,
    SUBSKILL_SIRAVARDE = 39,
    SUBSKILL_COMO = 40,
    SUBSKILL_OROB = 41,
    SUBSKILL_AUDREY = 42,
    SUBSKILL_ALLIE = 43,
    SUBSKILL_LARS = 44,
    SUBSKILL_GALAHAD = 45,
    SUBSKILL_CHUCKY = 46,
    SUBSKILL_SABOTENDER = 47,
    SUBSKILL_CLYVONNE = 49,
    SUBSKILL_SHASRA = 50,
    SUBSKILL_LULUSH = 51,
    SUBSKILL_FARGANN = 52,
    SUBSKILL_LOUISE = 53,
    SUBSKILL_SIEGHARD = 54,
    SUBSKILL_YULY = 55,
    SUBSKILL_MERLE = 56,
    SUBSKILL_NAZUNA = 57,
    SUBSKILL_CETAS = 58,
    SUBSKILL_ANNA = 59,
    SUBSKILL_JULIO = 60,
    SUBSKILL_BRONCHA = 61,
    SUBSKILL_GERARD = 62,
    SUBSKILL_HOBS = 63,
    SUBSKILL_FALCORR = 64,
    SUBSKILL_RAPHIE = 65,
    SUBSKILL_MAC = 66,
    SUBSKILL_SILAS = 67,
    SUBSKILL_TOLOI = 68,
    SUBSKILL_ROCHE = 76,  // AIRY BROTH
    SUBSKILL_CAROLINE = 77,  // AGED HUMUS
    SUBSKILL_KEN = 78, // BLACKWATER BROTH
    SUBSKILL_JEDD = 79,  // CRACKLING BROTH
    SUBSKILL_ANNABELLE = 80,  // CREEPY BROTH
    SUBSKILL_WALUIS = 81,  // CRUMBLY SOIL
    SUBSKILL_SLIME = 82,  // DECAYING BROTH
    SUBSKILL_PATRICE = 83,  // PUTRESCENT BROTH
    SUBSKILL_ARTHUR = 84, // DIRE BROTH
    SUBSKILL_CANDI = 85,  // ELECTRIFIED BROTH
    SUBSKILL_HONEY = 86,  // BUG-RIDDEN BROTH
    SUBSKILL_LYNX = 87, // FRIZZANTE BROTH
    SUBSKILL_GASTON = 88,  // SPUMANTE BROTH
    SUBSKILL_KIYOMARO = 89,  // FIZZY BROTH
    SUBSKILL_VICKIE = 90,  // TANT. BROTH
    SUBSKILL_ALICE = 91,  // FURIOUS BROTH
    SUBSKILL_STORM = 92,  // INSIPID BROTH
    SUBSKILL_IYO = 93,  // DEEPWATER BROTH
    SUBSKILL_PATRICK = 94,  // LIVID BROTH
    SUBSKILL_SHIZUNA = 95,  // LYRICAL BROTH
    SUBSKILL_RANDY = 96,  // MEATY BROTH
    SUBSKILL_LYNN = 97,  // MUDDY BROTH
    SUBSKILL_PERCIVAL = 98, // PALE SAP
    SUBSKILL_ACUEX = 99,  // POISONOUS BROTH
    SUBSKILL_BREDO = 100,  // VENOMOUS BROTH
    SUBSKILL_WEEVIL = 101,  // PRISTINE SAP
    SUBSKILL_ANGELINA = 102,  // TRULY PRISTINE SAP
    SUBSKILL_REINHARD = 103,  // RAPID BROTH
    SUBSKILL_HERMES = 104,  // SALINE BROTH
    SUBSKILL_PORTER_CRAB = 105,  // RANCID BROTH
    SUBSKILL_EDWIN = 106, // PUNGENT BROTH
    SUBSKILL_IBUKI = 107,  // SALUBRIOUS BROTH
    SUBSKILL_ZHIVAGO = 108, // WINDY GREENS
    SUBSKILL_MALFIK = 109,  // SHIMMERING BROTH
    SUBSKILL_ANGUS = 110,  // FERM. BROTH
    SUBSKILL_XERIN = 111,  // SPICY BROTH
    SUBSKILL_BERTHA = 112,  // BUBBLY BROTH
    SUBSKILL_SPIDER = 113,  // STICKY WEBBING
    SUBSKILL_HACHIROBE = 114, // SLIMY WEBBING
    SUBSKILL_COLIBRI = 115,  // SUGARY BROTH
    SUBSKILL_LEERA = 116,  // GLAZED BROTH
    SUBSKILL_DORTWIN = 117,  // SWIRLING BROTH
    SUBSKILL_PETER = 118,  // VIS. BROTH
    SUBSKILL_HENRY = 119,  // TRANS. BROTH
    SUBSKILL_HIPPOGRYPH = 120,  // TURPID BROTH
    SUBSKILL_ROLAND = 121,  // FECULENT BROTH
    SUBSKILL_MOSQUITO = 122,  // WETLANDS BROTH
    SUBSKILL_YOKO = 123,  // HEAVENLY BROTH
    SUBSKILL_GLENN = 124,  // WISPY BROTH
    // ID"s past 124 break the server
    SUBSKILL_YELLOW_BEETLE = 125,  // ZESTFUL SAP
    SUBSKILL_SEFINA = 126,  // GASSY SAP
};

// ячейки экипировки. монстры используют лишь первые четыре, персонаж использует все

enum WS
{
    // H2H
    WS_COMBO = 1,
    WS_SHOULDER_TACKLE = 2,
    WS_ONE_INCH_PUNCH = 3,
    WS_BACKHAND_BLOW = 4,
    WS_RAGING_FISTS = 5,
    WS_SPINNING_ATTACK = 6,
    WS_HOWLING_FIST = 7,
    WS_DRAGON_KICK = 8,
    WS_ASURAN_FISTS = 9,
    WS_FINAL_HEAVEN = 10,
    WS_ASCETICS_FURY = 11,
    WS_STRINGING_PUMMEL = 12,
    WS_TORNADO_KICK = 13,
    WS_VICTORY_SMITE = 14,
    WS_SHIJIN_SPIRAL = 15,
    WS_FINAL_PARADISE = 228,

    // DAGGER
    WS_WASP_STING = 16,
    WS_VIPER_BITE = 17,
    WS_GUST_SLASH = 19,
    WS_SHADOWSTICH = 18,
    WS_CYCLONE = 20,
    WS_ENERGY_STEAL = 21,
    WS_ENERGY_DRAIN = 22,
    WS_DANCING_EDGE = 23,
    WS_SHARK_BITE = 24,
    WS_EVISCERATION = 25,
    WS_MERCY_STROKE = 26,
    WS_MANDALIC_STAB = 27,
    WS_MORDANT_RIME = 28,
    WS_PYRRHIC_KLEOS = 29,
    WS_AEOLIAN_EDGE = 30,
    WS_RUDRAS_STORM = 31,
    WS_EXENTERATOR = 224,

    // SWORD
    WS_FAST_BLADE = 32,
    WS_BURNING_BLADE = 33,
    WS_RED_LOTUS_BLADE = 34,
    WS_FLAT_BLADE = 35,
    WS_SHINING_BLADE = 36,
    WS_SERAPH_BLADE = 37,
    WS_CIRCLE_BLADE = 38,
    WS_SPIRIT_WITHIN = 39,
    WS_VORPAL_BLADE = 40,
    WS_SWIFT_BLADE = 41,
    WS_SAVAGE_BLADE = 42,
    WS_KNIGHTS_OF_ROUND = 43,
    WS_DEATH_BLOSSOM = 44,
    WS_ATONEMENT = 45,
    WS_EXPIACION = 46,
    WS_SANGUINE_BLADE = 47,
    WS_CHANT_DU_CYGNE = 225,
    WS_REQUIESCAT = 226,
    WS_URIEL_BLADE = 238,
    WS_GLORY_SLASH = 239,

    // GREAT SWORD
    WS_HARD_SLASH = 48,
    WS_POWER_SLASH = 49,
    WS_FROSTBITE = 50,
    WS_FREEZEBITE = 51,
    WS_SHOCKWAVE = 52,
    WS_CRESCENT_MOON = 53,
    WS_SICKLE_MOON = 54,
    WS_SPINNING_SLASH = 55,
    WS_GROUND_STRIKE = 56,
    WS_HERCULEAN_STRIKE = 58,
    WS_SCOURGE = 57,
    WS_TORCLEAVER = 59,
    WS_RESOLUTION = 60,

    // AXE
    WS_RAGING_AXE = 64,
    WS_SMASH_AXE = 65,
    WS_GALE_AXE = 66,
    WS_AVALANCHE_AXE = 67,
    WS_SPINNING_AXE = 68,
    WS_RAMPAGE = 69,
    WS_CALAMITY = 70,
    WS_MISTRAL_AXE = 71,
    WS_DECIMATION = 72,
    WS_ONSLAUGHT = 73,
    WS_PRIMAL_REND = 74,
    WS_BORA_AXE = 75,
    WS_CLOUDSPLITTER = 76,
    WS_RUINATOR = 77,

    // GREAT AXE
    WS_SHIELD_BREAK = 80,
    WS_IRON_TEMPEST = 81,
    WS_STURMWIND = 82,
    WS_ARMOR_BREAK = 83,
    WS_KEEN_EDGE = 84,
    WS_WEAPON_BREAK = 85,
    WS_RAGING_RUSH = 86,
    WS_FULL_BREAK = 87,
    WS_STEEL_CYCLONE = 88,
    WS_METATRON_TORMENT = 89,
    WS_KINGS_JUSTICE = 90,
    WS_FELL_CLEAVE = 91,
    WS_UKKOS_FURY = 92,
    WS_UPHEAVAL = 93,

    // SCYTHE
    WS_SLICE = 96,
    WS_DARK_HARVEST = 97,
    WS_SHADOW_OF_DEATH = 98,
    WS_NIGHTMARE_SCYTHE = 99,
    WS_SPINNING_SCYTHE = 100,
    WS_VORPAL_SCYTHE = 101,
    WS_GUILLOTINE = 102,
    WS_CROSS_REAPER = 103,
    WS_SPIRAL_HELL = 104,
    WS_CATASTROPHE = 105,
    WS_INSURGENCY = 106,
    WS_INFERNAL_SCYTHE = 107,
    WS_QUIETUS = 108,
    WS_ENTROPY = 109,

    // POLEARM
    WS_DOUBLE_THRUST = 112,
    WS_THUNDER_THRUST = 113,
    WS_RAIDEN_THRUST = 114,
    WS_LEG_SWEEP = 115,
    WS_PENTA_THRUST = 116,
    WS_VORPAL_THRUST = 117,
    WS_SKEWER = 118,
    WS_WHEELING_THRUST = 119,
    WS_IMPULSE_DRIVE = 120,
    WS_GEIRSKOGUL = 121,
    WS_DRAKESBANE = 122,
    WS_SONIC_THRUST = 123,
    WS_CAMLANNS_TORMENT = 124,
    WS_STARDIVER = 125,

    // KATANA
    WS_BLADE_RIN = 128,
    WS_BLADE_RETSU = 129,
    WS_BLADE_TEKI = 130,
    WS_BLADE_TO = 131,
    WS_BLADE_CHI = 132,
    WS_BLADE_EI = 133,
    WS_BLADE_JIN = 134,
    WS_BLADE_TEN = 135,
    WS_BLADE_KU = 136,
    WS_BLADE_METSU = 137,
    WS_BLADE_KAMU = 138,
    WS_BLADE_YU = 139,
    WS_BLADE_HI = 140,
    WS_BLADE_SHUN = 141,

    // GREAT KATANA
    WS_TACHI_ENPI = 144,
    WS_TACHI_HOBAKU = 145,
    WS_TACHI_GOTEN = 146,
    WS_TACHI_KAGERO = 147,
    WS_TACHI_JINPU = 148,
    WS_TACHI_KOKI = 149,
    WS_TACHI_YUKIKAZE = 150,
    WS_TACHI_GEKKO = 151,
    WS_TACHI_KASHA = 152,
    WS_TACHI_KAITEN = 153,
    WS_TACHI_RANA = 154,
    WS_TACHI_AGEHA = 155,
    WS_TACHI_FUDO = 156,
    WS_TACHI_SHOHA = 157,
    WS_TACHI_SUIKAWARI = 158,

    // CLUB
    WS_SHINING_STRIKE = 160,
    WS_SERAPH_STRIKE = 161,
    WS_BRAINSHAKER = 162,
    WS_STARLIGHT = 163,
    WS_MOONLIGHT = 164,
    WS_SKULLBREAKER = 165,
    WS_TRUE_STRIKE = 166,
    WS_JUDGMENT = 167,
    WS_HEXA_STRIKE = 168,
    WS_BLACK_HALO = 169,
    WS_RANDGRITH = 170,
    WS_MYSTIC_BOON = 171,
    WS_FLASH_NOVA = 172,
    WS_DAGAN = 173,
    WS_REALMRAZER = 174,

    
    // STAFF
    WS_HEAVY_SWING = 176,
    WS_ROCK_CRUSHER = 177,
    WS_EARTH_CRUSHER = 178,
    WS_STARBURST = 179,
    WS_SUNBURST = 180,
    WS_SHELL_CRUSHER = 181,
    WS_FULL_SWING = 182,
    WS_SPIRIT_TAKER = 183,
    WS_RETRIBUTION = 184,
    WS_GATE_OF_TARTARUS = 185,
    WS_VIDOHUNIR = 186,
    WS_GARLAND_OF_BLISS = 187,
    WS_OMNISCIENCE = 188,
    WS_CATACLYSM = 189,
    WS_MYRKR = 190,
    WS_SHATTERSOUL = 191,
    WS_TARTARUS_TORPOR = 240,

    
    // ARCHERY
    WS_FLAMING_ARROW = 192,
    WS_PIERCING_ARROW = 193,
    WS_DULLING_ARROW = 194,
    WS_SIDEWINDER = 196,
    WS_BLAST_ARROW = 197,
    WS_ARCHING_ARROW = 198,
    WS_EMPYREAL_ARROW = 199,
    WS_NAMAS_ARROW = 200,
    WS_REFULGENT_ARROW = 201,
    WS_JISHNUS_RADIANCE = 202,
    WS_APEX_ARROW = 203,

    
    // MARKSMANSHIP
    WS_HOT_SHOT = 208,
    WS_SPLIT_SHOT = 209,
    WS_SNIPER_SHOT = 210,
    WS_SLUG_SHOT = 212,
    WS_BLAST_SHOT = 213,
    WS_HEAVY_SHOT = 214,
    WS_DETONATOR = 215,
    WS_CORONACH = 216,
    WS_TRUEFLIGHT = 217,
    WS_LEADEN_SALUTE = 218,
    WS_NUMBING_SHOT = 219,
    WS_WILDFIRE = 220,
    WS_LAST_STAND = 221,
};

enum SLOTTYPE
{
    SLOT_MAIN = 0x00,
    SLOT_SUB = 0x01,
    SLOT_RANGED = 0x02,
    SLOT_AMMO = 0x03,
    SLOT_HEAD = 0x04,
    SLOT_BODY = 0x05,
    SLOT_HANDS = 0x06,
    SLOT_LEGS = 0x07,
    SLOT_FEET = 0x08,
    SLOT_NECK = 0x09,
    SLOT_WAIST = 0x0A,
    SLOT_EAR1 = 0x0B,
    SLOT_EAR2 = 0x0C,
    SLOT_RING1 = 0x0D,
    SLOT_RING2 = 0x0E,
    SLOT_BACK = 0x0F,
    SLOT_LINK1 = 0x10,
    SLOT_LINK2 = 0x11,
};

#define MAX_SLOTTYPE	18

// CROSSBOW и GUN - это Piercing, разделение сделано из-за одинакового skilltype
// для возможности различить эти орудия при экипировке и избавиться от ошибки
// использования пуль с арбалетом и арбалетных стрел с огнестрельным оружием (только персонажи)

enum ATTACKTYPE
{
    ATTACK_NONE = 0,
    ATTACK_PHYSICAL = 1,
    ATTACK_MAGICAL = 2,
    ATTACK_RANGED = 3,
    ATTACK_SPECIAL = 4,
    ATTACK_BREATH = 5,
};

enum DAMAGETYPE
{
    DAMAGE_NONE = 0,
    DAMAGE_PIERCING = 1,
    DAMAGE_SLASHING = 2,
    DAMAGE_IMPACT = 3,
    DAMAGE_HTH = 4,
    DAMAGE_ELEMENTAL = 5,
    DAMAGE_FIRE = 6,
    DAMAGE_ICE = 7,
    DAMAGE_WIND = 8,
    DAMAGE_EARTH = 9,
    DAMAGE_LIGHTNING = 10,
    DAMAGE_WATER = 11,
    DAMAGE_LIGHT = 12,
    DAMAGE_DARK = 13,
    DAMAGE_RANGED = 14,
};

enum REACTION
{
    REACTION_NONE               = 0x00,		// отсутствие реакции
    REACTION_MISS               = 0x01,		// промах
    REACTION_PARRY              = 0x03,		// блокирование оружием (MISS + PARRY)
    REACTION_BLOCK              = 0x04,		// блокирование щитом
    REACTION_HIT                = 0x08,		// попадание
    REACTION_EVADE              = 0x09,		// уклонение (MISS + HIT)
    REACTION_ABILITY            = 0x10,     // Observed on JA and WS
    REACTION_GUARD              = 0x14,		// mnk guard (20 dec)
    REACTION_ABILITY_HIT        = REACTION_ABILITY | REACTION_HIT,
};

enum SPECEFFECT
{
    SPECEFFECT_NONE = 0x00,
    SPECEFFECT_BLOOD = 0x02,
    SPECEFFECT_HIT = 0x10,
    SPECEFFECT_RAISE = 0x11,
    SPECEFFECT_RECOIL = 0x20,
    SPECEFFECT_CRITICAL_HIT = 0x22
};

enum SUBEFFECT
{
    // ATTACK
    SUBEFFECT_FIRE_DAMAGE = 1,  // 110000     3
    SUBEFFECT_ICE_DAMAGE = 2,  // 1-01000    5
    SUBEFFECT_WIND_DAMAGE = 3,  // 111000     7
    SUBEFFECT_EARTH_DAMAGE = 4,  // 1-00100    9
    SUBEFFECT_LIGHTNING_DAMAGE = 5,  // 110100    11
    SUBEFFECT_WATER_DAMAGE = 6,  // 1-01100   13
    SUBEFFECT_LIGHT_DAMAGE = 7,  // 111100    15
    SUBEFFECT_DARKNESS_DAMAGE = 8,  // 1-00010   17
    SUBEFFECT_SLEEP = 9,  // 110010    19
    SUBEFFECT_POISON = 10, // 1-01010   21
    SUBEFFECT_PARALYSIS = 11,
    SUBEFFECT_BLIND = 12, // 1-00110   25
    SUBEFFECT_SILENCE = 13,
    SUBEFFECT_PETRIFY = 14,
    SUBEFFECT_PLAGUE = 15,
    SUBEFFECT_STUN = 16,
    SUBEFFECT_CURSE = 17,
    SUBEFFECT_DEFENSE_DOWN = 18, // 1-01001   37
    SUBEFFECT_EVASION_DOWN = 18, // Same subeffect as DEFENSE_DOWN
    SUBEFFECT_ATTACK_DOWN = 18, // Same subeffect as DEFENSE_DOWN
    SUBEFFECT_DEATH = 19,
    SUBEFFECT_SHIELD = 20,
    SUBEFFECT_HP_DRAIN = 21, // 1-10101   43  This is retail correct animation
    SUBEFFECT_MP_DRAIN = 22, // This is retail correct animation
    SUBEFFECT_TP_DRAIN = 22, // Pretty sure this is correct, but might use same animation as HP drain.
    SUBEFFECT_HASTE = 23,
    // There are no additional attack effect animations beyond 23. Some effects share subeffect/animations.

    // SPIKES
    SUBEFFECT_BLAZE_SPIKES = 1,  // 01-1000    6
    SUBEFFECT_ICE_SPIKES = 2,    // 01-0100   10
    SUBEFFECT_DREAD_SPIKES = 3,  // 01-1100   14
    SUBEFFECT_CURSE_SPIKES = 4,  // 01-0010   18
    SUBEFFECT_SHOCK_SPIKES = 5,  // 01-1010   22
    SUBEFFECT_REPRISAL = 6,      // 01-0110   26
    // SUBEFFECT_GLINT_SPIKES = 6,
    SUBEFFECT_GALE_SPIKES = 7,   // Wind damage + Silence. Used by enchantment "Cool Breeze" http://www.ffxiah.com/item/22018/
    SUBEFFECT_CLOD_SPIKES = 8,   // Earth damage + Slow.
    SUBEFFECT_DELUGE_SPIKES = 9, // Water damage + Poison https://ffxiclopedia.fandom.com/wiki/Aqua_Spikes
    SUBEFFECT_GLINT_SPIKES = 10, // yes really: http://www.ffxiah.com/item/26944/
    SUBEFFECT_COUNTER = 63,      // Also used by Retaliation
    // There are no spikes effect animations beyond 63. Some effects share subeffect/animations.
    // "Damage Spikes" use the Blaze Spikes animation even though they are different status.

    // SKILLCHAINS
    SUBEFFECT_LIGHT = 1,
    SUBEFFECT_DARKNESS = 2,
    SUBEFFECT_GRAVITATION = 3,
    SUBEFFECT_FRAGMENTATION = 4,
    SUBEFFECT_DISTORTION = 5,
    SUBEFFECT_FUSION = 6,
    SUBEFFECT_COMPRESSION = 7,
    SUBEFFECT_LIQUEFACATION = 8,
    SUBEFFECT_INDURATION = 9,
    SUBEFFECT_REVERBERATION = 10,
    SUBEFFECT_TRANSFIXION = 11,
    SUBEFFECT_SCISSION = 12,
    SUBEFFECT_DETONATION = 13,
    SUBEFFECT_IMPACTION = 14,
    SUBEFFECT_RADIANCE = 15,
    SUBEFFECT_UMBRA = 16,

    SUBEFFECT_NONE = 0,

    // UNKNOWN
    SUBEFFECT_IMPAIRS_EVASION,
    SUBEFFECT_BIND,
    SUBEFFECT_WEIGHT,
    SUBEFFECT_AUSPICE
};

enum TARGETTYPE
{
    TARGET_NONE                    = 0x00,
    TARGET_SELF                    = 0x01,
    TARGET_PLAYER_PARTY            = 0x02,
    TARGET_ENEMY                   = 0x04,
    TARGET_PLAYER_ALLIANCE         = 0x08,
    TARGET_PLAYER                  = 0x10,
    TARGET_PLAYER_DEAD             = 0x20,
    TARGET_NPC                     = 0x40, // an npc is a mob that looks like an npc and fights on the side of the character
    TARGET_PLAYER_PARTY_PIANISSIMO = 0x80,
    TARGET_PET                     = 0x100,
    TARGET_PLAYER_PARTY_ENTRUST    = 0x200,
    TARGET_IGNORE_BATTLEID         = 0x400, // Can hit targets that do not have the same battle ID
};

enum SKILLCHAIN_ELEMENT
{
    SC_NONE = 0, // Lv0 None

    SC_TRANSFIXION = 1, // Lv1 Light
    SC_COMPRESSION = 2, // Lv1 Dark
    SC_LIQUEFACTION = 3, // Lv1 Fire
    SC_SCISSION = 4, // Lv1 Earth
    SC_REVERBERATION = 5, // Lv1 Water
    SC_DETONATION = 6, // Lv1 Wind
    SC_INDURATION = 7, // Lv1 Ice
    SC_IMPACTION = 8, // Lv1 Thunder

    SC_GRAVITATION = 9, // Lv2 Dark & Earth
    SC_DISTORTION = 10, // Lv2 Water & Ice
    SC_FUSION = 11, // Lv2 Fire & Light
    SC_FRAGMENTATION = 12, // Lv2 Wind & Thunder

    SC_LIGHT = 13, // Lv3 Fire, Light, Wind, Thunder
    SC_DARKNESS = 14, // Lv3 Dark, Earth, Water, Ice
    SC_LIGHT_II = 15, // Lv4 Light
    SC_DARKNESS_II = 16, // Lv4 Darkness
};

#define MAX_SKILLCHAIN_LEVEL (4)
#define MAX_SKILLCHAIN_COUNT (5)

enum IMMUNITY
{
    IMMUNITY_NONE               = 0x00,
    IMMUNITY_SLEEP              = 0x01,
    IMMUNITY_GRAVITY            = 0x02,
    IMMUNITY_BIND               = 0x04,
    IMMUNITY_STUN               = 0x08,
    IMMUNITY_SILENCE            = 0x10,  // 16
    IMMUNITY_PARALYZE           = 0x20,  // 32
    IMMUNITY_BLIND              = 0x40,  // 64
    IMMUNITY_SLOW               = 0x80,  // 128
    IMMUNITY_POISON             = 0x100, // 256
    IMMUNITY_ELEGY              = 0x200, // 512
    IMMUNITY_REQUIEM            = 0x400, // 1024
    IMMUNITY_LIGHT_SLEEP        = 0x800, // 2048
    IMMUNITY_DARK_SLEEP         = 0x1000,// 4096
    IMMUNITY_PETRIFY            = 0x2000,// 81927
    IMMUNITY_TERROR             = 0x4000,// 16384
    IMMUNITY_AMNESIA            = 0x8000,// 32768
    IMMUNITY_VIRUS              = 0x10000,// 65536
    IMMUNITY_CURSE              = 0x20000,// 131072
    IMMUNITY_DOOM               = 0x40000,// 262144
    IMMUNITY_CHARM              = 0x80000,// 524288
};

struct apAction_t
{
    CBattleEntity*    ActionTarget;		    // 32 bits
    REACTION		  reaction;			    //  5 bits
    uint16			  animation;			// 12 bits
    SPECEFFECT		  speceffect;			// 7 bits
    uint8             knockback;            // 3 bits
    int32			  param;				// 17 bits
    uint16			  messageID;			// 10 bits
    SUBEFFECT         additionalEffect;     // 10 bits
    int32             addEffectParam;       // 17 bits
    uint16            addEffectMessage;     // 10 bits
    SUBEFFECT         spikesEffect;         // 10 bits
    uint16            spikesParam;          // 14 bits
    uint16            spikesMessage;        // 10 bits

    apAction_t()
    {
        ActionTarget = nullptr;
        reaction = REACTION_NONE;
        animation = 0;
        speceffect = SPECEFFECT_NONE;
        param = 0;
        messageID = 0;
        additionalEffect = SUBEFFECT_NONE;
        addEffectParam = 0;
        addEffectMessage = 0;
        spikesEffect = SUBEFFECT_NONE;
        spikesParam = 0;
        spikesMessage = 0;
        knockback = 0;
    }

};

/************************************************************************
*																		*
*  TP хранится то пому же принципу, что и skill, т.е. 6,4% = 64			*
*																		*
************************************************************************/

struct health_t
{
    int16   tp;                 // текущее значение
    int32   hp, mp;             // текущие значения
    int32   maxhp, maxmp;       // максимальные значения
    int32   modhp, modmp;       // модифицированные максимальные значения
};

typedef std::vector<apAction_t> ActionList_t;
class CModifier;
class CParty;
class CStatusEffectContainer;
class CPetEntity;
class CSpell;
class CItemEquipment;
class CAbilityState;
class CAttackState;
class CWeaponSkillState;
class CMagicState;
class CDespawnState;
class CRangeState;
class CRecastContainer;
class CNotorietyContainer;
struct action_t;

class CBattleEntity : public CBaseEntity
{
public:
    CBattleEntity();						// конструктор
    virtual ~CBattleEntity();						// деструктор

    uint16          STR();
    uint16          DEX();
    uint16          VIT();
    uint16          AGI();
    uint16          INT();
    uint16          MND();
    uint16          CHR();
    uint16          DEF();
    uint16          ATT();
    uint16			ACC(int8 attackNumber, int8 offsetAccuracy);
    uint16          EVA();
    uint16          RATT(uint8 skill, uint16 bonusSkill = 0);
    uint16          RACC(uint8 skill, uint16 bonusSkill = 0);

    uint8           GetSpeed();

    std::mutex      scMutex;
    bool            isDead();					// проверяем, мертва ли сущность
    bool            isAlive();
    bool            isInAssault();
    bool            isInDynamis();
    bool            hasImmunity(uint32 imID);
    bool            isAsleep();
    bool            isMounted();
    bool            isSitting();

    JOBTYPE		    GetMJob();					// главная профессия
    JOBTYPE		    GetSJob();					// дополнительная профессия
    uint8		    GetMLevel();				// уровень главной профессии
    uint8		    GetSLevel();				// уровень дополнительной профессии

    void		    SetMJob(uint8 mjob);		// главная профессия
    void		    SetSJob(uint8 sjob);		// дополнительная профессия
    void		    SetMLevel(uint8 mlvl);		// уровень главной профессии
    void		    SetSLevel(uint8 slvl);		// уровень дополнительной профессии

    uint8		    GetHPP();					// количество hp в процентах
    int32           GetMaxHP();                 // максимальное количество hp
    uint8		    GetMPP();					// количество mp в процентах
    int32           GetMaxMP();                 // максимальное количество mp
    void            UpdateHealth();             // пересчет максимального количества hp и mp, а так же корректировка их текущих значений

    int16			GetWeaponDelay(bool tp);		//returns delay of combined weapons
    uint8           GetMeleeRange();                //returns the distance considered to be within melee range of the entity
    int16			GetRangedWeaponDelay(bool tp);	//returns delay of ranged weapon + ammo where applicable
    int16			GetAmmoDelay();			        //returns delay of ammo (for cooldown between shots)
    uint16			GetMainWeaponDmg();				//returns total main hand DMG
    uint16			GetSubWeaponDmg();				//returns total sub weapon DMG
    uint16			GetRangedWeaponDmg();			//returns total ranged weapon DMG
    uint16			GetMainWeaponRank();			//returns total main hand DMG Rank
    uint16			GetSubWeaponRank();				//returns total sub weapon DMG Rank
    uint16			GetRangedWeaponRank();			//returns total ranged weapon DMG Rank

    uint16		    GetSkill(uint16 SkillID);	// текущая величина умения (не максимальная, а ограниченная уровнем)

    virtual int16	addTP(int16 tp);			// увеличиваем/уменьшаем количество tp
    virtual int32	addHP(int32 hp);			// увеличиваем/уменьшаем количество hp
    virtual int32 	addMP(int32 mp);			// увеличиваем/уменьшаем количество mp

    //Deals damage and updates the last attacker which is used when sending a player death message
    virtual int32   takeDamage(int32 amount, CBattleEntity* attacker = nullptr, ATTACKTYPE attackType = ATTACK_NONE, DAMAGETYPE damageType = DAMAGE_NONE, bool isDOT = false);

    int16		    getMod(Mod modID);		// Get the current value of the specified modifier 
    int16           getMaxGearMod(Mod modID);

    bool            CanRest(); // checks if able to heal
    bool			Rest(float rate); // heal an amount of hp / mp

    void		    addModifier(Mod type, int16 amount);
    void		    setModifier(Mod type, int16 amount);
    void		    delModifier(Mod type, int16 amount);
    void		    addModifiers(std::vector<CModifier> *modList);
    void            addEquipModifiers(std::vector<CModifier> *modList, uint8 itemLevel, uint8 slotid);
    void		    setModifiers(std::vector<CModifier> *modList);
    void		    delModifiers(std::vector<CModifier> *modList);
    void            delEquipModifiers(std::vector<CModifier> *modList, uint8 itemLevel, uint8 slotid);
    void 		    saveModifiers(); // save current state of modifiers
    void 		    restoreModifiers(); // restore to saved state

    void            addPetModifier(Mod type, PetModType, int16 amount);
    void            setPetModifier(Mod type, PetModType, int16 amount);
    void            delPetModifier(Mod type, PetModType, int16 amount);
    void            addPetModifiers(std::vector<CPetModifier> *modList);
    void            delPetModifiers(std::vector<CPetModifier> *modList);
    void            applyPetModifiers(CPetEntity* PPet);
    void            removePetModifiers(CPetEntity* PPet);

    template        <typename F, typename... Args>
    void            ForParty(F func, Args&&... args)
    {
        if (PParty) {
            for (auto PMember : PParty->members) {
                func(PMember, std::forward<Args>(args)...);
            }
        }
        else {
            func(this, std::forward<Args>(args)...);
        }
    }

    template        <typename F, typename... Args>
    void            ForAlliance(F func, Args&&... args)
    {
        if (PParty) {
            if (PParty->m_PAlliance) {
                for (auto PAllianceParty : PParty->m_PAlliance->partyList) {
                    for (auto PMember : PAllianceParty->members) {
                        func(PMember, std::forward<Args>(args)...);
                    }
                }
            }
            else {
                for (auto PMember : PParty->members) {
                    func(PMember, std::forward<Args>(args)...);
                }
            }
        }
        else {
            func(this);
        }
    }

    virtual void    addTrait(CTrait*);
    virtual void    delTrait(CTrait*);
    virtual bool    hasTrait(uint16);

    virtual bool    ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags);
    virtual bool    CanUseSpell(CSpell*);

    virtual void    Spawn() override;
    virtual void    Die();
    uint16 GetBattleTargetID();
    void SetBattleTargetID(uint16 id) { m_battleTarget = id; }
    CBattleEntity* GetBattleTarget();

    /* State callbacks */
    /* Auto attack */
    virtual bool OnAttack(CAttackState&, action_t&);
    virtual bool OnAttackError(CAttackState&) { return false; }
    /* Returns whether to call Attack or not (which includes error messages) */
    virtual bool CanAttack(CBattleEntity* PTarget, std::unique_ptr<CBasicPacket>& errMsg);
    virtual CBattleEntity* IsValidTarget(uint16 targid, uint16 validTargetFlags, std::unique_ptr<CBasicPacket>& errMsg);
    virtual void OnEngage(CAttackState&);
    virtual void OnDisengage(CAttackState&);
    /* Casting */
    virtual void OnCastStarting(CMagicState& state);
    virtual void OnCastFinished(CMagicState&, action_t&);
    virtual void OnCastInterrupted(CMagicState&, action_t&, MSGBASIC_ID msg, bool blockedCast);
    /* Weaponskill */
    virtual void OnWeaponSkillFinished(CWeaponSkillState& state, action_t& action);
    virtual void OnChangeTarget(CBattleEntity* PTarget);

    // Used to set an action to an "interrupted" state
    void setActionInterrupted(action_t& action, CBattleEntity* PTarget, uint16 messageID, uint16 actionID);

    virtual void OnAbility(CAbilityState&, action_t&) {}
    virtual void OnRangedAttack(CRangeState&, action_t&) {}
    virtual void OnDeathTimer();
    virtual void OnRaise() {}
    virtual void TryHitInterrupt(CBattleEntity* PAttacker);
    virtual void OnDespawn(CDespawnState&);

    void SetBattleStartTime(time_point);
    duration GetBattleTime();

    virtual void Tick(time_point) override;
    virtual void PostTick() override;

    health_t	    health;						// hp,mp,tp
    stats_t		    stats;						// атрибуты STR,DEX,VIT,AGI,INT,MND,CHR
    skills_t	    WorkingSkills;				// структура всех доступных сущности умений, ограниченных уровнем
    uint32		    m_Immunity;					// Mob immunity
    bool            m_unkillable;               // entity is not able to die (probably until some action removes this flag)

    time_point  	charmTime;					// to hold the time entity is charmed
    bool			isCharmed;					// is the battle entity charmed?
    bool            isSuperJumped;              // is the battle entity super jumping?

    uint8			m_ModelSize;			    // размер модели сущности, для расчета дальности физической атаки
    ECOSYSTEM		m_EcoSystem;			    // эко-система сущности
    CItemEquipment* m_Weapons[4];               // четыре основных ячейки, используемыж для хранения оружия (только оружия)
    bool            m_dualWield;                // True/false depending on if the entity is using two weapons

    TraitList_t     TraitList;                  // список постянно активных способностей в виде указателей

    EntityID_t	    m_OwnerID;				    // ID of the attacking entity(after death it will store the ID of the entity that dealt the final blow)

    ActionList_t	m_ActionList;			    // список совершенных действий за одну атаку (нужно будет написать структуру, включающую ActionList в которой будут категории анимации и т.д.)

    CParty*			PParty;					    // описание группы, в которой состоит сущность
    CBattleEntity*	PPet;					    // Pet #1
    CBattleEntity*  PPet2;                      // Pet #2
    CBattleEntity*	PMaster;				    // владелец/хозяин сущности (распространяется на все боевые сущности)
    CBattleEntity*  PLastAttacker;
    time_point      LastAttacked;
    uint8           m_outOfLosAutoAttacks;     // How many times the entity failed to auto due to the target being out of LOS

    std::unique_ptr<CStatusEffectContainer> StatusEffectContainer;
    std::unique_ptr<CRecastContainer> PRecastContainer;
    std::unique_ptr<CNotorietyContainer> PNotorietyContainer;
    std::unordered_map<Mod, int16, EnumClassHash> m_modStat;     // массив модификаторов
    std::unordered_map<Mod, int16, EnumClassHash> m_modStatSave; // saved state

private:

    JOBTYPE		m_mjob;						// главная профессия
    JOBTYPE		m_sjob;						// дополнительная профессия
    uint8		m_mlvl;						// ТЕКУЩИЙ уровень главной профессии
    uint8		m_slvl;						// ТЕКУЩИЙ уровень дополнительной профессии
    uint16      m_battleTarget {0};
    time_point  m_battleStartTime;

    std::unordered_map<PetModType, std::unordered_map<Mod, int16, EnumClassHash>, EnumClassHash> m_petMod;
};

#endif
