-----------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Amphiptere
-----------------------------------
mixins = {require("scripts/mixins/families/amphiptere")}
require("scripts/globals/status")
require("scripts/globals/pathfind")
-----------------------------------

local path1 = {
    {x = 312, y = 0, z = 58},
    {x = 189, y = 0, z = 115},
    {x = 281, y = 0, z = -16},
    {x = 313, y = 0, z = -105},
    {x = 380, y = 0, z = -270},
    {x = 224, y = 0, z = -194},
    {x = 146, y = 0, z = -180},
}

local path2 = {
    {x = 61, y = -39, z = 141},
    {x = 43, y = -39, z = 72},
    {x = 36, y = -41, z = -10},
    {x = 5, y = -60, z = 41},
    {x = -28, y = -62, z = 100},
    {x = -95, y = -75, z = 104},
    {x = -148, y = -79, z = 148},
    {x = -116, y = -80, z = 205},
    {x = -22, y = -80, z = 127},
}

local path3 = {
    {x = -55, y = -98, z = 53},
    {x = -127, y = -99, z = 64},
    {x = -114, y = -99, z = 4},
    {x = -197, y = -99, z = -23},
    {x = -255, y = -99, z = 23},
    {x = -294, y = -100, z = 23},
    {x = -315, y = -100, z = 61},
    {x = -360, y = -100, z = 75},
    {x = -361, y = -99, z = 132},
    {x = -318, y = -100, z = 122},
}


function onPath(mob)
end

function onMobSpawn(mob)
end

function onMobRoam(mob)
    local mobID = mob:getID()
    if mobID == 17334337 then
        tpz.path.loop(mob, path1, tpz.path.flag.RUN)
    elseif mobID == 17334380 then
        tpz.path.loop(mob, path2, tpz.path.flag.RUN)
    elseif mobID == 17334539 then
        tpz.path.loop(mob, path3, tpz.path.flag.RUN)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    mob:setRespawnTime(1800) -- 30 minutes
end