-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Delivery Crate
-- Type: Magian Trials NPC (Delivery Crate)
-- !pos -6.843 2.459 121.9 243
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/magian")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.MAGIAN_DELIVERY_CRATE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
