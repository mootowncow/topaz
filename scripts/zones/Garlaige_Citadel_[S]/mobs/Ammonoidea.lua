------------------------------
-- Area: Crawlers Nest [S]
--   NM: Ammonoidea
------------------------------
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/families/uragnite")}
------------------------------
function onMobSpawn(mob)
    tpz.wotg.onMobSpawn(mob)
end

function onMobFight(mob, target)
    tpz.wotg.onMobFight(mob, target)
end

function onAdditionalEffect(mob, target, damage)
end

function onSpellPrecast(mob, spell)
    tpz.wotg.onSpellPrecast(mob, spell)
end

function onMobWeaponSkillPrepare(mob, target)
    return tpz.wotg.onMobWeaponSkillPrepare(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.onMobDeath(mob, player, isKiller, noKiller, tpz.wotg.events.Boss)
end
