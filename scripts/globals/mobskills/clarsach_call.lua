---------------------------------------------------
-- Clarsach Call
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 9
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2.5, tpz.magic.ele.WIND, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.WIND, MOBPARAM_WIPE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.WIND)
    local effectsList =
    {
        tpz.effect.ATTACK_BOOST, tpz.effect.DEFENSE_BOOST,
        tpz.effect.ACCURACY_BOOST, tpz.effect.EVASION_BOOST,
        tpz.effect.MAGIC_ATK_BOOST, tpz.effect.MAGIC_DEF_BOOST,
        tpz.effect.MAGIC_EVASION_BOOST_II
    }

    for _, effect in pairs (effectsList) do
        MobBuffMoveSub(mob, effect, 25, 0, 180, 0, 0, 0)
    end
    return dmg
end
