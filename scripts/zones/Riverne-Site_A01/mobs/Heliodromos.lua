-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Heliodromos
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
    SetServerVariable("Heliodromos_Despawn", 0)
end

function onMobRoam(mob)
    local Heliodromos_Despawn = GetServerVariable("Heliodromos_Despawn")

    -- 10 minutes have passed since first heliodromos dies. despawn any remaining heliodromos.
    if (Heliodromos_Despawn > 0 and Heliodromos_Despawn <= os.time()) then
        SetServerVariable("Heliodromos_Despawn", 0)

        -- despawn heliodromos
        for i = ID.mob.HELIODROMOS_OFFSET, ID.mob.HELIODROMOS_OFFSET + 2 do
            if (GetMobByID(i):isSpawned()) then
                DespawnMob(i)
            end
        end
        -- allow placeholders to respawn
        for i = ID.mob.HELIODROMOS_PH_OFFSET, ID.mob.HELIODROMOS_PH_OFFSET + 2 do
            local ph = GetMobByID(i)
            DisallowRespawn(i, false)
            ph:setRespawnTime(GetMobRespawnTime(ph:getID()))
        end
    end
end

function onMobEngaged(mob)
	local target = mob:getTarget()

    -- Force links all 3 "clones" on engage
    for heliodromos = 16900110, 16900112 do
        GetMobByID(heliodromos):updateEnmity(target)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    -- one of the heliodromos was killed. set a 10 minute despawn timer before the others despawn
    if (isKiller and GetServerVariable("Heliodromos_Despawn") == 0) then
        SetServerVariable("Heliodromos_Despawn", os.time() + 600)
    end
end

function onMobDespawn(mob)
    local allHeliodromosDead = true

    for i = ID.mob.HELIODROMOS_OFFSET, ID.mob.HELIODROMOS_OFFSET + 2 do
        if (GetMobByID(i):isAlive()) then
            allHeliodromosDead = false
        end
    end

    if (allHeliodromosDead) then
        SetServerVariable("Heliodromos_ToD", os.time() + math.random(36000, 43200)) -- 11 to 12 hours

        -- allow placeholders to respawn
        for i = ID.mob.HELIODROMOS_PH_OFFSET, ID.mob.HELIODROMOS_PH_OFFSET + 2 do
            local ph = GetMobByID(i)
            DisallowRespawn(i, false)
            ph:setRespawnTime(GetMobRespawnTime(ph:getID()))
        end
    end
end
