------------------------------
-- Area: FeiYin
--   NM: Sluagh
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 349)
end
