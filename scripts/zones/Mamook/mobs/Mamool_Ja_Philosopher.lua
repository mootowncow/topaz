-----------------------------------
-- Area: Mamook
--  Mob: Mamool_Ja_Philosopher
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}
-----------------------------------

function onMobRoam(mob)
end

function onMobDeath(mob, player, isKiller, noKiller)
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(2488, mob)--Alexandrite 
	end
	mob:setLocalVar("SpawnTimer", 0)
end
