-----------------------------------
-- Area: Apollyon SW
--  Mob: Armoury Crate
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 2) 
end

function onMobEngaged(mob)
    mob:setTP(3000)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetNPCByID(ID.npc.APOLLYON_SW_PORTAL[3]):getAnimation() ~= tpz.animation.OPEN_DOOR then
            tpz.limbus.handleDoors(mob:getBattlefield(), true, ID.npc.APOLLYON_SW_PORTAL[3])
        end
    end
end

function onMobDespawn(mob)
    if mob:getBattlefield() then
        local mobID = mob:getID()
        local mimicSpawned = mob:getBattlefield():getLocalVar("mimicSpawned")
        if mobID == ID.mob.APOLLYON_SW_MOB[3] then
            mob:getBattlefield():setLocalVar("mimicSpawned", mimicSpawned-1)
        elseif mobID == ID.mob.APOLLYON_SW_MOB[3]+1 then
            mob:getBattlefield():setLocalVar("mimicSpawned", mimicSpawned-2)
        elseif mobID == ID.mob.APOLLYON_SW_MOB[3]+2 then
            mob:getBattlefield():setLocalVar("mimicSpawned", mimicSpawned-4)
        end
    end
end