------------------------------
-- Area: Batallia Downs [S]
--   NM: La Velue
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 491)
end
