-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Stirge
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 606, 1, tpz.regime.type.GROUNDS)
end
