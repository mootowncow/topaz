-----------------------------------
-- Area: Leujaoam Cleansing(Leujaoam Sanctum)
-- NPC:  Armor Chest
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
-----------------------------------
function onTrade(player,npc,trade)
    --if npc:getID() == 17060201 then
       --npc:setPos(325.2460,-36,199.7928, 0)
    --end
end

function onTrigger(player, npc)
    local instance = npc:getInstance()
	local Message = npc:getLocalVar("Message")
    if npc:getID() == 17060201 then 
        for v = 17060184,17060186,1 do
            SpawnMob(v, instance)
            GetMobByID(v, instance):setMobMod(tpz.mobMod.DRAW_IN, 0) 
	        GetMobByID(v, instance):updateEnmity(player)
        end
    end
    if Message == 0 then
        for _, member in pairs(player:getAlliance()) do
            if member:getZoneID() == player:getZoneID() then
                member:PrintToPlayer("You armor is enchanted with fire resistant runes! But a nearby chest melts away...",0,"Armor Chest")
                member:addMod(tpz.mod.FIREDEF, 13)
                GetNPCByID(npc:getID()+5, instance):setStatus(tpz.status.DISAPPEAR)
                npc:setLocalVar("Message", 1)
            end
        end
    end
    npc:entityAnimationPacket("open")
    npc:setLocalVar("open", 1)
    npc:timer(15000, function(npc)
        npc:entityAnimationPacket("kesu")
    end)
    npc:timer(16000, function(npc)
        npc:setStatus(tpz.status.DISAPPEAR)
        npc:timer(500, function(mob)
            npc:setLocalVar("open", 0)
        end)
    end)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
