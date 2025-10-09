------------------------------
-- Area: Mamook
--   NM: Hundredfaced Hapool Ja
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local function DespawnClones()
    for clone = 17043666, 17043669 do
        DespawnMob(GetMobByID(clone))
    end
end

function onMobSpawn(mob)
    SetGenericNMStats(mob)
    mob:setMod(tpz.mod.REGAIN, 200)
     tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIJIN_GAKURE, cooldown = 45, hpp = 90},
        },
     })
    mob:SetMagicCastingEnabled(false)
    mob:setLocalVar("UtsuTime", 0)
end

function onMobRoam(mob)
    mob:SetMagicCastingEnabled(false)
end

function onMobEngaged(mob)
    mob:SetMagicCastingEnabled(true)
end

function onMobFight(mob, target)
	local UtsuTime = mob:getLocalVar("UtsuTime")
	local BattleTime = mob:getBattleTime()

	if UtsuTime == 0 then
		mob:setLocalVar("UtsuTime", BattleTime + 45)
	elseif BattleTime >= UtsuTime then
		mob:castSpell(339, mob) -- Utusemi: Ni
		mob:setLocalVar("UtsuTime", BattleTime + 45)
	end
end

function onSpellPrecast(mob, spell)
	local target = mob:getTarget()
    local Guard = GetMobByID(17043666)
    local GuardTwo = GetMobByID(17043667)
    local GuardThree = GetMobByID(17043668)
    local GuardFour = GetMobByID(17043669)
    local X = mob:getXPos()
    local Y = mob:getYPos()
    local Z = mob:getZPos()
	if (spell:getID() == 339) then -- Utsusemi: Ni
		Guard:spawn()
        GuardTwo:spawn()
        GuardThree:spawn()
        GuardFour:spawn()
		Guard:updateEnmity(target)
        GuardTwo:updateEnmity(target)
        GuardThree:updateEnmity(target)
        GuardFour:updateEnmity(target)
		Guard:setPos(X, Y, Z)
		Guard:setSpawn(X, Y, Z)
		GuardTwo:setPos(X, Y, Z)
		GuardTwo:setSpawn(X, Y, Z)
		GuardThree:setPos(X, Y, Z)
		GuardThree:setSpawn(X, Y, Z)
		GuardFour:setPos(X, Y, Z)
		GuardFour:setSpawn(X, Y, Z)
	end
end

function onMobDisengage(mob)
    DespawnClones()
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
    DespawnClones()
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 461)
    DespawnClones()
	if isKiller  then 
		player:addTreasure(5736, mob)--Linen Coin Purse
	end
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(5736, mob)--Linen Coin Purse
	end
	if isKiller and math.random(1,100) <= 15 then 
		player:addTreasure(5736, mob)--Linen Coin Purse
	end
end
