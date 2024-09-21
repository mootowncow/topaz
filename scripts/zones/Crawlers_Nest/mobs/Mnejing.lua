-----------------------------------
-- Area: Crawler's Nest'
--  Mob: Mnejing
-- Note: PUP mythic weapon fight
-- Mythic weapon fight
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
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