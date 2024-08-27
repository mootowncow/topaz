-----------------------------------
-- Area: Pashhow Marshlands [S]
-- Door: Corroded Gate
-- !gotoid 17146571
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(102)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 102 and option == 1 then
        player:setPos(-297.364, 1.70, 96.049, 250, 92)
    end
end