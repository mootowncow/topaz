-----------------------------------
-- Area: Phomiuna_Aqueducts
--   NM: Eba
-----------------------------------
mixins = {require("scripts/mixins/fomor_hate")}
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("fomorHateAdj", 4)
end

function onMobDeath(mob, player, isKiller)
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



