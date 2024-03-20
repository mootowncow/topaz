-----------------------------------------
-- Spell: Spinal Cleave
-- Damage varies with TP
-- Spell cost: 61 MP
-- Monster Type: Undead
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 4
-- Stat Bonus: VIT+2, INT+1, MND+1
-- Level: 63
-- Casting Time: 0.5 seconds
-- Recast Time: 28.5 seconds
-- Skillchain Element(s): Earth/Wind (can open Scission, Reverberation, Detonation, Gravitation, or Liquefaction can close Scission or Distortion, Detonation)
-- Combos: Attack Bonus
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
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_DAMAGE
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.Piercing
    params.scattr = SC_SCISSION
    params.scattr2 = SC_DETONATION
    params.numhits = 1
    params.multiplier = 3.1
    params.tp150 = 3.75
    params.tp300 = 4.25
    params.azuretp = 4.25
    params.duppercap = 74
    params.str_wsc = 0.6
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
	params.attkbonus = 1.50
    params.AttkTPModifier = true
    params.shadowbehav = BLUPARAM_IGNORE_SHADOWS
    damage = BluePhysicalSpell(caster, target, spell, params)
	local arcana = (target:getSystem() == 3)
	
	if arcana then
		damage = damage * (1.25 + caster:getMerit(tpz.merit.MONSTER_CORRELATION)/100 + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)/100)
	end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
