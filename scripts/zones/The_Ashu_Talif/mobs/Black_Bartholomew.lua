-----------------------------------
-- Area: The Ashu Talif (The Black Coffin & Scouting the Ashu Talif)
--  Mob: Black Bartholomew
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
require("scripts/globals/status")
require("scripts/globals/pathfind")
-----------------------------------

function onMobInitialize(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobRoam(mob)
    local instance = mob:getInstance()
    if (instance:completed()) then
        DespawnMob(mob:getID(), instance)
    end
    tpz.path.CheckIfStuck(mob)
end

function onMobFight(mob, target)
    local instance = mob:getInstance()
    if (instance:completed()) then
        DespawnMob(mob:getID(), instance)
    end

    if tpz.path.CheckIfStuck(mob) then
        if (mob:checkDistance(target) >= 10) then
            mob:setPos(target:getXPos(), target:getYPos(), target:getZPos())
        end
    end
end

function onMobEngaged(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    instance:setLocalVar("bartholomew_killed", 1)
end

function onMobDespawn(mob)
end
