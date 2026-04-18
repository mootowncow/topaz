---------------------------------------------
-- Scream (Terror)
-- 10' MND Down + Terror.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local tick = 30
    local power = (target:getStat(tpz.mod.MND) * 0.25)

    MobStatusEffectMove(mob, target, tpz.effect.MND_DOWN, power, tick, 300)
    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.TERROR, 1, 0, 12))

    return typeEffect
end
