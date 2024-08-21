-----------------------------------
-- Area: Dynamis - Xarcabard
--  Mob: Kindred Ranger
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.MARQUIS_CIMERIES_PH, 5, 3600) -- 1 hour
end


