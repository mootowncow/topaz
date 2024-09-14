-----------------------------------
-- Area: Middle Delkfutt's Tower
--   NM: Scythe Victim
-- Involved In Quest: Blade of Evil
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:addImmunity(tpz.immunity.PETRIFY)
end


function onMobDeath(mob, player, isKiller, noKiller)
end