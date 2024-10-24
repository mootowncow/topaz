-----------------------------------
-- Area: Qufim Island
--  Mob: Dancing Weapon
-- Note: PH for Trickster Kinetix
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/mobs")
-----------------------------------

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.TRICKSTER_KINETIX_PH, 20, 3600) -- 1 hour
end
