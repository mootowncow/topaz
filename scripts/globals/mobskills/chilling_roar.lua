---------------------------------------------
-- Chilling Roar
-- Causes Terror, which causes the victim to be stunned for the duration of the effect, this can not be removed.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local currentTarget = mob:getTarget()
    if currentTarget and currentTarget:isBehind(mob, 90) then
        return 1
    end
    
    if (mob:getHPP() > 50) then
        return 1
    elseif mob:AnimationSub() == tpz.mob.animationSubs['Zilant'].WINGS_UP or mob:AnimationSub() == tpz.mob.animationSubs['Zilant'].AURA_WINGS_UP then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.TERROR
    local duration = 8

    local params = {}
    params.ALWAYS_ENFEEBLE = true
    params.STATIC_DURATION = true
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, duration, false, params))
    mob:lowerEnmity(target, 70)

    return typeEffect
end
