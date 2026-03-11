-----------------------------------
-- Area: Gustav Tunnel
--   NM: Bune
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setDamage(200)
    mob:addMod(tpz.mod.ATTP, 100)
    mob:addMod(tpz.mod.DEFP, 25)
    mob:addMod(tpz.mod.ACC, 25)
    mob:addMod(tpz.mod.EVA, 25)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 15000)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)

    -- Set Bune's spawnpoint and respawn time (21-23 hours)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(36000, 43200))
end
