-----------------------------------------
-- Spell: Hojo:San
-- Description: Inflicts Slow on target.
-- Edited from slow.lua
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    --Duration and Resistance calculation
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.NINJUTSU
    params.bonus = 30
    params.effect = tpz.effect.SLOW
    local power = 3000
    local resist = applyResistanceEffect(caster, target, spell, params)
    local duration = 180
    local tier = 3

    TryApplyEffect(caster, target, spell, params.effect, power, 0, duration, resist, 0.5, tier)

    return params.effect
end

