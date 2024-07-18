-----------------------------------
-- Area: Lufaise_Meadows
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.LUFAISE_MEADOWS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED     = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6388, -- Obtained: <item>.
        GIL_OBTAINED                = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6391, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                = 6392, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY     = 6402, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET       = 6417, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS         = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE               = 7049, -- Tallying conquest results...
        CONQUEST                    = 7217, -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET      = 7551, -- You can't fish here.
        KI_STOLEN                   = 7680, -- The <keyitem> has been stolen!
        LOGGING_IS_POSSIBLE_HERE    = 7728, -- Logging is possible here if you have <item>.
        SURVEY_THE_SURROUNDINGS     = 7735, -- You survey the surroundings but see nothing out of the ordinary.
        MURDEROUS_PRESENCE          = 7736, -- Wait, you sense a murderous presence...!
        YOU_CAN_SEE_FOR_MALMS       = 7737, -- You can see for malms in every direction.
        SPINE_CHILLING_PRESENCE     = 7739, -- You sense a spine-chilling presence!
        KURREA_SLURPS_SOUP     		= 7785, -- Kurrea slurps down the adamantoise soup!
		KURREA_MUSCLES_BULGE     	= 7786, -- Kurrea's muscles bulge crazily!
		KURREA_SCALES_SHINE     	= 7787, -- Kurrea's scales shine mysteriously!
		KURREA_FIERCE_WIND     		= 7788, -- Kurrea is enveloped by a fierce wind!
		KURREA_HIDE_RIGID     		= 7789, -- Kurrea's hide grows rigid!
		KURREA_VEINS_POPPING     	= 7790, -- The veins in Kurrea's head are popping out!
		KURREA_EYES_GLOW     		= 7791, -- Kurrea's eyes glow weirdly!
		KURREA_WOUNDS_DISAPPEAR     = 7792, -- Kurrea's wounds disappear!
		KURREA_OMINOUS_AURA     	= 7793, -- Kurrea is surrounded by an ominous aura!
		KURREA_FACE_GREEN     	    = 7794, -- Kurrea's face has turned green...
        COMMON_SENSE_SURVIVAL       = 8734, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        CONF_TOO_FAR                = 8760, -- You have ventured too far from the field of battle. The Confrontation will automatically disengage if you do not return
        CONF_DISENAGED              = 8761, -- Ventured too far, confrontation has disengaged.
        CONF_REENGAGED              = 8762, -- You have returned to the field of battle.
        CONF_BATTLE_BEGIN           = 8763, -- You have x earth time to complete the battle.
        CONF_MIN_REMAINING          = 8764, -- X earth minutes remaining to complete the battle.
        CONF_SEC_REMAINING          = 8765, -- x earth seconds remaining to complete the battle.
        CONF_TIME_UP                = 8766, -- Your time for this Confrontation is up...
    },
    mob =
    {
        PADFOOT               =
        {
            16875552, -- !pos -43.689 0.487 -328.028
            16875578, -- !pos 260.445 -1.761 -27.862
            16875615, -- !pos 412.447 -0.057 -200.161
            16875703, -- !pos -378.950 -15.742 144.215
            16875748, -- !pos -141.523 -15.529 91.709
        },
        MEGALOBUGARD_PH       =
        {
            [16875720] = 16875741, -- -137.168 -15.390 91.016
        },
        LESHY_OFFSET          = 16875754,
        COLORFUL_LESHY        = 16875762,
        SPLINTERSPINE_GRUKJUK = 16875774,
        KURREA                = 16875778,
        AMALTHEIA             = 16875779,
    },
    npc =
    {
        OVERSEER_BASE = 16875865, -- Jemmoquel_RK in npc_list
        LOGGING       =
        {
            16875883,
            16875884,
            16875885,
            16875886,
            16875887,
            16875888,
        },
    },
}

return zones[tpz.zone.LUFAISE_MEADOWS]
