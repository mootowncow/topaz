---------------------------------------------
-- Tiiimbeeer
--
-- Description: AoE magical damage Additional effect: Doom (10-count), Plague, Bind, all stats down
-- Type: Magical
-- Element: Earth
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local hasAura = mob:AnimationSub() == 1
    if (hasAura) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.BIND
    local typeEffectTwo = tpz.effect.PLAGUE
    local typeEffectThree = tpz.effect.DOOM
    local dmgmod = 7.0
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.EARTH, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg , mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.EARTH, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.EARTH)
    MobStatusEffectMove(mob, target, typeEffect, 1, 0, 20)
    MobStatusEffectMove(mob, target, typeEffectTwo, 5, 3, 90)
    MobStatusEffectMove(mob, target, typeEffectThree, 10, 3, 30)
    MobAllStatDownMove(mob, target, 21, 60)
    return dmg
end