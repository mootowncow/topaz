-----------------------------------
-- Area: West Sarutabaruta (115)
--   NM: Nunyenunc
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 251)
end
