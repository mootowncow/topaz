-----------------------------------
-- Area: Arrapago Reef
--  Mob: Jnun
-----------------------------------
require("scripts/globals/mobs")
mixins = {require("scripts/mixins/families/jnun")}
-----------------------------------
function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.NO_ROAM, 1)
end

function onMobDisengage(mob)
    local spawnPos = mob:getSpawnPos()
    mob:setPos(spawnPos.x, spawnPos.y, spawnPos.z)
end

function onMobDeath(mob, player, isKiller, noKiller)
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(2488, mob)--Alexandrite 
	end
end
