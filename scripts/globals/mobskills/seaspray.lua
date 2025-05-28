---------------------------------------------
-- Seaspray
-- Inflicts damage. Additional Effect: Slow. Ignores shadows.
-- Breath damage.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local AIMode = mob:getLocalVar("AIMode")
    if mob:getPool() == 2920 and AIMode == 1 then -- Nuhn
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobHPBasedMove(mob, target, 0.125, 1, tpz.magic.ele.WATER, 500)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)

    local typeEffect = tpz.effect.SLOW

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WATER)
    MobStatusEffectMove(mob, target, typeEffect, 3500, 0, 300)
    return dmg
end
