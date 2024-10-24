---------------------------------------------
-- Petrifactive Breath
--
-- Description: Petrifies a single target.
-- Type: Breath
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: Unknown
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PETRIFICATION
    skill:setMsg(MobStatusEffectMoveSub(mob, target, typeEffect, 1, 0, 30, 0, 0, 0))
    if mob:getPool() == 6849 then -- Chesma
        mob:resetEnmity(target)
    end
    return typeEffect
end
