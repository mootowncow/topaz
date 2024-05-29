-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Blue Bobble)
-- Type: Magian Trials NPC (Relic Armor)
-- !pos -6.843 2.459 121.9 243
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/magian")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.magian.magianOnTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.magian.magianOnTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
    tpz.magian.magianEventUpdate(player, csid, option, npc)
end

function onEventFinish(player, csid, option)
    tpz.magian.magianOnEventFinish(player, csid, option, npc)
end
