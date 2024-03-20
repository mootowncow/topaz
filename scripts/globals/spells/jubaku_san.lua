-----------------------------------------
-- Spell: Jubaku: Ichi
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and INT.
-- taken from paralyze
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
    params.bonus = 0
    params.effect = tpz.effect.PARALYSIS
    local resist = applyResistanceEffect(caster, target, spell, params)
    -- Jubaku base powers are not effected by resistances, Ichi:20, Ni:30, San:35.
    local power = 30
    local duration = math.random(60, 120)
    local tier = 3

    TryApplyEffect(caster, target, spell, params.effect, power, 0, duration, resist, 0.5, tier)

    return params.effect
end
