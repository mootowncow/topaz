------------------------------
-- Area: RoMaeve
--   NM: Nightmare Vase
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 327)
end
