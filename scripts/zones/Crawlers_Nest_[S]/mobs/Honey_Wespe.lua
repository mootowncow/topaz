------------------------------
-- Area: Crawlers Nest [S]
--   NM: Honey Wespe
--   Involved in: Witchweed
------------------------------
require("scripts/globals/wotg")
-----------------------------------
function onMobSpawn(mob)
    tpz.wotg.onMobSpawn(mob)
end

function onMobRoam(mob, target)
    tpz.wotg.onMobRoam(mob)
end

function onMobFight(mob, target)
    tpz.wotg.onMobFight(mob, target)
end
 
function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
end
