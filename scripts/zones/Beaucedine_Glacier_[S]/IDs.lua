-----------------------------------
-- Area: Beaucedine_Glacier_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.BEAUCEDINE_GLACIER_S] =
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
        COMMON_SENSE_SURVIVAL   = 8687, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        -- Voidwalker
        VOIDWALKER_NO_MOB        = 8654, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 8655, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 8656, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 8657, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 8658, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 8659, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 8660, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 8661, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OPTAIN_KI     = 8662, -- Obtained key item: ≺abyssite>!   
    },
    mob =
    {
        GRANDGOULE_PH =
        {
            -- [17334475] = 17334482,
            -- [17334476] = 17334482,
            [17334477] = 17334482,
        },
        BECUT_PH =
        {
            [17334352] = 17334356,
        },
        VOIDWALKER        =
        {
            [tpz.keyItem.CLEAR_ABYSSITE] = {
                17334561, -- Gorehound
                17334560, -- Gorehound
                17334559, -- Gorehound
                17334558, -- Gorehound
                17334557, -- Gjenganger
                17334556, -- Gjenganger
                17334555, -- Gjenganger
                17334554, -- Gjenganger
            },
            [tpz.keyItem.COLORFUL_ABYSSITE] = {
                17334553, -- Erebus
                17334552  -- Feuerunke
            },
            [tpz.keyItem.PURPLE_ABYSSITE] = {
                17334551  -- Lord Ruthven
            },
            [tpz.keyItem.BLACK_ABYSSITE] = {
                17334550  -- Yilbegan
            }
        }
    },
    npc =
    {
    },
}

return zones[tpz.zone.BEAUCEDINE_GLACIER_S]
