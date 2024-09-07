-----------------------------------
-- Area: Caedarva Mire
--  Mob: Jnun
-----------------------------------
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/families/jnun")}
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
end

function onMobDisengage(mob)
    local spawnPos = mob:getSpawnPos()
    mob:setPos(spawnPos.x, spawnPos.y, spawnPos.z)
end

function onMobDeath(mob, player, isKiller, noKiller)
end