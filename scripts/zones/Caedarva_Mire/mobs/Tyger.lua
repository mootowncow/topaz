-----------------------------------
-- Area: Caedarva Mire
--  ZNM: Tyger
-- !pos -766 -12 632 79
-- Spawn with Singed Buffalo: !additem 2593
-----------------------------------
mixins =
{
    require("scripts/mixins/job_special"),
    require("scripts/mixins/rage")
}
require("scripts/globals/magic")
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 300)
end

function onMobSpawn(mob)
	mob:setDamage(140) -- Hits buffed pld/NIN for 400+
    mob:setMod(tpz.mod.ATT, 450)
    mob:setMod(tpz.mod.DEF, 570)
    mob:setMod(tpz.mod.EVA, 358)
    mob:setMod(tpz.mod.MDEF, 40)
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.UDMGBREATH, -50)
    mob:setMod(tpz.mod.DMGSPIRITS, -50) 
    mob:setMod(tpz.mod.SDT_FIRE, 40)
    mob:setMod(tpz.mod.SDT_ICE, 80)
    mob:setMod(tpz.mod.SDT_WIND, 40)
    mob:setMod(tpz.mod.SDT_EARTH, 50)
    mob:setMod(tpz.mod.SDT_THUNDER, 30)
    mob:setMod(tpz.mod.SDT_WATER, 80)
    mob:setMod(tpz.mod.SDT_LIGHT, 50)
    mob:setMod(tpz.mod.SDT_DARK, 80)
    mob:setMod(tpz.mod.DOUBLE_ATTACK, 25)
    mob:setMod(tpz.mod.TRIPLE_ATTACK, 10)
    mob:setMod(tpz.mod.REGAIN, 0)
	mob:setMobMod(tpz.mobMod.MAGIC_COOL, 10)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.GIL_MIN, 12000)
    mob:setMobMod(tpz.mobMod.GIL_MAX, 14000)
    mob:setMobMod(tpz.mobMod.MUG_GIL, 8000)
    mob:AnimationSub(0)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), tpz.behavior.NO_TURN))
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setLocalVar("WingsBreakChance", 5) -- Wings break chance
end

function onMobFight(mob, target)
	local Phase = mob:getLocalVar("Phase")
    local SyngerismUses = mob:getLocalVar("SyngerismUses")
	local PathToPudding = mob:getLocalVar("PathToPudding")
	local Pudding = mob:getLocalVar("Pudding")
	local LastPudding = mob:getLocalVar("LastPudding")
	local Retaliated = mob:getLocalVar("Retaliated")
	local BattleTime = mob:getBattleTime()
    -- Wing break Logic

    -- 10% chance to break horn on critical hit
    mob:addListener("CRITICAL_TAKE", "TYGER_CRITICAL_TAKE", function(mob)
        if math.random(100) <= mob:getLocalVar("WingsBreakChance") and mob:AnimationSub() == 0 then
            mob:AnimationSub(1)
        end
    end)
	-- chance to break when hit by an offensive JA(like box step)
	mob:addListener("ABILITY_TAKE", "TYGER_ABILITY_TAKE", function(mob, user, ability, action)
        local abilityID = ability:getID()
        if abilityID == 150      -- tomahawk
        or abilityID == 46       -- shield bash
        or abilityID == 77       -- weapon bash
        or abilityID == 66       -- jump
        or abilityID == 67       -- high jump
        or abilityID == 68       -- super jump
        or abilityID == 201      -- quick step
        or abilityID == 202      -- box step
        or abilityID == 203      -- stutter step
        or abilityID == 205      -- desperate flourish
        or abilityID == 207      -- violent flourish
        or abilityID == 168      -- blade bash
        or abilityID == 170 then -- angon
			if math.random(100) <= mob:getLocalVar("WingsBreakChance") and mob:AnimationSub() == 0 then
				mob:AnimationSub(1)
			end
		end
	end)
    -- Regenrates wings and uses Tourbillion every 10%
    if mob:getHPP() < 90 and Phase == 0 then
        mob:useMobAbility(2024) -- Tourbillion
        mob:AnimationSub(0)
        mob:setLocalVar("Phase", 1)
    end
    if mob:getHPP() < 80 and Phase == 1 then
        mob:useMobAbility(2024) -- Tourbillion
        mob:AnimationSub(0)
        mob:setLocalVar("Phase", 2)
    end
    if mob:getHPP() < 70 and Phase == 2 then
        mob:useMobAbility(2024) -- Tourbillion
        mob:AnimationSub(0)
        mob:setLocalVar("Phase", 3)
    end
    if mob:getHPP() < 60 and Phase == 3 then
        mob:useMobAbility(2024) -- Tourbillion
        mob:AnimationSub(0)
        mob:setLocalVar("Phase", 4)
    end

    if mob:getHPP() < 50 and Phase == 4 then
        mob:useMobAbility(2024) -- Tourbillion
        mob:AnimationSub(0)
        mob:setLocalVar("Phase", 5)
    end
    if mob:getHPP() < 40 and Phase == 5 then
        mob:useMobAbility(2024) -- Tourbillion
        mob:AnimationSub(0)
        mob:setLocalVar("Phase", 6)
    end
    if mob:getHPP() < 30 and Phase == 6 then
        mob:useMobAbility(2024) -- Tourbillion
        mob:AnimationSub(0)
        mob:setLocalVar("Phase", 7)
    end
    if mob:getHPP() < 20 and Phase == 7 then
        mob:useMobAbility(2024) -- Tourbillion
        mob:AnimationSub(0)
        mob:setLocalVar("Phase", 8)
    end
    if mob:getHPP() < 10 and Phase == 8 then
        mob:useMobAbility(2024) -- Tourbillion
        mob:AnimationSub(0)
        mob:setLocalVar("Phase", 9)
    end
end

function onMobWeaponSkillPrepare(mob, target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    player:addCurrency("zeni_point", 400)
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
