-----------------------------------
-- Area: Toraimarai Canal
--   NM: Magic Sludge
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setDelay(2500)
    mob:setMod(tpz.mod.UDMGMAGIC, -75)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobInitialize(mob)
    mob:setMod(tpz.mod.UFASTCAST, 150) 
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:setCharVar("rootProblem", 3)
end
