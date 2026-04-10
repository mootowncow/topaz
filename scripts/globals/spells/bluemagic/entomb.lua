-----------------------------------------
-- Spell: Charged Whisker
-- 	Deals Lightning damage to enemies within area of effect.
-- Spell cost: 70 MP
-- Monster Type: Arcana
-- Spell Type: Magical (Lightning)
-- Blue Magic Points: 4
-- Stat Bonus: DEX+3
-- Level: 44
-- Casting Time: 4.5 seconds
-- Recast Time: 29.25 seconds
-- Magic Bursts on: Impaction, Fragmentation, Light
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}

    params.diff = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    local multi = 4.0
    if (caster:hasStatusEffect(tpz.effect.AZURE_LORE)) then
        multi = multi + 2.0
    end
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.EARTH
    params.multiplier = multi
    params.tMultiplier = 2.0
    params.duppercap = 80
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.8
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.eco = ECO_NONE
    local damage = BlueMagicalSpell(caster, target, spell, params, INT_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params.effect = tpz.effect.PETRIFICATION
    params.bonus = 50
    local power = 1
    local tick = 0
    local duration = 60
    BlueTryEnfeeble(caster, target, spell, damage, power, tick, duration, params)

    return damage
end
