-----------------------------------
-- Area: Dynamis-Jeuno
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.DYNAMIS_JEUNO] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7055, -- Tallying conquest results...
        DYNAMIS_TIME_BEGIN      = 7214, -- The sands of the <item> have begun to fall. You have <number> minutes (Earth time) remaining in Dynamis.
        DYNAMIS_TIME_EXTEND     = 7215, -- our stay in Dynamis has been extended by <number> minute[/s].
        DYNAMIS_TIME_UPDATE_1   = 7216, -- ou will be expelled from Dynamis in <number> [second/minute] (Earth time).
        DYNAMIS_TIME_UPDATE_2   = 7217, -- ou will be expelled from Dynamis in <number> [seconds/minutes] (Earth time).
        DYNAMIS_TIME_EXPIRED    = 7219, -- The sands of the hourglass have emptied...
        OMINOUS_PRESENCE        = 7230, -- You feel an ominous presence, as if something might happen if you possessed <item>.
        CONF_TOO_FAR            = 7234, -- You have ventured too far from the field of battle. The Confrontation will automatically disengage if you do not return
        CONF_DISENAGED          = 7235, -- Ventured too far, confrontation has disengaged.
        CONF_REENGAGED          = 7236, -- You have returned to the field of battle.
        CONF_BATTLE_BEGIN       = 7237, -- You have x earth time to complete the battle.
        CONF_MIN_REMAINING      = 7238, -- X earth minutes remaining to complete the battle.
        CONF_SEC_REMAINING      = 7239, -- x earth seconds remaining to complete the battle.
        CONF_TIME_UP            = 7240, -- Your time for this Confrontation is up...
        MONSTER_FADES           = 7241, -- The monster fades before your eyes, a look of disappointment on its face.
    },
    mob =
    {
        TIME_EXTENSION =
        {
            {minutes = 10, ki = tpz.ki.CRIMSON_GRANULES_OF_TIME,   mob = {17547301, 17547302, 17547303}},
            {minutes = 10, ki = tpz.ki.AZURE_GRANULES_OF_TIME,     mob = 17547389},
            {minutes = 10, ki = tpz.ki.AMBER_GRANULES_OF_TIME,     mob = 17547390},
            {minutes = 15, ki = tpz.ki.ALABASTER_GRANULES_OF_TIME, mob = 17547420},
            {minutes = 15, ki = tpz.ki.OBSIDIAN_GRANULES_OF_TIME,  mob = 17547467},
        },
        REFILL_STATUE =
        {
            {
                {mob = 17547295, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17547296, eye = dynamis.eye.BLUE },
                {mob = 17547297, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17547391, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17547392, eye = dynamis.eye.BLUE },
                {mob = 17547393, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17547421, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17547422, eye = dynamis.eye.BLUE },
                {mob = 17547423, eye = dynamis.eye.GREEN},
            },
            {
                {mob = 17547456, eye = dynamis.eye.RED  }, -- Goblin_Replica
                {mob = 17547457, eye = dynamis.eye.BLUE },
                {mob = 17547458, eye = dynamis.eye.GREEN},
            },
        },
        TUFFLIX_LOGLIMBS_PH      = {[17547290] = 17547291}, -- Vanguard_Hitman
        SMELTIX_THICKHIDE_PH      = {[17547295] = 17547298}, -- Goblin_Replica
        JABKIX_PIGEONPECS_PH      = {[17547296] = 17547299}, -- Goblin_Replica
        WASABIX_CALLUSDIGIT_PH      = {[17547297] = 17547300}, -- Goblin_Replica
        HERMITRIX_TOOTHROT_PH      = {[17547309] = 17547311}, -- Vanguard_Welldigger
        WYRMWIX_SNAKESPECS_PH      = {[17547308] = 17547312}, -- Vanguard_Alchemist
        MORGMOX_MOLDNOGGIN_PH      = {[17547321] = 17547322}, -- Vanguard_Enchanter
        SPARKSPOX_SWEATBROW_PH      = {[17547320] = 17547329}, -- Vanguard_Shaman
        ELIXMIX_HOOKNOSE_PH      = {[17547353] = 17547355}, -- Vanguard_Armorer
        BANDRIX_ROCKJAW_PH      = {[17547352] = 17547356}, -- Vanguard_Tinkerer
        BUFFRIX_EARGONE_PH      = {[17547373] = 17547387}, -- Vanguard_Necromancer
        HUMNOX_DRUMBELLY_PH      = {[17547372] = 17547378}, -- Vanguard_Shaman
        TICKTOX_BEADYEYES_PH      = {[17547393] = 17547394}, -- Goblin_Replica
        LURKLOX_DHALMELNECK_PH      = {[17547392] = 17547395}, -- Goblin_Replica
        TRAILBLIX_GOATMUG_PH      = {[17547391] = 17547396}, -- Goblin_Replica
        KIKKLIX_LONGLEGS_PH      = {[17547406] = 17547407}, -- Vanguard_Shaman
        KARASHIX_SWOLLENSKULL_PH      = {[17547419] = 17547424}, -- Vanguard_Welldigger
        RUTRIX_HAMGAM_PHS      = {[17547452] = 17547454}, -- Vanguard_Dragontamer
        SNYPESTIX_EAGLEBEAK_PH      = {[17547467] = 17547468}, -- Goblin_Statue
        ANVILIX_SOOTWRISTS_PH      = {[17547471] = 17547472}, -- Vanguard_Welldigger
        BOOTRIX_JAGGEDELBOW_PH      = {[17547470] = 17547473}, -- Vanguard_Pitfighter
        MOBPIX_MUCOUSMOUTH_PH      = {[17547469] = 17547474}, -- Vanguard_Smithy
        DISTILIX_STICKYTOES_PH      = {[17547475] = 17547478}, -- Vanguard_Alchemist
        EREMIX_SNOTTYNOSTRIL_PH      = {[17547466] = 17547479}, -- Vanguard_Hitman
        CLOKTIX_LONGNAIL_PH      = {[17547289] = 17547294}, -- Vanguard_Armorer
        JABBROX_GRANNYGUISE_PH      = {[17547265] = 17547480}, -- Goblin_Golem
        SCRUFFIX_SHAGGYCHEST_PH      = {[17547266] = 17547485}, -- Vanguard_Smithy
        BLAZOX_BONEYBOD_PH      = {[17547267] = 17547487}, -- Vanguard_Welldigger
        PROWLOX_BARRELBELLY_PH      = {[17547268] = 17547490}, -- Vanguard_Pathfinder
        MORTILOX_WARTPAWS_PH      = {[17547270] = 17547438}, -- Vanguard_Shaman
        SLYSTIX_MEGAPEEPERS_PH      = {[17547286] = 17547492}, -- Vanguard_Necromancer
        TYMEXOX_NINEFINGERS_PH      = {[17547288] = 17547486}, -- Vanguard_Ronin
        GABBLOX_MAGPIETONGUE_PH    = {[17547276] = 17547277}, -- Vanguard_Hitman

    },
    npc =
    {
        QM =
        {
            [17547509] =
            {
                param = {3356, 3419, 3420, 3421, 3422, 3423},
                trade =
                {
                    {item = 3356,                           mob = 17547265}, -- Goblin Golem
                    {item = {3419, 3420, 3421, 3422, 3423}, mob = 17547499}, -- Arch Goblin Golem
                }
            },
            [17547510] = {trade = {{item = 3392, mob = 17547493}}}, -- Quicktrix Hexhands
            [17547511] = {trade = {{item = 3393, mob = 17547494}}}, -- Feralox Honeylips
            [17547512] = {trade = {{item = 3394, mob = 17547496}}}, -- Scourquix Scaleskin
            [17547513] = {trade = {{item = 3395, mob = 17547498}}}, -- Wilywox Tenderpalm
        },
    },
}

return zones[tpz.zone.DYNAMIS_JEUNO]
