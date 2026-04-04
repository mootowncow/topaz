---------------------------------------------
-- Kick Out
--
-- Description: Deals heavy damage and inflicts blind to any target behind user.
-- Type: Physical
-- Utsusemi/Blink absorb: 2-3 shadows
-- Range: Unknown cone, backwards
-- Notes:  Only used when the Behemoth is attacking with its tail.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if target:isInfront(mob, 90) then
        return 1
    elseif target:isBeside(mob, 45) then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local dmgmod = MobHPBasedMove(mob, target, skill, 0.125, 1, tpz.magic.ele.ELEMENTAL, 1500)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.ELEMENTAL, MOBPARAM_IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.ELEMENTAL)
    return dmg
end
