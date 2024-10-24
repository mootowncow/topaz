-----------------------------------------
-- Spell: Frazzle II
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

    -- Base evasion reduction is determend by enfeebling skill
    -- Caps at -40 evasion at 350 skill
    local basePotency = utils.clamp(math.floor(caster:getSkillLevel(tpz.skill.ENFEEBLING_MAGIC) * 4 / 35), 0, 40)

    -- dMND is tacked on after
    -- Min cap: 0 at 0 dMND
    -- Max cap: 10 at 50 dMND
    basePotency = basePotency + utils.clamp(math.floor(dMND / 5), 0, 10)
    local power = calculatePotency(basePotency, spell:getSkillType(), caster, target)

    local duration = 120

    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 150
    params.effect = tpz.effect.MAGIC_EVASION_DOWN
    local resist = applyResistanceEffect(caster, target, spell, params)

    TryApplyEffect(caster, target, spell, params.effect, 1, 0, duration, resist, 0.5)

    return params.effect
end
