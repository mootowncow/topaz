-----------------------------------
-- Area: Mamook
--   NM: Dragonscaled Bugaal Ja
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
function onMobSpawn(mob)
    SetGenericNMStats(mob)
end

function onMobEngaged(mob, target)
    for i = mob:getID() + 1, mob:getID() + 3 do
        local pet = GetMobByID(i)
        if (pet:getCurrentAction() == tpz.act.ROAMING) then
            pet:updateEnmity(target)
        end
    end
end

function onMobFight(mob, target)
        local mobId = mob:getID()
        local bugard1 = GetMobByID(mobId +1)
        local bugard2 = GetMobByID(mobId +2)
        local bugard3 = GetMobByID(mobId +3)
        local currentlySummoning = mob:getLocalVar("SpawnPetAnimation")

    -- Spawn the pets if they are killed
    if (currentlySummoning == 0) then
        if not bugard1:isSpawned() or not bugard2:isSpawned() or not bugard3:isSpawned() then
            utils.spawnPetInBattle(mob, { bugard1, bugard2, bugard3 }, true, false, true)
        end
    end

    -- Make sure all pets engage with master
    for i = mob:getID() + 1, mob:getID() + 3 do
        local pet = GetMobByID(i)
        if (pet:getCurrentAction() == tpz.act.ROAMING) then
            pet:updateEnmity(target)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
	if isKiller  then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
	if isKiller and math.random(1,100) <= 15 then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(100800, 259200)) -- 28 to 72 hours
end
