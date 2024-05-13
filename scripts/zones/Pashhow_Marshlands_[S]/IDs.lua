-----------------------------------
-- Area: Pashhow_Marshlands_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.PASHHOW_MARSHLANDS_S] =
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
        FISHING_MESSAGE_OFFSET  = 7146, -- You can't fish here.
        THERE_IS_NO_REPONSE     = 7672, -- There is no response...
        ALREADY_OBTAINED_TELE   = 7691, -- You already possess the gate crystal for this telepoint.
        COMMON_SENSE_SURVIVAL   = 9071, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        ANNM_TREASURE_APPEARED  = 8029, -- A treasure box has/Treasure boxes have appeared! The treasure will disappear after three minutes have elapsed or when the time limit for this battlefield expires, whichever comes first.
        -- Voidwalker
        VOIDWALKER_NO_MOB        = 8034, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 8035, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 8036, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 8037, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 8038, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 8039, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 8040, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 8041, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 8042, -- Obtained key item: ≺abyssite>!
    },
    mob =
    {
        SUGAAR_PH =
        {
            -- [17145862] = 17145867, -- -412.599 24.437 -431.639
            -- [17145863] = 17145867, -- -455.311 24.499 -472.247
            -- [17145864] = 17145867, -- -446.738 24.499 -443.850
            [17145865] = 17145867, -- -417.691 23.840 -485.922
            -- [17145866] = 17145867, -- -444.380 24.499 -487.828
        },
        NOMMO_PH =
        {
            [17146007] = 17146012, -- -168.292 24.499 396.933
            -- [17146008] = 17146012, -- -165.745 24.499 349.06
        },
        KINEPIKWA = 17146147,
        VOIDWALKER  =
        {
            [tpz.keyItem.CLEAR_ABYSSITE] = {
                17146186, -- Globster
                17146185, -- Globster
                17146184, -- Globster
                17146183, -- Globster
                17146182,  -- Ground Guzzler
                17146181,  -- Ground Guzzler
                17146180,  -- Ground Guzzler
                17146179,  -- Ground Guzzler
            },
            [tpz.keyItem.COLORFUL_ABYSSITE] = {
                17146178, -- Lamprey Lord
                17146177, -- Shoggoth
            },
            [tpz.keyItem.ORANGE_ABYSSITE] = {
                17146170  -- Blobdingnag
            },
            [tpz.keyItem.BLACK_ABYSSITE] = {
                17146169  -- Yilbegan
            }
        }
    },
    pet = 
    {
        [17146170] = -- Blobdingnag
        {
            17146176,-- Septic Boils
            17146175,-- Septic Boils
            17146174,-- Septic Boils
            17146173,-- Septic Boils
            17146172,-- Septic Boils
            17146171,-- Septic Boils
        },
    },
    npc =
    {
        INDESCRIPT_MARKINGS_OFFSET = 17146626,
    },
}

return zones[tpz.zone.PASHHOW_MARSHLANDS_S]
