-----------------------------------
-- Area: Walk_of_Echoes
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.WALK_OF_ECHOES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        KEYITEM_LOST            = 6392, -- Lost <key item>
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 7049, -- Tallying conquest results...
        DOOR_SHUT               = 7311, -- The door is sealed shut with an evil curse.
        CAIT_ENGAGE             = 7766, -- Don't hold back
        CAIT_TAUNT1             = 7767, -- All it takes is a flash and a howl, and you'll be on your knees! Bowing in supplication! Prepare yourself
        CAIT_CHAINSPELL         = 7768, -- Eddies of magic, swirl and consume! I hope you know how to hold your breath! Hehehe!
        CAIT_TAUNT2             = 7769, -- Maybe I'm not playing fair, but a little stickiness can go a long way! Let's see how long you stay standing!
        CAIT_LOWHP              = 7770, -- Playtime's over! Time for the grand finale! Bring down the curtain! Show me what you're made of, Champion
        CAIT_DEAD               = 7771, -- Well...done
        CAITSITH_UNLOCKED       = 8124, -- You have gained the ability to summon Cait Sith!
        MIN_COMPLETE_OBJECTIVE  = 7230,
        CANT_ENTER_BF_NO_KI     = 7234,
        ALL_MEMBERS_FALLEN      = 7241,
        CANT_OPEN_CHEST         = 7242,
        ALL_ENEMIES_VANQUISHED  = 7243,
        EXITING_IN              = 7245,
        WALK_NOW_ENDOWED        = 7277,
        VANQUISHED_ALL_FOES     = 7281,
        NOT_CLEARED_EXITING_BF  = 7307,

    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.WALK_OF_ECHOES]
