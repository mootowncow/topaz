------------------------------
-- Area: Gusgen Mines
--   NM: Wounded Wurfel
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 234)
end
