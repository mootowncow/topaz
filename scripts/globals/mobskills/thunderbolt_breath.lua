---------------------------------------------
--  Thunderbolt
--
--  Description: Deals thunder damage to enemies within a fan-shaped area originating from the caster.
--  Type: Magical (Thunder)
--
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    -- not used in Uleguerand_Range
    if (mob:getZoneID() == 5) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobHPBasedMove(mob, target, 0.10, 1, tpz.magic.ele.THUNDER, 700)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.LIGHTNING, MOBPARAM_IGNORE_SHADOWS)

    local typeEffect = tpz.effect.STUN

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.LIGHTNING)
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 8)
    return dmg
end
