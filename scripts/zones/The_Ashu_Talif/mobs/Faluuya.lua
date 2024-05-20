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
-- First stop(by door) rot: 253
local firstPath = { 
    { X=-8.131993, Y=-22.500000, Z=2.034237 },
    { X=-10.963132, Y=-22.500000, Z=1.293651 },
    { X=-7.723091, Y=-22.500000, Z=1.504090 },
    { X=-7.938271, Y=-22.500000, Z=-5.944552 },
    { X=3.018289, Y=-18.500000, Z=-5.362344 },
    { X=3.720953, Y=-18.701359, Z=-9.715941 },
    { X=-6.397033, Y=-14.500002, Z=-10.183089 },
    { X=-3.811580, Y=-14.500002, Z=-16.114532 } -- Mobs spawn, immediately retrats to top
};

local retreatToTop = {
    { X=-6.052155, Y=-14.500002, Z=-11.098473 },
    { X=3.230412, Y=-18.500000, Z=-10.153654 },
    { X=3.134426, Y=-18.500000, Z=-6.958476 },
    { X=-7.547063, Y=-22.500000, Z=-6.043747 },
    { X=-6.991322, Y=-22.500000, Z=3.234773 },
    { X=-6.634718, Y=-22.000000, Z=23.389055 },
    { X=-7.507441, Y=-31.000000, Z=41.822979 },
    { X=-7.531722, Y=-31.000000, Z=53.427715 },
    { X=0.460836, Y=-31.000000, Z=53.537926 } -- Once all mobs dead, immediately pathTwo
};

local sketchOne = {
    { X=-6.552976, Y=-31.000000, Z=53.135220 },
    { X=-6.953773, Y=-31.062500, Z=40.949741 },
    { X=-7.313815, Y=-22.000000, Z=24.565838 },
    { X=-7.628562, Y=-22.009054, Z=14.275635 },
    { X=-7.742513, Y=-22.500000, Z=0.696395 },
    { X=-7.211101, Y=-22.500000, Z=-7.453206 } -- Waits as mobs spawn all inside and behind
};

local sketchTwo = { -- Waits as mobs spawn in front and behind again
    { X=3.019294, Y=-18.500000, Z=-7.452654 },
    { X=2.090031, Y=-18.500000, Z=-11.088349 }
};

local retreatToTopTwo = { -- Retreats back to top mobs spawning on top of deck and below and running at her
    { X=2.336882, Y=-18.500000, Z=-5.786534 },
    { X=-8.180116, Y=-22.500000, Z=-5.705924 },
    { X=-8.156613, Y=-22.500000, Z=-1.157002 },
    { X=-6.507248, Y=-22.059174, Z=15.529238 },
    { X=-7.080959, Y=-31.062500, Z=39.635307 },
    { X=-7.267087, Y=-31.000000, Z=49.876953 },
    { X=-0.116310, Y=-31.000000, Z=51.085835 }
};

function onMobSpawn(mob)
    mob:setLocalVar("path", 0)
end

function onMobRoam(mob)
    local instance = mob:getInstance()
    local stage = instance:getStage()
    local progress = instance:getProgress()
    if (stage == 1 and progress == 0) then
        tpz.path.followPoints(mob, firstPath, tpz.path.flag.NONE)
    end
    -- TODO: Set once arrived at end of firstPath instance:setProgress(instance:getProgress() +1)
end

function onMobDespawn(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
end