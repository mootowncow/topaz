-----------------------------------
-- Rarcasmeault
-- Involved in quest: The Flipside of Things
-----------------------------------
-- !addquest 7 11
-- !pos -69.588 -1.415 57.695 164
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not player:hasKeyItem(tpz.ki.FIREPOWER_CASE) then
        return player:startEvent(7)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 7) then
        npcUtil.giveKeyItem(player, tpz.ki.FIREPOWER_CASE)
    end
end