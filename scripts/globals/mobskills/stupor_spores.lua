---------------------------------------------
--  Stupor Spores
--
--  Spreads intoxicating spores that damages nearby targets. Additional effect: Sleep
--  Type: Magical Water (Element)
-- Open mouth only (Aimation Sub 6)
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
   if (mob:AnimationSub() == 6) or (mob:AnimationSub() == 2) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLEEP_I
    local dmgmod = 1.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 6, tpz.magic.ele.NONE, dmgmod, TP_NO_EFFECT, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.NONE, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.NONE)
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 90)
    return dmg
end