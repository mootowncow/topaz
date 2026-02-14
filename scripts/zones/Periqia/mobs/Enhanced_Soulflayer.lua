-----------------------------------
-- Area: Periqia (Requiem)
--  Mob: Enhanced Soulflayer
require("scripts/globals/status")
require("scripts/globals/pathfind")
require("scripts/globals/mobs")
require("scripts/globals/salvage")
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
-----------------------------------
function onMobSpawn(mob)
    mob:setMod(tpz.mod.MDEF, 40)
    mob:setMod(tpz.mod.UDMGMAGIC, -13)
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 75)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:SetMagicCastingEnabled(false)
    mob:SetMobAbilityEnabled(false)
	mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
	local RunAwayPath = mob:getLocalVar("RunAwayPath")
	if RunAwayPath == 1 then 
	    mob:setPos(-339, -15, 205, 190)
        mob:SetMagicCastingEnabled(true)
	    mob:setLocalVar("RunAway", 1)
    end
    if RunAwayPath == 2 then 
	    mob:setPos( -380, -15, 51, 210)
        mob:SetMagicCastingEnabled(false)
        mob:SetMobAbilityEnabled(true)
	    mob:setLocalVar("RunAway", 2)
    end
    if RunAwayPath == 3 then 
	    mob:setPos(-482,-10,-83, 220)
        mob:SetMagicCastingEnabled(true)
        mob:SetMobAbilityEnabled(true)
	    mob:setLocalVar("RunAway", 3)
    end
    -- Make sure he doesn't roam with shiled up somehow
    mob:setMod(tpz.mod.MAGIC_SS, 0)
    if (mob:getMod(tpz.mod.MAGIC_SS) == 0) then
        mob:AnimationSub(0)
    end
    mob:setMod(tpz.mod.REGEN, 0)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

function onMobEngaged(mob)
	local RunAwayPath = mob:getLocalVar("RunAwayPath")
    if RunAwayPath == 1 then
        mob:setHP(63000)
        salvageUtil.msgGroup(mob, "The " .. MobName(mob) .. " calls for help!", 0xD, none)
    end
    if RunAwayPath == 2 then
        mob:setHP(56000)
    end 
    if RunAwayPath == 3 then
        mob:setHP(35000)
    end
    mob:setMod(tpz.mod.REGEN, 30)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
    local firstFightShield = mob:getLocalVar("firstFightShield")
	local ImmortalShieldTime = mob:getLocalVar("ImmortalShieldTime")
	local RunAwayPath = mob:getLocalVar("RunAwayPath")
    local RunAway = mob:getLocalVar("RunAway")
    local AnimationSub = mob:AnimationSub()
	local BattleTime = mob:getBattleTime()

    -- Use Immortal Shield immediately in the first fight
    if (RunAwayPath == 0 and firstFightShield == 0) then
        mob:setLocalVar("firstFightShield", 1)
        mob:useMobAbility(1965)
    end

    -- Handle running away
    if not IsMobBusy(mob) and not mob:hasPreventActionEffect() then
        if mob:getHPP() <= 90 and mob:getHPP() > 80 and RunAway == 0 then
            salvageUtil.msgGroup(mob, "The " .. MobName(mob) .. " disappears!", 0xD, none)
            mob:setLocalVar("RunAwayPath", 1)
            mob:disengage()
            mob:getEntity(bit.band(ID.npc._JK1, 0xFFF), tpz.objType.NPC):setAnimation(8)
        elseif mob:getHPP() <= 80 and mob:getHPP() > 70 and RunAway == 1  then
            salvageUtil.msgGroup(mob, "The " .. MobName(mob) .. " disappears!", 0xD, none)
            mob:setLocalVar("RunAwayPath", 2)
            mob:disengage()
            mob:getEntity(bit.band(ID.npc._1K6, 0xFFF), tpz.objType.NPC):setAnimation(8) -- Rock H-8
        elseif mob:getHPP() <= 70 and RunAway == 2  then
            salvageUtil.msgGroup(mob, "The " .. MobName(mob) .. " disappears!", 0xD, none)
            mob:setLocalVar("RunAwayPath", 3)
            mob:disengage()
        end
    end

    -- Handle calling adds
    if RunAway == 1 then
        local instance = mob:getInstance()
        local Mobs =
        {
            [1] = GetMobByID(17006904, instance), 
            [2] = GetMobByID(17006905, instance),
            [3] = GetMobByID(17006906, instance),
            [4] = GetMobByID(17006910, instance),
            [5] = GetMobByID(17006911, instance),
            [6] = GetMobByID(17006912, instance),
            [7] = GetMobByID(17006913, instance),
            [8] = GetMobByID(17006914, instance),
            [9] = GetMobByID(17006915, instance),
            [10] = GetMobByID(17006920, instance),
        }

        for _,v in pairs(Mobs) do
            v:updateEnmity(target)
        end
    end

    -- Handle Final Fight
	if mob:getHPP() <= 70 then
		if ImmortalShieldTime == 0 then
			mob:setLocalVar("ImmortalShieldTime", BattleTime + math.random(15, 45))
            printf("Setting first Shield Time")
		elseif BattleTime >= ImmortalShieldTime then
		    mob:useMobAbility(1965) -- Immortal Shield
		    mob:setLocalVar("ImmortalShieldTime", BattleTime + math.random(90, 120))
		end
	end

    -- Handle Immortal Shield being interrupted
    mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "ES_WS_INTERRUPTED", function(mob, skill)
        if skill == 1965 then
            mob:setLocalVar("firstFightShield", 0)
            mob:setLocalVar("ImmortalShieldTime", 1)
        end
    end)

    if AnimationSub == 2 then
        mob:setMod(tpz.mod.UDMGPHYS, -100)
        mob:setMod(tpz.mod.UDMGRANGE, -100)
        mob:setMod(tpz.mod.MDEF, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, 25)
    else
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.MDEF, 40)
        mob:setMod(tpz.mod.UDMGMAGIC, -13)
    end

    if (mob:getMod(tpz.mod.MAGIC_SS) == 0) then
        mob:AnimationSub(0)
    else
        mob:AnimationSub(2)
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1965 then
        mob:useMobAbility(math.random(1963, 1964)) 
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

function onMobDespawn(mob)
end
