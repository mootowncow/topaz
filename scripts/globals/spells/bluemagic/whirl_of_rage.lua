-----------------------------------------
-- Spell: Whirl of Rage
-- Damage varies with TP
-- Spell cost: 73 MP
-- Monster Type: Arcana
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 2
-- Stat Bonus: STR +2 DEX +2
-- Level: 72
-- Casting Time: 1 second
-- Recast Time: 30 seconds
-- Skillchain Element(s): Scission / Detonation
-- Combos: 	Zanshin
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
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
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_DAMAGE
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.SLASHING
    params.scattr = SC_SCISSION
    params.scattr2 = SC_DETONATION
    params.numhits = 1
    params.multiplier = 3.0
    params.tp150 = 3.5
    params.tp300 = 4.0
    params.azuretp = 4.0
    params.duppercap = 80
    params.str_wsc = 0.3
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0
    params.eco = ECO_ARCANA
    params.shadowbehav = BLUPARAM_WIPE_SHADOWS
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params.bonus = BlueHandleCorrelationMACC(caster, target, spell, params, 25)
    local resist = applyResistanceEffect(caster, target, spell, params)

    BlueTryPhysStun(caster, target, spell, resist, params)

    return damage
end
