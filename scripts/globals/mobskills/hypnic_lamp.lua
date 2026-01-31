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
    local message = tpz.msg.basic.SKILL_MISS
    local typeEffect = tpz.effect.SLEEP_II

    skill:setMsg(MobGazeMove(mob, target, typeEffect, 1, 0, 90))
    if (target:isFacing(mob) and target:hasStatusEffect(tpz.effect.SLEEP_II)) then
		if not target:hasStatusEffect(tpz.effect.BLINDNESS) then
            target:addStatusEffectEx(tpz.effect.DEEPSLEEP,0,1,3,90)
        end
    end

    return typeEffect
end
