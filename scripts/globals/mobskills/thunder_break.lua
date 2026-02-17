---------------------------------------------------
-- Thunder Break
-- Channels the power of Thunder toward targets in an area of effect. Additional effect: Stun

---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 1.5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.THUNDER, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHTNING)

    local effect = tpz.effect.STUN
    local power = 1
    local tick = 0
    local duration = 10
    local tier = 1
    local subId = 1
    local subPower = 1
    local isGaze = false
    MobStatusEffectMoveSub(mob, target, effect, power, tick, duration, subId, subPower, tier, isGaze)
    return dmg
end
