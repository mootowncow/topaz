------------------------------
-- Area: Garlaige Citadel [S]
--   NM: Citadel Pipistrelles
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 533)
end
