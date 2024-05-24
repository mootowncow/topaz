------------------------------
-- Area: Alzadaal Undersea Ruins
--   NM: Boompadu
------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
require("scripts/globals/status")
------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

function onMobSpawn(mob)
    mob:addMod(tpz.mod.ATTP, 50)
    mob:addMod(tpz.mod.ACC, 25)
    mob:setMod(tpz.mod.REFRESH, 400)
	mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)
	mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
	mob:setMod(tpz.mod.BINDRESTRAIT, 100)
	mob:setMod(tpz.mod.GRAVITYRESTRAIT, 100)
end

function onMobRoam(mob)
    mob:setMod(tpz.mod.REGAIN, 0)
end

function onMobFight(mob, target)
    local hp = mob:getHPP()
    -- Uses TP moves every 10 seconds at 50-100% HP, then every 5 seconds below 50.
    if (hp < 25) then
        mob:setMod(tpz.mod.REGAIN, 500)
    elseif (hp < 50) then
        mob:setMod(tpz.mod.REGAIN, 1500)
    else
        mob:setMod(tpz.mod.REGAIN, 1000)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    local hp = mob:getHPP()
    -- 100%-66%: Dire Straight
    -- 66%-33%: Sinker Drill
    -- 33%-0%: Earth Shutter
    if (hp < 33) then
        return 2072 -- earth_shatter
    elseif (hp < 66) then
        return 2073 -- sinker_drill
    else
        return 2071 -- dire_straight
    end
end

function onAdditionalEffect(mob, target, damage)
	return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.ENTHUNDER, {chance = 100, power = math.random(100, 120)})
end

function onMobDeath(mob, player, isKiller, noKiller)
    tpz.hunts.checkHunt(mob, player, 476)
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
