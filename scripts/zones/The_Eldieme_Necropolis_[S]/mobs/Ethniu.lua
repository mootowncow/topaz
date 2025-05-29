------------------------------
-- Area: The Eldieme Necropolis [S]
--   NM: Ethniu
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 497)
end
