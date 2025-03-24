-----------------------------------
-- Area: Uleguerand Range
--   NM: Kindred Summoner
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
local spawnPools = {
    [16797876] = { 16797873, 16797874, 16797875, 16797876 },
    [16797883] = { 16797880, 16797881, 16797882, 16797883 },
    [16797891] = { 16797888, 16797889, 16797890, 16797891 },
    -- TODO
}
function onMobInitialize(mob)
    MobRandomSpawn(mob, 5, spawnPools)
end

function onMobDeath(mob, player, isKiller, noKiller)
    MobRandomSpawn(mob, 5, spawnPools)
end