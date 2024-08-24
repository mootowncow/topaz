-----------------------------------
-- Area: Ilrusi Atoll (Golden Salvage)
--  Mob: Evolved_Orobon
-- WAR
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
require("scripts/globals/pathfind")
mixins = {require("scripts/mixins/families/qutrub")}
-----------------------------------
local path =
{
    414.4073,-3.1179,150.6085,
    410.4030,-7.1669,130.3957
}

function onMobSpawn(mob)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.HTHRES, 500)
    mob:setMod(tpz.mod.SLASHRES, 500)
    mob:setMod(tpz.mod.PIERCERES, 500)
    mob:setMod(tpz.mod.RANGEDRES, 500)
    mob:setMod(tpz.mod.IMPACTRES, 500)
    mob:setMobMod(tpz.mobMod.MOBMOD_SUPERLINK, 30)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobRoam(mob)
	local Path = mob:getLocalVar("Path")
	local Wait = mob:getLocalVar("Wait")
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    if mob:getID(instance) == 17002775 then
        --mob:setPos(508.7736,-7,101.6420,130)
    end
    if mob:getID(instance) == 17002768 then
        if Path == 0 then
            mob:pathTo(414,-3,150)
            mob:setLocalVar("Path", 1)
            mob:setLocalVar("Wait", os.time()+1)
        end
        if os.time() > Wait and Path == 1 then
            mob:pathTo(410,-7,130)
            mob:setLocalVar("Path", 0)
            mob:setLocalVar("Wait", os.time()+1)
        end
    end
end

function onMobEngaged(mob)
    local instance = mob:getInstance()
    local target = mob:getTarget(instance)
	local Buddy = 0
    if mob:getID(instance) == 17002760 then
        Buddy = GetMobByID(mob:getID(instance)+1, instance)
	    Buddy:updateEnmity(target)
    end
    if mob:getID(instance) == 17002761 then
        Buddy = GetMobByID(mob:getID(instance)-1, instance)
	    Buddy:updateEnmity(target)
    end
    if mob:getID(instance) == 17002771 then
        Buddy = GetMobByID(mob:getID(instance)-1, instance)
	    Buddy:updateEnmity(target)
    end
    if mob:getID(instance) == 17002775 then
        Buddy = GetMobByID(mob:getID(instance)-1, instance)
	    Buddy:updateEnmity(target)
    end
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
end

function onMobWeaponSkillPrepare(mob, target)
    return 1782 -- Only uses Animating Wail
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1782 then -- Animating Wail
         mob:useMobAbility(math.random(1778, 1781)) -- Spinal Cleave, Mangle, Leaping Cleave, Hex Palm
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end