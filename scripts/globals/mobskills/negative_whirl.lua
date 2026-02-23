---------------------------------------------
--  Negative Whirl
--
--  Description: Slow Wipes shadows
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 10' cone
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local element = mob:getLocalVar("element") + 5
    local typeEffect = tpz.effect.SLOW
    local dmgmod = math.floor(mob:getMainLvl() * 2)
    if mob:isNM() then
        dmgmod = math.floor(mob:getMainLvl() * 3)
    end
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, tpz.attackType.MAGICAL, element, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, element)
    MobStatusEffectMove(mob, target, typeEffect, 8500, 0, 300)
    return dmg
end
