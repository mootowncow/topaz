-----------------------------------
-- Area: Batallia Downs [S]
-- Door: Crypt Door
-- Note: The Eldieme Necropolis [S] entrance 3
-- !gotoid 17122120
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(16)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 16 and option == 1 then
        player:setPos(59.998, -32.000, 161.041, 66, 175)
    end
end