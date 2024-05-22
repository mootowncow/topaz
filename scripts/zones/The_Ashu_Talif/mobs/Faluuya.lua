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
-- First stop (by door) rot: 253
-- At door: -7.56, -22.50, 3.40
-- Port through door: -8.02, -22.50, -4.83
-- Spawn mobs: -3.92, -14.50, -16.01 
local stageOnePts1 = {
    { 4.15, -22.00, 16.72 },
    { -1.10, -22.00, 12.90 },
    { -7.16, -22.03, 10.21 },
    { -7.81, -22.50, 2.58 }, -- Added
}

local stageOnePts2 = {
    { -6.54, -22.50, -6.73 }, -- Might need to be removed/changed
    { -2.11, -20.75, -6.82 },
    { 4.85, -18.50, -7.44 },
    { 3.52, -18.50, -10.32 },
    { -1.05, -17.25, -10.45 },
    { -6.93, -14.50, -10.68 },
    { -6.85, -14.50, -12.76 },
    { -4.68, -14.50, -15.22 },
    { -3.92, -14.50, -16.01 }
}

local retreatToTopPts1 = {
    { -6.052155, -14.500002, -11.098473 },
    { 3.230412, -18.500000, -10.153654 },
    { 3.134426, -18.500000, -6.958476 },
    { -7.547063, -22.500000, -6.043747 }, -- Inside door
};

local retreatToTopPts2 = {
    { -6.991322, -22.500000, 3.234773 }, -- Seems to go back inside and teleports down?
    { -6.634718, -22.000000, 23.389055 },
    { -7.507441, -31.000000, 41.822979 },
    { -7.531722, -31.000000, 53.427715 },
    { 0.460836, -31.000000, 53.537926 } -- Once all mobs dead, immediately pathTwo
}

local sketchOne = {
    { -6.552976, -31.000000, 53.135220 },
    { -6.953773, -31.062500, 40.949741 },
    { -7.313815, -22.000000, 24.565838 },
    { -7.628562, -22.009054, 14.275635 },
    { -7.742513, -22.500000, 0.696395 },
    { -7.211101, -22.500000, -7.453206 } -- Waits as mobs spawn all inside and behind
};

local sketchTwo = { -- Waits as mobs spawn in front and behind again
    { 3.019294, -18.500000, -7.452654 },
    { 2.090031, -18.500000, -11.088349 }
};

local retreatToTopTwo = { -- Retreats back to top mobs spawning on top of deck and below and running at her
    { 2.336882, -18.500000, -5.786534 },
    { -8.180116, -22.500000, -5.705924 },
    { -8.156613, -22.500000, -1.157002 },
    { -6.507248, -22.059174, 15.529238 },
    { -7.080959, -31.062500, 39.635307 },
    { -7.267087, -31.000000, 49.876953 },
    { -0.116310, -31.000000, 51.085835 }
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

    if IsOutsideDoor(mob) and (progress == 0) then
        printf("Outside door, increasing progress and teleporting")
        instance:setProgress(instance:getProgress() +1)
        mob:clearPath()
        mob:setLocalVar("path", 0)
        mob:setLocalVar("pathingDone", 0)
        mob:setPos(-8.02, -22.50, -4.83)
    end

    if IsAtFirstSpawns(mob) and (stage == 1) and (progress == 1) then
        printf("At first spawns, spawning mobs and setting stage to 2")
        instance:setStage(instance:getStage() +1)
        instance:setProgress(0)
        mob:clearPath()
        mob:setLocalVar("path", 0)
        mob:setLocalVar("pathingDone", 0)
    end

    if IsInsideDoor(mob) and (stage == 2) then
        printf("Inside door, increasing stage and teleporting")
        instance:setStage(instance:getStage() +1)
        instance:setProgress(0)
        mob:clearPath()
        mob:setLocalVar("path", 0)
        mob:setLocalVar("pathingDone", 0)
        mob:setPos(-7.56, -22.50, 3.40)
    end

    if (stage == 1 and progress == 0) then
        tpz.path.followPointsInstance(mob, stageOnePts1, tpz.path.flag.NONE)
    elseif (stage == 1) and (progress == 1) then
        tpz.path.followPointsInstance(mob, stageOnePts2, tpz.path.flag.NONE)
    elseif (stage == 2) then
        tpz.path.followPointsInstance(mob, retreatToTopPts1, tpz.path.flag.RUN)
    elseif (stage == 3) then -- Seems to go back inside and teleports down?
        tpz.path.followPointsInstance(mob, retreatToTopPts2, tpz.path.flag.RUN)
    end
end

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function Teleport(mob, x, y, z) -- TODO
end

function IsOutsideDoor(mob)
    local currentPos = mob:getPos()
    local pathingDone = mob:getLocalVar("pathingDone") == 1
    if (math.abs(currentPos.x - -8.0) <= 1.0 and pathingDone) then
        return true
    end
    return false
end

function IsInsideDoor(mob)
    local currentPos = mob:getPos()
    local pathingDone = mob:getLocalVar("pathingDone") == 1
    if
        (math.abs(currentPos.x - -7.0) <= 1.0  and
        math.abs(currentPos.y - (-22.0)) <= 1.0 and
        pathingDone)
    then
        return true
    end
    return false
end

function IsAtFirstSpawns(mob)
    local currentPos = mob:getPos()
    local pathingDone = mob:getLocalVar("pathingDone") == 1
    if (math.abs(currentPos.x - -4) <= 1.0 and pathingDone) then
        return true
    end
    return false
end