-----------------------------------------
-- Spell: Dokumori: San
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = tpz.effect.POISON
    -- Base Stats
    local dINT = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    --Duration Calculation
    local params = {}
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.NINJUTSU
    params.bonus = 0
    params.effect = tpz.effect.POISON
    local resist = applyResistance(caster, target, spell, params)
    local power = 20
    local duration = 180
    local tier = 3

    TryApplyEffect(caster, target, spell, params.effect, power, 3, duration, resist, 0.5, 0, tier)

    return params.effect
end

