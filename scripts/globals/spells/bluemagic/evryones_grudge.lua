-----------------------------------------
-- Spell: Everyones Grudge
-- Deals dark damage to an enemy
-- Spell cost: 112 MP
-- Monster Type: Demons
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: HP-5, MP+15
-- Level: 61
-- Casting Time: 4.5 seconds
-- Recast Time: 29.25 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: Magic Attack Bonus
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    spell:setFlag(tpz.magic.spellFlag.IGNORE_SHADOWS)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    -- This data should match information on https://www.bg-wiki.com/bg/Calculating_Blue_Magic_Damage
    params.diff = caster:getStat(tpz.mod.CHR)-target:getStat(tpz.mod.CHR)
    params.attribute = tpz.mod.CHR
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    local multi = 3.0
    if (caster:hasStatusEffect(tpz.effect.AZURE_LORE)) then
        multi = multi + 2.0
    end
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.DARK
    params.multiplier = multi
    params.tMultiplier = 2.0
    params.duppercap = 80
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.4
    params.chr_wsc = 0.0
    damage = BlueMagicalSpell(caster, target, spell, params, CHR_BASED)

    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
