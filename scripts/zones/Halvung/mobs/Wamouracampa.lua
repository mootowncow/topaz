-----------------------------------
-- Area: Halvung
--  Mob: Wamouracampa
-----------------------------------
require("scripts/globals/status")
mixins = {require("scripts/mixins/families/wamouracampa")}
-----------------------------------

function onMobDeath(mob)
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(2488, mob)--Alexandrite 
	end
end
