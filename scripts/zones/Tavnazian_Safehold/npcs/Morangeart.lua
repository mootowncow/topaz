-----------------------------------
-- Area: Tavnazian Safehold
--   NPC: Morangeart
-- Type: ENM Quest Activator
-- !pos -74.308 -24.782 -28.475 26
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local MonarchBeardTimer = player:getCharVar("[ENM]MonarchBeardTimer")
    if os.time() < MonarchBeardTimer and player:hasKeyItem(tpz.ki.MONARCH_BEARD) == false then -- Time remaining until player can get another Monarch Beard
        player:startEvent(522) 
    elseif os.time() > MonarchBeardTimer and player:hasKeyItem(tpz.ki.MONARCH_BEARD) == false then -- Give player Monarch Beard
        player:startEvent(521) 
    elseif player:hasKeyItem(tpz.ki.MONARCH_BEARD) then 
        player:startEvent(520) -- ENM already accepted text
    else
        player:startEvent(520) -- Default text
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local MonarchBeardTimer = player:getCharVar("[ENM]MonarchBeardTimer")
    -- Give the player Monarch Beard
    if csid == 521 then
        player:addKeyItem(tpz.ki.MONARCH_BEARD)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MONARCH_BEARD)
        player:setCharVar("[ENM]MonarchBeardTimer", os.time() + 432000) -- 5 days
    end
    if csid == 522 then
        -- player:updateEvent(MonarchBeardTimer, MonarchBeardTimer, MonarchBeardTimer, MonarchBeardTimer, MonarchBeardTimer, MonarchBeardTimer, MonarchBeardTimer, MonarchBeardTimer)
        player:updateEvent(MonarchBeardTimer, 0, 0, 0, 0, 1, 0, 0)
    end
end
