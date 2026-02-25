-----------------------------------------
-- Spell: Yurin: Ichi
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.diff = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.NINJUTSU
    params.bonus = 255
    params.effect = tpz.effect.EVASION_DOWN
    local resist = applyResistanceEffect(caster, target, spell, params)
    local power = 20
    local duration =  180

    TryApplyEffect(caster, target, spell, params.effect, power, 0, duration, resist, 0.5)

    return params.effect
end
