---------------------------------------------
-- Hi-Freq Field
-- Lowers the evasion of enemies in a fan-shaped area of effect.
-- -25% EVA down
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.EVASION_DOWN
    local power = math.floor(target:getEVA()* 0.25)

    if (mob:getName() == 'Gouger Beetle') then
        typeEffect = tpz.effect.AVOIDANCE_DOWN
    end

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, 300))

    return typeEffect
end
