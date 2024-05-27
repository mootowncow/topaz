-----------------------------------------
-- Spell: Frypan
-- Delivers an area attack. Additional effect: "Stun." Accuracy varies with TP
-- Spell cost: 65 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: DEX+2
-- Level: 63
-- Casting Time: 1 seconds
-- Recast Time: 26 seconds
-- Skillchain Element(s): Lightning (can open Liquefaction or Detonation can close Impaction or Fusion)
-- Combos: Max HP Boost
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
    local dINT = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    local params = {}
    params.diff = dINT
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.effect = tpz.effect.STUN
    local resist = applyResistanceEffect(caster, target, spell, params)
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_ACC
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_IMPACTION
    params.numhits = 1
    params.multiplier = 2.0
    params.tp150 = 2.0
    params.tp300 = 2.0
    params.azuretp = 2.0
    params.duppercap = 75
    params.str_wsc = 0.4
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.2
    params.chr_wsc = 0.0
    params.AccTPModifier = true
    params.shadowbehav = BLUPARAM_WIPE_SHADOWS

    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    BlueTryPhysStun(caster, target, spell, resist, params)

    return damage
end
