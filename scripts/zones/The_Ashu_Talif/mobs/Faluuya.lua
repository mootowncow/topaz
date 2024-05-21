-----------------------------------
-- Area: The Ashu Talif (Royal Painter Escort
--  Mob: Faluuya
-- TOAU-15 Mission Battle
-----------------------------------

local ID = require("scripts/zones/The_Ashu_Talif/IDs")

require("scripts/globals/instance")
require("scripts/globals/status")
require("scripts/globals/pathfind")
-----------------------------------
-- Top: X=0.460836, Y=-31.000000, Z=53.537926
-- teleport to sketchOne { X=-7.211101, Y=-22.500000, Z=-7.453206 }
local firstPath = { 
    { X=3.302114, Y=-18.500000, Z=-6.698709 },
    { X=2.237761, Y=-18.500000, Z=-10.151311 },
    { X=-6.964653, Y=-14.500002, Z=-10.171860 },
    { X=-7.827848, Y=-14.500002, Z=-10.566154 },
    { X=-5.446637, Y=-14.500002, Z=-17.951368 },
    { X=-2.168818, Y=-14.500002, Z=-18.013985 } -- Mobs spawn, immediately retreats to top
};



local retreatToTop = {
    { X=-7.227223, Y=-14.500002, Z=-11.107519 },
    { X=3.113629, Y=-18.500000, Z=-9.737992 },
    { X=2.686222, Y=-18.500000, Z=-6.436531 },
    { X=-7.184405, Y=-22.500000, Z=-6.048779 } -- Teleport to top
};

local sketchOne = {
    { X=-6.512912, Y=-31.000000, Z=52.447601 },
    { X=-7.074765, Y=-31.062500, Z=40.669388 },
    { X=-7.333328, Y=-22.625000, Z=25.520134 },
    { X=-7.318003, Y=-22.000000, Z=9.355526 },
    { X=-7.594603, Y=-22.500000, Z=2.544827 }
};

local sketchTwo = { -- Waits as mobs spawn in front and behind again
    { X=3.019294, Y=-18.500000, Z=-7.452654 },
    { X=2.090031, Y=-18.500000, Z=-11.088349 }
};

local retreatToTopTwo = { -- Retreats back to top mobs spawning on top of deck and below and running at her
    { X=3.150824, Y=-18.500000, Z=-6.762420 },
    { X=-8.307346, Y=-22.500000, Z=-5.826944 }
};

function onMobSpawn(mob)
    mob:setLocalVar("path", 0)
end

function onMobRoam(mob)
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local progress = instance:getProgress()

    local escortProgress = {
        { Stage = 1,    Path = firstPath,           Flags = tpz.path.flag.NONE        },
        { Stage = 2,    Path = retreatToTop,        Flags = tpz.path.flag.RUN         },
        { Stage = 3,    Path = sketchOne,           Flags = tpz.path.flag.NONE        },
        { Stage = 4,    Path = sketchTwo,           Flags = tpz.path.flag.NONE        },
        { Stage = 5,    Path = retreatToTopTwo,     Flags = tpz.path.flag.RUN         },
    }

    for _, escorts in pairs(escortProgress) do
        if (stage == escorts.Stage) then
            tpz.path.followPoints(mob, escorts.Path, escorts.Flags)

            local finalPoint = escorts.Path[#escorts.Path]
            local pos = mob:getPos()

            if isClose(pos, finalPoint, 1.0) then
            -- if (pos.x == finalPoint.x) then
                instance:setStage(instance:getStage() + 1)
                break
            end
        end
    end
end

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function isClose(pos1, pos2, threshold)
    -- Calculate the difference in each coordinate
    local dx = pos1.x - pos2.X
    local dy = pos1.y - pos2.Y
    local dz = pos1.z - pos2.Z

    -- Calculate the squared distance
    local squaredDistance = dx * dx + dy * dy + dz * dz

    -- Calculate the squared threshold
    local squaredThreshold = threshold * threshold

    -- Print the positions, squared distance, squared threshold, and result
    print(string.format("pos1: (x: %f, y: %f, z: %f)", pos1.x, pos1.y, pos1.z))
    print(string.format("pos2: (X: %f, Y: %f, Z: %f)", pos2.X, pos2.Y, pos2.Z))
    print(string.format("squaredDistance: %f", squaredDistance))
    print(string.format("squaredThreshold: %f", squaredThreshold))
    print(string.format("isClose result: %s", squaredDistance <= squaredThreshold))

    -- Compare squared distance to squared threshold
    return squaredDistance <= squaredThreshold
end
