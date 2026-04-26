-- Chaos Blast
-- '18 AOE damage
-- Inflicts Max HP Down, Max MP Down, Max TP Down and Knockback to all in range.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
if (mob:getHPP() > 65) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = 2
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, tpz.magic.ele.DARK, dmgmod, TP_NO_EFFECT, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.DARK, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.DARK)
    local params = {}
    params.ALWAYS_ENFEEBLE = true
    MobStatusEffectMove(mob, target, tpz.effect.MAX_HP_DOWN, 50, 0, 60, false, params)
    MobStatusEffectMove(mob, target, tpz.effect.MAX_MP_DOWN, 50, 0, 60, false, params)
    MobStatusEffectMove(mob, target, tpz.effect.MAX_TP_DOWN, 50, 0, 60, false, params)
    return dmg
end
