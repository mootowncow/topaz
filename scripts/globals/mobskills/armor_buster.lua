---------------------------------------------------
-- Armor_Buster
-- Description:
-- Type: Magical
-- additional effect: WEIGHT
---------------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local phase = mob:getLocalVar("battlePhase")

    if (phase >= 3) then -- only proto-ultima has the var at a value other than 0. Note that the phase values range from 0-4 for the five phases.
        if mob:getLocalVar("nuclearWaste") == 0 and mob:getLocalVar("citadelBuster") == 0 then
            return 0
        end
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.WEIGHT
    local dmgmod = 2
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, tpz.magic.ele.LIGHT, dmgmod, TP_MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.MAGICAL, tpz.damageType.LIGHT, MOBPARAM_IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, tpz.attackType.MAGICAL, tpz.damageType.LIGHT)
    MobStatusEffectMove(mob, target, typeEffect, 25, 0, 300)
    return dmg
end