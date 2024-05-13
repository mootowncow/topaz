---------------------------------------------
-- Sinister Wing
--
--  Description: Deals hurricane-force Dark damage to enemies within a very wide area of effect. Additional effect: Blind
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 15' radial.
--  Notes: Used when soeone on the left of the mob has hate
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------
function onMobSkillCheck(target, mob, skill)
    if not target:isToLeft(mob, 45) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 2.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    MobStatusEffectMove(mob, target, tpz.effect.ACCURACY_DOWN, 50, 0, 300)
    MobStatusEffectMove(mob, target, tpz.effect.MAGIC_ACC_DOWN, 25, 0, 300)
    return dmg
end
