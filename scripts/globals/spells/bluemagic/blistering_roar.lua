-----------------------------------------
-- Spell: Blistering Roar
-- 	Enemies within an area of effect are frozen with fear.
-- Spell cost: 37 MP
-- Monster Type: Birds
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: MP+15
-- Level: 48
-- Casting Time: 0.5 seconds
-- Recast Time: 2:00
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
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
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.effect = tpz.effect.TERROR
    params.bonus = 125
	local lizard = (target:getSystem() == 14)
    local beast = (target:getSystem() == 6)

	if lizard then
		params.bonus = params.bonus + caster:getMerit(tpz.merit.MONSTER_CORRELATION) + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)
    elseif beast then
        params.bonus = params.bonus - 25
	end

    local duration = 30

	if target:isNM() then
		duration = duration / 2
	end

    typeEffect = tpz.effect.TERROR

    if target:hasStatusEffect(typeEffect) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return typeEffect
    end

    params.effect = typeEffect
    if BlueTryEnfeeble(caster, target, spell, 1, power, 0, duration, params) then
        spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
    else
        if (spell:getMsg() ~= tpz.msg.basic.MAGIC_IMMUNE) then
            spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        end
    end

    return tpz.effect.TERROR
end
