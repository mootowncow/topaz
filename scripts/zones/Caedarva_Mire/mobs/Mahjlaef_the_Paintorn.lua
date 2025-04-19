-----------------------------------
-- Area: Caedarva Mire (79)
--  ZNM: Mahjlaef the Paintorn
-- !pos 695.369 -7.147 527.646
-----------------------------------
mixins =
{
    require("scripts/mixins/rage"),
}
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
    mob:setDamage(130)
    mob:setMod(tpz.mod.ATT, 522)
    mob:setMod(tpz.mod.DEF, 422)
    mob:setMod(tpz.mod.EVA, 278)
    mob:setMod(tpz.mod.MDEF, 20)
    mob:setMod(tpz.mod.UDMGMAGIC, -25)
    mob:setMod(tpz.mod.SDT_FIRE, 70)
    mob:setMod(tpz.mod.SDT_ICE, 50)
    mob:setMod(tpz.mod.SDT_WIND, 70)
    mob:setMod(tpz.mod.SDT_EARTH, 70)
    mob:setMod(tpz.mod.SDT_THUNDER, 70)
    mob:setMod(tpz.mod.SDT_WATER, 10)
    mob:setMod(tpz.mod.SDT_LIGHT, 85)
    mob:setMod(tpz.mod.SDT_DARK, 5)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 8000) -- 9k Gil
    mob:setMobMod(tpz.mobMod.GIL_MAX, 9000) 
    mob:setMobMod(tpz.mobMod.GIL_BONUS, 0)
    mob:setSpellList(2057)
    mob:AnimationSub(0)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

function onMobFight(mob, target)
	local Phase = mob:getLocalVar("Phase")
	local ShieldBroken = mob:getLocalVar("ShieldBroken")
    local AnimationSub = mob:AnimationSub()
	local BattleTime = mob:getBattleTime()
    local immortalShield = mob:getLocalVar("immortalShield")

    -- Uses Immortal shield every 20% HP
    if mob:getHPP() < 80 and Phase == 0 then
        mob:setLocalVar("Phase", 1)
        mob:setLocalVar("immortalShield", 1)
	end
    if mob:getHPP() < 60 and Phase == 1 then
        mob:setLocalVar("Phase", 2)
        mob:setLocalVar("immortalShield", 1)
	end
    if mob:getHPP() < 40 and Phase == 2 then
        mob:setLocalVar("Phase", 3)
        mob:setLocalVar("immortalShield", 1)
	end
    if mob:getHPP() < 20 and Phase == 3 then
        mob:setLocalVar("Phase", 4)
        mob:setLocalVar("immortalShield", 1)
	end

    if
        (immortalShield == 1) and
        not IsMobBusy(mob) and
        not mob:hasPreventActionEffect()
    then
        mob:useMobAbility(tpz.mob.skills.IMMORTAL_SHIELD)
        mob:setLocalVar("immortalShield", 0)
    end

    -- While his shields are up physical damage taken is GREATLY reduced.
    if AnimationSub > 0 then
        if AnimationSub == 2 then
            mob:setSpellList(2058) -- AM2, T3 -gas, status -gas
        elseif AnimationSub == 1 then
            mob:setSpellList(2059) -- AM1, T2 -gas
        end
        mob:setMod(tpz.mod.UDMGPHYS, -99)
        mob:setMod(tpz.mod.UDMGRANGE, -99)
        mob:setMod(tpz.mod.MDEF, 0)
        mob:setMod(tpz.mod.UDMGMAGIC, 25)
    else
        mob:setSpellList(2057) -- T3 Nukes, Absorb-TP, Drain 2, Aspir 2, T2 Enfeebles
        mob:setMod(tpz.mod.UDMGPHYS, 0)
        mob:setMod(tpz.mod.UDMGRANGE, 0)
        mob:setMod(tpz.mod.MDEF, 20)
        mob:setMod(tpz.mod.UDMGMAGIC, -25)
    end

    -- Dealing magic damage removes 1 shield
    if (mob:getMod(tpz.mod.MAGIC_SS) == 0) then
        -- Reapply another magic stoneskin after first shield is broken
        if AnimationSub == 2 and ShieldBroken == 0 then
            mob:AnimationSub(1)
            mob:setMod(tpz.mod.MAGIC_SS, 1500)
		    mob:setLocalVar("ShieldBroken", 1)
        end
        -- Second shield broken
        if AnimationSub == 1 and ShieldBroken == 1 then
            mob:AnimationSub(0)
		    mob:setLocalVar("ShieldBroken", 0)
            -- Uses a full dispel TP move when both shields are broken
            if Phase == 4 then -- Uses Reprobation if below 20% HP
                mob:useMobAbility(1969) -- Reprobation
            else
                mob:useMobAbility(1966) -- Mind Purge
            end
        end
    end

    -- Handle Immortal Shield being interrupted
    mob:addListener("WEAPONSKILL_STATE_INTERRUPTED", "MAHLJ_WS_INTERRUPTED", function(mob, skill)
        if (skill == tpz.mob.skills.IMMORTAL_SHIELD) then
            mob:setLocalVar("immortalShield", 1)
        end
    end)
end

function onMobWeaponSkill(target, mob, skill)
    -- Gain floating shields after usnig Immortal Shields
    if (skill:getID() == tpz.mob.skills.IMMORTAL_SHIELD) then
        mob:AnimationSub(2)
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addCurrency("zeni_point", 300)
	if isKiller  then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
	if isKiller and math.random(1,100) <= 24 then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
	if isKiller and math.random(1,100) <= 15 then 
		player:addTreasure(5735, mob)--Cotton Coin Purse
	end
end
