-----------------------------------------
-- Spell: Barbed Crescent
-- Damage varies with TP. Additional Effect: Accuracy Down
-- Spell cost: 39 MP
-- Monster Type: Vermin
-- Spell Type: Physical (Ranged)
-- Blue Magic Points: 3
-- Stat Bonus: STR+1 HP+5
-- Level: 60
-- Casting Time: 4 seconds
-- Recast Time: 45 seconds
-- Skillchain property: Transfixion (can open Compression, Reverberation, or Distortion)
-- Combos: Plantoid Killer
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
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
    params.effect = tpz.effect.ACCURACY_DOWN
    local resist = applyResistanceEffect(caster, target, spell, params)
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_DAMAGE
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.SLASHING
    params.scattr = SC_TRANSFIXION
    params.numhits = 1
    params.multiplier = 3.0
    params.tp150 = 3.2
    params.tp300 = 3.5
    params.azuretp = 3.5
    params.duppercap = 80
    params.str_wsc = 0.0
    params.dex_wsc = 0.5
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.attkbonus = 1.50
    params.eco = ECO_UNDEAD
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    BlueTryEnfeeble(caster, target, spell, damage, 30, 0, 180, params)

    return damage
end
