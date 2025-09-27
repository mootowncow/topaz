-----------------------------------------
-- Spell: Drain
-- Drain functions only on skill level!!
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    if target:isUndead() then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end
    --calculate raw damage (unknown function  -> only dark skill though) - using http://www.bluegartr.com/threads/44518-Drain-Calculations
    -- also have small constant to account for 0 dark skill
    local dmg = 20 + caster:getSkillLevel(tpz.skill.DARK_MAGIC) -- changed from 1.035 to 0.60

    --get resist multiplier (1x if no resist)
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    params.bonus = 0
    local resist = applyResistance(caster, target, spell, params)

    -- Check for zombie
    if utils.CheckForZombieSpell(caster, spell) then
        return 0
    end

    --get the resisted damage
    dmg = dmg*resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    --add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    --add in final adjustments

    if (dmg < 0) then
        dmg = 0
    end
	
    dmg = finalMagicAdjustments(caster, target, spell, dmg)

	-- add dmg variance
	dmg = (dmg * math.random(50, 100)) / 100

    dmg = dmg * DARK_POWER

    if (target:isUndead()) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- No effect
        return dmg
    end

    local healing = dmg
    -- Cap healing amount at the targets current HP
    if (target:getHP() < dmg) then
        healing = target:getHP()
    end

	-- Heal for 0 if afflicted with zombie
	if caster:hasStatusEffect(tpz.effect.CURSE_II) then
		caster:addHP(0)
	else
		caster:addHP(healing)
	end
	
    return dmg
end
