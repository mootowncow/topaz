-----------------------------------
-- Area: Leafallia
--  NPC: Drifting Feather
-- !gotoid 17928262
-- Siren fight entrance
-----------------------------------
local ID = require("scripts/zones/Leafallia/IDs")
require("scripts/globals/quests")
require("scripts/globals/msg")
require("scripts/globals/battlefield")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not player:hasKeyItem(tpz.ki.FISTFUL_OF_FAMILIAR_SOIL) then
        player:startEvent(65)
    elseif player:hasKeyItem(tpz.ki.FISTFUL_OF_FAMILIAR_SOIL) then
        local entry = true

        for _, member in pairs(player:getAlliance()) do
            if not member:hasKeyItem(tpz.ki.FISTFUL_OF_FAMILIAR_SOIL) then
                entry = false
                break
            end
        end

        if entry then
            player:PrintToPlayer("Entering battle with Siren.",tpz.msg.textColor.HIDDEN,null)
            player:queue(2000, function(player)
                for _, member in pairs(player:getAlliance()) do
                    member:setPos(-17.570, 0.827, -419.504, 32, 264)
                end
                if not GetMobByID(17859397):isSpawned() then
                    SpawnMob(17859397)
                end
            end)
        else
            player:PrintToPlayer("One or more party members does not have the Fistful of Familiar Soil.",tpz.msg.textColor.HIDDEN,null)
        end
    end
end

function onEventUpdate(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
end
