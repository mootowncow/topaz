-----------------------------------
-- Area: Xarcabard [S]
--  NPC: Veridical Conflux
-- !pos 239 -8 -247 137
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Xarcabard_[S]/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not player:hasKeyItem(tpz.ki.KUPOFRIEDS_MEDALLION) then
        player:startEvent(37)
    else
        player:startEvent(44)
    end
end

function onEventUpdate(player, csid, option)
    player:updateEvent(6, 1, 0, 7, 67108863, 11466178, 4095, player:getGil())
end

function onEventFinish(player, csid, option)
    if csid == 37 and option == 99 then
        if not player:hasKeyItem(tpz.ki.KUPOFRIEDS_MEDALLION) then
            npcUtil.giveKeyItem(player, tpz.ki.KUPOFRIEDS_MEDALLION)
            player:delGil(1000)
        end
    elseif csid == 44 and option == 99 then
        player:setPos(-420, 13.5, -32, 192, 182) -- send to walk of echoes
    end
end
