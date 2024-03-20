-----------------------------------------
-- Spell: Sub-zero Smash
-- Additional Effect: Paralysis. Damage varies with TP
-- Spell cost: 44 MP
-- Monster Type: Aquans
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 4
-- Stat Bonus: HP+10 VIT+3
-- Level: 72
-- Casting Time: 1 second
-- Recast Time: 30 seconds
-- Skillchain Element(s): Fragmentation-IconFragmentation (can open/close Light-Icon Light with Fusion WSs and spells)
-- Combos: Fast Cast
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
    params.diff = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    params.attribute = tpz.mod.MND
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    params.effect = tpz.effect.PARALYSIS
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_CRITICAL
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.PIERCING
    params.scattr = SC_FRAGMENTATION
    params.numhits = 1
    params.multiplier = 3.5
    params.tp150 = 3.5
    params.tp300 = 3.5
    params.azuretp = 3.5
    params.duppercap = 80
    params.str_wsc = 0.0
    params.dex_wsc = 0.4
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.eco = ECO_AQUAN
	params.attkbonus = 1.50
    params.CritTPModifier = true
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    BlueTryEnfeeble(caster, target, spell, damage, 10, 0, 180, params)

    return damage
end
