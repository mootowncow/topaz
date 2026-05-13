---------------------------------------------
-- Soul Douse
-- Description: Inflicts Doom upon an enemy. This is not a gaze attack. Turing away will not prevent doom.
-- Range: 30' Frontal Cone
-- Type: Magical (Dark)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if not target:isInfront(mob, 90) then
        return 1
    elseif mob:AnimationSub() == tpz.mob.animationSubs['Zilant'].WINGS_UP or mob:AnimationSub() == tpz.mob.animationSubs['Zilant'].AURA_WINGS_UP then
        return 1
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DOOM
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 3, 30))
    mob:resetEnmity(target)
    return typeEffect
end
