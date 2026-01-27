-----------------------------------
-- Area: Mamool Ja Trianing Grounds (Imperial Agent Rescue)
--  Mob: Mamool Ja Medic
-- Job: NIN
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/instance")
local ID = require("scripts/zones/Mamool_Ja_Training_Grounds/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.MDEF, 40)
    mob:setMod(tpz.mod.UDMGMAGIC, -13)
    mob:setMod(tpz.mod.COUNTER,50)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:addImmunity(tpz.immunity.SLEEP)
    mob:setStatus(tpz.status.INVISIBLE)
end

function onMobRoam(mob)
	local Path = mob:getLocalVar("Path")
	local Wait = mob:getLocalVar("Wait")
    local flags = tpz.path.flag.NONE
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    if mob:getID(instance) == 17047923 then
        if os.time() > Wait and Path == 0 then
            mob:pathTo(255,1,-457, flags)
            mob:setLocalVar("Path", 1)
            mob:setLocalVar("Wait", os.time()+12)
        end
        if os.time() > Wait and Path == 1 then
            mob:pathTo(-208,2,-463, flags)
            mob:setLocalVar("Path", 0)
            mob:setLocalVar("Wait", os.time()+12)
        end
    end
    if mob:getID(instance) == 17047925 then
        if os.time() > Wait and Path == 0 then
            mob:pathTo(178,2,-459 , flags)
            mob:setLocalVar("Path", 1)
            mob:setLocalVar("Wait", os.time()+12)
        end
        if os.time() > Wait and Path == 1 then
            mob:pathTo(223,2,-462, flags)
            mob:setLocalVar("Path", 0)
            mob:setLocalVar("Wait", os.time()+12)
        end
    end
    if mob:getID(instance) == 17047927 then
        if os.time() > Wait and Path == 0 then
            mob:pathTo(183,1,-542, flags)
            mob:setLocalVar("Path", 1)
            mob:setLocalVar("Wait", os.time()+12)
        end
        if os.time() > Wait and Path == 1 then
            mob:pathTo(228,2,-537, flags)
            mob:setLocalVar("Path", 0)
            mob:setLocalVar("Wait", os.time()+12)
        end
    end
    if mob:getID(instance) == 17047929 then
        if os.time() > Wait and Path == 0 then
            mob:pathTo(263,2,-541, flags)
            mob:setLocalVar("Path", 1)
            mob:setLocalVar("Wait", os.time()+12)
        end
        if os.time() > Wait and Path == 1 then
            mob:pathTo(214,2,-537, flags)
            mob:setLocalVar("Path", 0)
            mob:setLocalVar("Wait", os.time()+12)
        end
    end
    if mob:getID(instance) == 17047931 then
        if os.time() > Wait and Path == 0 then
            mob:pathTo(120,2,-499, flags)
            mob:setLocalVar("Path", 1)
            mob:setLocalVar("Wait", os.time()+15)
        end
        if os.time() > Wait and Path == 1 then
            mob:pathTo(173,1,-500, flags)
            mob:setLocalVar("Path", 0)
            mob:setLocalVar("Wait", os.time()+15)
        end
    end
    if mob:getID(instance) == 17047933 then
        if os.time() > Wait and Path == 0 then
            mob:pathTo(98,2,-539, flags)
            mob:setLocalVar("Path", 1)
            mob:setLocalVar("Wait", os.time()+15)
        end
        if os.time() > Wait and Path == 1 then
            mob:pathTo(20,2,-543, flags)
            mob:setLocalVar("Path", 0)
            mob:setLocalVar("Wait", os.time()+15)
        end
    end
    if mob:getID(instance) == 17047934 then
        if os.time() > Wait and Path == 0 then
            mob:pathTo(20,2,-543, flags)
            mob:setLocalVar("Path", 1)
            mob:setLocalVar("Wait", os.time()+15)
        end
        if os.time() > Wait and Path == 1 then
            mob:pathTo(98,2,-539, flags)
            mob:setLocalVar("Path", 0)
            mob:setLocalVar("Wait", os.time()+15)
        end
    end
    --if mob:getID(instance) == 17047941 then
        --mob:setPos(-57.0044,3.0815,-431.4511,65)
    --end
    --mob:setStatus(tpz.status.UPDATE)
end

function onMobEngaged(mob)
    mob:setStatus(tpz.status.UPDATE)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    mob:setStatus(tpz.status.UPDATE)
end

function onMobWeaponSkillPrepare(mob, target)
    return 1734 -- Only uses Warm-Up
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1734 then -- Warm-Up
         mob:useMobAbility(math.random(1731, 1733)) -- Forceful Blow, Somersault Kick, Fire Spit
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    instanceUtil.ImperialAgentRescue.SpawnChestOnMobDeath(mob, player, isKiller, noKiller)
end