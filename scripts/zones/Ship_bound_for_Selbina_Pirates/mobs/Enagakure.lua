-----------------------------------
-- Area: Ship bound for Selbina (Pirates)
--  Mob: Enagakure
-- Involved in Quest: I'll Take the Big Box
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobDeath(mob, player, isKiller, noKiller)

    if (player:hasKeyItem(tpz.ki.SEANCE_STAFF) and player:getCharVar("Enagakure_Killed") == 0) then
        player:setCharVar("Enagakure_Killed", 1)
    end

end
