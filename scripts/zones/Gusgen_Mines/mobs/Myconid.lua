-----------------------------------
-- Area: Gusgen Mines
--  Mob: Myconid
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 683, 2, tpz.regime.type.GROUNDS)
end
