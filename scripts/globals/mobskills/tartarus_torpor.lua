---------------------------------------------
--  Tartarus Torpor
--
--  Description: Puts to sleep enemies within the area of effect and lowers their magical defense and magical evasion.
--  Type: Magical Non-elemental
--  Utsusemi/Blink absorb: Ignores shadows
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 4
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*1, tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    MobStatusEffectMove(mob, target, tpz.effect.SLEEP, 1, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.MAGIC_DEF_DOWN, 25, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.MAGIC_EVASION_DOWN, 25, 0, 60)
    return dmg
end
