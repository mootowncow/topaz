------------------------------
-- Area: Yhoator Jungle
--   NM: Edacious Opo-opo
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 366)
end
