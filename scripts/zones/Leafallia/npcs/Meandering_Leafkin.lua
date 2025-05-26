-----------------------------------
-- Area: Leafallia
--  NPC: Meandering Leafkin
-- !gotoid 17928210
-----------------------------------
function onTrigger(player, npc)
    local npcId = npc:getID()
    if (npcId == 17928209) then
        player:startEvent(21)
    elseif (npcId == 17928210) then
        player:startEvent(22)
    elseif (npcId == 17928216) then
     player:startEvent(28)
    else -- The rest also have events but too lazy to code for now
        player:startEvent(28)
    end
end 