-----------------------------------
-- Area: Qufim_Island
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.QUFIM_ISLAND] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED        = 6382,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6388,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6389,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6391,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6392,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY        = 6402,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET          = 6417,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                   = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                  = 7049,  -- Tallying conquest results...
        BEASTMEN_BANNER                = 7130,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET         = 7208,  -- You can't fish here.
        THESE_WITHERED_FLOWERS         = 7328,  -- These withered flowers seem unable to bloom.
        NOW_THAT_NIGHT_HAS_FALLEN      = 7329,  -- Now that night has fallen, the flowers bloom with a strange glow.
        CONQUEST                       = 7377,  -- You've earned conquest points!
        AN_EMPTY_LIGHT_SWIRLS          = 7736,  -- An empty light swirls about the cave, eating away at the surroundings...
        GIGANTIC_FOOTPRINT             = 7820,  -- There is a gigantic footprint here.
        DYNA_NPC_DEFAULT_MESSAGE       = 7834,  -- You hear a mysterious, floating voice: Bring forth the <item>...
        YOU_CANNOT_ENTER_DYNAMIS       = 7846,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7848,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        PLAYER_OBTAINS_ITEM            = 8044,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8045,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8046,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8047,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8052,  -- You were unable to enter a combination.
        REGIME_REGISTERED              = 10328, -- New training regime registered!
        COMMON_SENSE_SURVIVAL          = 12653, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        CONF_TOO_FAR                   = 8076, -- You have ventured too far from the field of battle. The Confrontation will automatically disengage if you do not return
        CONF_DISENAGED                 = 8077, -- Ventured too far, confrontation has disengaged.
        CONF_REENGAGED                 = 8078, -- You have returned to the field of battle.
        CONF_BATTLE_BEGIN              = 8079, -- You have x earth time to complete the battle.
        CONF_MIN_REMAINING             = 8080, -- X earth minutes remaining to complete the battle.
        CONF_SEC_REMAINING             = 8081, -- x earth seconds remaining to complete the battle.
        CONF_TIME_UP                   = 8082, -- Your time for this Confrontation is up...
    },
    mob =
    {
        SLIPPERY_SUCKER_PH =
        {
            [17293376] = 17293389,
            [17293377] = 17293389,
            [17293378] = 17293389,
            [17293380] = 17293389,
        },
        TRICKSTER_KINETIX_PH =
        {
            [17293533] = 17293537, -- -138.180 -20.928 228.793
            [17293534] = 17293537, -- -157.659 -25.501 235.862
            [17293535] = 17293537, -- -152.269 -20 243
            [17293536] = 17293537, -- -137.651 -23.507 231.528
        },
        OPHIOTAURUS = 17293666
    },
    npc =
    {
        CASKET_BASE   = 17293678,
        OVERSEER_BASE = 17293716,
    },
}

return zones[tpz.zone.QUFIM_ISLAND]
