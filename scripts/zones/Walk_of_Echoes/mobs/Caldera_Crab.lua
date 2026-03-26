-----------------------------------
-- Area: Walk of Echoes
--  Mob: Caldera Crab (Walk: #1)
-----------------------------------
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
require("scripts/globals/walk_of_echoes")
-----------------------------------
function onMobInitialize(mob)
end

function onMobSpawn(mob)
end

function onMobEngaged(mob, target)
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local zone = mob:getZone()
        local walk = 1
        tpz.woe.incrementProgress(zone, walk)
    end
end