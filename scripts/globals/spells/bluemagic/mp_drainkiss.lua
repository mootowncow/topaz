-----------------------------------------
-- Spell: MP Drainkiss
-- Steals an enemy's MP. Ineffective against undead
-- Spell cost: 20 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: MP+5
-- Level: 42
-- Casting Time: 4 seconds
-- Recast Time: 90 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
-- Notes:
-- Affected by Blue Magic Skill and Magic Accuracy.
-- Soft cap at 165MP before Magic Bursts / Day and Weather/Elemental Affinity effects.
-- Elemental Affinity and Elemental Obis affect both accuracy and amount of MP drained.
-- Magic Burst affects both accuracy and amount of MP drained.
-- INT increases Magic Accuracy in general, but is not a modifier of this spell.
-- Unlike Magic Hammer, MP drained is not enhanced by Magic Attack Bonus.
-- A positive Monster Correlation (vs Birds) or a negative Monster Correlation (vs Aquans), affects both accuracy and potency.
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.DARK
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    local multi = 1.0

    if (caster:hasStatusEffect(tpz.effect.AZURE_LORE)) then
        multi = multi + 2.0
    end
    params.multiplier = multi
    params.tMultiplier = 1.0
    params.duppercap = 80
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.3
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local dmg = BlueMagicalSpell(caster, target, spell, params, INT_BASED)

    -- Check for zombie
    if utils.CheckForZombieSpell(caster, spell) then
        return 0
    end

    if (target:isUndead()) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end

    -- add in final adjustments
    dmg = BlueFinalAdjustments(caster, target, spell, dmg, params)

	dmg = (dmg * math.random(50, 100)) / 100

    if dmg > 0 then
        dmg = dmg * BLUE_POWER
        caster:addMP(dmg)
    end

    return dmg
end
