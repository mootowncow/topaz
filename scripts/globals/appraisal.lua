-----------------------------------
-- Appraisal Utilities
-- desc: Common functionality for Appraisals
-- Credit: KnowOne - https://github.com/KnowOne134/DSP-Shared_Collection/blob/main/Appraisal/appraisal.lua
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------
tpz = tpz or {}
tpz.appraisalUtil = tpz.appraisalUtil or {}
-----------------------------------

tpz.appraisalUtil.Origin = 
{
    SCOUTING_THE_ASHU_TALIF     = 55,
    ROYAL_PAINTER_ESCORT        = 56,
    TARGETING_THE_CAPTAIN       = 57,
    NYZUL_BASIC                 = 100,
    NYZUL_BAT_EYE               = 101,
    NYZUL_SHADOW_EYE            = 102,
    NYZUL_BOMB_KING             = 103,
    NYZUL_JUGGLER_HECATOMB      = 104,
    NYZUL_SMOTHERING_SCHMIDT    = 105,
    NYZUL_HELLION               = 106,
    NYZUL_LEAPING_LIZZY         = 107,
    NYZUL_TOM_TIT_TAT           = 108,
    NYZUL_JAGGEDY_EARED_JACK    = 109,
    NYZUL_CACTUAR_CANTAUTOR     = 110,
    NYZUL_GARGANTUA             = 111,
    NYZUL_GYRE_CARLIN           = 112,
    NYZUL_ASPHYXIATED_AMSEL     = 113,
    NYZUL_FROSTMANE             = 114,
    NYZUL_PEALLAIDH             = 115,
    NYZUL_CARNERO               = 116,
    NYZUL_FALCATUS_ARANEI       = 117,
    NYZUL_EMERGENT_ELM          = 118,
    NYZUL_OLD_TWO_WINGS         = 120,
    NYZUL_AIATAR                = 121,
    NYZUL_INTULO                = 122,
    NYZUL_ORCTRAP               = 123,
    NYZUL_VALKURM_EMPEROR       = 124,
    NYZUL_CRUSHED_KRAUSE        = 125,
    NYZUL_STINGING_SOPHIE       = 126,
    NYZUL_SERPOPARD_ISHTAR      = 127,
    NYZUL_WESTERN_SHADOW        = 128,
    NYZUL_BLOODTEAR_BALDURF     = 129,
    NYZUL_ZIZZY_ZILLAH          = 130,
    NYZUL_ELLYLLON              = 131,
    NYZUL_MISCHIEVOUS_MICHOLAS  = 132,
    NYZUL_LEECH_KING            = 133,
    NYZUL_EASTERN_SHADOW        = 134,
    NYZUL_NUNYENUNC             = 135,
    NYZUL_HELLDIVER             = 136,
    NYZUL_TAISAIJIN             = 137,
    NYZUL_FUNGUS_BEETLE         = 138,
    NYZUL_FRIAR_RUSH            = 139,
    NYZUL_PULVERIZED_PFEFFER    = 140,
    NYZUL_ARGUS                 = 141,
    NYZUL_BLOODPOOL_VORAX       = 142,
    NYZUL_NIGHTMARE_VASE        = 143,
    NYZUL_DAGGERCLAW_DRACOS     = 144,
    NYZUL_NORTHERN_SHADOW       = 145,
    NYZUL_FRAELISSA             = 146,
    NYZUL_ROC                   = 147,
    NYZUL_SABOTENDER_BAILARIN   = 148,
    NYZUL_AQUARIUS              = 150,
    NYZUL_ENERGETIC_ERUCA       = 151,
    NYZUL_SPINY_SPIPI           = 152,
    NYZUL_TRICKSTER_KINETIX     = 153,
    NYZUL_DROOLING_DAISY        = 154,
    NYZUL_BONNACON              = 155,
    NYZUL_GOLDEN_BAT            = 156,
    NYZUL_STEELFLEECE_BALDARICH = 157,
    NYZUL_SABOTENDER_MARIACHI   = 158,
    NYZUL_UNGUR                 = 159,
    NYZUL_SWAMFISK              = 160,
    NYZUL_BUBURIMBOO            = 161,
    NYZUL_KEEPER_OF_HALIDOM     = 162,
    NYZUL_SERKET                = 163,
    NYZUL_DUNE_WIDOW            = 164,
    NYZUL_ODQAN                 = 165,
    NYZUL_BURNED_BERGMANN       = 166,
    NYZUL_TYRANNIC_TUNNOK       = 167,
    NYZUL_BLOODSUCKER           = 168,
    NYZUL_TOTTERING_TOBY        = 169,
    NYZUL_SOUTHERN_SHADOW       = 170,
    NYZUL_SHARP_EARED_ROPIPI    = 171,
    NYZUL_PANZER_PERCIVAL       = 172,
    NYZUL_VOUIVRE               = 173,
    NYZUL_JOLLY_GREEN           = 174,
    NYZUL_TUMBLING_TRUFFLE      = 175,
    NYZUL_CAPRICIOUS_CASSIE     = 176,
    NYZUL_AMIKIRI               = 177,
    NYZUL_STRAY_MARY            = 178,
    NYZUL_SEWER_SYRUP           = 179,
    NYZUL_UNUT                  = 180,
    NYZUL_SIMURGH               = 181,
    NYZUL_PELICAN               = 182,
    NYZUL_CARGO_CRAB_COLIN      = 183,
    NYZUL_WOUNDED_WURFEL        = 184,
    NYZUL_PEG_POWLER            = 185,
    NYZUL_JADED_JODY            = 186,
    NYZUL_MAIGHDEAN_UAINE       = 187,    
}

tpz.appraisalUtil.questionMarkItems =
{
    SWORD     = 2190,
    DAGGER    = 2191,
    POLEARM   = 2192,
    AXE       = 2193,
    BOW       = 2194,
    GLOVES    = 2195,
    FOOTWEAR  = 2196,
    HEADPIECE = 2276,
    EARRING   = 2277,
    RING      = 2278,
    CAPE      = 2279,
    SASH      = 2280,
    SHIELD    = 2281,
    NECKLACE  = 2282,
    INGOT     = 2283,
    POTION    = 2284,
    CLOTH     = 2285,
    BOX       = 2286,
}

tpz.appraisalUtil.appraisalItems =
{
    [tpz.appraisalUtil.questionMarkItems.SWORD] =
    {
        [SEAGULL_GROUNDED] =
        {
            items =
            {
                {65, 18366}, -- Gust Claymore
                {34, 16978}, -- Uchigatana+1
                { 1, 18434}, -- Kosetsusamonji
            },
        },
        [SAGELORD_ELIMINATION] =
        {
            items =
            {
                {55,18366}, -- Gust Claymore
                {40,16978}, -- Uchigatana+1
                { 5,18387}, -- Djinnbringer
            },
        },
        [BREAKING_MORALE] =
        {
            items =
            {
                {45, 18366}, -- Gust Claymore
                {30, 16978}, -- Uchigatana+1
                {20, 17703}, -- Pealing Anelace
                {10, 18433}, -- Kagiroi
                { 5, 17661}, -- Storm Schimitar
            },
        },
        [THE_DOUBLE_AGENT] =
        {
            items =
            {
                {45, 18336}, -- Gust Claymore
                {10, 18387}, -- Djinnbringer
                {38, 16978}, -- Uchigatana+1
                { 4, 17703}, -- Pealing Anelace
                { 3, 18433}, -- Kagiroi
            },
        },
        [AZURE_EXPERIMENTS] =
        {
            items =
            {
                {100,17716}, -- Macuahuitl-1
            },
        },
        [BLITZKRIEG] =
        {
            items =
            {
                {45, 18366}, -- Gust Claymore
                {30, 16978}, -- Uchigatana+1
                {20, 17700}, -- Durandal
                { 5, 17721}, -- Sanguine Sword
            },
        },
        [WAMOURA_FARM_RAID] =
        {
            items =
            {
                {45, 18366}, -- Gust Claymore
                {30 ,16978}, -- Uchigatana+1
                {20, 18435}, -- Hotarumaru
                { 5, 18438}, -- Kumokirimaru
            },
        },
        [RED_VERSUS_BLUE] =
        {
            items =
            {
                {100,17660}, -- Kilij
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_FROSTMANE] =
        {
            items =
            {
                {60, 16583}, -- Claymore
                {35, 18366}, -- Gust Claymore
                { 5, 16944}, -- Lockheart
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_CARNERO] =
        {
            items =
            {
                {75, 16535}, -- Bronze Sword
                {25, 17811}, -- Katayama
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_EMERGENT_ELM] =
        {
            items =
            {
                {60, 16535}, -- Bronze Sword
                {35, 16530}, -- Xiphos
                { 5, 18386}, -- Gloom Claymore
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_ZIZZY_ZILLAH] =
        {
            items =
            {
                {60, 16535}, -- Bronze Sword
                {35, 16978}, -- Uchigatana+1
                { 5, 18437}, -- Namikirimaru
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_KEEPER_OF_HALIDOM] =
        {
            items =
            {
                {65, 16535}, -- Bronze Sword
                {32, 16978}, -- Uchigatana+1
                { 3, 16990}, -- Daihannya
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_AMIKIRI] =
        {
            items =
            {
                {75, 16535}, -- Bronze Sword
                {25, 16968}, -- Kamewari
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_CARGO_CRAB_COLIN] =
        {
            items =
            {
                {85, 16535}, -- Bronze Sword
                {15, 17650}, -- Nadris
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.DAGGER] =
    {
        [tpz.appraisalUtil.Origin.SCOUTING_THE_ASHU_TALIF] =
        {
            items =
            {
                {20, 18028}, -- Matron's Knife
                {50, 17984}, -- Spark Dagger
                {30, 18008}, -- Hushed Dagger
            }
        },
        [tpz.appraisalUtil.Origin.NYZUL_TOM_TIT_TAT] =
        {
            items =
            {
                {70, 16465}, -- Bronze Knife
                {25, 16896}, -- Kunai
                { 5, 16443}, -- Fruit Punches
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_ORCTRAP] =
        {
            items =
            {
                {95, 16465}, -- Bronze Knife
                { 5, 17792}, -- Nikkariaoe
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_STINGING_SOPHIE] =
        {
            items =
            {
                {95, 16465}, -- Bronze Knife
                { 5, 16486}, -- Beestinger
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_WESTERN_SHADOW] =
        {
            items =
            {
                {95, 16896}, -- Kunai
                { 5, 18752}, -- Retaliators
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_MISCHIEVOUS_MICHOLAS] =
        {
            items =
            {
                {95, 16465}, -- Bronze Knife
                { 5, 17610}, -- Kidney Dagger
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_NIGHTMARE_VASE] =
        {
            items =
            {
                {90, 16896}, -- Kunai
                {10, 16913}, -- Shinogi
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_DAGGERCLAW_DRACOS] =
        {
            items =
            {
                {90, 16390}, -- Bronze Knuckels
                {10, 16434}, -- Sonic Knuckles
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_SABOTENDER_MARIACHI] =
        {
            items =
            {
                {90, 16465}, -- Bonze Knife
                {10, 17981}, -- Bano Del Sol
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.POLEARM] =
    {
        [SEAGULL_GROUNDED] =
        {
            items =
            {
                {100, 18076}, -- Spark Spear
            },
        },
        [REQUIEM] =
        {
            items =
            {
                {20, 17125}, -- Holly Staff +1
                {40, 16769}, -- Brass Zaghnal
                {20, 17138}, -- Willow Wand +1
                { 5, 18112}, -- Puk Lance
                {15, 18076}, -- Spark Spear
            },
        },
        [GOLDEN_SALVAGE] =
        {
            items =
            {
                {40, 18076}, -- Spark Spear
                {40, 16769}, -- Brass Zaghnal
                {10, 17138}, -- Willow Wand +1
                {9, 17124}, -- Holly Pole +1
                {1, 18843}, -- Flan Smasher
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_JUGGLER_HECATOMB] =
        {
            items =
            {
                {90, 17024}, -- Ash Club
                {10, 16868}, -- Heavy Halberd
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_HELLION] =
        {
            items =
            {
                {70, 17049}, -- Maple Wand
                {30, 16868}, -- A I'Outrance
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_FALCATUS_ARANEI] =
        {
            items =
            {
                {70, 17049}, -- Maple Wand
                {20, 16768}, -- Bronze Zaghnal
                {10, 18040}, -- Webcutter
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_NUNYENUNC] =
        {
            items =
            {
                {90, 17024}, -- Ash Club
                {10, 18394}, -- Pilgrams Wand
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_ROC] =
        {
            items =
            {
                {90, 17049}, -- Maple Wand
                {10, 18587}, -- Dryad Staff
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_SWAMFISK] =
        {
            items =
            {
                {90, 17049}, -- Maple Wand
                {10, 17594}, -- Gelong Staff
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_VOUIVRE] =
        {
            items =
            {
                {90, 17024}, -- Ash Club
                {10, 16885}, -- Gae Blog
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.AXE] =
    {
        [REQUIEM] =
        {
            items =
            {
                {100, 605}, -- Pickaxe
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_BAT_EYE] =
        {
            items =
            {
                {95, 16642}, -- Bone Axe
                { 5, 16675}, -- Storm Axe
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_NORTHERN_SHADOW] =
        {
            items =
            {
                {90, 16704}, -- Butterfly Axe
                {10, 16723}, -- Executioner
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_AQUARIUS] =
        {
            items =
            {
                {90, 16642}, -- Bone Axe
                {10, 17925}, -- Fransisca
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_TRICKSTER_KINETIX] =
        {
            items =
            {
                {90, 16642}, -- Bone Axe
                {10, 16657}, -- Tabar
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_TYRANNIC_TUNNOK] =
        {
            items =
            {
                {90, 16642}, -- Bone Axe
                {10, 17927}, -- Lohar
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_PANZER_PERCIVAL] =
        {
            items =
            {
                {90, 16704}, -- Butterfly Axe
                {10, 16714}, -- Neckchopper
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_PEG_POWLER] =
        {
            items =
            {
                {90, 16704}, -- Butterfly Axe
                {10, 16728}, -- Schwarz Axe
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.BOW] =
    {
        [LAMIA_NO_13] =
        {
            items =
            {
                {43, 17177}, -- Longbow +1
                {43, 17225}, -- Crossbow +1
                {14, 18683}, -- Imperial Bow
            },
        },      
        [tpz.appraisalUtil.Origin.NYZUL_GYRE_CARLIN] =
        {
            items =
            {
                {90, 17152}, -- Shortbow
                {10, 17247}, -- Rikonodo
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_EASTERN_SHADOW] =
        {
            items =
            {
                {90, 17160}, -- Longbow
                {10, 18714}, -- Valis Bow
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_HELLDIVER] =
        {
            items =
            {
                {90, 17153}, -- Self Bow
                {10, 17281}, -- Wingedge
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_UNGUR] =
        {
            items =
            {
                {90, 17217}, -- Crossbow
                {10, 18141}, -- Ungar Boomerang
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.GLOVES] =
    {
        [tpz.appraisalUtil.Origin.SCOUTING_THE_ASHU_TALIF] =
        {
            items =
            {
                {5, 12679}, -- Trickster's Gloves
                {50, 12696}, -- Leather Gloves
                {45, 12721}, -- Cotton Gloves
            }
        },
        [ORICHALCUM_SURVEY] =
        {
            items =
            {
                {100, 14937}, -- Storm Gages
            },
        },
        [SEAGULL_GROUNDED] =
        {
            items =
            {
                {30, 12695}, -- Bronze Mittens + 1
                {30, 12696}, -- Leather Gloves
                {20, 12721}, -- Cotton Gloves
                {19, 12728}, -- Cuffs
                { 1, 14936}, -- Storm Manopolas
            },
        },
        [REQUIEM] =
        {
            items =
            {
                {30, 12969}, -- Leather Gloves
                {28, 12965}, -- Bronze Mittens + 1
                {20, 12721}, -- Cotton Gloves
                {18, 12728}, -- Cuffs
                { 5, 14937}, -- Storm Gages
            },
        },
        [tpz.appraisalUtil.Origin.TARGETING_THE_CAPTAIN] =
        {
            items =
            {
                {20, 12969}, -- Leather Gloves
                {20, 12965}, -- Bronze Mittens + 1
                {20, 12721}, -- Cotton Gloves
                {20, 12728}, -- Cuffs
                {20, 14943}, -- Barbarossa's Moufles
            }
        },
        [tpz.appraisalUtil.Origin.NYZUL_PEALLAIDH] =
        {
            items =
            {
                {90, 12696}, -- Leather Gloves
                {10, 14946}, -- Nightmare Gloves
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_ENERGETIC_ERUCA] =
        {
            items =
            {
                {90, 12721}, -- Cotton Cloves
                {10, 14947}, -- Hanzo Tekko
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.FOOTWEAR] =
    {
        [LAMIA_NO_13] =
        {
            items =
            {
                {20, 12984}, -- Ash Clogs
                {38, 12951}, -- Bronze Leggings +1
                {18, 12952}, -- Leather Highboots
                {6,  12992}, -- Solea
                {18, 15691}, -- Storm Gambieras
            },
        },        
        [tpz.appraisalUtil.Origin.NYZUL_LEAPING_LIZZY] =
        {
            items =
            {
                {95, 12952}, -- Leather Highboots
                { 5, 15351}, -- Bounding boots
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_CACTUAR_CANTAUTOR] =
        {
            items =
            {
                {90, 12952}, -- Leather Highboots
                {10, 14128}, -- Kung Fu Shoes
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_BONNACON] =
        {
            items =
            {
                {90, 12984}, -- Ash Clogs
                {10, 15323}, -- Cure Clogs
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_TOTTERING_TOBY] =
        {
            items =
            {
                {90, 12984}, -- Ash Clogs
                {10, 13013}, -- Stumbling Sandles
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_SIMURGH] =
        {
            items =
            {
                {90, 12952}, -- Leather Highboots
                {10, 15736}, -- Trotter Boots
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.HEADPIECE] =
    {
        [tpz.appraisalUtil.Origin.SCOUTING_THE_ASHU_TALIF] =
        {
            items =
            {
                {5, 12523}, -- Clergy Crown
                {50, 12472}, -- Circlet
                {45, 13837}, -- Bonzes Circlet
            }
        },
        [tpz.appraisalUtil.Origin.ROYAL_PAINTER_ESCORT] =
        {
            items =
            {
                {20, 12463}, -- Bronze Cap +1
                {20, 16077}, -- Megrim Crown
                {20, 12472}, -- Circlet
                {20, 12472}, -- Circlet
                {20, 12472}, -- Leather Bandana
                {20, 12465}, -- Cotton Headgear
            }
        },
        [tpz.appraisalUtil.Origin.NYZUL_VALKURM_EMPEROR] =
        {
            items =
            {
                {90, 12496}, -- Copper Hairpin
                {10, 15224}, -- Empress Hairpin
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_ELLYLLON] =
        {
            items =
            {
                {90, 12440}, -- Leather Bandana
                {10, 13913}, -- Mushroom Helm
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_TAISAIJIN] =
        {
            items =
            {
                {90, 12440}, -- Leather Bandana
                {10, 15222}, -- Spelunker's Hat
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_DROOLING_DAISY] =
        {
            items =
            {
                {90, 12505}, -- Bone Hairpin
                {10, 13838}, -- Dodge Headband
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_SHARP_EARED_ROPIPI] =
        {
            items =
            {
                {90, 12496}, -- Copper Hairpin
                {10, 15218}, -- Entrancing Ribbon
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_TUMBLING_TRUFFLE] =
        {
            items =
            {
                {90, 12440}, -- Leather Bandana
                {10, 12485}, -- Fungus Hat
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.EARRING] =
    {
        [EXCAVATION_DUTY] =
        {
            items =
            {
                {25, 13313}, -- Shell Earring
                {20, 13321}, -- Bone Earring
                {25, 13323}, -- Beetle Earring
                {20, 13327}, -- Silver Earring
                { 9, 14790}, -- Reraise Earring
                { 1, 15968}, -- Storm Loop
            },
        },
        [GOLDEN_SALVAGE] =
        {
            items =
            {
                {22, 13313}, -- Shell Earring
                {20, 13321}, -- Bone Earring
                {21, 13323}, -- Beetle Earring
                {27, 13327}, -- Silver Earring
                { 6, 14805}, -- Heims Earring
                { 4, 15969}, -- Storm Earring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_LEECH_KING] =
        {
            items =
            {
                {90, 13313}, -- Shell Earring
                {10, 13359}, -- Bloodbead Earring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_CAPRICIOUS_CASSIE] =
        {
            items =
            {
                {90, 13321}, -- Bone Earring
                {10, 13402}, -- Cassie Earring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_MAIGHDEAN_UAINE] =
        {
            items =
            {
                {90, 13323}, -- Beetle Earring
                {10, 14803}, -- Optical Earring
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.RING] =
    {
        [tpz.appraisalUtil.Origin.ROYAL_PAINTER_ESCORT] =
        {
            items =
            {
                { 5, 13505}, -- Veterinarians Ring
                {50, 13454}, -- Copper Ring
                {45, 13465}, -- Brass Ring
            },
        },
        [LEUJAOAM_CLEANSING] =
        {
            items =
            {
                {50, 13454}, -- Copper Ring
                {49, 13465}, -- Brass Ring
                { 1, 15773}, -- Imperial Ring
            },
        },
        [IMPERIAL_AGENT_RESCUE] =
        {
            items =
            {
                {50, 13454}, -- Copper Ring
                {30, 13465}, -- Brass Ring
                {19, 13549}, -- Ether Ring
                {1, 15774}, -- Storm Ring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_BOMB_KING] = 
        {
            items =
            {
                {60, 13454}, -- Copper Ring
                {30, 13465}, -- Brass Ring
                {10, 13506}, -- Bomb Ring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_SMOTHERING_SCHMIDT] =
        {
            items =
            {
                {60, 13454}, -- Copper Ring
                {30, 13465}, -- Brass Ring
                {10, 13507}, -- Malflood Ring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_ASPHYXIATED_AMSEL] =
        {
            items =
            {
                {90, 13465}, -- Brass Ring
                {10, 13512}, -- Malgust Ring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_CRUSHED_KRAUSE] =
        {
            items =
            {
                {90, 13454}, -- Copper Ring
                {10, 13508}, -- Maldust Ring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_PULVERIZED_PFEFFER] =
        {
            items =
            {
                {90, 13454}, -- Copper Ring
                {10, 13509}, -- Malfrost Ring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_SERKET] =
        {
            items =
            {
                {90, 13465}, -- Brass Ring
                {10, 13552}, -- Serket Ring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_BURNED_BERGMANN] =
        {
            items =
            {
                {90, 13454}, -- Copper Ring
                {10, 13510}, -- Malflame Ring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_BLOODSUCKER] =
        {
            items =
            {
                {90, 13454}, -- Copper Ring
                {10, 13302}, -- Bloodbead Ring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_SEWER_SYRUP] =
        {
            items =
            {
                {90, 13465}, -- Brass Ring
                {10, 13303}, -- Jelly Ring
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_WOUNDED_WURFEL] =
        {
            items =
            {
                {90, 13454}, -- Copper Ring
                {10, 13511}, -- Malflash Ring
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.CAPE] =
    {
        [tpz.appraisalUtil.Origin.SCOUTING_THE_ASHU_TALIF] =
        {
            items =
            {
                {5, 13606}, -- Clergy Cape
                {50, 13583}, -- Cape
                {45, 13584}, -- Cotton Cape
            }
        },
        [LEBROS_SUPPLIES] =
        {
            items =
            {
                {30, 13600}, -- Dhamel Mantle +1
                {25, 13601}, -- Cotton Cape +1
                {25, 13608}, -- Lizard Mantle +1
                { 5, 15489}, -- Storm Cape
                {15, 13624}, -- Enhancing Mantle
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_OLD_TWO_WINGS] =
        {
            items =
            {
                {90, 13608}, -- Lizard Mantle +1
                {10, 13598}, -- Bat Cape
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_FRAELISSA] =
        {
            items =
            {
                {90, 13601}, -- Cotton Cape +1
                {10, 15469}, -- Bellicose Mantle
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_SPINY_SPIPI] =
        {
            items =
            {
                {90, 13594}, -- Rabbit Mantle
                {10, 13607}, -- Mist Silk Cape
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_GOLDEN_BAT] =
        {
            items =
            {
                {90, 13601}, -- Cotton Cape +1
                {10, 13576}, -- Night Cape
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.SASH] =
    {
        [tpz.appraisalUtil.Origin.NYZUL_JOLLY_GREEN] =
            {
                items =
                {
                    {90, 13205}, -- Silver Obi
                    {10, 13228}, -- Shaman's Belt
                },
            },
    },
    [tpz.appraisalUtil.questionMarkItems.SHIELD] =
    {
        [tpz.appraisalUtil.Origin.NYZUL_BLOODTEAR_BALDURF] =
        {
            items =
            {
                {90, 12293}, -- Oak Shield
                {10, 12356}, -- Viking Shield
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_FUNGUS_BEETLE] =
        {
            items =
            {
                {90, 12289}, -- Lauan Shield
                {10, 12371}, -- Clipeus
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_STEELFLEECE_BALDARICH] =
        {
            items =
            {
                {90, 12293}, -- Oak Shield
                {10, 12356}, -- Viking Shield
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_SOUTHERN_SHADOW] =
        {
            items =
            {
                {90, 12291}, -- Elm Shield
                {10, 12344}, -- Master Shield
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_PELICAN] =
        {
            items =
            {
                {90, 12299}, -- Aspis
                {10, 12382}, -- Astral Aspis
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.NECKLACE] =
    {
        [ORICHALCUM_SURVEY] =
        {
            items =
            {
                {55, 13075}, -- Feather Collar
                {30, 13065}, -- Gorget +1
                {10, 13165}, -- Jagd Gorget
                { 5, 15519}, -- Storm Muffler
            },
        },
        [PREEMPTIVE_STRIKE] =
        {
            items =
            {
                {55, 13075}, -- Feather Collar
                {30, 13065}, -- Gorget +1
                {10, 13128}, -- Spectacles
                { 5, 15520}, -- Storm Torqe
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_SHADOW_EYE] =
        {
            items =
            {
                {95, 15526}, -- Regen Collar
                { 5, 13114}, -- Moon Amulet
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_JAGGEDY_EARED_JACK] =
        {
            items =
            {
                {90, 13081}, -- Leather Gorget
                {10, 13112}, -- Rabbit Charm
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_GARGANTUA] =
        {
            items =
            {
                {90, 13075}, -- Feather Collar
                {10, 13115}, -- Elementl Charm
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_SERPOPARD_ISHTAR] =
        {
            items =
            {
                {90, 13075}, -- Feather Collar
                {10, 13086}, -- Cerulean Pendant
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_ARGUS] =
        {
            items =
            {
                {90, 15526}, -- Regen Collar
                {10, 15515}, -- Peacok Amulet
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_BLOODPOOL_VORAX] =
        {
            items =
            {
                {90, 13065}, -- Gorget +1
                {10, 13058}, -- Bloodbead Amulet
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_BUBURIMBOO] =
        {
            items =
            {
                {90, 13065}, -- Gorget +1
                {10, 13057}, -- Buburimu Gorget
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_DUNE_WIDOW] =
        {
            items =
            {
                {90, 15526}, -- Regen Collar
                {10, 13137}, -- Spider Torque
            },
        },
    },
    [tpz.appraisalUtil.questionMarkItems.INGOT] =
    {

    },
    [tpz.appraisalUtil.questionMarkItems.POTION] =
    {

    },
    [tpz.appraisalUtil.questionMarkItems.CLOTH] =
    {

    },
    [tpz.appraisalUtil.questionMarkItems.BOX] =
    {
        [LEUJAOAM_CLEANSING] =
        {
            items =
            {
                {25,  776}, -- White Rock
                {25, 1164}, -- Tsurara
                {10, 1411}, -- Phalaenopsis
                {10, 1472}, -- Gardenia Seed
                {10, 1887}, -- Glass Sheet
                {10, 4097}, -- Ice Crystal
                {10, 5450}, -- Lakerda
            },
        },
        [ORICHALCUM_SURVEY] =
        {
            items =
            {
                {10, 4388}, -- Eggplant
                { 9, 1472}, -- Gardenia Seed
                {10, 4097}, -- Ice Crystal
                { 7, 5332}, -- Kabura Quiver
                {13,  826}, -- Linen Cloth
                { 8, 2146}, -- Merrow Scale
                { 5, 1411}, -- Phalaenopsis
                {10, 2334}, -- Poroggo Hat
                { 6, 1724}, -- Soulflayer Robe
                {15, 1164}, -- Tsurara
                { 7,  776}, -- White Rock
            },
        },
        [IMPERIAL_AGENT_RESCUE] =
        {
            items =
            {
                {20, 2475}, -- Kaolin
                {20, 2227}, -- Mamool Ja Collar
                {20, 2334}, -- Poroggo Hat
                {20,  638}, -- Sage
                {20, 4387}, -- Wild Onion
            },
        },
        [LEBROS_SUPPLIES] =
        {
            items =
            {
                {20,  1108}, -- Sulfur
                {20,  2175}, -- Flan Meat
                { 5,  5363}, -- Bullet Pouch
                {20,  2160}, -- Troll Pauldron
                {10, 18160}, -- Spartan Bullet
                {25,  1590}, -- Holy Basil
            },
        },
        [PREEMPTIVE_STRIKE] =
        {
            items =
            {
                {17, 4388}, -- Eggplant
                {15,  638}, -- Sage
                {15, 2156}, -- Imp. Tea Leaves
                { 7, 4387}, -- Wild Onion
                {10, 1828}, -- Red Grass Thread
                { 7, 2227}, -- Mamool Ja Collar
                { 4, 5317}, -- Toolbag (Sairui-ran)
                { 3, 5314}, -- Toolbag (Shihei)
                { 4, 5315}, -- Toolbag (Jusa)
                {10, 2475}, -- Kaolin
                { 8, 2334}, -- Poroggo Hat
            },
        },
        [REQUIEM] =
        {
            items =
            {
                { 4,  1654}, -- Igneous Rock
                { 5,  4196}, -- Rotten Quiver
                { 5,  5336}, -- Holy Bolt Quiver
                {20,   880}, -- Bone Chip
                { 5,   113}, -- Cleaning Tool Set
                { 2,   867}, -- Dragon Scales
                { 9,  2153}, -- Qiqirn Sandbag
                {15,  2163}, -- Imp Wing
                {20, 17339}, -- Bronze Bolt
                {15,  1523}, -- Apple Mint
            },
        },
        [EXCAVATION_DUTY] =
        {
            items =
            {
                {20,  640}, -- Copper Ore
                {16,  769}, -- Red Rock
                {16,  928}, -- Bomb Ash
                {16, 1108}, -- Sulfur
                {16, 1590}, -- Holy Basil
                {16, 2175}, -- Flan Meat
            },
        },
        [SEAGULL_GROUNDED] =
        {
            items =
            {
                {1,  113}, -- Cleaning Tool Set
                {2,  821}, -- Rainbow Thread
                {25,  880}, -- Bone Chip
                {10, 1523}, -- Apple Mint
                {13, 1654}, -- Igneous Rock
                {20, 2153}, -- Qiqirn Sandbag
                {9, 2163}, -- Imp Wing
                {10, 4196}, -- Rotton Quiver
                {10, 4387}, -- Wild Onion
            },
        },
        [GOLDEN_SALVAGE] =
        {
            items =
            {
                {20,    90}, -- Rusty Bucket
                {20,  2165}, -- Qutrub Gorget
                {20,  2167}, -- Lamian Armlet
                {20, 17391}, -- Willow Fishing Rod
                {20, 17396}, -- Little Worm
            },
        },
        [LAMIA_NO_13] =
        {
            items =
            {
                { 2,  1523}, -- Apple Mint
                {25,  2165}, -- Qutrub Gorget
                {25,  2167}, -- Lamian Armlet
                { 2,  2418}, -- Aht Urhgan Brass Ingot
                { 2,  4129}, -- Stone Quiver
                { 6,  4220}, -- Bone Quiver
                { 2,  4221}, -- Beetle Quiver
                { 2,  4224}, -- Demon Quiver
                { 4,  4226}, -- Silver Quiver
                { 6,  4902}, -- Light Spirit Pact
                { 2,  5332}, -- Kabura Quiver
                { 2,  5333}, -- Sleep Quiver
                {19,  5453}, -- Istakoz
                { 1,    90}, -- Rusty Bucket
            },
        },
        [tpz.appraisalUtil.Origin.SCOUTING_THE_ASHU_TALIF] =
        {
            items =
            {
                {25, 2349}, -- Turbo Charger
                {25, 2352}, -- Condenser
                {25, 2348}, -- Tranquilizer
                {25, 2353}, -- Optic Fiber
            }
        },
        [tpz.appraisalUtil.Origin.ROYAL_PAINTER_ESCORT] =
        {
            items =
            {
                {5, tpz.items.CERBERUS_HIDE},
                {5, tpz.items.HYDRA_SCALE},
                {5, tpz.items.DIAMOND},
                {5, tpz.items.EMERALD},
                {5, tpz.items.SPOOL_OF_RAINBOW_THREAD},
                {5, tpz.items.SPOOL_OF_GOLD_THREAD},
                {5, tpz.items.SPOOL_OF_SILVER_THREAD},
                {5, tpz.items.SPOOL_OF_WOOL_THREAD},
                {5, tpz.items.DEATHSTONE},
                {5, tpz.items.ANGELSTONE},
                {5, tpz.items.CHUNK_OF_KHROMA_ORE},
                {5, tpz.items.SCHURZEN},
                {5, tpz.items.DYNAMO},
                {5, tpz.items.ECONOMIZER},
                {5, tpz.items.OPTIC_FIBER},
                {5, tpz.items.TURBO_CHARGER},
                {5, tpz.items.REACTIVE_SHIELD},
                {5, tpz.items.TRANQUILIZER},
                {5, tpz.items.CONDENSER},
                {5, tpz.items.JUDGES_CUISSES},
            }
        },
        [tpz.appraisalUtil.Origin.TARGETING_THE_CAPTAIN] =
        {
            items =
            {
                {5, tpz.items.CERBERUS_HIDE},
                {5, tpz.items.HYDRA_SCALE},
                {5, tpz.items.DIAMOND},
                {5, tpz.items.SPOOL_OF_RAINBOW_THREAD},
                {5, tpz.items.SPOOL_OF_GOLD_THREAD},
                {5, tpz.items.SPOOL_OF_SILVER_THREAD},
                {5, tpz.items.SPOOL_OF_WOOL_THREAD},
                {5, tpz.items.BLOODWOOD_LOG},
                {5, tpz.items.DEATHSTONE},
                {5, tpz.items.ANGELSTONE},
                {5, tpz.items.CHUNK_OF_KHROMA_ORE},
                {5, tpz.items.SCHURZEN},
                {5, tpz.items.DYNAMO},
                {5, tpz.items.ECONOMIZER},
                {5, tpz.items.OPTIC_FIBER},
                {5, tpz.items.TURBO_CHARGER},
                {5, tpz.items.REACTIVE_SHIELD},
                {5, tpz.items.TRANQUILIZER},
                {5, tpz.items.CONDENSER},
                {5, tpz.items.BARBAROSSAS_ZEREHS},
            }
        },
        [tpz.appraisalUtil.Origin.NYZUL_AIATAR] =
        {
            items =
            {
                {80, 12824}, -- Leather Trousers
                {10, 15367}, -- Falconer's Hose
                {10, 15370}, -- Sable Cuisses
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_INTULO] =
        {
            items =
            {
                {90, 12864}, -- Slacks
                {10, 15372}, -- Magic Slacks
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_FRIAR_RUSH] =
        {
            items =
            {
                {90, 17316}, -- Bomb Arm
                {10, 18139}, -- Bomb Core
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_SABOTENDER_BAILARIN] =
        {
            items =
            {
                {90, 17307}, -- Dart
                {10, 18138}, -- Bailathorn
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_ODQAN] =
        {
            items =
            {
                {90, 12824}, -- Leather Trousers
                {10, 15373}, -- Bravo's Subligar
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_STRAY_MARY] =
        {
            items =
            {
                {90, 17344}, -- Cornette
                {10, 17366}, -- Mary's Horn
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_UNUT] =
        {
            items =
            {
                {90, 12857}, -- Linen Slops
                {10, 14287}, -- Luna Subligar
            },
        },
        [tpz.appraisalUtil.Origin.NYZUL_JADED_JODY] =
        {
            items =
            {
                {90, 12864}, -- Slacks
                {10, 15613}, -- Jet Seraweels
            },
        },
    },
}


tpz.appraisalUtil.appraiseItem = function(player, npc, trade, gil, appraisalCsid, dialogs)
    if player:getGil() >= gil then
        if npcUtil.tradeHas(trade, { {4101, 2} }, true, false) then
            player:messageSpecial(dialogs[2])
            return
        end
        for _, v in pairs(tpz.appraisalUtil.questionMarkItems) do            
            if npcUtil.tradeHasExactly(trade, v) then
                local tradeID = trade:getItemId()
                local info = tpz.appraisalUtil.appraisalItems[tradeID]
                local appraisalID = trade:getItem():getAppraisalID()
                local item  = itemPick(player, info, appraisalID)

                if item ~= 0 then
                    player:delGil(gil)
                    player:startEvent(appraisalCsid, 1, item)
                    player:setLocalVar("Appraisal", item) -- anticheat
                end
                break
            end
        end
    else
        player:messageSpecial(dialogs[1])
    end
end

function itemPick(player, info, appraisalID)
    -- possible drops
    local items = info[appraisalID].items

    -- sum weights
    local sum = 0
    for i = 1, #items do
        sum = sum + items[i][1]
    end

    -- pick weighted result
    local item = 0
    local pick = math.random(sum)
    sum = 0
    for i = 1, #items do
        sum = sum + items[i][1]
        if sum >= pick then
            item = items[i][2]
            break
        end
    end

    return item
end

tpz.appraisalUtil.appraisalOnEventFinish = function(player, csid, option, gil, appraisalCsid)
    if csid == appraisalCsid then
        local itemId = player:getLocalVar("Appraisal")
        player:confirmTrade()
        player:addTreasure(itemId, nil)
        player:delGil(gil)
        player:setLocalVar("Appraisal", 0)
    end
end

function canGetQuestionMarkItem(player, instance, area)
    local result = false
    local cap = instance:getLevelCap()
    if cap == 0 or cap >= tpz.assaultUtil.missionInfo[area].suggestedLevel then
        result = true
    end
    return result
end
