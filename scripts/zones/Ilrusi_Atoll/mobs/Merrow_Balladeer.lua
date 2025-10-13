-----------------------------------
-- Area: Ilrusi Atoll (Golden Salvage)
--  Mob: Merrow_Balladeer
-- BRD
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
mixins = 
{
    require("scripts/mixins/weapon_break"),
    require("scripts/mixins/job_special")
}
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 25)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGMAGIC, 0)
    mob:setMod(tpz.mod.HTHRES, 500)
    mob:setMod(tpz.mod.SLASHRES, 500)
    mob:setMod(tpz.mod.PIERCERES, 500)
    mob:setMod(tpz.mod.RANGEDRES, 500)
    mob:setMod(tpz.mod.IMPACTRES, 500)
    mob:setMod(tpz.mod.UFASTCAST, 75)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobRoam(mob)
    local Turn = mob:getLocalVar("Turn")
    local Time = os.time()
    if mob:getID(instance) == 17002757 then
        if Time > Turn then
            mob:setPos(322.3556,-10.0000,-51.1431, math.random(0, 255))
            mob:setLocalVar("Turn", Time + 25)
        end
    end
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
    if mob:getID(instance) == 17002767 then
        --mob:setPos(380.4065,-7.8809,72.7741, 50)
    end
end

function onMobEngaged(mob)
    local instance = mob:getInstance()
    local target = mob:getTarget(instance)
	local Buddy = 0

    if mob:getID(instance) == 17002773 then
        Buddy = GetMobByID(mob:getID(instance)+1, instance)
	    Buddy:updateEnmity(target)
    end

    if mob:getID(instance) == 17002774 then
        Buddy = GetMobByID(mob:getID(instance)-1, instance)
	    Buddy:updateEnmity(target)
    end

    mob:setLocalVar("BreakChance", 50)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    -- Enrages when weapon is Broken
    if (mob:AnimationSub() == 1) then
        mob:setMod(tpz.mod.REGAIN, 250)
        mob:setMod(tpz.mod.GLOBAL_DMG_DONE, 0)
    end
end

function onMobWeaponSkillPrepare(mob, target)
    -- Only uses Hysteric Barrage when weapon is broken
    if (mob:AnimationSub() == 1) then
        return tpz.mob.skills.HYSTERIC_BARRAGE_MERROW
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
end