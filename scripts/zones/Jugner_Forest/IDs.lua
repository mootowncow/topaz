-----------------------------------
-- Area: Jugner_Forest
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.JUGNER_FOREST] =
{
    text =
    {
        NOTHING_HAPPENS          = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6404,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6410,  -- Obtained: <item>.
        GIL_OBTAINED             = 6411,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6413,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6414,  -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET    = 6439,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7021, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7022, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7023, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7071,  -- Tallying conquest results...
        BEASTMEN_BANNER          = 7152,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET   = 7704,  -- You can't fish here.
        DIG_THROW_AWAY           = 7717,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7719,  -- You dig and you dig, but find nothing.
        LOGGING_IS_POSSIBLE_HERE = 7897,  -- Logging is possible here if you have <item>.
        CONQUEST                 = 8048,  -- You've earned conquest points!
        PLAYER_OBTAINS_ITEM      = 8639,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8640,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8641,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8642,  -- You already possess that temporary item.
        NO_COMBINATION           = 8647,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 10852, -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 13081, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        -- Voidwalker
        VOIDWALKER_NO_MOB        = 12070, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 12071, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 12072, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 12073, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 12074, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 12075, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 12076, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 12077, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 12078, -- Obtained key item: ≺abyssite>!
    },
    mob =
    {
        PANZER_PERCIVAL_PH =
        {
            [17203581] = 17203585, -- 535.504 -1.517 152.171 (southeast)
            [17203637] = 17203642, -- 239.541 -0.365 559.722 (northwest)
        },
        SUPPLESPINE_MUJWUJ_PH =
        {
            [17203437] = 17203475,
        },
        FRADUBIO_PH =
        {
            [17203447] = 17203448,
        },
        KING_ARTHRO = 17203216,
        FRAELISSA   = 17203447,
        VOIDWALKER  =
        {
            [tpz.keyItem.CLEAR_ABYSSITE] = {
                17203695, -- Sunderclaw
                17203694, -- Sunderclaw
                17203693, -- Sunderclaw
                17203692, -- Sunderclaw
                17203691,  -- Quagmire Pugil
                17203690,  -- Quagmire Pugil
                17203689,  -- Quagmire Pugil
                17203688,  -- Quagmire Pugil
            },
            [tpz.keyItem.COLORFUL_ABYSSITE] = {
                17203687, -- Capricornus
                17203686  -- Yacumama
            },
            [tpz.keyItem.BLUE_ABYSSITE] = {
                17203685  -- Krabkatoa
            },
            [tpz.keyItem.BLACK_ABYSSITE] = {
                17203684  -- Yilbegan
            }
        }
    },
    npc =
    {
        CASKET_BASE   = 17203786,
        OVERSEER_BASE = 17203848,
        LOGGING =
        {
            17203864,
            17203865,
            17203866,
            17203867,
            17203868,
            17203869,
        },
    },
}

return zones[tpz.zone.JUGNER_FOREST]
