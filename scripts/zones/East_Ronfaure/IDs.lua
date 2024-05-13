-----------------------------------
-- Area: East_Ronfaure
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.EAST_RONFAURE] =
{
    text =
    {
        NOTHING_HAPPENS          = 141,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6404, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6410, -- Obtained: <item>.
        GIL_OBTAINED             = 6411, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6413, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6424, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6439, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7021, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7022, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7023, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7071, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7230, -- You can't fish here.
        DIG_THROW_AWAY           = 7243, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7245, -- You dig and you dig, but find nothing.
        RAYOCHINDOT_DIALOG       = 7410, -- If you are outmatched, run to the city as quickly as you can.
        CROTEILLARD_DIALOG       = 7411, -- Sorry, no chatting while I'm on duty.
        CHEVAL_RIVER_WATER       = 7436, -- You fill your waterskin with water from the river. You now have <item>.
        BLESSED_WATERSKIN        = 7455, -- To get water, trade the waterskin you hold with the river.
        LOGGING_IS_POSSIBLE_HERE = 7486, -- Logging is possible here if you have <item>.
        PLAYER_OBTAINS_ITEM      = 7497, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7498, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7499, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7500, -- You already possess that temporary item.
        NO_COMBINATION           = 7505, -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9865, -- New training regime registered!
        -- Voidwalker
        VOIDWALKER_NO_MOB        = 11038, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 11039, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 11040, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 11041, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 11042, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 11043, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 11044, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 11045, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 11046, -- Obtained key item: ≺abyssite>!
    },
    mob =
    {
        BIGMOUTH_BILLY_PH =
        {
            [17191194] = 17191196, -- 453.625 -18.436 -127.048
            [17191142] = 17191196, -- 403.967 -36.822 -16.285
            [17191143] = 17191196, -- 413.229 -38.467 7.047
        },
        SWAMFISK_PH       =
        {
            [17191289] = 17191189, -- 461.268 -6.674 -391.342
            [17191290] = 17191189, -- 459.345 -6.686 -363.842
            [17191287] = 17191189, -- 443.334 -17.000 -303.275
            [17191288] = 17191189, -- 423.000 -16.000 -285.000
            [17191188] = 17191189, -- 417.542 -17.210 -177.883
            [17191187] = 17191189, -- 379.120 -27.898 -46.436
            [17191019] = 17191189, -- 373.619 -37.093 8.811
        },
        VOIDWALKER        =
        {
            [tpz.keyItem.CLEAR_ABYSSITE] = {
                17191334, -- Sunderclaw
                17191333, -- Sunderclaw
                17191332, -- Sunderclaw
                17191331, -- Sunderclaw
                17191330,  -- Quagmire Pugil
                17191329,  -- Quagmire Pugil
                17191328,  -- Quagmire Pugil
                17191327,  -- Quagmire Pugil
            },
            [tpz.keyItem.COLORFUL_ABYSSITE] = {
                17191326, -- Capricornus
                17191325  -- Yacumama
            },
            [tpz.keyItem.BLUE_ABYSSITE] = {
                17191324  -- Krabkatoa
            },
            [tpz.keyItem.BLACK_ABYSSITE] = {
                17191323  -- Yilbegan
            }
        }
    },
    npc =
    {
        CASKET_BASE = 17191482,
        LOGGING =
        {
            17191530,
            17191531,
            17191532,
            17191533,
            17191534,
            17191535,
        },
    },
}

return zones[tpz.zone.EAST_RONFAURE]
