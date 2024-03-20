-----------------------------------------
-- Spell: Silence
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dMND = (caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND))

    local duration = math.random(60, 120)

    --Resist
    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.SILENCE
    local resist = applyResistanceEffect(caster, target, spell, params)

    local isMaaIllmutheBestower = target:getPool() == 2465

    if isMaaIllmutheBestower then
        resist = 1
        duration = 30
        target:addTP(3000)
    end

    TryApplyEffect(caster, target, spell, params.effect, 1, 0, duration, resist, 0.5)

    return params.effect
end
