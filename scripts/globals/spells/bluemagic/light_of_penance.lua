-----------------------------------------
-- Spell: Light of Penance
-- Reduces an enemy's TP. Additional effect: Blindness and "Bind"
-- Spell cost: 53 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Light)
-- Blue Magic Points: 5
-- Stat Bonus: CHR+1, HP+15
-- Level: 58
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Magic Bursts on: Transfixion, Fusion, and Light
-- Combos: Auto Refresh
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
	local typeEffectOne = tpz.effect.BLINDNESS
    local typeEffectTwo = tpz.effect.BIND
    local params = {}
    local multi = 3.0
    if (caster:hasStatusEffect(tpz.effect.AZURE_LORE)) then
        multi = multi + 2.0
    end
    params.attackType = tpz.attackType.MAGICAL
    params.damageType = tpz.damageType.LIGHT
    params.diff = caster:getStat(tpz.mod.MND) - target:getStat(tpz.mod.MND)
    params.attribute = tpz.mod.MND
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    -- This data should match information on https://www.bg-wiki.com/bg/Calculating_Blue_Magic_Damage
    params.multiplier = multi
    params.tMultiplier = 3.0
    params.duppercap = 80
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.4
    params.chr_wsc = 0.0

    spell:setMsg(tpz.msg.basic.MAGIC_DMG)
    local damage = BlueMagicalSpell(caster, target, spell, params, MND_BASED)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params.effect = tpz.effect.BLINDNESS
    BlueTryEnfeeble(caster, target, spell, damage, 100, 0, 12, params)
    params.effect = tpz.effect.BIND
    BlueTryEnfeeble(caster, target, spell, damage, 1, 0, GetBindDuration(), params)

	return damage
end
