-----------------------------------
-- Area: Alzadaal Undersea Ruins
--  ZNM: Cheese Hoarder Gigiroon
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/status")
require("scripts/globals/pathfind")
require("scripts/globals/mobs")
-----------------------------------
local Mines =
{
    [1] = 17072173,
    [2] = 17072174,
    [3] = 17072175,
    [4] = 17072176,
    [5] = 17072177,
}

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
	mob:setDamage(150)
    mob:setMod(tpz.mod.DEF, 450)
    mob:setMod(tpz.mod.ACC, 500) 
    mob:setMod(tpz.mod.EVA, 380)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 25) 
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000) -- 5k Gil
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000) 
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0) 
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobFight(mob, target)
    local LayMine = mob:getLocalVar("LayMine")
    local LayingMines = mob:getLocalVar("LayingMines")
    local LayingMinesMultuple = mob:getLocalVar("LayingMinesMultuple")
    local MineLayingDelay = mob:getLocalVar("MineLayingDelay")
    local BattleTime = mob:getBattleTime()
    local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()
    local pet = GetMobByID(17072173)
    if BattleTime >= MineLayingDelay and LayingMines == 1 then
        if not pet:isSpawned() then
            pet:spawn()
            pet:setPos(mobX, mobY, mobZ)
            pet:updateEnmity(target)
        end
    end
    if BattleTime >= MineLayingDelay and LayingMinesMultuple == 1 then
        if not GetMobByID(17072173):isSpawned() then
            pet = GetMobByID(17072173)
            pet:spawn()
            pet:setPos(mobX, mobY, mobZ)
            pet:updateEnmity(target)
            mob:setLocalVar("MineLayingDelay", BattleTime + 5)
        elseif not GetMobByID(17072174):isSpawned() then
            pet = GetMobByID(17072174)
            pet:spawn()
            pet:setPos(mobX, mobY, mobZ)
            pet:updateEnmity(target)
            mob:setLocalVar("MineLayingDelay", BattleTime + 5)
        elseif not GetMobByID(17072175):isSpawned() then
            pet = GetMobByID(17072175)
            pet:spawn()
            pet:setPos(mobX, mobY, mobZ)
            pet:updateEnmity(target)
            mob:setLocalVar("MineLayingDelay", BattleTime + 5)
        elseif not GetMobByID(17072176):isSpawned() then
            pet = GetMobByID(17072176)
            pet:spawn()
            pet:setPos(mobX, mobY, mobZ)
            pet:updateEnmity(target)
            mob:setLocalVar("MineLayingDelay", BattleTime + 5)
        elseif not GetMobByID(17072177):isSpawned() then
            pet = GetMobByID(17072177)
            pet:spawn()
            pet:setPos(mobX, mobY, mobZ)
            pet:updateEnmity(target)
            mob:setLocalVar("MineLayingDelay", BattleTime + 5)
        end
    end
	if LayMine == 0 then
		mob:setLocalVar("LayMine", BattleTime + math.random(60, 75))
	elseif BattleTime >= LayMine then
        local RNG = math.random()
        if RNG < 0.8 then
            if LayingMines == 0 then
                mob:setLocalVar("MineLayingDelay", BattleTime + 3)
                mob:setLocalVar("LayingMines", 1)
            end
            local pos = mob:getSpawnPos()
		    mob:pathTo(-182, -8, -20)
		    mob:SetAutoAttackEnabled(false)
            mob:SetMagicCastingEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:setLocalVar("LayMine", BattleTime + math.random(90, 180))
        else
            if LayingMines == 0 then
                mob:setLocalVar("MineLayingDelay", BattleTime + 3)
                mob:setLocalVar("LayingMinesMultuple", 1)
            end
            local pos = mob:getSpawnPos()
		    mob:pathTo(9, -4, -20)
		    mob:SetAutoAttackEnabled(false)
            mob:SetMagicCastingEnabled(false)
            mob:SetMobAbilityEnabled(false)
            mob:setLocalVar("LayMine", BattleTime + math.random(90, 180))
        end
	end

	local Pos = mob:getPos()
	if (Pos.x == -182) and (LayingMines == 1) then
        for v = 17072173, 17072177, 1 do
            DespawnMob(v)   
        end
        mob:disengage()
 		mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:setLocalVar("LayingMines", 0)
	end
	if (Pos.x == 9) and (LayingMinesMultuple == 1) then
        for v = 17072173, 17072177, 1 do
            DespawnMob(v)   
        end
        mob:disengage()
 		mob:SetAutoAttackEnabled(true)
        mob:SetMagicCastingEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:setLocalVar("LayingMinesMultuple", 0)
	end
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addCurrency("zeni_point", 100)
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
