-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Ose
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 6000)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {chance = 50, power = 50})
end

function onMobDeath(mob, player, isKiller, noKiller)
end
