---------------------------------------------
-- Spoil
--
-- Description: Lowers the strength of target.
-- Type: Enhancing
-- Utsusemi/Blink absorb: Ignore
-- Range: Self
-- Notes: Very sharp evasion increase.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.STR_DOWN
    local tick = 30
    local power = (target:getStat(tpz.mod.STR) * 0.2) +5

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, tick, 300))

    return typeEffect
end
