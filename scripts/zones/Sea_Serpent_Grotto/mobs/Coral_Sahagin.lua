-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Coral Sahagin
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 50)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:addMod(tpz.mod.DEFP, 35)
    mob:addMod(tpz.mod.ACC, 50) 
    mob:addMod(tpz.mod.EVA, 20)
    mob:setMod(tpz.mod.REFRESH, 400)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(1200, 2700)) -- 20 to 45 minutes
end
