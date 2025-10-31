------------------------------
-- Area: Garlaige Necropolis [S]
--   NM: Abatwa
------------------------------
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/families/djinn")}
------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
end

function onMobFight(mob, target)
    tpz.wotg.onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.onMobDeath(mob, player, isKiller, noKiller, tpz.wotg.events.Waves)
end

function onMobDespawn(mob)
    tpz.wotg.onMobDespawn(mob, tpz.wotg.events.Waves)
end