---------------------------------------------
-- Gloeosuccus
-- Enfeebling
-- Description: Slows down a single target.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if mob:getName() == 'Gnoletrap' then
        local dmgmod = MobHPBasedMove(mob, target, skill, 0.125, 1, tpz.magic.ele.EARTH, 500)
        local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.EARTH, MOBPARAM_IGNORE_SHADOWS)
        target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.EARTH)
        MobStatusEffectMove(mob, target, tpz.effect.SLOW, 3550, 0, 300)
        return dmg
    else
        skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.SLOW, 3550, 0, 300))
        return tpz.effect.SLOW
    end
end
