-----------------------------------------
-- Spell: Blood Drain
-- Steals an enemy's HP. Ineffective against undead
-- Spell cost: 10 MP
-- Monster Type: Giant Bats
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 2
-- Stat Bonus: HP-5, MP+5
-- Level: 20
-- Casting Time: 4 seconds
-- Recast Time: 90 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
-----------------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local params = {}
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.BLUE_MAGIC
    params.bonus = 0
    local multi = 2.0
    if (caster:hasStatusEffect(tpz.effect.AZURE_LORE)) then
        multi = multi + 2.0
    end
    params.multiplier = multi
    params.attackType = tpz.attackType.MAGICAL
    params.dmgType = tpz.damageType.DARK
    params.bonus = 0
    params.multiplier = multi
    params.tMultiplier = 1.0
    params.duppercap = 80
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.4
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0
    local dmg = BlueMagicalSpell(caster, target, spell, params, INT_BASED)

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
