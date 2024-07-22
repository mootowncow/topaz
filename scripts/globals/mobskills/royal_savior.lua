---------------------------------------------
-- Royal Savior
-- Grants effect of Protect, Stoneskin and Reprisal
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local duration = 60

    local maxReflectedDamage = target:getMaxHP() * 2
    local reflectedPercent = 33

    mob:delStatusEffect(tpz.effect.REPRISAL)
    mob:addStatusEffect(tpz.effect.DEFENSE_BOOST, 100, 0, duration)
    mob:addStatusEffect(tpz.effect.STONESKIN, 1500, 0, duration)
    mob:addStatusEffect(tpz.effect.REPRISAL, reflectedPercent, 0, duration, 0, maxReflectedDamage)
    skill:setMsg(tpz.effect.PROTECT)

    return tpz.effect.PROTECT
end

