------------------------------
-- Area: Crawlers Nest [S]
--   NM: Abatwa
------------------------------
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/job_special")}
------------------------------
function onMobSpawn(mob)
    tpz.wotg.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.wotg.onMobFight(mob, target)
end

function onAdditionalEffect(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENFIRE, {chance = 100, power = math.random(80, 120)})
end

function onSpellPrecast(mob, spell)
end

function onMobWeaponSkillPrepare(mob, target)
    return tpz.wotg.onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkillPrepare(mob, target)
    return tpz.wotg.onMobWeaponSkillPrepare(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.onMobDeath(mob, player, isKiller, noKiller, tpz.wotg.events.Boss)
end
