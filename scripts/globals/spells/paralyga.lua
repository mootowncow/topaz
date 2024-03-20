-----------------------------------------
-- Spell: Paralyze
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and MND.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    -- Pull base stats
    local dMND = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    local MND = caster:getStat(tpz.mod.MND) 

    -- Base potency
    local potency = utils.clamp(math.floor(2 * (MND+dMND)) / 10, 5, 25)

    potency = calculatePotency(potency, spell:getSkillType(), caster, target)

    --print(string.format("step1: %u",potency))
	--GetPlayerByID(6):PrintToPlayer(string.format("Paralyze chance: %u",potency))
    --printf("Duration : %u", duration)
    --printf("Potency : %u", potency)
    local duration = math.random(60, 120)
    local params = {}
    params.diff = dMND
    params.skillType = tpz.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.PARALYSIS
    local resist = applyResistanceEffect(caster, target, spell, params)

    TryApplyEffect(caster, target, spell, params.effect, potency, 0, duration, resist, 0.5)

    return params.effect
end
