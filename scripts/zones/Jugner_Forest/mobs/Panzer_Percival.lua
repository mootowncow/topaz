------------------------------
-- Area: Jugner Forest
--   NM: Panzer Percival
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 157)
end
