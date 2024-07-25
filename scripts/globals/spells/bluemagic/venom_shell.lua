-----------------------------------------
-- Spell: Venom Shell
-- Poisons enemies within range and gradually reduces their HP
-- Spell cost: 86 MP
-- Monster Type: Aquans
-- Spell Type: Magical (Water)
-- Blue Magic Points: 3
-- Stat Bonus: MND+2
-- Level: 42
-- Casting Time: 3 seconds
-- Recast Time: 45 seconds
-- Magic Bursts on: Reverberation, Distortion, and Darkness
-- Combos: Clear Mind
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
    local typeEffect = tpz.effect.POISON
    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    local params = {}
    params.diff = dINT
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = typeEffect
    params.eco = ECO_AQUAN
    local skill = caster:getSkillLevel(tpz.skill.BLUE_MAGIC)
    local power = (skill / 6) 

    if target:hasStatusEffect(typeEffect) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return typeEffect
    end

    params.effect = typeEffect
    if BlueTryEnfeeble(caster, target, spell, 1, power, 3, 180, params) then
        spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB_IS)
    else
        if (spell:getMsg() ~= tpz.msg.basic.MAGIC_IMMUNE) then
            spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
        end
    end

    return typeEffect
end
