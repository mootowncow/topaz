-----------------------------------------
-- Spell: Cruel Joke
-- 	Inflicts doom on enemies within range
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
    params.effect = tpz.effect.DOOM
    params.bonus = 125
	local demon = (target:getSystem() == 9)

	if demon then
		params.bonus = params.bonus + caster:getMerit(tpz.merit.MONSTER_CORRELATION) + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)
	end

    local duration = 60

    typeEffect = tpz.effect.DOOM

    if target:hasStatusEffect(typeEffect) or target:isNM() then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return typeEffect
    end

    params.effect = typeEffect
    if BlueTryEnfeeble(caster, target, spell, 1, 10, 10, 60, params) then
        spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
    else
        if (spell:getMsg() ~= tpz.msg.basic.MAGIC_IMMUNE) then
            spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        end
    end

    return tpz.effect.DOOM
end
