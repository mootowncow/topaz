------------------------------
-- Area: Tahrongi Canyon
--   NM: Serpopard Ishtar
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 257)
end
