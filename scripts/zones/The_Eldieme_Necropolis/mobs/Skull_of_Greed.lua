------------------------------
-- Area: The Eldieme Necropolis
--   NM: Skull of Greed
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 185)
end
