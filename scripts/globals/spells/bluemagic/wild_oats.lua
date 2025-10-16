-----------------------------------------
-- Spell: Wild Oats
-- Additional effect: Vitality Down. Duration of effect varies on TP
-- Spell cost: 9 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 3
-- Stat Bonus: CHR+1, HP+10
-- Level: 4
-- Casting Time: 0.5 seconds
-- Recast Time: 7.25 seconds
-- Skillchain Element(s): Light (can open Compression, Reverberation, or Distortion can close Transfixion)
-- Combos: Beast Killer
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
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_DURATION
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.PIERCING
    params.scattr = SC_TRANSFIXION
    params.numhits = 1
    params.multiplier = 1.84
    params.tp150 = 1.84
    params.tp300 = 1.84
    params.azuretp = 1.84
    params.duppercap = 11
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.3
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.eco = ECO_PLANTOID
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params.bonus = 15
    params.effect = tpz.effect.VIT_DOWN
    local vitDown = 3 + caster:getMainLvl() / 7
    BlueTryEnfeeble(caster, target, spell, damage, vitDown, 30, 180, params)
    params.effect = tpz.effect.ATTACK_DOWN
    BlueTryEnfeeble(caster, target, spell, damage, 8, 0, 180, params)

    return damage
end
