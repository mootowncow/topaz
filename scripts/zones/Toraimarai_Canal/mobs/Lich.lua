-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Lich
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 619, 2, tpz.regime.type.GROUNDS)
end
