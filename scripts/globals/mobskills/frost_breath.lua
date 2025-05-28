---------------------------------------------
--  Frost Breath
--
--  Description: Deals ice damage to enemies within a fan-shaped area originating from the caster. Additional effect: Paralysis.
--  Type: Magical (Ice)
--
--
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    -- only used in Uleguerand_Range and by Rahu(MMM)
    if (mob:getZoneID() == 5) then
        return 0
    end
    if (mob:getPool( )== 9068) then -- Rahu
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PARALYSIS

    MobStatusEffectMove(mob, target, typeEffect, 25, 0, 300)

    local dmgmod = MobHPBasedMove(mob, target, 0.10, 1, tpz.magic.ele.ICE, 700)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.ICE, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.ICE)
    return dmg
end
