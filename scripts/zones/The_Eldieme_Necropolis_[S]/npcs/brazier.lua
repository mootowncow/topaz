-----------------------------------
-- Area: The Eldieme Necropolis [S]
-- Door: Ebon Door
-- Note: Teleports back to Batallia Downs [S]
-- !gotoid 17494741
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(100)
end

function onEventUpdate(player, csid, option)
    printf("on event update csid: %d, option: %d", csid, option)
    if csid == 100 then
        --player:setPos(283.593 -403.207, 8.000 -2.724, 84)
    end
end

function onEventFinish(player, csid, option)
    printf("on event finish csid: %d, option: %d", csid, option)
    if csid == 100 and option == 1 then
    printf("finish")
        player:setPos(283.593, 8, -403.207, 148, 84)
    end
end