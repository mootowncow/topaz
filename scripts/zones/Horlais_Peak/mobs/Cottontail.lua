-----------------------------------
-- Area: Horlais Peak
--  Mob: Cottontail
-- BCNM: Tails of Woe
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMobMod(tpz.mobMod.CHARMABLE, 1)
end

function onMobDeath(mob, player, isKiller, noKiller)
end
