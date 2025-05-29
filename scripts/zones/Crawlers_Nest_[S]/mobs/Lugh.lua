------------------------------
-- Area: Crawlers Nest [S]
--   NM: Lugh
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 516)
end
