-----------------------------------------
-- Spell: Bind
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    --Pull base stats.
    local dINT = (caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))

    --Duration, including resistance.  May need more research.
    local duration = GetBindDuration()

    --Resist
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = 35
    params.bonus = 0
    params.effect = tpz.effect.BIND
    local resist = applyResistanceEffect(caster, target, spell, params)

    TryApplyEffect(caster, target, spell, params.effect, target:speed(), 0, duration, resist, 0.5)

    return tpz.effect.BIND
end
