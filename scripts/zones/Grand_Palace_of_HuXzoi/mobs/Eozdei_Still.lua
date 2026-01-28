-----------------------------------
-- Area: Grand Palace of Hu'Xzoi
--  MOB: Eo'Zdei
-- Animation Sub 0 Pot Form
-- Animation Sub 1 Pot Form (reverse eye position)
-- Animation Sub 2 Bar Form
-- Animation Sub 3 Ring Form
-----------------------------------
local ID = require("scripts/zones/Grand_Palace_of_HuXzoi/IDs")
mixins = {require("scripts/mixins/families/zdei")}
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 15)
end

function onMobEngaged(mob,target)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onPath(mob)
    local spawnPos = mob:getSpawnPos()
    mob:pathThrough({spawnPos.x, spawnPos.y, spawnPos.z})
    local pos = mob:getPos()
    if spawnPos.x == pos.x and spawnPos.z == pos.z then
        mob:setPos(spawnPos.x, spawnPos.y, spawnPos.z, spawnPos.rot)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end


function onMobDespawn(mob)
end
