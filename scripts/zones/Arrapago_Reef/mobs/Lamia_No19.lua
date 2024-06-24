-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamia No.19
-----------------------------------
mixins = {require("scripts/mixins/weapon_break")}
require("scripts/globals/mobs")
require("scripts/globals/status")
------------------------------

function onMobSpawn(mob)
	mob:setDamage(120) 
	mob:addMod(tpz.mod.DEFP, 20) 
	mob:addMod(tpz.mod.ACC, 25) 
	mob:addMod(tpz.mod.MOVE_SPEED_STACKABLE, 12) 
	mob:addMod(tpz.mod.SPELLINTERRUPT, 33) 
	mob:setMod(tpz.mod.REFRESH, 400)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setLocalVar("SpawnGuards", 0)
end

function onMobFight(mob, target)
	local SpawnGuards = mob:getLocalVar("SpawnGuards")
    local mobId = mob:getID()
    if SpawnGuards == 0 then
        SpawnMob(mobId+1):updateEnmity(target)
        SpawnMob(mobId+2):updateEnmity(target)
        mob:setLocalVar("SpawnGuards", 1)
    end
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
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
