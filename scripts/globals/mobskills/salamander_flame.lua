---------------------------------------------
--  Searing Effulgence 
--
--  Description: AoE Fire damage and powerful DoT Dia effect (-15% defense).
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
    local dmgmod = 5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 0.01, tpz.magic.ele.FIRE, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.FIRE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.FIRE)
    MobStatusEffectMoveSub(mob, target, tpz.effect.DIA, 35, 3, 120, 0, 15, 3)
    return dmg
end
