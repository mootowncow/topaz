-----------------------------------------
-- Spell: Bio II
-- Deals dark damage that weakens an enemy's attacks and gradually reduces its HP.
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local skillLvl = caster:getSkillLevel(tpz.skill.DARK_MAGIC)
    if caster:isAutomaton() then
        skillLvl = caster:getSkillLevel(tpz.skill.AUTOMATON_MAGIC)
    end

    local basedmg = skillLvl / 4
    local params = {}
    params.dmg = basedmg
    params.multiplier = 2
    params.skillType = tpz.skill.DARK_MAGIC
    params.attribute = tpz.mod.INT
    params.hasMultipleTargetReduction = false
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    params.bonus = 10

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Softcaps at 30, should always do at least 1
    dmg = utils.clamp(dmg, 1, 30)
    -- Get resist multiplier (1x if no resist)
    local resist = applyResistance(caster, target, spell, params)
    -- Get the resisted damage
    dmg = dmg * resist
    -- Add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg)
    -- Add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
	if dmg <= 0 then dmg = 1 end
    -- Add in final adjustments including the actual damage dealt
    local final = finalMagicAdjustments(caster, target, spell, dmg)

    -- Calculate duration
    local duration = calculateDuration(120, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local tier = 2

    -- Calculate DoT effect
    -- http://wiki.ffo.jp/html/1954.html
    -- This formula gives correct values for every breakpoint listed on that site
    --local dotdmg = math.floor((skillLvl + 29) / 40)
    local dotdmg = math.floor((skillLvl + 29) / 5)
    if caster:isMob() then -- Don't let this scale out of control from mobs
        dotdmg = math.floor((skillLvl + 29) / 40)
    end
    dotdmg = utils.clamp(dotdmg, 3, 100)

    if ShouldOverwriteDiaBio(caster, target, tpz.effect.BIO, tier) then
        target:addStatusEffect(tpz.effect.BIO, dotdmg, 3, duration, 0, 10, 2)
    end

    spell:setMsg(tpz.msg.basic.MAGIC_DMG)
    CheckForMagicBurst(caster, spell, target)

    return final
end
