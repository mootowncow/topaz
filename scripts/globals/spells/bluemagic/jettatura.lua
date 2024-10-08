-----------------------------------------
-- Spell: Jettatura
-- Enemies within a fan-shaped area originating from the caster are frozen with fear
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
    params.bonus = 0
    local duration = 30
	local aquan = (target:getSystem() == 2)
	local amorph = (target:getSystem() == 1)
	
	if aquan then
		params.bonus = 25 + caster:getMerit(tpz.merit.MONSTER_CORRELATION) + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)
	elseif amorph then
		params.bonus = -25
	end

    if target:hasStatusEffect(params.effect) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return params.effect
    end

    if isNoEffectMsg(caster, target, params.effect, params) then
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return params.effect
    end

    if BlueTryEnfeeble(caster, target, spell, 1, power, 0, duration, params) then
        spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
    else
        if (spell:getMsg() ~= tpz.msg.basic.MAGIC_IMMUNE) then
            spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        end
    end

    return tpz.effect.TERROR
end
