------------------------------
-- Area: North Gustaberg [S]
--   NM: Ankabut
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 500)
end
