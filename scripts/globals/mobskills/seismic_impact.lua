---------------------------------------------
--  Seismic Impact
--
--  Description: Deals earth damage in an AOE around the target.
-- Additional effect: Slow and Terror.
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 3.5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.EARTH, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.EARTH, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.EARTH)
    MobHasteOverwriteSlowMove(mob, target, 7500, 0, 180, 0, 0, 2)
    MobStatusEffectMove(mob, target, tpz.effect.TERROR, 1, 0, 15)
    return dmg
end
