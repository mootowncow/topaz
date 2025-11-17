---------------------------------------------------
-- Tyrant Tusk
--
-- Magical
-- Element: Dark
-- Conal
-- Additional effect: KO if targets HP is below 50% as of a result of this damage
---------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 5.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    if target:getHPP() < 50 then
        target:setHP(0)
        return skill:setMsg(tpz.msg.basic.FALL_TO_GROUND)
    end
    MobStatusEffectMoveSub(mob, target, skill, tpz.effect.BIO, 10, 3, 180, 0, 15, 3)
    return dmg
end
