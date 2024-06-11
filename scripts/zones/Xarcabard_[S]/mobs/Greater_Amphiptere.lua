-----------------------------------
-- Area: Xarcabard [S]
--  Mob: Greater Amphiptere
-----------------------------------
mixins = {require("scripts/mixins/families/amphiptere")}
require("scripts/globals/status")
require("scripts/globals/pathfind")
-----------------------------------

local path1 = {
    { x=389.78, y=-0.89, z=-87.98 },
    { x=48.59, y=-23.43, z=-47.01 },
    { x=80.42, y=-23.45, z=-186.43 }
};


local path2 = {
    { x=322.46, y=8.23, z=-211.09 },
    { x=417.55, y=-0.80, z=-141.47 },
    { x=364.22, y=-7.43, z=-12.35 },
    { x=434.72, y=-5.68, z=64.41 },
    { x=440.81, y=-7.97, z=115.44 }
};


local path3 = {
    { x=-195.62, y=-3.63, z=28.89 },
    { x=-148.33, y=-17.73, z=-11.33 },
    { x=-73.51, y=-17.62, z=-10.17 }
};



function onMobSpawn(mob)
end

function onMobRoam(mob)
    local mobID = mob:getID()
    if mobID == 17338586 then
        tpz.path.loop(mob, path1, tpz.path.flag.RUN)
    elseif mobID == 17338587 then
        tpz.path.loop(mob, path2, tpz.path.flag.RUN)
    elseif mobID == 17338588 then
        tpz.path.loop(mob, path3, tpz.path.flag.RUN)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    mob:setRespawnTime(1800) -- 30 minutes
end
