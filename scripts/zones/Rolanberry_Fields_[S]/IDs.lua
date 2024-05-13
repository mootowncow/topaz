-----------------------------------
-- Area: Rolanberry_Fields_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ROLANBERRY_FIELDS_S] =
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
        FISHING_MESSAGE_OFFSET  = 7069, -- You can't fish here.
        COMMON_SENSE_SURVIVAL   = 9249, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        CANNOT_ENTER            = 7700, -- You cannot enter at this time. Please wait a moment and try again.    
        ANNM_TREASURE_APPEARED  = 8023, -- A treasure box has/Treasure boxes have appeared! The treasure will disappear after three minutes have elapsed or when the time limit for this battlefield expires, whichever comes first.
        --Voidwalker
        VOIDWALKER_NO_MOB        = 8036, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 8037, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 8038, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 8039, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 8040, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 8041, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 8042, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 8043, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 8044, -- Obtained key item: ≺abyssite>!   
    },
    mob =
    {
        DELICIEUSE_DELPHINE_PH =
        {
            [17150279] = 17150280, -- -484.535 -23.756 -467.462
        },
        DYINYINGA_PH =
        {
            [17150045] = 17150047, -- -484.535 -23.756 -467.462
        },
        ERLE_PH =
        {
            [17150075] = 17150081, -- -484.535 -23.756 -467.462
        },
        VOIDWALKER        =
        {
            [tpz.keyItem.CLEAR_ABYSSITE] = {
                17150346,  -- Lacus
                17150345,  -- Thunor
                17150344, -- Beorht
                17150343, -- Pruina
                17150342,  -- Puretos
                17150341,  -- Eorthe
                17150340, -- Deorc
                17150339, -- Aither
            },
            [tpz.keyItem.COLORFUL_ABYSSITE] = {
                17150338, -- Skuld
                17150337  -- Urd
            },
            [tpz.keyItem.YELLOW_ABYSSITE] = {
                17150336  -- Verthandi
            },
            [tpz.keyItem.BLACK_ABYSSITE] = {
                17150335  -- Yilbegan
            }
        }
    },
    npc =
    {
    },
}

return zones[tpz.zone.ROLANBERRY_FIELDS_S]
