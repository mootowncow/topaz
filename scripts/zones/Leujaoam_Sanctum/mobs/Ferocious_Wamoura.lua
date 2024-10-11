-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Ferocious Wamoura
-----------------------------------
require("scripts/globals/mobs")
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
function onMobSpawn(mob)
	mob:setDamage(125)
    mob:setMod(tpz.mod.DEFP, 12)
    mob:setMod(tpz.mod.MDEF, 40)
    mob:setMod(tpz.mod.UDMGMAGIC, 13)
    mob:setMod(tpz.mod.REGAIN, 50)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 2) 
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
    mob:setMobMod(tpz.mobMod.NO_AGGRO, 1)
	mob:setMobMod(tpz.mobMod.SIGHT_RANGE, 20)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MANAFONT, hpp = 25},
        },
    })
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
	local AddleTime = mob:getLocalVar("AddleTime")
	local BattleTime = mob:getBattleTime()
    local HPP = mob:getHPP()
    local Defp = (100 - HPP) -- 1% for every 1% missing HP
    local UFastCast = (100 - HPP) / 2 --1% for every 2% missing HP

	if mob:hasStatusEffect(tpz.effect.BLAZE_SPIKES) == false then
		mob:addStatusEffect(tpz.effect.BLAZE_SPIKES, 25, 0, 7200)
        local effect1 = mob:getStatusEffect(tpz.effect.BLAZE_SPIKES)
        effect1:unsetFlag(tpz.effectFlag.DISPELABLE)
	end

    utils.AddDynamicMod(mob, tpz.mod.UFASTCAST, UFastCast)
    utils.AddDynamicMod(mob, tpz.mod.DEFP, Defp)

	if mob:getHPP() <= 50 then
		if AddleTime == 0 then
			mob:setLocalVar("AddleTime", BattleTime)
		elseif BattleTime >= AddleTime then
			mob:castSpell(286) -- Addle
			mob:setLocalVar("AddleTime", BattleTime + 180)
		end
	end

	if mob:getHPP() <= 25 then
        mob:setMod(tpz.mod.REGAIN, 100)
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
    if mob:getHPP() > 51 then
        return 1956 -- Fire Break
    else
        return math.random(1951, 1955) -- Normal Wamoura TP moves
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