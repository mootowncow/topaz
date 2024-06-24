-----------------------------------
-- Area: Arrapago Reef
--  ZNM: Lil Apkallu
-----------------------------------
mixins = {require("scripts/mixins/rage")}
require("scripts/globals/pathfind")
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setDamage(110)
    mob:setMod(tpz.mod.DEF, 450)
    mob:setMod(tpz.mod.EVA, 350)
    mob:setMod(tpz.mod.COUNTER, 5)
    mob:setMod(tpz.mod.MOVE_SPEED_STACKABLE, -25)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 3000) -- 5k Gil
    mob:setMobMod(tpz.mobMod.GIL_MAX, 5000) 
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0) 
    mob:setLocalVar("TwoHourTime", 0)
    mob:setLocalVar("RunAroundTime",0)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
	mob:setMobMod(tpz.mobMod.SOUND_RANGE, 50)
    mob:delRoamFlag(512)
end

function onMobRoam(mob)
	local RunAroundTime = mob:getLocalVar("RunAroundTime")
	if RunAroundTime == 0 then
		return
	elseif RunAroundTime < os.time() then
		mob:setLocalVar("RunAroundTime",0)
		mob:delRoamFlag(512)
		return
	end
    -- Ensure he stays tagged
    local NearbyPlayers = mob:getPlayersInRange(50)
        if NearbyPlayers == nil then return end
        if NearbyPlayers then
            for _,v in ipairs(NearbyPlayers) do
                mob:updateClaim(v)
            end
        end
	
	-- scripted run around
	mob:addRoamFlag(512) -- ignore attacking
	if not mob:isFollowingPath() then
        if mob:getHPP() >= 5 then
		    mob:disengage()
        end
		local point = {math.random(485, 508),-2.742,math.random(173,182)}
		mob:pathThrough(point, tpz.path.flag.RUN)
	end
end

function onMobFight(mob,target)
	local YawnTime = mob:getLocalVar("YawnTime")
	local RunAroundTime = mob:getLocalVar("RunAroundTime")
    local TwoHourTime = mob:getLocalVar("TwoHourTime")
    local TwoHourDelay = mob:getLocalVar("TwoHourDelay")
    local TwoHourCounter = mob:getLocalVar("TwoHourCounter")
    local TwoHourMax = mob:getLocalVar("TwoHourMax")
    local WingWhirlTime = mob:getLocalVar("WingWhirlTime")
	local BattleTime = mob:getBattleTime()

    -- Yawn use timer
	if YawnTime == 0 then
		mob:setLocalVar("YawnTime", BattleTime + math.random(45, 60))
	elseif (BattleTime >= YawnTime and WingWhirlTime == 0 and mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) == false
    and mob:actionQueueEmpty()) then
		mob:useMobAbility(1713) -- Yawn
        mob:setLocalVar("TwoHourCounter", 0)
        mob:setLocalVar("TwoHourMax", 0)
        mob:setLocalVar("TwoHourTime", 0)
		mob:setLocalVar("YawnTime", BattleTime + math.random(90, 120))
	end

    -- Hundred fists after using Yawn at lower HP(up to 3 times)
    if TwoHourTime > 0 and os.time() >= TwoHourDelay then
        if TwoHourCounter >= TwoHourMax and TwoHourCounter > 0 and TwoHourMax > 0 then
            mob:setLocalVar("TwoHourCounter", 0)
            mob:setLocalVar("TwoHourMax", 0)
            mob:setLocalVar("TwoHourTime", 0)
        else
            if os.time() >= TwoHourDelay and mob:hasStatusEffect(tpz.effect.HUNDRED_FISTS) == false and mob:checkDistance(target) <= 5 then
                mob:useMobAbility(690) -- Hundred Fists
                mob:setLocalVar("TwoHourDelay", os.time() + 40)
            end
        end
    end
	
	if RunAroundTime == 0 then
		return
	elseif RunAroundTime < os.time() then
		mob:setLocalVar("RunAroundTime",0)
		mob:delRoamFlag(512)
		return
	end
    -- Run around after using Yawn
	mob:addRoamFlag(512) -- ignore attacking
	if not mob:isFollowingPath() then
		mob:disengage()
		local point = {math.random(485,508),-2.742,math.random(173,182)}
		mob:pathThrough(point, tpz.path.flag.RUN)
	end
end

function onMobWeaponSkillPrepare(mob, target)
	local WingWhirlTime = mob:getLocalVar("WingWhirlTime")
    local TwoHourTime = mob:getLocalVar("TwoHourTime")
    if WingWhirlTime > 0 and TwoHourTime == 0 then
        return 1717 -- Wing Whirl
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1713 then -- Yawn
        if mob:getHPP() <= 50 then -- Hundred fists after using Yawn
            mob:setLocalVar("TwoHourDelay", os.time() + 5)
            mob:setLocalVar("TwoHourTime", 1)
        end
        mob:setLocalVar("WingWhirlTime", 1)
        mob:setLocalVar("RunAroundTime", os.time() + math.random(15, 30))
    end

    if skill:getID() == 1717 then -- Wing Whirl
        local WingWhirlCounter = mob:getLocalVar("WingWhirlCounter")
        local WingWhirlMax = mob:getLocalVar("WingWhirlMax")

        if WingWhirlCounter == 0 and WingWhirlMax == 0 then
            WingWhirlMax = math.random(2, 5)
            mob:setLocalVar("WingWhirlMax", WingWhirlMax)
        end

        WingWhirlCounter = WingWhirlCounter + 1
        mob:setLocalVar("WingWhirlCounter", WingWhirlCounter)

        if WingWhirlCounter > WingWhirlMax then
            mob:setLocalVar("WingWhirlCounter", 0)
            mob:setLocalVar("WingWhirlMax", 0)
            mob:setLocalVar("WingWhirlTime", 0)
        else
            mob:useMobAbility(1717)
        end
    end
    local TwoHourTime = mob:getLocalVar("TwoHourTime")
    local TwoHourDelay = mob:getLocalVar("TwoHourDelay")
    if skill:getID() == 690 then -- Hundred fists
        local TwoHourCounter = mob:getLocalVar("TwoHourCounter")
        local TwoHourMax = mob:getLocalVar("TwoHourMax")
        if TwoHourCounter == 0 and TwoHourMax == 0 then
            TwoHourMax = math.random(1, 3)
            mob:setLocalVar("TwoHourMax", TwoHourMax)
        end

        TwoHourCounter = TwoHourCounter + 1
        mob:setLocalVar("TwoHourCounter", TwoHourCounter)
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
