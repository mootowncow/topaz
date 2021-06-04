-----------------------------------------
-- Spell: Stinking Gas
-- Lowers Vitality of enemies within range
-- Spell cost: 37 MP
-- Monster Type: Undead
-- Spell Type: Magical (Wind)
-- Blue Magic Points: 2
-- Stat Bonus: AGI+1
-- Level: 44
-- Casting Time: 4 seconds
-- Recast Time: 60 seconds
-- Magic Bursts on: Detonation, Fragmentation, and Light
-- Combos: Auto Refresh
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 1.0
    local resist = applyResistance(caster, target, spell, params)
    if (target:hasStatusEffect(tpz.effect.VIT_DOWN)) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
    else
		local params = {}
		params.attribute = tpz.mod.INT
		params.skillType = tpz.skill.BLUE_MAGIC
		params.effect = tpz.effect.VIT_DOWN
		local duration = 90 * resist
		local level = (caster:getMainJob()  / 5)
		local power = level 

		if (resist >= 0.5) then -- Do it!
			if (target:addStatusEffect(params.effect, power, 0, duration)) then
				spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
			else
				spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
			end
		end

    return params.effect
end
