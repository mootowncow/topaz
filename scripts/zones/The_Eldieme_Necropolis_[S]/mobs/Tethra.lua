------------------------------
-- Area: The Eldieme Necropolis [S]
--   NM: Tethra
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 496)
end
