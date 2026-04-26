---------------------------------------------
-- Abominable Belch
-- Description: inflicts all targets in an area of effect with silence, paralysis and plague.
-- Radial
-- Ignores Shadows
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getPool() == 2920 then -- Nuhn
        return 1
    end
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.PLAGUE, 10, 3, 300))
    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.SILENCE, 1, 0, 300))
    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.PARALYSIS, 33, 0, 300))

    return tpz.effect.PLAGUE
end
