---------------------------------------------
-- Absolute Terror
-- Causes Terror, which causes the victim to be stunned for the duration of the effect, this can not be removed.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:hasStatusEffect(tpz.effect.MIGHTY_STRIKES) then
        return 1
    elseif mob:hasStatusEffect(tpz.effect.SUPER_BUFF) then
        return 1
    elseif mob:hasStatusEffect(tpz.effect.INVINCIBLE) then
        return 1
    elseif mob:hasStatusEffect(tpz.effect.BLOOD_WEAPON) then
        return 1
    elseif mob:AnimationSub() == 1 then
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.TERROR
    local power = 1
    local duration = 5 

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration))
    return typeEffect
end
