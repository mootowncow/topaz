-----------------------------------
-- Area: East_Ronfaure_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.EAST_RONFAURE_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6388, -- Obtained: <item>.
        GIL_OBTAINED             = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6391, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6402, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS      = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        LOGGING_IS_POSSIBLE_HERE = 7146, -- Logging is possible here if you have <item>.
        FISHING_MESSAGE_OFFSET   = 7730, -- You can't fish here.
        COMMON_SENSE_SURVIVAL    = 8957, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        ANNM_TREASURE_APPEARED   = 8034, -- A treasure box has/Treasure boxes have appeared! The treasure will disappear after three minutes have elapsed or when the time limit for this battlefield expires, whichever comes first.
        -- Voidwalker
        VOIDWALKER_NO_MOB        = 8039, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 8040, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 8041, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 8042, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 8043, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 8044, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 8045, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 8046, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 8047, -- Obtained key item: ≺abyssite>!
    },
    mob =
    {
        GOBLINTRAP_PH =
        {
            [17109295] = 17109296, -- 156 0 -438
        },
        SKOGS_FRU_PH =
        {
            -- [17109268] = 17109338,
            -- [17109306] = 17109338,
            [17109307] = 17109338,
            -- [17109308] = 17109338,
        },
        MYRADROSH    = 17109235,
        VOIDWALKER   =
        {
            [tpz.keyItem.CLEAR_ABYSSITE] = {
                17109393, -- Sunderclaw
                17109392, -- Sunderclaw
                17109391, -- Sunderclaw
                17109390, -- Sunderclaw
                17109389,  -- Quagmire Pugil
                17109388,  -- Quagmire Pugil
                17109387,  -- Quagmire Pugil
                17109386,  -- Quagmire Pugil
            },
            [tpz.keyItem.COLORFUL_ABYSSITE] = {
                17109385, -- Capricornus
                17109384  -- Yacumama
            },
            [tpz.keyItem.BLUE_ABYSSITE] = {
                17109383  -- Krabkatoa
            },
            [tpz.keyItem.BLACK_ABYSSITE] = {
                17109382  -- Yilbegan
            }
        }
    },
    npc =
    {
        LOGGING =
        {
            17109782,
            17109783,
            17109784,
            17109785,
            17109786,
            17109787,
        },
    },
}

return zones[tpz.zone.EAST_RONFAURE_S]
