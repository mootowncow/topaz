-----------------------------------
-- Area: Monarch Linn
--  Mob: Guard Hippogryph
-- Beloved of the Atlantes
-- Key item ID: 674
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    mob:setDamage(100)
    mob:addMod(tpz.mod.ATTP, 25)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.HP_DRAIN, {chance = 25, power = 60})
end

function onMobDeath(mob, player, isKiller, noKiller)
end