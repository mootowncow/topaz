-----------------------------------
-- Area: Lower Jeuno
--  Mob: Dimensional Efflux
-- Notes: Ports to Leafillia
-- !gotoid 17781025
-----------------------------------
require("scripts/globals/msg")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:getGil() == 1) then
        player:PrintToPlayer("The portal sucks you into it!",tpz.msg.textColor.HIDDEN,null)
        player:queue(2000, function(player)
            player:setPos(-1, -0.46, 0, 151, 281)
        end)
    end
end

function onTrigger(player, npc)
    player:PrintToPlayer("A strange looking portal...what happens if I throw gil into it?",tpz.msg.textColor.HIDDEN,null)
end