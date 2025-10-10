-----------------------------------
-- Area: Caedarva Mire
--  Mob: Reserve_Draugar
-- Note: 
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
function onMobEngaged(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(2488, mob)--Alexandrite 
	end
end
