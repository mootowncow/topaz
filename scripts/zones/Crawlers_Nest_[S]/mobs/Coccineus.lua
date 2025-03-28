------------------------------
-- Area: Crawlers Nest [S]
--   NM: Abatwa
------------------------------
require("scripts/globals/wotg")
------------------------------
function onMobSpawn(mob)
    tpz.wotg.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.wotg.onMobFight(mob)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.SILENCE, {chance = 100})
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.onMobDeath(mob, player, tpz.wotg.events.Boss)
end
