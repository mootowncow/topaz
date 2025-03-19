-----------------------------------
-- Area: Uleguerand Range
--   NM: Kindred Warrior
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
--[[
function onMobDeath(mob, player, isKiller, noKiller)
local spawnPools = {
    [16797873] = { 16797873, 16797874, 16797875, 16797876 },
    [16797880] = { 16797880, 16797881, 16797882, 16797883 },
    [16797888] = { 16797888, 16797889, 16797890, 16797891 },
}
    ChooseRandomSpawn(mob, spawnPools)
end
]]