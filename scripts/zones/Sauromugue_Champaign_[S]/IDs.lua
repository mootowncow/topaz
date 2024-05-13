-----------------------------------
-- Area: Sauromugue_Champaign_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SAUROMUGUE_CHAMPAIGN_S] =
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
        COMMON_SENSE_SURVIVAL   = 10055, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        ANNM_TREASURE_APPEARED  = 8517, -- A treasure box has/Treasure boxes have appeared! The treasure will disappear after three minutes have elapsed or when the time limit for this battlefield expires, whichever comes first.
        -- Voidwalker
        VOIDWALKER_NO_MOB        = 8662, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 8663, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 8664, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 8665, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 8666, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 8667, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 8668, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 8669, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 8670, -- Obtained key item: ≺abyssite>!    
    },
    mob =
    {
        BALAM_QUITZ_PH =
        {
            [17178778] = 17178803, -- 481.509 24.184 98.264
        },
        COQUECIGRUE = 17178689,
        VOIDWALKER        =
        {
            [tpz.keyItem.CLEAR_ABYSSITE] = {
                17178932,  -- Lacus
                17178931,  -- Thunor
                17178930, -- Beorht
                17178929, -- Pruina
                17178928,  -- Puretos
                17178927,  -- Eorthe
                17178926, -- Deorc
                17178925, -- Aither
            },
            [tpz.keyItem.COLORFUL_ABYSSITE] = {
                17178924, -- Skuld
                17178923  -- Urd
            },
            [tpz.keyItem.YELLOW_ABYSSITE] = {
                17178922  -- Verthandi
            },
            [tpz.keyItem.BLACK_ABYSSITE] = {
                17178921  -- Yilbegan
            }
        }
    },
    npc =
    {
    },
}

return zones[tpz.zone.SAUROMUGUE_CHAMPAIGN_S]
