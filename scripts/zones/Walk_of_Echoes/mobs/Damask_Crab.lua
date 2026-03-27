-----------------------------------
-- Area: Walk of Echoes
--  Mob: Damask Crab (Walk: #1)
-----------------------------------
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
require("scripts/globals/walk_of_echoes")
-----------------------------------
function onMobSpawn(mob)
    tpz.woe.onMobSpawn(mob)
end

function onMobEngaged(mob, target)
    tpz.woe.onMobEngaged(mob, target)
end

function onMobFight(mob, target)
    tpz.woe.onMobFight(mob, target)
end

function onMobDisengage(mob)
    tpz.woe.onMobDisengage(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.woe.onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    tpz.woe.onMobDespawn(mob)
end