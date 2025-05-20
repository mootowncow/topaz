---------------------------------------------
--  Sweet Breath
--
--  Description: Deals water damage to enemies within a fan-shaped area originating from the caster.
--  Type: Magical Water (Element)
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local isCassie = mob:getPool() == 630
    local isVivian = mob:getPool() == 4253

    if isCassie or isVivian then
        skill:setAoe(1)
        skill:setDistance(50)
    else
        skill:setAoe(2)
        skill:setDistance(15)
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLEEP_I
    local dmgmod = MobHPBasedMove(mob, target, skill, 0.09, 1, tpz.magic.ele.WATER, 500)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WATER)
    mob:resetEnmity(target)

    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 180)

    return dmg
end
