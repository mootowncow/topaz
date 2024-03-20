-----------------------------------------
-- Spell: Uppercut
-- Damage varies with TP
-- Spell cost: 31 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: STR+2, DEX+1
-- Level: 38
-- Casting Time: 0.5 seconds
-- Recast Time: 17.75 seconds
-- Skillchain Element(s): Fire (Primary) and Lightning (Secondary) - (can open Scission, Detonation, Liquefaction, or Fusion can close Liquefaction, Impaction, or Fusion)
-- Combos: Attack Bonus
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
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_LIQUEFACTION
    params.scattr2 = SC_IMPACTION
    params.numhits = 1
    params.multiplier = 2.0 -- 1.5 on retail but it sucked
    params.tp150 = 2.0
    params.tp300 = 2.0
    params.azuretp = 2.0
    params.duppercap = 39
    params.str_wsc = 0.35
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
	params.attkbonus = 1.50
    params.AttkTPModifier = true
    damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)
	local beast = (target:getSystem() == 6)
	local vermin = (target:getSystem() == 20)
	
	if beast then
		damage = damage * (1.25 + caster:getMerit(tpz.merit.MONSTER_CORRELATION)/100 + caster:getMod(tpz.mod.MONSTER_CORRELATION_BONUS)/100)
	elseif vermin then
		damage = damage * 0.75
	end

    return damage
end
