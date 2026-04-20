---------------------------------------------------
-- Wings of Woe
-- Deals wind damage to enemies in an AOE. 
-- Additional effect: Unremovable Silence, Plague, and Bind.
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 7.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2, tpz.magic.ele.WIND, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    local params = {}
    params.UNREMOVABLE = true
    MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 60, false, params)
    MobStatusEffectMove(mob, target, tpz.effect.PLAGUE, 25, 0, 8, false, params)
    MobStatusEffectMove(mob, target, tpz.effect.BIND, 1, 0, 45, false, params)
    return dmg
end
