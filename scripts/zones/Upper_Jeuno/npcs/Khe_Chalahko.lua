-----------------------------------
-- Area: Upper Jeuno
--  NPC: Khe Chalahko
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/shop")
require("scripts/globals/items")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        tpz.items.DARKSTEEL_ARMET,      7500,
        tpz.items.DARKSTEEL_CUIRASS,    10000,
        tpz.items.DARKSTEEL_GAUNTLETS,  5500,
        tpz.items.DARKSTEEL_CUISSES,    9000,
        tpz.items.DARKSTEEL_SABATONS,   5500
    }

    player:showText(npc, ID.text.KHECHALAHKO_SHOP_DIALOG)
    tpz.shop.general(player, stock, JEUNO)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
