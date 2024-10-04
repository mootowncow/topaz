-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Leujaoam Worm
-----------------------------------
require("scripts/globals/mobs")
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:hideName(true)
    mob:setMod(tpz.mod.UDMGPHYS, 25)
    mob:setMod(tpz.mod.UDMGRANGE, 25)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mobMod.MOVE, -25)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
	mob:setMobMod(tpz.mobMod.SOUND_RANGE, 15)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    --if mob:getID(instance) == 17060191 then
        --mob:setPos(385.6032,2.1313,-57.3992,170)
    --end
end

function onMobEngaged(mob)
    mob:setTP(3000)
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
end