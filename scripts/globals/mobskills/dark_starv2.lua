---------------------------------------------------
-- Dark Star
-- Deals dark elemental damage to enemies in a '18 radius. Additional effect: Defense Down and Magic Defense Down.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:AnimationSub() == tpz.mob.animationSubs['Zilant'].WINGS_DOWN or mob:AnimationSub() == tpz.mob.animationSubs['Zilant'].AURA then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 4
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    MobStatusEffectMove(mob, target, tpz.effect.DEFENSE_DOWN, 50, 0, 60)
    MobStatusEffectMove(mob, target, tpz.effect.MAGIC_DEF_DOWN, 25, 0, 60)
    return dmg
end
