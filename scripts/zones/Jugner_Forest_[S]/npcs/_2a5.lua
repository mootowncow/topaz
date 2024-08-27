-----------------------------------
-- Area: Jugner Forest [S]
-- Door: Wooden Gate
-- !gotoid 17113882
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(104)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 104 and option == 1 then
        player:setPos(236.547, 0, 20, 120, 85)
    end
end
