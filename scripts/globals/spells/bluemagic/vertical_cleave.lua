-----------------------------------------
-- Spell: Vertical Cleave
-- Damage varies with TP
-- Spell cost: 86 MP
-- Monster Type: Luminians
-- Spell Type: Physical (Slashing)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+1 HP-5 MP+5
-- Level: 75
-- Casting Time: 0.5 seconds
-- Recast Time: 37.25 seconds
-- Skillchain Element(s): Gravitation (can open/close Darkness with Distortion WSs and spells)
-- Combos: Defense Bonus
-- TODO: Ignores Shadows
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
    params.tpmod = TPMOD_ATTACK
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.SLASHING
    params.scattr = SC_GRAVITATION
    params.numhits = 1
    params.multiplier = 3.0
    params.tp150 = 3.0
    params.tp300 = 3.0
    params.azuretp = 3.0
    params.duppercap = 80
    params.str_wsc = 0.4
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
 	local luminions = (target:getSystem() == 16)
	
	if luminions then
		damage = damage * (1.25 + caster:getMerit(tpz.merit.MONSTER_CORRELATION)/100 + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)/100)
	end
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    return damage
end
