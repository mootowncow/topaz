-----------------------------------
-- Area: PsoXja
--   NM: Frosted Soul
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:addStatusEffect(tpz.effect.ICE_SPIKES, 10)
    mob:setEffectUndispellable(tpz.effect.ICE_SPIKES)
end

function onMobFight(mob, target) 
    if not mob:hasStatusEffect(tpz.effect.ICE_SPIKES) then
        mob:addStatusEffect(tpz.effect.ICE_SPIKES, 10)
        mob:setEffectUndispellable(tpz.effect.ICE_SPIKES)
    end
end

function onMobRoam(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
