-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Goblin Reaper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 129, 2, tpz.regime.type.FIELDS)
end
