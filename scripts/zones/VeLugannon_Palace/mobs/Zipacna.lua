-----------------------------------
-- Area: VeLugannon Palace
--  Mob: Zipacna
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/globals/pathfind")
-----------------------------------


function onMobInitialize(mob)
	mob:setMod(tpz.mod.MOVE, 45)
    UpdateNMSpawnPoint(mob:getID())
end


function onMobSpawn(mob)
    SetGenericNMStats(mob)
	mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 30)
    mob:setLocalVar("path", 0)
    mob:setLocalVar("pathstep", 0)
end


function onMobRoam(mob)
    local blueDoorPathing =
    {
        { x = -162, y = 0, z = 379   },
        { x = -193,  y = 0, z = 387  },
        { x = -231,  y = 0, z = 379  },
        { x = -259,  y = 7, z = 399  },
        { x = -254,  y = 12, z = 420 },
        { x = -221,  y = 16, z = 420 },
    }

    local yellowDoorPathing =
    {
        { x=62.543587, y=0.000000, z=451.382874 },
        { x=61.403900, y=0.110000, z=424.514130 },
        { x=43.312580, y=-0.000009, z=419.347015 },
        { x=25.647673, y=0.000001, z=420.440460 },
        { x=-25.096540, y=0.000001, z=420.725586 },
        { x=-61.917976, y=0.109999, z=420.918610 },
        { x=-59.091969, y=0.000000, z=449.585052 },
        { x=-69.277657, y=0.000000, z=459.252625 }
    };


    local blueGate = GetNPCByID(ID.npc.H3_BLUE_GATE)
    local yellowGate = GetNPCByID(ID.npc.H3_YELLOW_GATE)
    local pathingTable = yellowDoorPathing

    local spawnPos = mob:getSpawnPos()
    --print(spawnPos.x)
    --print(spawnPos.y)
    --print(spawnPos.z)
    -- Spawned inside the Blue Gate
    if (spawnPos.x == -195 and spawnPos.y == -0.5 and spawnPos.z == 396) then
        pathingTable = blueDoorPathing
    else -- Spawned inside the Yellow Gate
        pathingTable = yellowDoorPathing
    end

    tpz.path.loop(mob, pathingTable, tpz.path.flag.RUN)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(7200) -- 2 hours
end
