-----------------------------------
-- Area: Meriphataud_Mountains
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.MERIPHATAUD_MOUNTAINS] =
{
    text =
    {
        NOTHING_HAPPENS          = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6404,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6410,  -- Obtained: <item>.
        GIL_OBTAINED             = 6411,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6413,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6414,  -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET    = 6439,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7021, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7022, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7023, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7071,  -- Tallying conquest results...
        BEASTMEN_BANNER          = 7152,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET   = 7230,  -- You can't fish here.
        DIG_THROW_AWAY           = 7243,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7245,  -- You dig and you dig, but find nothing.
        NOTHING_FOUND            = 7488,  -- You find nothing.
        CONQUEST                 = 7900,  -- You've earned conquest points!
        ITEMS_ITEMS_LA_LA        = 8274,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY      = 8280,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM      = 8337,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8338,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8339,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8340,  -- You already possess that temporary item.
        NO_COMBINATION           = 8345,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 10585, -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 12614, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        -- Voidwalker
        VOIDWALKER_NO_MOB        = 11704, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 11705, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 11706, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 11707, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 11708, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 11709, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 11710, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 11711, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 11712, -- Obtained key item: ≺abyssite>!
    },
    mob =
    {
        NAA_ZEKU_THE_UNWAITING_PH =
        {
            [17264763] = 17264768,
        },
        PATRIPATAN_PH       =
        {
            [17264967] = 17264972, -- 551.767, -32.570, 590.205
            [17264968] = 17264972, -- 646.199, -24.483, 644.477
            [17264969] = 17264972, -- 535.318, -32.179, 602.055
        },
        DAGGERCLAW_DRACOS_PH =
        {
            [17264815] = 17264818, -- 583.725 -15.652 -388.159
        },
        WARAXE_BEAK         = 17264828,
        COO_KEJA_THE_UNSEEN = 17264946,
        VOIDWALKER        =
        {
            [tpz.keyItem.CLEAR_ABYSSITE] = {
                17265129, -- Raker bee
                17265128, -- Raker bee
                17265127, -- Raker bee
                17265126, -- Raker bee
                17265125,  -- Rummager beetle
                17265124,  -- Rummager beetle
                17265123,  -- Rummager beetle
                17265122,  -- Rummager beetle
            },
            [tpz.keyItem.COLORFUL_ABYSSITE] = {
                17265121,  -- Jyeshtha
                17265120, -- Farruca Fly
            },
            [tpz.keyItem.BROWN_ABYSSITE] = {
                17265119  -- Orcus
            },
            [tpz.keyItem.BLACK_ABYSSITE] = {
                17265118  -- Yilbegan
            }
        }
    },
    npc =
    {
        CASKET_BASE   = 17265219,
        OVERSEER_BASE = 17265271,
    },
}

return zones[tpz.zone.MERIPHATAUD_MOUNTAINS]
