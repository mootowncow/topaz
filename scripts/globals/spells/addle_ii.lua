-----------------------------------------
-- Spell: Addle
-- Increases the casting time of the target
-- Exact formula is unknown.
-- https://wiki.ffo.jp/html/21127.html
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local dMND = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)

    -- Spell casting increase
    local power = 50 + utils.clamp(math.floor(dMND / 5), 0, 20)
    power = calculatePotency(30, spell:getSkillType(), caster, target)
    
    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 20
    params.effect = tpz.effect.ADDLE
    local resist = applyResistanceEffect(caster, target, spell, params)
    --Duration, including resistance.
    local duration = 180 * resist

    TryApplyEffect(caster, target, spell, params.effect, power, 0, duration, resist, 0.5, power)

    return params.effect
end
