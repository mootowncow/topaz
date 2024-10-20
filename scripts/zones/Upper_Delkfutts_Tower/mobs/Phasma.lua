-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Phasma
-- Note: PH for Ixtab
-----------------------------------
local ID = require("scripts/zones/Upper_Delkfutts_Tower/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.IXTAB_PH, 5, 3600) -- 1 hour
end
