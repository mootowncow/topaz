---------------------------------------------------
-- Tremors
-- Deals Earth damage with a seismic disturbance. Additional effect: DEX Down
-- Area of Effect is centered around caster.
-- Utsusemi/Blink absorb: Wipes shadows
-- Duration: Three minutes ?
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DEX_DOWN
    local tick = 30
    local power = (target:getStat(tpz.mod.DEX) * 0.2) + 5

    local dmgmod = 1.5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*2.5, tpz.magic.ele.EARTH, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.EARTH, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.EARTH)
    MobStatusEffectMove(mob, target, typeEffect, power, tick, 300)
    return dmg
end
