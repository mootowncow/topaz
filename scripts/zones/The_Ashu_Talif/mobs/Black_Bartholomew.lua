-----------------------------------
-- Area: The Ashu Talif (The Black Coffin & Scouting the Ashu Talif)
--  Mob: Black Bartholomew
-----------------------------------
require("scripts/globals/status")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------

function onMobInitialize(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.EXP_BONUS, -100)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobEngaged(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    for v = ID.mob[56].CREW[1], ID.mob[56].MARINE[5] do
        DespawnMob(v, instance)
    end
    instance:setLocalVar("bartholomew_killed", 1)
end

function onMobDespawn(mob)
end
