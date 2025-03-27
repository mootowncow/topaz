------------------------------
-- Area: Crawlers Nest [S]
--   NM: Abatwa
------------------------------
require("scripts/globals/wotg")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.wotg.WaveonMobDeath(mob)
end
