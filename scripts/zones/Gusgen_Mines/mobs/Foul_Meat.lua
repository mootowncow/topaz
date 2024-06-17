-----------------------------------
-- Area: Gusgen Mines
--  Mob: Foul Meat
-----------------------------------
require("scripts/globals/mobs")
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

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(64800, 43200)) -- 18 to 24 hours
end
