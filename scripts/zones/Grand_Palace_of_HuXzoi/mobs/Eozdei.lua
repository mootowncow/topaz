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
    if isKiller then
        local mobId = mob:getID()
        local nm = GetMobByID(ID.mob.JAILER_OF_TEMPERANCE)
        local ph = nm:getLocalVar("ph")
        local pop = nm:getLocalVar("pop")

        if ph == mobId and pop ~= 0 and os.time() > pop then
            local pos = mob:getSpawnPos()
            nm:setSpawn(pos.x, pos.y, pos.z)
            SpawnMob(ID.mob.JAILER_OF_TEMPERANCE):updateClaim(player)
            nm:setLocalVar("hold", ph)
            DisallowRespawn(mobId, true)
        end
    end
end

function onMobDespawn(mob)
end
