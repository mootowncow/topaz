-----------------------------------
-- Area: Apollyon NW
--  Mob: Kronprinz Behemoth
-----------------------------------
function onMobSpawn(mob)
	mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
end

function onMobDeath(mob, player, isKiller, noKiller)
end
