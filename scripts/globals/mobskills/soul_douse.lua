---------------------------------------------
-- Soul Dose
-- Description: Breat damage.
-- Additional effect: Inflicts Doom upon an enemy. This is not a gaze attack. Turing away will not prevent doom.
-- Range: 30' Frontal Cone
-- Type: Magical (Dark)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if not target:isInfront(mob, 90) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobHPBasedMove(mob, target, 0.10, 1, tpz.magic.ele.DARK, 2000)
    local typeEffect = tpz.effect.DOOM
    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.50)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.DARK, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.DARK)
    if mob:AnimationSub() == 1 then  -- Additional effects when Wings are up
        MobStatusEffectMove(mob, target, typeEffect, 1, 3, 15)
    end
    return dmg
end
