-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Tulwar Scorpion
-- Note: PH for Calchas
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.regime.checkRegime(player, mob, 137, 2, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.CALCHAS_PH, 20, 3600) -- 1 hour
end
