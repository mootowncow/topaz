-----------------------------------
-- Area: Ship_bound_for_Mhaura
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SHIP_BOUND_FOR_MHAURA] =
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
        FISHING_MESSAGE_OFFSET  = 7230, -- You can't fish here.
        ON_WAY_TO_MHAURA        = 7331, -- We're on our way to Mhaura. We should be there in [less than an hour/about 1 hour/about 2 hours/about 3 hours/about 4 hours/about 5 hours/about 6 hours/about 7 hours] (# [minute/minutes] in Earth time).
        DOCKING_IN_MHAURA       = 7332, -- We are now docking in Mhaura.
        NEARING_MHAURA          = 7333, -- We are nearing Mhaura.
        LOKHONG_SHOP_DIALOG     = 7336, -- There's nothing like fishing to pass the time!
        CHHAYA_SHOP_DIALOG      = 7337, -- May I offer you items to help you on your journey?
        ARRIVING_SOON_MHAURA    = 7338, -- We are on our way to Mhaura. We will be arriving soon.
    },
    mob =
    {
        SEA_CREATURES =
        {
            17682437,   -- Sea Monk 1
            17682438,   -- Sea Crab 1
            17682439,   -- Sea Crab 2
            17682440,   -- Sea Pugil 1
            17682441,   -- Sea Pugil 2
            17682442,   -- Sea Monk 2
        },
        SEA_HORROR = 17682446,
        PHANTOM = 17682443,
    },
    npc =
    {
    },
}

return zones[tpz.zone.SHIP_BOUND_FOR_MHAURA]
