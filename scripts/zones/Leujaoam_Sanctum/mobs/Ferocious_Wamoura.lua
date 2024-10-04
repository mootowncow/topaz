-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Ferocious Wamoura
-----------------------------------
require("scripts/globals/mobs")
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
-----------------------------------
function onMobSpawn(mob)
	mob:setDamage(125)
    mob:setMod(tpz.mod.MDEF, 40)
    mob:setMod(tpz.mod.UDMGMAGIC, 13)
    mob:setMod(tpz.mod.REGAIN, 50)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 2) 
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 1)
	mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 20)
end

function onMobRoam(mob)
    if mob:getTP() > 1000 then
        mob:setTP(1000)
    end
	if mob:hasStatusEffect(tpz.effect.BLAZE_SPIKES) == false then
		mob:addStatusEffect(tpz.effect.BLAZE_SPIKES, 25, 0, 7200)
        local effect1 = mob:getStatusEffect(tpz.effect.BLAZE_SPIKES)
        effect1:unsetFlag(tpz.effectFlag.DISPELABLE)
	end
    mob:setMod(tpz.mod.REGAIN, 50)
end

function onMobEngaged(mob)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

function onMobFight(mob, target)
	local StunTime = mob:getLocalVar("StunTime")
	local AddleTime = mob:getLocalVar("AddleTime")
	local DrainTime = mob:getLocalVar("DrainTime")
	local BattleTime = mob:getBattleTime()

	if mob:hasStatusEffect(tpz.effect.BLAZE_SPIKES) == false then
		mob:addStatusEffect(tpz.effect.BLAZE_SPIKES, 25, 0, 7200)
            local effect1 = mob:getStatusEffect(tpz.effect.BLAZE_SPIKES)
            effect1:unsetFlag(tpz.effectFlag.DISPELABLE)
	end

	if mob:getHPP() <= 50 then
		if AddleTime == 0 then
			mob:setLocalVar("AddleTime", BattleTime)
		elseif BattleTime >= AddleTime then
			mob:castSpell(286) -- Addle
			mob:setLocalVar("AddleTime", BattleTime + 180)
		end
	end
	if mob:getHPP() <= 25 then
        mob:setMod(tpz.mod.REGAIN, 500)
    end
end

function onSpellPrecast(mob, spell)
    if spell:getID() == 286 then -- Addle
        spell:setAoE(tpz.magic.aoe.RADIAL)
        spell:setFlag(tpz.magic.spellFlag.HIT_ALL)
        spell:setRadius(50)
	end
end

function onMobWeaponSkillPrepare(mob, target)
    if mob:getHPP() <= 25 then
        return 1956 -- Fire Break
    end
end

function onMobWeaponSkill(target, mob, skill)
    if skill:getID() == 1956 then -- Fire Break
        mob:castSpell(176) -- Firaga III
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end