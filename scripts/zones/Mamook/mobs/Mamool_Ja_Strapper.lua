-----------------------------------
-- Area: Mamook
--  Mob: Mamool_Ja_Strapper
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}
-----------------------------------
function onMobEngaged(mob, target)
    local pet = GetMobByID(mob:getID()+1)
    if not pet:isSpawned() then
		utils.spawnPetInBattle(mob, pet, true, false, true)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(2488, mob)--Alexandrite 
	end
end
