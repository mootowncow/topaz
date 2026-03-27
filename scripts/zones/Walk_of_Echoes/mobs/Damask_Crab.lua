-----------------------------------
-- Area: Walk of Echoes
--  Mob: Damask Crab (Walk: #1)
-----------------------------------
local ID = require("scripts/zones/Walk_of_Echoes/IDs")
require("scripts/globals/walk_of_echoes")
-----------------------------------
function onMobSpawn(mob)
    tpz.woe.mob.onMobSpawn(mob)
end

function onMobEngaged(mob, target)
    tpz.woe.mob.onMobEngaged(mob, target)
end

function onMobFight(mob, target)
    tpz.woe.mob.onMobFight(mob, target)
end

function onMobDisengage(mob)
    tpz.woe.mob.onMobDisengage(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.woe.mob.onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
    tpz.woe.onMobDespawn(mob)
end