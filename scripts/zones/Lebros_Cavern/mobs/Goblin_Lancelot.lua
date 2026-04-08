-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Red Pineapple
-- 
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/mobs")
require("scripts/globals/assault")
-----------------------------------
function onMobSpawn(mob)
    SetExcavationDutyMods(mob)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.LINK_RADIUS, 30)
    --mob:AnimationSub(0)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    if mob:getID(instance) == 17002772 then
        --mob:setPos(558.6038,-15.6880,139.2372,160)
    end
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobDeath(mob, player, isKiller, noKiller)
end