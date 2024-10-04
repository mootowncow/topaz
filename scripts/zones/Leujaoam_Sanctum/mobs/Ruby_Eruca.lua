-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Leujaoam Worm
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:hideName(true)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
	mob:setMobMod(tpz.mobMod.SOUND_RANGE, 15)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    --if mob:getID(instance) == 17060196 then
        --mob:setPos(379.1731,-3.4971,92.9006,180)
    --end
end

function onMobEngaged(mob)
    mob:setTP(3000)
    mob:setMod(tpz.mod.REGAIN, 250)
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
    return 1791 -- Only uses Incinerate
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
end