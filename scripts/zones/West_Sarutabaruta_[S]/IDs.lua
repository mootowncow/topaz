-----------------------------------
-- Area: West_Sarutabaruta_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.WEST_SARUTABARUTA_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED     = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6388, -- Obtained: <item>.
        GIL_OBTAINED                = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS         = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        HARVESTING_IS_POSSIBLE_HERE = 7069, -- Harvesting is possible here if you have <item>.
        FISHING_MESSAGE_OFFSET      = 7076, -- You can't fish here.
        DOOR_OFFSET                 = 7434, -- The door is sealed shut...
        COMMON_SENSE_SURVIVAL       = 9258, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        ANNM_TREASURE_APPEARED      = 8002, -- A treasure box has/Treasure boxes have appeared! The treasure will disappear after three minutes have elapsed or when the time limit for this battlefield expires, whichever comes first.
        -- Voidwalker
        VOIDWALKER_NO_MOB        = 8358, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 8359, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 8360, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 8361, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 8362, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 8363, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 8364, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 8365, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 8366, -- Obtained key item: ≺abyssite>!
    },
    mob =
    {
        JEDUAH_PH =
        {
            [17166542] = 17166543, -- 113.797 -0.8 -310.342
        },
        RAMPONNEAU_PH =
        {
            [17166701] = 17166705, -- 78.836 -0.109 -199.204
        },
        VOIDWALKER        =
        {
            [tpz.keyItem.CLEAR_ABYSSITE] = {
                17166778, -- Raker bee
                17166777, -- Raker bee
                17166776, -- Raker bee
                17166775, -- Raker bee
                17166774,  -- Rummager beetle
                17166773,  -- Rummager beetle
                17166772,  -- Rummager beetle
                17166771,  -- Rummager beetle
            },
            [tpz.keyItem.COLORFUL_ABYSSITE] = {
                17166770,  -- Jyeshtha
                17166769, -- Farruca Fly
            },
            [tpz.keyItem.BROWN_ABYSSITE] = {
                17166768  -- Orcus
            },
            [tpz.keyItem.BLACK_ABYSSITE] = {
                17166767  -- Yilbegan
            }
        }
    },
    npc =
    {
        HARVESTING =
        {
            17167162,
            17167163,
            17167164,
            17167165,
            17167166,
            17167167,
        },
    },
}

return zones[tpz.zone.WEST_SARUTABARUTA_S]
