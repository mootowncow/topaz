------------------------------
-- Area: The Eldieme Necropolis
--   NM: Skull of Wrath
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 190)
end
