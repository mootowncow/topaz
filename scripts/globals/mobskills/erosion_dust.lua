---------------------------------------------
--  Erosion Dust
--
--  Description: AoE Dia effect, can be Erased. Removes all shadows.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: AoE
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DIA
    local dmgmod = 3.3
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 0.01, tpz.magic.ele.LIGHT, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    MobStatusEffectMoveSub(mob, target, tpz.effect.DIA, 11, 3, 180, 0, 15, 3)
    return typeEffect
end
