-----------------------------------
--
--    Functions for Shop system
--
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/items")
-----------------------------------

-----------------------------------
-- IDs for Curio Vendor Moogle
-----------------------------------

curio =
{
    ["medicine"]        = 1,
    ["ammunition"]      = 2,
    ["ninjutsuTools"]   = 3,
    ["foodStuffs"]      = 4,
    ["scrolls"]         = 5,
    ["keys"]            = 6,
    -- keyitems not implemented yet
}

tpz = tpz or {}

tpz.shop =
{
    --[[ *******************************************************************************
        send general shop dialog to player
        stock cuts off after 16 items. if you add more, extras will not display
        stock is of form {itemId1, price1, itemId2, price2, ...}
        log is a log ID from scripts/globals/log_ids.lua
    ******************************************************************************* --]]
    general = function(player, stock, log)
        local priceMultiplier = 1

        if log then
            priceMultiplier = (1 + (0.120 * (9 - player:getFameLevel(log)) / 8)) * SHOP_PRICE   -- changed from 0.2
        else
            log = -1
        end

        player:createShop(#stock / 2, log)

        for i = 1, #stock, 2 do
            player:addShopItem(stock[i], stock[i+1] * priceMultiplier)
        end

        player:sendMenu(2)
    end,

    --[[ *******************************************************************************
        send general guild shop dialog to player (Added on June 2014 QoL)
        stock is of form {itemId1, price1, guildID, guildRank, ...}
        log is default set to -1 as it's needed as part of createShop()
    ******************************************************************************* --]]
    generalGuild = function(player, stock, guildSkillId)
        local log = -1     -- changed from -1

        player:createShop(#stock / 3, log)      -- changed from / 3

        for i = 1, #stock, 3 do
            player:addShopItem(stock[i], stock[i+1], guildSkillId, stock[i+2])
        end

        player:sendMenu(2)
    end,

     --[[ *******************************************************************************
           On trigger to check nation rank
    ******************************************************************************* --]]   
    curioVendorMoogleOnTrigger = function(player)
        local unlocks =
        {
            {   2, tpz.ki.RHAPSODY_IN_WHITE    },
            {   4, tpz.ki.RHAPSODY_IN_UMBER    },
            {   7, tpz.ki.RHAPSODY_IN_AZURE    },
            {   8, tpz.ki.RHAPSODY_IN_CRIMSON  },
            {   9, tpz.ki.RHAPSODY_IN_EMERALD  },
            {  10, tpz.ki.RHAPSODY_IN_MAUVE    },
        }
        local playerRank = player:getRank()
        local ID = zones[player:getZoneID()]

        for _, rank in pairs(unlocks) do
            if (rank[1] <= playerRank) then
                if not player:hasKeyItem(rank[2]) then
                    player:addKeyItem(rank[2])
                    player:messageSpecial(ID.text.KEYITEM_OBTAINED, rank[2])
                    player:PrintToPlayer("Oooooh! You're already rank " .. playerRank .. "? I have a new gift for you then, adventurer!",0,"Curio Moogle")
                end
            end
        end
    end,

    --[[ *******************************************************************************
        send curio vendor moogle shop shop dialog to player
        stock is of form {itemId1, price1, keyItemRequired, ...}
        log is default set to -1 as it's needed as part of createShop()
    ******************************************************************************* --]]
    curioVendorMoogle = function(player, stock)
        local log = -1

        player:createShop(#stock / 3, log)

        for i = 1, #stock, 3 do
            if player:hasKeyItem(stock[i+2]) then
                player:addShopItem(stock[i], stock[i+1])
            end
        end

        player:sendMenu(2)
    end,

    --[[ *******************************************************************************
        send nation shop dialog to player
        stock cuts off after 16 items. if you add more, extras will not display
        stock is of form {itemId1, price1, place1, itemId2, price2, place2, ...}
            where place is what place the nation must be in for item to be stocked
        nation is a tpz.nation ID from scripts/globals/zone.lua
    ******************************************************************************* --]]
    nation = function(player, stock, nation)
        local rank = getNationRank(nation)
        local newStock = {}
        for i = 1, #stock, 3 do
            table.insert(newStock, stock[i])
            table.insert(newStock, stock[i+1])
        end
        tpz.shop.general(player, newStock, nation)
    end,

    --[[ *******************************************************************************
        send outpost shop dialog to player
    ******************************************************************************* --]]
    outpost = function(player)
        local stock =
        {
            4148,  316, -- Antidote
            4151,  800, -- Echo Drops
            4128, 4832, -- Ether
            4150, 2595, -- Eye Drops
            4112,  910, -- Potion
            4153, 1000, -- Antacid
        }
        tpz.shop.general(player, stock, JEUNO)
    end,

    --[[ *******************************************************************************
        send celebratory chest shop dialog to player
    ******************************************************************************* --]]
    celebratory = function(player)
        local stock =
        {
            4167,   30, -- Cracker
            4168,   30, -- Twinkle Shower
            4215,   60, -- Popstar
            4216,   60, -- Brilliant Snow
            4256,   30, -- Ouka Ranman
            4169,   30, -- Little Comet
            5769,  650, -- Popper
            4170, 1000, -- Wedding Bell
            5424, 6000, -- Serene Serinette
            5425, 6000, -- Joyous Serinette
            4441, 1116, -- Grape Juice
            4238, 3000, -- Inferno Crystal
            4240, 3000, -- Cyclone Crystal
            4241, 3000, -- Terra Crystal
        }
        tpz.shop.general(player, stock, JEUNO)
    end,

    --[[ *******************************************************************************
        stock for guild vendors that are open 24/8
    ******************************************************************************* --]]
    generalGuildStock =
    {
        [tpz.skill.COOKING] =
        {
                 936,      16,      tpz.craftRank.AMATEUR,      -- Rock Salt
                4509,      12,      tpz.craftRank.AMATEUR,      -- Distilled Water


        },
        [tpz.skill.CLOTHCRAFT] =
        {
                2128,      75,      tpz.craftRank.AMATEUR,      -- Spindle
                2145,      75,      tpz.craftRank.AMATEUR,      -- Zephyr Thread
                 833,      20,      tpz.craftRank.AMATEUR,      -- Moko Grass


        },
        [tpz.skill.GOLDSMITHING] =
        {
                2144,      75,      tpz.craftRank.AMATEUR,      -- Workshop Anvil
                2143,      75,      tpz.craftRank.AMATEUR,      -- Mandrel


        },
        [tpz.skill.WOODWORKING] =
        {
                1657,     100,      tpz.craftRank.AMATEUR,      -- Bundling Twine

        },
        [tpz.skill.ALCHEMY] =
        {
                2131,      75,      tpz.craftRank.AMATEUR,      -- Triturator


        },
        [tpz.skill.BONECRAFT] =
        {
                2130,      75,      tpz.craftRank.AMATEUR,      -- Shagreen File


        },
        [tpz.skill.LEATHERCRAFT] =
        {
                2129,      75,      tpz.craftRank.AMATEUR,      -- Tanning Vat

        },
        [tpz.skill.SMITHING] =
        {
                2144,      75,      tpz.craftRank.AMATEUR,      -- Workshop Anvil
                2143,      75,      tpz.craftRank.AMATEUR,      -- Mandrel


        }
    },

    curioVendorMoogleStock =
    {
        [curio.medicine] =
        {
                4112,     300,      tpz.ki.RHAPSODY_IN_WHITE,   -- Potion
                4116,    1000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Hi-Potion
                4120,    2000,      tpz.ki.RHAPSODY_IN_AZURE,   -- X-Potion
                4124,   10000,      tpz.ki.RHAPSODY_IN_MAUVE,   -- Max-Potion
                4128,    1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Ether
                4132,    1200,      tpz.ki.RHAPSODY_IN_UMBER,   -- Hi-Ether
                4136,    4000,      tpz.ki.RHAPSODY_IN_AZURE,   -- Super Ether
                4140,    5000,      tpz.ki.RHAPSODY_IN_MAUVE,   -- Pro Ether
                4145,   15000,      tpz.ki.RHAPSODY_IN_EMERALD, -- Elixir
                4144,   20000,      tpz.ki.RHAPSODY_IN_MAUVE,   -- Hi-Elixir
                4148,     300,      tpz.ki.RHAPSODY_IN_WHITE,   -- Antidote
                4150,     400,      tpz.ki.RHAPSODY_IN_WHITE,   -- Eye Drops
                4151,     700,      tpz.ki.RHAPSODY_IN_WHITE,   -- Echo Drops
                4153,    1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Antacid
                4154,     400,      tpz.ki.RHAPSODY_IN_WHITE,   -- Holy Water
                4155,    2500,      tpz.ki.RHAPSODY_IN_AZURE,   -- Remedy
                4156,     500,      tpz.ki.RHAPSODY_IN_AZURE,   -- Mulsum
                4164,     800,      tpz.ki.RHAPSODY_IN_WHITE,   -- Prism Powder
                4165,     800,      tpz.ki.RHAPSODY_IN_WHITE,   -- Silent Oil
                4166,     250,      tpz.ki.RHAPSODY_IN_WHITE,   -- Deodorizer
                4172,    1000,      tpz.ki.RHAPSODY_IN_AZURE,   -- Reraiser
                4173,    1500,      tpz.ki.RHAPSODY_IN_EMERALD, -- Hi-Reraiser
                4213,   15000,      tpz.ki.RHAPSODY_IN_EMERALD, -- Icarus Wing
                4157,    1000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Poison Potion
                4163,     666,      tpz.ki.RHAPSODY_IN_AZURE,   -- Blinding Potion
                4161,    1083,      tpz.ki.RHAPSODY_IN_CRIMSON, -- Sleeping Potion
                4162,    1000,      tpz.ki.RHAPSODY_IN_EMERALD, -- Silencing Potion
                4159,    2000,      tpz.ki.RHAPSODY_IN_EMERALD, -- Paralyze Potion
                18731,    50,       tpz.ki.RHAPSODY_IN_WHITE,   -- Automaton Oil
                18732,    250,      tpz.ki.RHAPSODY_IN_WHITE,   -- Automaton Oil +1
                18733,    500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Automaton Oil +2
                19185,   1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Automaton Oil +3
        },
        [curio.ammunition] =
        {
                17296,      3,      tpz.ki.RHAPSODY_IN_WHITE,   -- Pebble
                4219,     300,      tpz.ki.RHAPSODY_IN_WHITE,   -- Stone Quiver
                4220,     350,      tpz.ki.RHAPSODY_IN_WHITE,   -- Bone Quiver
                4225,    2083,      tpz.ki.RHAPSODY_IN_WHITE,   -- Iron Quiver
                4221,    2083,      tpz.ki.RHAPSODY_IN_WHITE,   -- Beetle Quiver
                4226,    2083,      tpz.ki.RHAPSODY_IN_WHITE,   -- Silver Quiver
                4222,    4166,      tpz.ki.RHAPSODY_IN_WHITE,   -- Horn Quiver
                5333,    1250,      tpz.ki.RHAPSODY_IN_WHITE,   -- Sleep Quiver
                4223,    2916,      tpz.ki.RHAPSODY_IN_WHITE,   -- Scorpion Quiver
                4224,    6666,      tpz.ki.RHAPSODY_IN_AZURE,   -- Demon Quiver
                5332,   12500,      tpz.ki.RHAPSODY_IN_MAUVE,   -- Kabura Quiver
                -- 5819,    9900,      tpz.ki.RHAPSODY_IN_WHITE,   -- Antlion Quiver
                4227,     300,      tpz.ki.RHAPSODY_IN_WHITE,   -- Bronze Bolt Quiver
                5334,    3333,      tpz.ki.RHAPSODY_IN_WHITE,   -- Blind Bolt Quiver
                5335,    3333,      tpz.ki.RHAPSODY_IN_WHITE,   -- Acid Bolt Quiver
                5337,    3333,      tpz.ki.RHAPSODY_IN_WHITE,   -- Sleep Bolt Quiver
                5339,    3333,      tpz.ki.RHAPSODY_IN_WHITE,   -- Bloody Bolt Quiver
                5338,    1666,      tpz.ki.RHAPSODY_IN_WHITE,   -- Venom Bolt Quiver
                5336,    2500,      tpz.ki.RHAPSODY_IN_UMBER,   -- Holy Bolt Quiver
                4228,    2500,      tpz.ki.RHAPSODY_IN_AZURE,   -- Mythril Bolt Quiver
                4229,    4166,      tpz.ki.RHAPSODY_IN_MAUVE,   -- Darksteel Bolt Quiver
                -- 5820,    9460,      tpz.ki.RHAPSODY_IN_WHITE,   -- Darkling Bolt Quiver
                -- 5821,    9790,      tpz.ki.RHAPSODY_IN_WHITE,   -- Fusion Bolt Quiver
                5359,     200,      tpz.ki.RHAPSODY_IN_WHITE,   -- Bronze Bullet Pouch
                5363,    5742,      tpz.ki.RHAPSODY_IN_WHITE,   -- Bullet Pouch
                5341,     350,      tpz.ki.RHAPSODY_IN_WHITE,   -- Spartan Bullet Pouch
                5353,   13333,      tpz.ki.RHAPSODY_IN_WHITE,   -- Iron Bullet Pouch
                5340,   10000,      tpz.ki.RHAPSODY_IN_AZURE,   -- Silver Bullet Pouch
                5342,   20000,      tpz.ki.RHAPSODY_IN_MAUVE,   -- Corsair Bullet Pouch
                5416,   18333,      tpz.ki.RHAPSODY_IN_MAUVE,   -- Steel Bullet Pouch
                -- 5822,    9680,      tpz.ki.RHAPSODY_IN_WHITE,   -- Dweomer Bullet Pouch
                -- 5823,    9900,      tpz.ki.RHAPSODY_IN_WHITE,   -- Oberon Bullet Pouch
                6299,     2871,     tpz.ki.RHAPSODY_IN_WHITE,   -- Shuriken Pouch
                6297,     5148,     tpz.ki.RHAPSODY_IN_WHITE,   -- Juji Shuriken Pouch
                6298,     7048,     tpz.ki.RHAPSODY_IN_WHITE,   -- Manji Shuriken Pouch
                6302,     8676,     tpz.ki.RHAPSODY_IN_AZURE,   -- Fuma Shuriken Pouch
                -- 6303,    1000,      tpz.ki.RHAPSODY_IN_MAUVE,   -- Iga Shuriken Pouch
                5870,    10000,     tpz.ki.RHAPSODY_IN_WHITE,   -- Trump Card Case
                1022,    3643,      tpz.ki.RHAPSODY_IN_AZURE,   -- Thief's Tools
                1023,    5520,      tpz.ki.RHAPSODY_IN_EMERALD, -- Living Key
                1115,    6574,      tpz.ki.RHAPSODY_IN_MAUVE,   -- Skeleton Key
        },
        [curio.ninjutsuTools] =
        {
                5308,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Uchi)
                5309,    2000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Tsurara)
                5310,    8000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Kawahori-Ogi)
                5311,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Makibishi)
                5312,    4000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Hiraishin)
                5313,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Mizu-Deppo)
                5314,    4000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Shihei)
                5315,   11000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Jusatsu)
                5316,   10000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Kaginawa)
                5317,    8000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Sairui-Ran)
                5318,    8000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Kodoku)
                5319,    5000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Shinobi-Tabi)
                5417,    5000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Sanjaku-Tenugui)
                -- 5734,    5000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Toolbag (Soshi)
                5867,    4000,      tpz.ki.RHAPSODY_IN_EMERALD,   -- Toolbag (inoshishinofuda)
                5868,    5000,      tpz.ki.RHAPSODY_IN_EMERALD,   -- Toolbag (shikanofuda)
                5869,   11000,      tpz.ki.RHAPSODY_IN_EMERALD,   -- Toolbag (chonofuda)
        },
        [curio.foodStuffs] =
        {
                4378,      60,      tpz.ki.RHAPSODY_IN_WHITE,   -- Selbina Milk
                4299,     100,      tpz.ki.RHAPSODY_IN_WHITE,   -- Orange au Lait
                -- 5703,     100,      tpz.ki.RHAPSODY_IN_WHITE,   -- Uleguerand Milk
                4300,     300,      tpz.ki.RHAPSODY_IN_UMBER,   -- Apple au Lait
                4301,     600,      tpz.ki.RHAPSODY_IN_AZURE,   -- Pear au Lait
                4422,     200,      tpz.ki.RHAPSODY_IN_WHITE,   -- Orange Juice
                4424,    1100,      tpz.ki.RHAPSODY_IN_UMBER,   -- Melon Juice
                4558,    2000,      tpz.ki.RHAPSODY_IN_CRIMSON, -- Yagudo Drink
                4405,     160,      tpz.ki.RHAPSODY_IN_WHITE,   -- Rice Ball
                4376,     120,      tpz.ki.RHAPSODY_IN_WHITE,   -- Meat Jerky
                4578,     140,      tpz.ki.RHAPSODY_IN_WHITE,   -- Sausage
                4371,     184,      tpz.ki.RHAPSODY_IN_WHITE,   -- Grilled Hare
                4381,     583,      tpz.ki.RHAPSODY_IN_UMBER,   -- Meat Mithkabob
                4456,     120,      tpz.ki.RHAPSODY_IN_WHITE,   -- Boiled Crab
                4398,     833,      tpz.ki.RHAPSODY_IN_WHITE,   -- Fish Mithkabob
                5166,    1500,      tpz.ki.RHAPSODY_IN_EMERALD, -- Coeurl Sub
                4538,     900,      tpz.ki.RHAPSODY_IN_UMBER,   -- Roast Pipira
                6217,     500,      tpz.ki.RHAPSODY_IN_UMBER,   -- Anchovy Slice
                6215,     400,      tpz.ki.RHAPSODY_IN_UMBER,   -- Pepperoni Slice
                5752,    1000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Pot-au-feu
                4488,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Jack-o'-Lantern
                5721,     500,      tpz.ki.RHAPSODY_IN_AZURE,   -- Crab Sushi
                5148,    1250,      tpz.ki.RHAPSODY_IN_CRIMSON, -- Squid Sushi
                5176,    1000,      tpz.ki.RHAPSODY_IN_CRIMSON, -- Bream Sushi
                5178,    1666,      tpz.ki.RHAPSODY_IN_CRIMSON, -- Dorado Sushi
                -- 5775,     500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Chocolate Crepe
                -- 5766,    1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Butter Crepe
                4413,     120,      tpz.ki.RHAPSODY_IN_WHITE,   -- Apple Pie
                4421,     416,      tpz.ki.RHAPSODY_IN_AZURE,   -- Melon Pie
                4446,     250,      tpz.ki.RHAPSODY_IN_UMBER,   -- Pumpkin Pie
                4410,     120,      tpz.ki.RHAPSODY_IN_WHITE,   -- Roast Mushroom
                4510,      24,      tpz.ki.RHAPSODY_IN_WHITE,   -- Acorn Cookie
                4394,      12,      tpz.ki.RHAPSODY_IN_WHITE,   -- Ginger Cookie
                5188,      750,     tpz.ki.RHAPSODY_IN_WHITE,   -- Peperoncino
                5213,     1500,     tpz.ki.RHAPSODY_IN_AZURE,   -- Melanzane
                5189,     1833,     tpz.ki.RHAPSODY_IN_EMERALD, -- Vongole Rosso
                -- 5782,    1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Sugar Rusk
                -- 5783,    2000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Chocolate Rusk
                -- 5779,    1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Cherry Macaron
                -- 5780,    2000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Coffee Macaron
                -- 5885,    1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Saltena
                -- 5886,    2000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Elshena
                -- 5887,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Montagna
                -- 5889,    1000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Stuffed Pitaru
                -- 5890,    2000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Poultry Pitaru
                -- 5891,    2500,      tpz.ki.RHAPSODY_IN_WHITE,   -- Seafood Pitaru
                -- 6258,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Shiromochi
                -- 6262,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Kusamochi
                -- 6260,    3000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Akamochi
                -- 5547,   15000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Beef Stewpot
                -- 5727,   15000,      tpz.ki.RHAPSODY_IN_WHITE,   -- Zaru Soba
                4466,       12,      tpz.ki.RHAPSODY_IN_WHITE,   -- Spicy Cracker
        },
        [curio.scrolls] =
        {
                4181,     500,      tpz.ki.RHAPSODY_IN_UMBER,     -- Instant Warp
                4182,     500,      tpz.ki.RHAPSODY_IN_UMBER,     -- Instant Reraise
                5428,     500,      tpz.ki.RHAPSODY_IN_AZURE,     -- Instant Retrace
                5988,     500,      tpz.ki.RHAPSODY_IN_CRIMSON,   -- Instant Protect
                5989,     500,      tpz.ki.RHAPSODY_IN_CRIMSON,   -- Instant Shell
                5990,     500,      tpz.ki.RHAPSODY_IN_CRIMSON,   -- Instant Stoneskin
               15533,    5000,      tpz.ki.RHAPSODY_IN_UMBER,     -- Chocobo Whistle
        },
        [curio.keys] =
        {
                17016,      11,      tpz.ki.RHAPSODY_IN_WHITE,   -- Pet Food Alpha Biscuit
                17017,      82,      tpz.ki.RHAPSODY_IN_WHITE,   -- Pet Food Beta Biscuit
                19251,     300,      tpz.ki.RHAPSODY_IN_WHITE,   -- Pet Roborant
                19252,     250,      tpz.ki.RHAPSODY_IN_WHITE,   -- Pet Poultice
                17860,      82,      tpz.ki.RHAPSODY_IN_WHITE,   -- Carrot Broth
                17861,     250,      tpz.ki.RHAPSODY_IN_UMBER,   -- Famous Carrot Broth
                17862,     695,      tpz.ki.RHAPSODY_IN_WHITE,   -- Bug Broth
                17863,    1000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Quadav Bug Broth
                17864,     126,      tpz.ki.RHAPSODY_IN_WHITE,   -- Herbal Broth
                17865,    1000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Singing Herbal Broth
                17866,     695,      tpz.ki.RHAPSODY_IN_WHITE,   -- Carrion Broth
                17867,    1000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Cold Carrion Broth
                17868,     695,      tpz.ki.RHAPSODY_IN_WHITE,   -- Humus Broth
                17869,    1500,      tpz.ki.RHAPSODY_IN_UMBER,   -- Rich Humus Broth
                17870,     695,      tpz.ki.RHAPSODY_IN_WHITE,   -- Meat Broth
                17871,    1250,      tpz.ki.RHAPSODY_IN_UMBER,   -- Warm Meat Broth
                17876,     165,      tpz.ki.RHAPSODY_IN_WHITE,   -- Fish Broth
                17877,     833,      tpz.ki.RHAPSODY_IN_UMBER,   -- Fish Oil Broth
                17885,     695,      tpz.ki.RHAPSODY_IN_WHITE,   -- Grasshopper Broth
                17886,    1500,      tpz.ki.RHAPSODY_IN_UMBER,   -- Noisy Grasshopper Broth
                17872,     695,      tpz.ki.RHAPSODY_IN_WHITE,   -- Tree Sap
                17873,    1500,      tpz.ki.RHAPSODY_IN_UMBER,   -- Scarlet Sap
                17880,     695,      tpz.ki.RHAPSODY_IN_WHITE,   -- Seedbed Soil
                17882,    1500,      tpz.ki.RHAPSODY_IN_AZURE,   -- Alchemist Water
                17884,    1500,      tpz.ki.RHAPSODY_IN_AZURE,   -- Sun Water
                17887,     695,      tpz.ki.RHAPSODY_IN_WHITE,   -- Mole Broth
                17888,    1500,      tpz.ki.RHAPSODY_IN_UMBER,   -- Lively Mole Broth
                17891,     695,      tpz.ki.RHAPSODY_IN_WHITE,   -- Antica Broth
                17892,    1500,      tpz.ki.RHAPSODY_IN_UMBER,   -- Fragrant Antica Broth
                17889,     500,      tpz.ki.RHAPSODY_IN_UMBER,   -- Blood Broth
                17890,    1500,      tpz.ki.RHAPSODY_IN_AZURE,   -- Clear Blood Broth
                17902,    4000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Lucky Broth
                17904,    4000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Briny Broth
                17874,     417,      tpz.ki.RHAPSODY_IN_UMBER,   -- Cunning Brain Broth
                17893,    4000,      tpz.ki.RHAPSODY_IN_UMBER,   -- Wool Grease
                17879,     708,      tpz.ki.RHAPSODY_IN_UMBER,   -- Curdled Plasma Broth
                17883,     583,      tpz.ki.RHAPSODY_IN_UMBER,   -- Mellow Bird Broth
                17900,     417,      tpz.ki.RHAPSODY_IN_UMBER,   -- Cloudy Wheat Broth
                17903,    2084,      tpz.ki.RHAPSODY_IN_UMBER,   -- Shadowy Broth
                21470,     354,      tpz.ki.RHAPSODY_IN_UMBER,   -- Decaying Broth
                21466,     583,      tpz.ki.RHAPSODY_IN_UMBER,   -- Frizzante Broth
                21442,     708,      tpz.ki.RHAPSODY_IN_UMBER,   -- Sticky Webbing TODO: Recipe and cost
                21440,     354,      tpz.ki.RHAPSODY_IN_UMBER,   -- Sugary Broth TODO: Recipe and cost
                21494,    1042,      tpz.ki.RHAPSODY_IN_UMBER,   -- Wetlands Broth TODO: Recipe and cost
                17914,     250,      tpz.ki.RHAPSODY_IN_UMBER,   -- Wispy Broth
                21446,     519,      tpz.ki.RHAPSODY_IN_AZURE,   -- Airy Broth
                17909,     708,      tpz.ki.RHAPSODY_IN_CRIMSON, -- Spicy Broth TODO: Recipe and cost
                21488,    1146,      tpz.ki.RHAPSODY_IN_CRIMSON, -- Pristine Sap
                17911,    2084,      tpz.ki.RHAPSODY_IN_EMERALD, -- Salubrious Broth
                21438,    2084,      tpz.ki.RHAPSODY_IN_EMERALD, -- Poisonous Broth
                21450,    2084,      tpz.ki.RHAPSODY_IN_EMERALD, -- Electrified Broth
                21464,    2084,      tpz.ki.RHAPSODY_IN_MAUVE,   -- Rancid Broth
                17912,    2084,      tpz.ki.RHAPSODY_IN_MAUVE,   -- Fizzy Broth
                21468,    2084,      tpz.ki.RHAPSODY_IN_MAUVE,   -- Zestful Sap
        }
    }
}
