-----------------------------------------
-- Spell: Delta Thrust
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
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_ATTACK
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.PIERCING
    params.scattr = SC_TRANSFIXION
    params.numhits = 5
    params.multiplier = 1.0
    params.tp150 = 1.0
    params.tp300 = 1.0
    params.azuretp = 1.0
    params.duppercap = 100
    params.str_wsc = 0.2
    params.dex_wsc = 0.0
    params.vit_wsc = 0.2
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.eco = ECO_ARCANA
    params.attkbonus = 0.9
    params.AttkTPModifier = true

    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
