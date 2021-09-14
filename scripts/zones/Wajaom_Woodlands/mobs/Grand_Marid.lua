-----------------------------------
-- Area: Wajaom Woodlands
--  MOB: Grand Marid
-- Note: 30 minute lottery
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/mobs")
mixins = { require("scripts/mixins/behavior_spawn_chigoe")}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.GRAND_MARID1_PH, 20, 1800)
    tpz.mob.phOnDespawn(mob, ID.mob.GRAND_MARID2_PH, 20, 1800)
end
