-----------------------------------
-- Area: Davoi
--   NM: Blubbery Bulge
-- Involved in Quest: The Miraculous Dale
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 196)
end
