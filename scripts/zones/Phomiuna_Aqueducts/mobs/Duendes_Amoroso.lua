-----------------------------------
-- Area: Phomiuna_Aqueducts
--  MOB: Duendes Amoroso
-- !pos -140 0 166 27
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/pathfind")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    onPath(mob)
end

function onPath(mob)
    local master = GetMobByID(mob:getID() -1)
    mob:pathTo(master:getXPos() + 0.15, master:getYPos(), master:getZPos() + 0.15)
end


function onMobFight(mob)
end

function onMobEngaged(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
end