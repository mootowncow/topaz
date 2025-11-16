-----------------------------------
-- Area: Selbina
--  NPC: Falgima
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/shop")
require("scripts/globals/items")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        --4744,  5351,    -- Scroll of Invisible
        --4745,  2325,    -- Scroll of Sneak
        --4746,  1204,    -- Scroll of Deodorize
        tpz.items.SCROLL_OF_FLURRY, 30360,       -- Scroll of Flurry
        tpz.items.SCROLL_OF_FLURRY_II, 72560,    -- Scroll of Flurry II
    }

    player:showText(npc, ID.text.FALGIMA_SHOP_DIALOG)
    tpz.shop.general(player, stock, SELBINA)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
