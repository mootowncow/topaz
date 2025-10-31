------------------------------
-- Area: Crawlers Nest [S]
--   NM: Abatwa
------------------------------
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/families/mimic")}
------------------------------
function onMobSpawn(mob)
end

function onMobFight(mob, target)
end

function onMobEngaged(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.onMobDeath(mob, player, isKiller, noKiller, tpz.wotg.events.Mimic)
end
