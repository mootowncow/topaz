---------------------------------------------
--  Gate of Tartarus
--
--  Description: Lowers target's attack. Claustrum/Thyrus: Refresh
--  Type: Magica
--  Shadow per hit
--  Range: Melee
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
require("scripts/globals/aftermath")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.ATTACK_DOWN
    local tp = mob:getLocalVar("tp")

    local dmgmod = 5
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.DARK, dmgmod, TP_MAB_BONUS)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    MobStatusEffectMove(mob, target, tpz.effect.ATTACK_DOWN, 20, 0, 300)
    tpz.aftermath.addStatusEffect(mob, tp, tpz.slot.MAIN, tpz.aftermath.type.RELIC, true, 12)
    return dmg
end
