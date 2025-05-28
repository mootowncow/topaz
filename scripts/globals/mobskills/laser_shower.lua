---------------------------------------------
-- Laser_Shower
--
-- Description: Fires several lasers into a fan-shaped area of effect. Additional effect: Defense Down
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown cone
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:AnimationSub() == 2 and mob:getHPP() < 20 then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobHPBasedMove(mob, target, 0.25, 1, tpz.magic.ele.NONE, 900)

    dmgmod = utils.conalDamageAdjustment(mob, target, skill, dmgmod, 0.50)

    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.ELEMENTAL, MOBPARAM_IGNORE_SHADOWS)


    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.ELEMENTAL)
    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.DEFENSE_DOWN, 75, 0, 300)
    return dmg
end
