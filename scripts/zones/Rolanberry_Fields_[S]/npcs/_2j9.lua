-----------------------------------
-- Area: Rolanberry Fields [S]
-- Door: Sturdy Door
-- Note: Crawler's Nest [S] Front Entrance
-- !gotoid 17150734
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(104)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 104 and option == 1 then
        player:setPos(380.61, -32.31, 4.58, 65, 171)
    end
end

--exit back to rolanberry[s]:
  --  { X=-774.122864, Y=-36.616634, Z=-495.705872 }

--enter crawlers nest (eventID: 104):
  --  { X=84.039001, Y=-0.353522, Z=379.477997 }
