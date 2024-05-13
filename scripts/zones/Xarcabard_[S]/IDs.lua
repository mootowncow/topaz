-----------------------------------
-- Area: Xarcabard_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.XARCABARD_S] =
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
        HOMEPOINT_SET           = 8748, -- Home point set!
        -- Voidwalker
        VOIDWALKER_NO_MOB        = 8568, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 8569, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 8570, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 8571, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 8572, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 8573, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 8574, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 8575, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 8576, -- Obtained key item: ≺abyssite>!  
    },
    mob =
    {
        GRAOULLY_PH =
        {
            [17338384] = 17338386,
        },
        PRINCE_OROBAS_PH =
        {
            [17338457] = 17338462,
        },
        VOIDWALKER        =
        {
            [tpz.keyItem.CLEAR_ABYSSITE] = {
                17338607, -- Gorehound
                17338606, -- Gorehound
                17338605, -- Gorehound
                17338604, -- Gorehound
                17338603, -- Gjenganger
                17338602, -- Gjenganger
                17338601, -- Gjenganger
                17338600, -- Gjenganger
            },
            [tpz.keyItem.COLORFUL_ABYSSITE] = {
                17338599, -- Erebus
                17338598  -- Feuerunke
            },
            [tpz.keyItem.PURPLE_ABYSSITE] = {
                17338597  -- Lord Ruthven
            },
            [tpz.keyItem.BLACK_ABYSSITE] = {
                17338596  -- Yilbegan
            }
        }
    },
    npc =
    {
    },
}

return zones[tpz.zone.XARCABARD_S]
