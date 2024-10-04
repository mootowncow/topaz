-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Sleepy Wamourcampa
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:hideName(true)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mobMod.MOVE, -25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
	mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    --mob:setPos(511.3300,8.5709,-81.2756,130)
end

function onMobEngaged(mob)
    mob:hideName(false)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
	local StunTime = mob:getLocalVar("StunTime")
	local DreadSpikesTime = mob:getLocalVar("DreadSpikesTime")
	local DrainTime = mob:getLocalVar("DrainTime")
	local BattleTime = mob:getBattleTime()
end

function onMobWeaponSkillPrepare(mob, target)
    return 1819 -- Only uses Heat Barrier
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1819 then -- Heat Barrier
         mob:useMobAbility(1817) -- Thermal Pulse
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    local target = mob:getTarget(instance)
    local Wamoura = GetMobByID(mob:getID(instance)+1, instance)
    SpawnMob(17060199, instance)
	Wamoura:updateEnmity(player)
    Wamoura:setMobMod(tpz.mobMod.NO_AGGRO, 0)
    OnDeathMessage(mob, player, isKiller, noKiller, "The Wamouracampa's cocoon opens and something big appears!", 0xD, none)
end