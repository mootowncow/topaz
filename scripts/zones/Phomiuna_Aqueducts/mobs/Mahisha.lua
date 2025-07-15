-----------------------------------
-- Area: Phomiuna_Aqueducts
--   NM: Mahisha
-----------------------------------
mixins = {require("scripts/mixins/fomor_hate")}
require("scripts/globals/status")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
end

function onMobSpawn(mob)
    mob:setLocalVar("fomorHateDecrease", 1)
    mob:setLocalVar("fomorHateAdj", 1)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    if math.random(2) == 1 then
        DisallowRespawn(ID.mob.EBA, true)
        DisallowRespawn(ID.mob.MAHISHA, false)
        UpdateNMSpawnPoint(ID.mob.MAHISHA)
        GetMobByID(ID.mob.MAHISHA):setRespawnTime(math.random(28800, 43200)) -- 8 to 12 hours
    else
        DisallowRespawn(ID.mob.MAHISHA, true)
        DisallowRespawn(ID.mob.EBA, false)
        UpdateNMSpawnPoint(ID.mob.EBA)
        GetMobByID(ID.mob.EBA):setRespawnTime(math.random(28800, 43200)) -- 8 to 12 hours
    end
end
