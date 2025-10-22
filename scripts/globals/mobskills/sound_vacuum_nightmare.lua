---------------------------------------------
-- Sound Vacuum (Nightmare)
--
-- Description: Mutes enemies in a 10' radius around the mob.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown cone
-- Notes: Worm version is single target rather than conical (except for Nightmare Worm). The Nightmare Cockatrice inflicts Mute with this ability.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.MUTE

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 10))

    return typeEffect
end
