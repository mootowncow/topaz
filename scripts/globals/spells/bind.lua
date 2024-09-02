-----------------------------------------
-- Spell: Bind
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    -- Pull base stats.
    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)

    -- BIND spells have a special random duration the follows a normal distribution with mean=30 and std=12
    -- Use the Box-Muller transform to change uniform dist sample to the normal dist sample
    local z0 = math.sqrt(-2 * math.log(math.random())) * math.cos(2 * math.pi * math.random())
    local duration = utils.clamp(math.floor(30 + z0 * 12), 1, duration)

    -- Resist
    local params = {}
    params.diff = dINT
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.BIND
    local resist = applyResistanceEffect(caster, target, spell, params)

    TryApplyEffect(caster, target, spell, params.effect, target:speed(), 0, duration, resist, 0.5)

    return params.effect
end
