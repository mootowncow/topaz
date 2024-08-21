-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Vanguard Priest
-----------------------------------
mixins =
{
    require("scripts/mixins/dynamis_beastmen"),
    require("scripts/mixins/job_special")
}
local ID = require("scripts/zones/Dynamis-Beaucedine/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.KOO_SAXU_THE_EVERFAST_PH, 5, 3600) -- 1 hour
end
