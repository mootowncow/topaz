-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Vanguard Alchemist
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
    tpz.mob.phOnDespawn(mob, ID.mob.WYRMWIX_SNAKESPECS_PH, 5, 3600) -- 1 hour
    tpz.mob.phOnDespawn(mob, ID.mob.DISTILIX_STICKYTOES_PH, 5, 3600) -- 1 hour
end

function onMobDeath(mob, player, isKiller, noKiller)
end
