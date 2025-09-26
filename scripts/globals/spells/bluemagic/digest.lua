-----------------------------------------
-- Spell: Digest
-- Steals an enemy's HP. 
-- Spell cost: 20 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Light)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5, MP+5
-- Level: 36
-- Casting Time: 4 seconds
-- Recast Time: 90 seconds
-- Magic Bursts on: Transfixion, Fusion, Light
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.diff = caster:getStat(tpz.mod.MND)-target:getStat(tpz.mod.MND)
    params.attribute = tpz.mod.MND
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    local multi = 2.0
    if (caster:hasStatusEffect(tpz.effect.AZURE_LORE)) then
        multi = multi + 2.0
    end
    params.multiplier = multi
    local resist = applyResistance(caster, target, spell, params)
    -- This data should match information on http://wiki.ffxiclopedia.org/wiki/Calculating_Blue_Magic_dmg
    params.attackType = tpz.attackType.MAGICAL
    params.dmgType = tpz.damageType.LIGHT
    params.bonus = 0
    params.multiplier = multi
    params.tMultiplier = 1.0
    params.duppercap = 80
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.4
    params.chr_wsc = 0.0
    local dmg = BlueMagicalSpell(caster, target, spell, params, MND_BASED)

    -- Check for zombie
    if utils.CheckForZombieSpell(caster, spell) then
        return 0
    end

    if (dmg < 0) then
        dmg = 0
    end

    if (target:isUndead()) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end

	-- add final adjustments
    dmg = BlueFinalAdjustments(caster, target, spell, dmg, params)

	-- add dmg variance
	dmg = (dmg * math.random(50, 100)) / 100
 
    local healing = dmg
    -- Cap healing amount at the targets current HP
    if (target:getHP() < dmg) then
        healing = target:getHP()
    end

    if dmg > 0 then
	    dmg = dmg * BLUE_POWER
	    caster:addHP(healing)
    end

    spell:setMsg(tpz.msg.basic.MAGIC_DRAIN_HP)

    return dmg
end
