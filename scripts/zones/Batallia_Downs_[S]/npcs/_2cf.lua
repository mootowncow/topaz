-----------------------------------
-- Area: Batallia Downs [S]
-- Door: Crypt Door
-- Note: The Eldieme Necropolis [S] entrance 5 (4 is unaccessible on retail)
-- !gotoid 17122122
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(14)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 14 and option == 1 then
        player:setPos(-160.936, -32.000, 259.974, 0.000, 175)
    end
end