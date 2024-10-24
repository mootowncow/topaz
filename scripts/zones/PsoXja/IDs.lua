-----------------------------------
-- Area: PsoXja
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.PSOXJA] =
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
        CONQUEST_BASE           = 7071, -- Tallying conquest results...
        DEVICE_IN_OPERATION     = 7230, -- The device appears to be in operation...
        DOOR_LOCKED             = 7233, -- The door is locked.
        ARCH_GLOW_BLUE          = 7234, -- The arch above the door is glowing blue...
        ARCH_GLOW_GREEN         = 7235, -- The arch above the door is glowing green...
        CANNOT_OPEN_SIDE        = 7238, -- The door cannot be opened from this side.
        TRAP_FAILS              = 7241, -- <name> examines the door. The trap connected to it fails to activate.
        DISCOVER_DISARM_FAIL    = 7242, -- <name> discovers a trap connected to the door, but fails to disarm it!
        DISCOVER_DISARM_SUCCESS = 7243, -- <name> discovers a trap connected to the door and succeeds in disarming it!
        TRAP_ACTIVATED          = 7245, -- <name> examines the stone compartment. A trap connected to it has been activated!
        SHUT_TIGHTLY            = 7248, -- The door is shut tightly.
        CHEST_UNLOCKED          = 7463, -- You unlock the chest!
        BROKEN_KNIFE            = 7471, -- A broken knife blade can be seen among the rubble...
        HOMEPOINT_SET           = 7476, -- Home point set!
    },
    mob =
    {
        GYRE_CARLIN_PH =
        {
            [16814330] = 16814331,
        },
        GARGOYLE_OFFSET         = 16814081,
        NUNYUNUWI               = 16814361,
        GOLDEN_TONGUED_CULBERRY = 16814432,
        GARGOYLE_IOTA   = 16814231,
        GARGOYLE_KAPPA  = 16814232,
        GARGOYLE_LAMBDA = 16814233,
        GARGOYLE_MU     = 16814234,
    },
    npc =
    {
        STONE_DOOR_OFFSET          = 16814445, -- _090 in npc_list
        TREASURE_CHEST             = 16814557,
    },
}

return zones[tpz.zone.PSOXJA]
