------------------------------
-- Area: The Sanctuary of ZiTah
--   NM: Bastet
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 325)
end
