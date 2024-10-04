-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Ravaging Diremite
-----------------------------------
require("scripts/globals/mobs")
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
-----------------------------------
local auraParams = {
    radius = 10,
    effect = tpz.effect.GEO_SLOW,
    power = 3000,
    duration = 3,
    auraNumber = 1
}

function onMobSpawn(mob)
    mob:hideName(true)
    mob:setMod(tpz.mod.MDEF, 40)
    mob:setMod(tpz.mod.UDMGMAGIC, 13)
    mob:setMobMod(tpz.mobMod.MOVE, 0)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
	mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 20)
    mob:SetMobAbilityEnabled(true)
    mob:setLocalVar("Message", 1)
    mob:setLocalVar("MessageWait", 0)
	mob:setLocalVar("SpinningTopTime", 0)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    mob:setMobMod(tpz.mobMod.MOVE, 0)
    mob:SetMobAbilityEnabled(true)
end

function onMobEngaged(mob)
    mob:setDamage(140)
    mob:addMod(tpz.mod.ATTP, 100)
    mob:hideName(false)
    mob:setMobMod(tpz.mobMod.MOVE, 0)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:SetMobAbilityEnabled(true)
end

function onMobFight(mob, target)
	local SpinningTopTime = mob:getLocalVar("SpinningTopTime")
	local Message = mob:getLocalVar("Message")
	local MessageWait = mob:getLocalVar("MessageWait")
	local BattleTime = mob:getBattleTime()

	if mob:getHPP() < 75 then
		if SpinningTopTime == 0 then
			mob:setLocalVar("SpinningTopTime", BattleTime)
		elseif BattleTime >= SpinningTopTime then
            mob:SetMobAbilityEnabled(true)
            mob:setMobMod(tpz.mobMod.MOVE, -25)
            mob:useMobAbility(365) -- Spinning Top
            mob:useMobAbility(365) -- Spinning Top
            mob:useMobAbility(365) -- Spinning Top
            mob:SetMobAbilityEnabled(false)
            mob:setLocalVar("MessageWait", BattleTime + 14)
            mob:setLocalVar("Message", 0)
			mob:setLocalVar("SpinningTopTime", BattleTime + 30)
		end
	end
    if Message == 0 and BattleTime >= MessageWait then
        local zonePlayers = mob:getZone():getPlayers()
        for _, zonePlayer in pairs(zonePlayers) do
            zonePlayer:PrintToPlayer("The Ravaging Diremite is very exhausted.",0,"Ravaging Diremite")
        end
        mob:setLocalVar("Message", 1)
    end
    TickMobAura(mob, target, auraParams)
    AddMobAura(mob, target, auraParams)
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    SpawnMob(17060198, instance)
    OnDeathMessage(mob, player, isKiller, noKiller, "You hear a rumbling noise in the distance...", 0xD, none)
end