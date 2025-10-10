-----------------------------------
-- Area: Mamook
--  Mob: Mamool_Ja_Pikeman
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}
-----------------------------------
function onMobEngaged(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(2488, mob)--Alexandrite 
	end
end
