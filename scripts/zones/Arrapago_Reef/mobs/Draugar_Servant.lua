-----------------------------------
-- Area: Arrapago Reef
--  Mob: Draugar Servant
-- Note: PH for Bloody Bones
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/mobs")
-----------------------------------
function onMobEngaged(mob, target)
	if mob:getMainJob() == tpz.job.DRG then
        local pet = GetMobByID(mob:getID()+1)
        if not pet:isSpawned() then
		    utils.spawnPetInBattle(mob, pet, true, false, true)
        end
	end
end

function onMobDeath(mob, player, isKiller, noKiller)
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(2488, mob)--Alexandrite 
	end
end

function onMobDespawn(mob)
    tpz.mob.phOnDespawn(mob, ID.mob.BLOODY_BONES_PH, 20, 36000) -- 11 hours
end
