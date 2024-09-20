-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Eater
-----------------------------------
mixins = {require("scripts/mixins/families/worm")}
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 814, 1, tpz.regime.type.GROUNDS)
end
