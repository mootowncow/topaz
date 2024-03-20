-----------------------------------------
-- Spell: Blind
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    -- Pull base stats.
    local dINT = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.MND)) --blind uses caster INT vs target MND

    -- Base power.  May need more research.
    local power = math.floor(dINT * 9/40) + 23

    if (power < 5) then
        power = 5
    end

    if (power > 30) then
        power = 30
    end


    -- Duration, including resistance.  Unconfirmed.
    local duration = math.random(180, 300)
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = 35
    params.bonus = 0
    params.effect = tpz.effect.BLINDNESS
    local resist = applyResistanceEffect(caster, target, spell, params)
    duration = duration * applyResistanceEffect(caster, target, spell, params)
    duration = duration * applyResistanceEffect(caster, target, spell, params)
    duration = math.ceil(duration * tryBuildResistance(tpz.magic.buildcat.BLIND, target))

    TryApplyEffect(caster, target, spell, params.effect, power, 0, duration, resist, 0.5)

    return params.effect
end
