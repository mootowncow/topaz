------------------------------
-- Area: Crawlers Nest [S]
--   NM: Lugh
------------------------------
require("scripts/globals/wotg")
require("scripts/globals/hunts")
mixins = {require("scripts/mixins/job_special")}
------------------------------
function onMobSpawn(mob)
    tpz.wotg.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.wotg.onMobFight(mob, target)
end

function onMobWeaponSkillPrepare(mob, target)
    return tpz.wotg.onMobWeaponSkillPrepare(mob, target)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.PLAGUE, {chance = 100})
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.onMobDeath(mob, player, isKiller, noKiller, tpz.wotg.events.MetaBoss)
    tpz.hunts.checkHunt(mob, player, 516)
end
