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
    local introCompleted = player:getCharVar("[WoE]XarcaConfluxIntro") > 0

    if not player:hasKeyItem(tpz.ki.KUPOFRIEDS_MEDALLION) then
        if not introCompleted then
            player:startEvent(37)
        else
            player:startEvent(43, 137, 291640804, 20977028, 131136, 66977791, player:getGil(), 4095, 0)
        end
    else
        player:startEvent(44)
    end
end

function onEventUpdate(player, csid, option)
    if csid == 37 then
        player:updateEvent(6, 1, 0, 7, 67108863, 11466178, 4095, player:getGil())
    elseif csid == 43 then
        player:updateEvent(76, 291640804, 20977028, 131136, 66977791, player:getGil(), 4095, 0)
        if player:getGil() >= 1000 then
            player:updateEvent(77, 291640804, 20977028, 131136, 66977791, player:getGil(), 4095, 17169543)
        end
    end
end

function onEventFinish(player, csid, option)
    if csid == 37 and option == 99 then -- Option 99 means has enough gil
        if not player:hasKeyItem(tpz.ki.KUPOFRIEDS_MEDALLION) then
            npcUtil.giveKeyItem(player, tpz.ki.KUPOFRIEDS_MEDALLION)
            player:delGil(1000)
            player:setCharVar("[WoE]XarcaConfluxIntro", 1)
        end
    elseif csid == 43 and option == 99 then -- Option 99 means has enough gil, otherwise it says "You do not have enough gil"
        npcUtil.giveKeyItem(player, tpz.ki.KUPOFRIEDS_MEDALLION)
        player:delGil(1000)
    elseif csid == 44 and option == 99 then  -- Enter Walk of Echoes
        player:setPos(-420, 14, -32, 192, 182)
    end
end
