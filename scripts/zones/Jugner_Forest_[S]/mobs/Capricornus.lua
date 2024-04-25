-----------------------------------
-- Area: Jugner Forest_[S]
--  VNM: Capricornus
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
    if mob:getHPP() < 15 then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER, {chance = 100, power = 75})
    elseif mob:getHPP() < 50 then
	    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER, {chance = 100, power = 50})
    else
	    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENWATER, {chance = 100, power = 35})
    end
end

function onMobDisengage(mob)
    tpz.voidwalker.onMobDisengage(mob)
end

function onMobDespawn(mob)
    tpz.voidwalker.onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.voidwalker.onMobDeath(mob, player, isKiller, tpz.keyItem.BLUE_ABYSSITE)
end