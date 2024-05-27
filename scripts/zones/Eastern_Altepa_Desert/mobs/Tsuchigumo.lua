-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Tsuchigumo
-- Involved in Quest: 20 in Pirate Years
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if player:getCharVar("twentyInPirateYearsCS") == 3 then
        player:addCharVar("TsuchigumoKilled", 1)
    end
end
