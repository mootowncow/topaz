-----------------------------------
-- Area: Rolanberry Fields [S]
-- Door: Sturdy Door
-- Note: Crawler's Nest [S] Back Entrance
-- !gotoid 17150735
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(104)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 104 and option == 1 then
        player:setPos(84.03, 0.35, 379.47, 134, 171)
    end
end

--exit back to rolanberry[s]:
  --  { X=-774.122864, Y=-36.616634, Z=-495.705872 }

--enter crawlers nest (eventID: 104):
  --  { X=84.039001, Y=-0.353522, Z=379.477997 }
