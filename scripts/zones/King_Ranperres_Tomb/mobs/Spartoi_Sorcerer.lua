-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Spartoi Sorcerer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 638, 1, tpz.regime.type.GROUNDS)
end
