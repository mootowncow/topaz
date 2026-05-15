---------------------------------------------------
-- Dark Star
-- Deals dark elemental damage to enemies in a '20 radius.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local currentTarget = mob:getTarget()
    if currentTarget and currentTarget:isBehind(mob, 90) then
        return 1
    end

    if mob:AnimationSub() == tpz.mob.animationSubs['Zilant'].WINGS_UP or mob:AnimationSub() == tpz.mob.animationSubs['Zilant'].AURA_WINGS_UP then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 4
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    return dmg
end
