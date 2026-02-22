------------------------------
-- Area: Crawlers Nest [S]
--   NM: Abatwa
------------------------------
require("scripts/globals/wotg")
mixins = {
require("scripts/mixins/job_special"), 
require("scripts/mixins/families/slug")}
------------------------------
function onMobSpawn(mob)
    tpz.wotg.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.wotg.onMobFight(mob, target)
end

function onAdditionalEffect(mob, target, damage)
    local resistance = mob:getLocalVar("resistance")

    -- Changes Enspell based on current resistances (which are rotated every 60-90s)
    if resistance == 1 then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PETRIFY, {chance = 100})
    elseif resistance == 2 then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {chance = 100})
    elseif resistance == 3 then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SILENCE, {chance = 100})
    elseif resistance == 4 then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ADDLE, {chance = 100})
    elseif resistance == 5 then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PARALYZE, {chance = 100})
    elseif resistance == 6 then
        return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.STUN, {chance = 100})
    else
        return 0, 0, 0 -- Just in case no variable is set
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.onMobDeath(mob, player, isKiller, noKiller, tpz.wotg.events.Boss)
end
