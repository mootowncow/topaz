-----------------------------------
-- Area: Ordelles Caves
--   NM: Polevik
-- Involved In Quest: Dark Puppet
-- !pos -51 0.1 3 193
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:addMod(tpz.mod.DEFP, 100)
    mob:addMod(tpz.mod.MDEF, 100) 
    mob:addMod(tpz.mod.ATTP, 100)
    mob:addMod(tpz.mod.ACC, 100) 
    mob:addMod(tpz.mod.EVA, 30)
    mob:setMod(tpz.mod.MACC, 50) 
    mob:setMod(tpz.mod.REFRESH, 400)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobInitialize(mob)
    mob:setMod(tpz.mod.UFASTCAST, 50) 
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if player:getCharVar("sharpeningTheSwordCS") == 3 then
        player:setCharVar("PolevikKilled", 1)
    end
end
