-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Hecteyes
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 606, 2, tpz.regime.type.GROUNDS)
end
