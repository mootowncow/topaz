-----------------------------------
-- Area: Pso'Xja
--   NM: Gyre-Carlin
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobInitialize(mob)
    -- Pick a random spawn position on server load
    UpdateNMSpawnPoint(mob:getID())
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.TERROR_ENMITY_RESET, { chance = 100 })
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    -- Select a new random spawn position
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(36000, 43200)) -- 11 to 12 hours
end