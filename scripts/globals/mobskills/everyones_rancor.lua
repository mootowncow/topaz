---------------------------------------------
-- Everyone's Rancor
--
-- Notes: Invokes rancor to spite a single target.
--
-- Damage is 50x the amount of Tonberries slain.
-- Only used by certain NMs, generally only once
-- and when they have reached a certain percentage
-- of HP (usually 25%).
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:isNM() then
        mob:setLocalVar("everyonesRancorUsed", 1)
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local realDmg = 0
    local grudgeVar = target:getCharVar("EVERYONES_GRUDGE_KILLS")

    if target:isPet() or target:isTrust() then
        local master = target:getMaster()
        if master:isPC() then
            grudgeVar = master:getCharVar("EVERYONES_GRUDGE_KILLS")
        end
    end

    if target:isAlly() then
        grudgeVar = 50
    end

    realDmg = 10 * grudgeVar

    local dmg = MobFinalAdjustments(realDmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.ELEMENTAL)

    return dmg
end
