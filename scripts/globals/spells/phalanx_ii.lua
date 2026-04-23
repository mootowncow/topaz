-----------------------------------------
-- Spell: Phalanx II
-----------------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local enhskill = caster:getSkillLevel(tpz.skill.ENHANCING_MAGIC) + caster:getMod(tpz.mod.ENHANCE)
    local power = 0
    local merits = caster:getMerit(tpz.merit.PHALANX_II)

    -- Non-players have version is equal to a fully merited version
    if not caster:isPC() then
        merits = 15
    end

    local meritPowerBonus = merits - 3
    local baseDuration = 120 + ((merits * 10) - 30)
    local finalDuration = calculateDuration(baseDuration, spell:getSkillType(), spell:getSpellGroup(), caster, target)
    finalDuration = calculateDurationForLvl(finalDuration, 75, target:getMainLvl())

    if enhskill <= 300 then
        power = math.floor(enhskill / 25) + 1
        -- add merit bonus
        power = power + meritPowerBonus
        -- add gear mod
        power = power + caster:getMod(tpz.mod.PHALANX_POTENCY)
    else
        power = 13 + meritPowerBonus
        -- add merit bonus
        power = power + math.floor((enhskill - 300.5) / 28.5)
        -- add gear mod
        power = power + caster:getMod(tpz.mod.PHALANX_POTENCY)
    end

    -- Cap at 35
    power = math.min(power, 35)

    -- Add phalanx recieved gear mod
    power = power + target:getMod(tpz.mod.PHALANX_RECIEVED)

    if target:addStatusEffect(tpz.effect.PHALANX, power, 0, finalDuration) then
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.PHALANX
end
