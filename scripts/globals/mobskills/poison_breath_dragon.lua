---------------------------------------------
--  Poison Breath (Dragon)
--
--  Description: Deals Water breath damage to enemies within a fan-shaped area originating from the caster.
--  Type: Magical (Water)
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)

    local dmgmod = MobHPBasedMove(mob, target, 0.10, 1, tpz.magic.ele.WATER, 900)
    if mob:getPool() == 9056 then -- Vishap(Assault - Lebros Cavern)
        dmgmod = MobHPBasedMove(mob, target, 0.10, 1, tpz.magic.ele.WATER, 400)
    end

    local typeEffect = tpz.effect.POISON
    local power = 50

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WATER)
    MobStatusEffectMove(mob, target, typeEffect, power, 3, 90)
    return dmg
end
