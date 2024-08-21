-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Vanguard Dragontamer
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
    tpz.mob.phOnDespawn(mob, ID.mob.RUTRIX_HAMGAM_PHS, 5, 3600) -- 1 hour
end


function onMobDeath(mob, player, isKiller, noKiller)
end
