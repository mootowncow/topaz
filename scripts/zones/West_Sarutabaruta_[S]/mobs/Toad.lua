-----------------------------------
-- Area: West Sarutabaruta [S]
--  Mob: Toad
-- Note: Place holder Ramponneau
-----------------------------------
local ID = require("scripts/zones/West_Sarutabaruta_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.RAMPONNEAU_PH, 20, 5400) -- 90 minutes
end
