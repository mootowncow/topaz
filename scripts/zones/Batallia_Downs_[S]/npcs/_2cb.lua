-----------------------------------
-- Area: Batallia Downs [S]
-- Door: Ebon Door
-- Note: The Eldieme Necropolis [S] entrance
-- !gotoid 17122118
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(18)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 18 and option == 1 then
        player:setPos(420, -56, -119.51, 191, 175)
    end
end