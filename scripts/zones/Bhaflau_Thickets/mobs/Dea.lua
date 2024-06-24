-----------------------------------
-- Area: Bhaflau Thickets
--  ZNM: Dea
-----------------------------------
mixins =
{
    require("scripts/mixins/rage")
}
require("scripts/globals/status")
-----------------------------------
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setDamage(220) -- 500 dmg crits
    mob:setMod(tpz.mod.ATT, 522)
    mob:setMod(tpz.mod.DEF, 522)
    mob:setMod(tpz.mod.EVA, 320)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.STORETP, 100)
    mob:setMod(tpz.mod.REGEN, 5)
    mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, 8)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 8000) -- 9k Gil
    mob:setMobMod(tpz.mobMod.GIL_MAX, 9000) 
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0) 
    mob:AnimationSub(0)
	mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    mob:setLocalVar("CripplingSlamEnabled", 0)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobFight(mob, target)
	local CripplingSlamEnabled = mob:getLocalVar("CripplingSlamEnabled")
    -- If  Demo Roar or Boiling Blood is used, follow up with a Crippling Slam at next possible chance when target is in range
    if CripplingSlamEnabled > 0 and mob:checkDistance(target) <= 10 then
        mob:useMobAbility(2104) -- Crippling Slam
        mob:setLocalVar("CripplingSlamEnabled", 0)
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 2101 or skill:getID() == 2102 then -- Uses Crippling Slam after Demo Roar and Boiling Blood
        mob:setLocalVar("CripplingSlamEnabled", 1)
    end
    if skill:getID() == 2104 then -- Crippling Slam
        mob:setLocalVar("CripplingSlamEnabled", 0) 
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addCurrency("zeni_point", 300)
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
