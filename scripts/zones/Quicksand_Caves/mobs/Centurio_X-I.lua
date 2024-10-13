-----------------------------------
-- Area: Quicksand Caves
--   NM: Centurio X-I
-----------------------------------
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.DEFP, 50) 
    mob:addMod(tpz.mod.ATTP, 30)
    mob:addMod(tpz.mod.ACC, 50) 
    mob:addMod(tpz.mod.EVA, 50)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
    mob:addMod(tpz.mod.SILENCERESTRAIT, 75)
    mob:addMod(tpz.mod.SLEEPRESTRAIT, 50)
    mob:addMod(tpz.mod.LULLABYRESTRAIT, 50)
    mob:addMod(tpz.mod.SPELLINTERRUPT, 25)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 426)
end
