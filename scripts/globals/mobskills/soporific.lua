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
    local typeEffect = tpz.effect.SLEEP_II

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, 90))
    if mob:getName() == 'Gnoletrap' then
        mob:resetEnmity(target)
    elseif mob:getName() == 'Goblintrap' then
        local effect = target:getStatusEffect(tpz.effect.SLEEP_II)
        local duration = math.ceil((effect:getTimeRemaining()) / 1000)
        if (duration > 0) then
            target:addStatusEffectEx(tpz.effect.DEEPSLEEP,0,1,3,duration)
        end
    end
    return tpz.effect.SLEEP_I
end
