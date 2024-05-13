-----------------------------------
-- Area: North_Gustaberg_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.NORTH_GUSTABERG_S] =
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
        LYCOPODIUM_ENTRANCED    = 7056, -- The lycopodium is entranced by a sparkling light...
        FISHING_MESSAGE_OFFSET  = 7355, -- You can't fish here.
        MINING_IS_POSSIBLE_HERE = 7544, -- Mining is possible here if you have <item>.
        COMMON_SENSE_SURVIVAL   = 9076, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        CANNOT_ENTER            = 7719, -- You cannot enter at this time. Please wait a moment and try again.
        ANNM_TREASURE_APPEARED  = 8171, -- A treasure box has/Treasure boxes have appeared! The treasure will disappear after three minutes have elapsed or when the time limit for this battlefield expires, whichever comes first.
        -- Voidwalker
        VOIDWALKER_NO_MOB        = 8176, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 8177, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 8178, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 8179, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 8180, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 8181, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 8182, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 8183, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 8184, -- Obtained key item: ≺abyssite>!
    },
    mob =
    {
        ANKABUT_PH =
        {
            [17137701] = 17137705, -- 656.399 -11.580 507.091
        },
        GLOOMANITA_PH =
        {
            [17137820] = 17137821, -- -19.961 0.5 623.989
        },
        VOIDWALKER  =
        {
            [tpz.keyItem.CLEAR_ABYSSITE] = {
                17138086, -- Globster
                17138085, -- Globster
                17138084, -- Globster
                17138083, -- Globster
                17138082,  -- Ground Guzzler
                17138081,  -- Ground Guzzler
                17138080,  -- Ground Guzzler
                17138079,  -- Ground Guzzler
            },
            [tpz.keyItem.COLORFUL_ABYSSITE] = {
                17138078, -- Lamprey Lord
                17138077,  -- Shoggoth
            },
            [tpz.keyItem.ORANGE_ABYSSITE] = {
                17138070  -- Blobdingnag
            },
            [tpz.keyItem.BLACK_ABYSSITE] = {
                17138069  -- Yilbegan
            }
        }
    },
    pet = 
    {
        [17138070] = -- Blobdingnag
        {
            17138076,-- Septic Boils
            17138075,-- Septic Boils
            17138074,-- Septic Boils
            17138073,-- Septic Boils
            17138072,-- Septic Boils
            17138071,-- Septic Boils
        },
    },
    npc =
    {
        MINING =
        {
            17138511,
            17138512,
            17138513,
            17138514,
            17138515,
            17138516,
        },
    },
}

return zones[tpz.zone.NORTH_GUSTABERG_S]
