------------------------------
-- Area: Cape Teriggan
--   NM: Zmey Gorynych
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 406)
end
