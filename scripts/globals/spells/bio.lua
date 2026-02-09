-----------------------------------------
-- Spell: Bio
-- Deals dark damage that weakens an enemy's attacks and gradually reduces its HP.
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------------

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
    params.multiplier = 1
    params.skillType = tpz.skill.DARK_MAGIC
    params.attribute = tpz.mod.INT
    params.hasMultipleTargetReduction = false
    params.diff = caster:getStat(tpz.mod.INT)-target:getStat(tpz.mod.INT)
    params.attribute = tpz.mod.INT
    params.skillType = tpz.skill.DARK_MAGIC
    params.bonus = 10

    -- Calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    -- Softcaps at 15, should always do at least 1
    dmg = utils.clamp(dmg, 1, 15)  -- changed from 1 and 15
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
    local duration = calculateDuration(60, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    local tier = 1

    -- Calculate DoT effect
    -- http://wiki.ffo.jp/html/1954.html
    local dotdmg = 0
    if     skillLvl > 80 then dotdmg = 9    -- changed from 3
    elseif skillLvl > 40 then dotdmg = 4    -- changed from 2
    else                      dotdmg = 2    -- changed from 1
    end

    if caster:isMob() then -- Don't let this scale out of control from mobs
        if     skillLvl > 80 then dotdmg = 3
        elseif skillLvl > 40 then dotdmg = 2
        else                      dotdmg = 1
        end
    end

    if ShouldOverwriteDiaBio(caster, target, tpz.effect.BIO, tier) then
        target:addStatusEffect(tpz.effect.BIO, dotdmg, 3, duration, 0, 5, 1)
    end

    spell:setMsg(tpz.msg.basic.MAGIC_DMG)
    CheckForMagicBurst(caster, spell, target)

    return final
end
