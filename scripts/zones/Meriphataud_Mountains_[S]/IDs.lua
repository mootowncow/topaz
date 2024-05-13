-----------------------------------
-- Area: Meriphataud_Mountains_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MERIPHATAUD_MOUNTAINS_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY = 6402, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        ALREADY_OBTAINED_TELE   = 7591, -- You already possess the gate crystal for this telepoint.
        THERE_IS_NO_REPONSE     = 7672, -- There is no response...
        COMMON_SENSE_SURVIVAL   = 8940, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        ANNM_TREASURE_APPEARED  = 7902, -- A treasure box has/Treasure boxes have appeared! The treasure will disappear after three minutes have elapsed or when the time limit for this battlefield expires, whichever comes first.
        -- Voidwalker
        VOIDWALKER_NO_MOB        = 7907, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 7908, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 7909, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 7910, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 7911, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 7912, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 7913, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 7914, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 7915, -- Obtained key item: ≺abyssite>!
    },
    mob =
    {
        CENTIPEDAL_CENTRUROIDES_PH =
        {
            [17174708] = 17174709,
        },
        HEMODROSOPHILA_PH =
        {
            [17174681] = 17174682,
        },
        BLOODLAPPER = 17174889,
        VOIDWALKER        =
        {
            [tpz.keyItem.CLEAR_ABYSSITE] = {
                17174917, -- Raker bee
                17174916, -- Raker bee
                17174915, -- Raker bee
                17174914, -- Raker bee
                17174913,  -- Rummager beetle
                17174912,  -- Rummager beetle
                17174911,  -- Rummager beetle
                17174910,  -- Rummager beetle
            },
            [tpz.keyItem.COLORFUL_ABYSSITE] = {
                17174909,  -- Jyeshtha
                17174908, -- Farruca Fly
            },
            [tpz.keyItem.BROWN_ABYSSITE] = {
                17174907  -- Orcus
            },
            [tpz.keyItem.BLACK_ABYSSITE] = {
                17174906  -- Yilbegan
            }
        }
    },
    npc =
    {
        INDESCRIPT_MARKINGS = 17175342,
    },
}

return zones[tpz.zone.MERIPHATAUD_MOUNTAINS_S]
