---------------------------------------------
-- Hypnic Lamp
-- 	Inflicts Sleep upon targets facing the user. Ignores shadows
-- Damage does not wake target(like Nightmare)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local AIMode = mob:getLocalVar("AIMode")
    if mob:getPool() == 2920 and AIMode == 1 then -- Nuhn
        return 1
    end
    if mob:AnimationSub() == 1 then
        return 1
    else
        return 0
    end
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.SLEEP_II
    local params = {}
    params.DEEPSLEEP = true
    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, 90, params))

    return typeEffect
end
