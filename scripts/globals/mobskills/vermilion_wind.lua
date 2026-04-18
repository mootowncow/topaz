---------------------------------------------
-- Warped Wail
-- 15' AoE Inflicts -101 attribute down
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end



function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 7
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
	target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    local params = {}
    params.ALWAYS_ENFEEBLE = true
    local power = 101
    local duration = 60
    local isGaze = false
    MobAllStatDownMove(mob, target, power, duration, isGaze, params)
    return dmg
end
