-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Troll Destroyer
-- 
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/mobs")
-----------------------------------
function onMobSpawn(mob)
    mob:setDamage(200)
    mob:setMod(tpz.mod.MDEF, 40)
    mob:setMod(tpz.mod.UDMGMAGIC, 13)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 2) 
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
	mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 20)
    mob:AnimationSub(4)
	mob:setLocalVar("TwoHourUsed", 0)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    mob:AnimationSub(4)
    mob:setLocalVar("TwoHourUsed", 0)
    --if mob:getID(instance) == 17002772 then
        --mob:setPos(558.6038,-15.6880,139.2372,160)
    --end
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    if mob:getHPP() <= 25 then
        mob:addStatusEffect(tpz.effect.HUNDRED_FISTS)
	    local TwoHourUsed = mob:getLocalVar("TwoHourUsed")
	    if TwoHourUsed == 0 then
		    mob:useMobAbility(690) -- Hundred Fists
		    mob:AnimationSub(1)
		    mob:setLocalVar("TwoHourUsed", 1)
	    end
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end