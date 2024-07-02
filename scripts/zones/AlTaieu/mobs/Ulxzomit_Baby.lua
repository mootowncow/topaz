-----------------------------------
-- Area: Al'Taieu
--   NM: Ulxzomit Baby
-- Note: Follows around mother Ulxzomits
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/pathfind")
-----------------------------------
function onMobSpawn(mob)
    mob:addMod(tpz.mod.MOVE_SPEED_STACKABLE, 45)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

