-----------------------------------
-- Area: Batallia Downs (105)
--   NM: Lumber Jack
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setDamage(130)
    mob:setMod(tpz.mod.ATT, 500)
    mob:addMod(tpz.mod.DEFP, 30) 
    mob:setMod(tpz.mod.ACC, 300) 
    mob:addMod(tpz.mod.EVA, 30)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 600)
end

function onAdditionalEffect(mob, target, damage)
    if mob:hasStatusEffect(tpz.effect.ENSTONE) then
        return 0, 0, 0
    else
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    -- Set Weeping Willow's respawn time (21-24 hours)
    GetMobByID(mob:getID() -6):setRespawnTime(math.random(36000, 43200))
end
