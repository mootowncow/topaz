-----------------------------------
-- Area: Batallia Downs [S]
-- Door: Crypt Door
-- Note: The Eldieme Necropolis [S] entrance 2
-- !gotoid 17122119
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(17)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 17 and option == 1 then
        player:setPos(340.023, -48.000, 320.927, 60, 175)
    end
end