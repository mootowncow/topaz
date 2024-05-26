-----------------------------------
-- Area: North Gustaberg_[S]
--  VNM: Lamprey Lord
-----------------------------------
require("scripts/globals/voidwalker")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobInitialize(mob)
    tpz.voidwalker.onMobInitialize(mob)
end

function onMobSpawn(mob)
    tpz.voidwalker.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.voidwalker.onMobFight(mob, target)
end

function onAdditionalEffect(mob, target, damage)
    if not mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON) then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, { chance = 100, power = math.random(30, 50) })
    end
end

function onMobDisengage(mob)
    tpz.voidwalker.onMobDisengage(mob)
end

function onMobDespawn(mob)
    tpz.voidwalker.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.voidwalker.onMobDeath(mob, player, isKiller, tpz.keyItem.ORANGE_ABYSSITE)
end