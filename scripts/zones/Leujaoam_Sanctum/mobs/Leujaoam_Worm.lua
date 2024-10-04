-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Leujaoam Worm
-----------------------------------
require("scripts/globals/mobs")
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/utils")
-----------------------------------
function onMobSpawn(mob)
    mob:hideName(true)
    mob:untargetable(true)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:addMod(tpz.mod.SPELLINTERRUPT, 300)
	mob:setMobMod(tpz.mobMod.SOUND_RANGE, 15)
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
    local instance = npc:getInstance()
    if mob:getID(instance) == 17060180 or mob:getID(instance) == 17060177 or mob:getID(instance) == 17060178 then
        mob:setMobMod(tpz.mobMod.DRAW_IN, 2) 
    end
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
end

function onMobEngaged(mob)
    mob:hideName(false)
    mob:untargetable(false)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
	local StunTime = mob:getLocalVar("StunTime")
	local DreadSpikesTime = mob:getLocalVar("DreadSpikesTime")
	local DrainTime = mob:getLocalVar("DrainTime")
	local BattleTime = mob:getBattleTime()
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 25)
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    if mob:getID(instance) == 17060180 then
         GetMobByID(17060179,instance):setMobMod(tpz.mobMod.DRAW_IN, 2) 
    end
end