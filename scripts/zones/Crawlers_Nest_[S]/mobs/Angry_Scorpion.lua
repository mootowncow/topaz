------------------------------
-- Area: Crawlers Nest [S]
--   NM: Abatwa
------------------------------
require("scripts/globals/wotg")
------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
end

function onMobFight(mob, target)
    tpz.wotg.onMobFight(mob, target)
end

function onMobWeaponSkillPrepare(mob, target)
    return tpz.wotg.onMobWeaponSkillPrepare(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.onMobDeath(mob, player, isKiller, noKiller, tpz.wotg.events.Waves)
end

function onMobDespawn(mob)
    tpz.wotg.onMobDespawn(mob, tpz.wotg.events.Waves)
end