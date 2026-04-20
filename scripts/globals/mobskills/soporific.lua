---------------------------------------------
-- Soporific
-- 15' AoE sleep
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if mob:getName() == 'Goblintrap' then
        skill:setDistance(20)
    else
        skill:setDistance(15)
    end

    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local params = {}
    local typeEffect = tpz.effect.SLEEP_II

    if mob:getName() == 'Gnoletrap' then
        mob:resetEnmity(target)
    elseif mob:getName() == 'Goblintrap' then
        params.DEEPSLEEP = true
    end

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 90, false, params))

    return tpz.effect.SLEEP_I
end
