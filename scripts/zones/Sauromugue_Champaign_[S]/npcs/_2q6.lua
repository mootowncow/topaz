-----------------------------------
-- Area: Sauromugue Champaign [S]
-- Door: Ebon Door
-- Note: Garlaige Citadel [S] Entrance
-- !gotoid 17179326
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(104)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 104 and option == 1 then
        player:setPos(-300, -12, 157, 64, 164)
    end
end
