-----------------------------------
-- Area: Rolanberry Fields [S]
--  Mob: Scabrous Slug
-- Note: PH for Dyinyinga 
-----------------------------------
local ID = require("scripts/zones/Rolanberry_Fields_[S]/IDs")
require("scripts/globals/mobs")
mixins = { require("scripts/mixins/families/slug") }
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.DYINYINGA_PH, 20, 3600) -- 1 hour
end
