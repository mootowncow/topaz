-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Tebhi
-- Note: BST mythic weapon fight
-- !spawnmob 17584515
-- Mythic weapon fight
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.SHARE_TARGET, mob:getID() -1)
end

function onMobDeath(mob, player, isKiller, noKiller)
end