---------------------------------------------
-- Spoil
--
-- Description: Lowers the strength of target.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignore
-- Range: Single
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
    if (mob:getName() == 'Gouger_Beetle') then
        MobStatusEffectMove(mob, target, tpz.effect.ACCURACY_DOWN, 50, 0, 30)
        MobStatusEffectMove(mob, target, tpz.effect.MAGIC_ACC_DOWN, 25, 0, 30)
    end

    return typeEffect
end
