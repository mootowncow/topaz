-----------------------------------
-- Area: Dynamis - Jeuno
--  Mob: Vanguard Shaman
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
    tpz.mob.phOnDespawn(mob, ID.mob.SPARKSPOX_SWEATBROW_PH, 5, 3600) -- 1 hour
    tpz.mob.phOnDespawn(mob, ID.mob.HUMNOX_DRUMBELLY_PH, 5, 3600) -- 1 hour
    tpz.mob.phOnDespawn(mob, ID.mob.KIKKLIX_LONGLEGS_PH, 5, 3600) -- 1 hour
    tpz.mob.phOnDespawn(mob, ID.mob.MORTILOX_WARTPAWS_PH, 5, 3600) -- 1 hour
end

function onMobDeath(mob, player, isKiller, noKiller)
end
