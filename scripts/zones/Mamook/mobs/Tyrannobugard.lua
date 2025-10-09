-----------------------------------
-- Area: Mamook
--   NM: Tyrannobugard
-- Pet of Dragonscaled Bugaal Ja
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.GIL_MAX, -1)
    mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
end

function onMobDeath(mob, player, isKiller, noKiller)
end

function onMobDespawn(mob)
end
