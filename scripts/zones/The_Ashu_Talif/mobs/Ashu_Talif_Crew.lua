-----------------------------------
-- Area: The Ashu Talif
-- (The Black Coffin & Scouting the Ashu Talif & Royal Painter Escort)
--  Mob: Ashu Talif Crew
-----------------------------------
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
require("scripts/globals/status")
require("scripts/globals/pathfind")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobSpawn(mob)
    mob:setDamage(40)
end

function onMobRoam(mob)
    local instance = mob:getInstance()
    if (instance:completed()) then
        DespawnMob(mob:getID(), instance)
    end
    if tpz.path.CheckIfStuck(mob) then
        mob:setPos(15.82,-22.74,-1.99)
    end
end

function onMobEngaged(mob, target)
    -- Black Coffin
    local allies = mob:getInstance():getAllies()
    for i, v in pairs(allies) do
        if (v:isAlive()) then
            v:setLocalVar("ready", 1)
        end
    end

    local mobs = mob:getInstance():getMobs()
    for i, v in pairs(mobs) do
        if(v:isAlive()) then
            v:setLocalVar("ready", 1)
        end
    end
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

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end
