---------------------------------------------
--  Infernal Pestilence
--
--  Description: Releases a horrible disease on targets in front. Additional effect: Plague.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Front arc
--  Notes: Only used by Chahnameed's Stomach and Verrottendes Fleisch(Custom - Arrapago Remnants Salvage)
---------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PLAGUE
    local dmgmod = MobHPBasedMove(mob, target, 0.50, 1, tpz.magic.ele.WATER, 500)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.BREATH, tpz.damageType.WATER, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.BREATH, tpz.damageType.WATER)
    MobStatusEffectMove(mob, target, typeEffect, 5, 3, 180)
    return dmg
end
