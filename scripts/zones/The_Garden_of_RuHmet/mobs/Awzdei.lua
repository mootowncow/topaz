-----------------------------------
-- Area: The Garden of Ru'Hmet
--  MOB: Aw'Zdei
-- Animation Sub 0 Pot Form
-- Animation Sub 1 Pot Form (reverse eye position)
-- Animation Sub 2 Bar Form
-- Animation Sub 3 Ring Form
-----------------------------------
require("scripts/globals/status")
mixins = {require("scripts/mixins/families/zdei")}
-----------------------------------
function onMobSpawn(mob)
end

function onPath(mob)
    local spawnPos = mob:getSpawnPos()
    mob:pathThrough({spawnPos.x, spawnPos.y, spawnPos.z})
    local pos = mob:getPos()
    if spawnPos.x == pos.x and spawnPos.z == pos.z then
        mob:setPos(spawnPos.x, spawnPos.y, spawnPos.z, mob:getRotPos() + 20)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end
