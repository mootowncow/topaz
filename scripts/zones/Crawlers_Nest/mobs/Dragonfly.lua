-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Dragonfly
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 691, 3, tpz.regime.type.GROUNDS)
end
