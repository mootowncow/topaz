-----------------------------------
-- Area: South Gustaberg
--  Mob: Sand Crab
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 80, 2, tpz.regime.type.FIELDS)
end
