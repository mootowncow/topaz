------------------------------
-- Area: Crawlers Nest [S]
--   NM: Abatwa
------------------------------
require("scripts/globals/wotg")
mixins = {require("scripts/mixins/families/peiste")}
------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 1)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.onMobDeath(mob, player, tpz.wotg.events.Waves)
end
