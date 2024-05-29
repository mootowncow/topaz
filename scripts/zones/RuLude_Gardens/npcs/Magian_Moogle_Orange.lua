-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Orange Bobble)
-- Type: Magian Trials NPC (Weapon/Empyrean Armor)
-- !pos -11 2.453 118 64
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
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
