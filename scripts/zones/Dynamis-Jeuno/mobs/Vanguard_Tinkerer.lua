-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Vanguard Tinkerer
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Jeuno/IDs")
require("scripts/globals/mobs")
-----------------------------------
function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BANDRIX_ROCKJAW_PH, 5, 3600) -- 1 hour
end

function onMobDeath(mob, player, isKiller, noKiller)
end
