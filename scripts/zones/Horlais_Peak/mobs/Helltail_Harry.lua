-----------------------------------
-- Area: Horlais Peak
--  Mob: Helltail Harry
-- BCNM: Tails of Woe
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
