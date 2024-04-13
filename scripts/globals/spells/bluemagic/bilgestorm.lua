-----------------------------------------
-- Spell: Bilgestorm
-- Deals damage in an area of effect. Additional effect: Lowers attack, accuracy, and defense
-- Spell cost: 12 MP
-- Monster Type: Beastmen
-- Spell Type: Physical (Blunt)
-- Blue Magic Points: 3
-- Stat Bonus: DEX+2
-- Level: 12
-- Casting Time: 0.5 seconds
-- Recast Time: 10 seconds
-- Skillchain Element(s): Lightning (can open Liquefaction or Detonation can close Impaction or Fusion)
-- Combos: None
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
    params.bonus = 0
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_Damage
    params.tpmod = TPMOD_DAMAGE
    params.attackType = tpz.attackType.PHYSICAL
    params.damageType = tpz.damageType.BLUNT
    params.scattr = SC_LIGHT
    params.numhits = 1
    params.multiplier = 4.0
    params.tp150 = 4.0
    params.tp300 = 4.0
    params.azuretp = 4.0
    params.duppercap = 80
    params.str_wsc = 0.3
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.3
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    params.eco = ECO_DEMON
    local damage = BluePhysicalSpell(caster, target, spell, params)
    damage = BlueFinalAdjustments(caster, target, spell, damage, params)

    params.bonus = BlueHandleCorrelationMACC(caster, target, spell, params, 125)
    local power = 15
    -- Spell physically hit, check for additional effect proccing
    if (spell:getMsg() ~= tpz.msg.basic.MAGIC_FAIL) then
        params.effect = tpz.effect.ATTACK_DOWN
        local resist = applyResistanceEffect(caster, target, spell, params)
        -- Check for attack down landing
        if (resist >= 0.5) then
            target:addStatusEffect(params.effect, power, 0, 180)
        end

        params.effect = tpz.effect.ACCURACY_DOWN
        resist = applyResistanceEffect(caster, target, spell, params)
        -- Check for accuracy down landing
        if (resist >= 0.5) then
            target:addStatusEffect(params.effect, power, 0, 180)
        end

        params.effect = tpz.effect.DEFENSE_DOWN
        resist = applyResistanceEffect(caster, target, spell, params)
        -- Check for defense down landing
        if (resist >= 0.5) then
            target:addStatusEffect(params.effect, power, 0, 180)
        end
    end

    return damage
end
