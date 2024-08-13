---------------------------------------------
-- Ion_Efflux
--
-- Description: 10'(?) cone  Paralysis, ignores Utsusemi
-- Type: Magical
--
-- Range: 10 yalms
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    local mobhp = mob:getHPP()
	if mob:getPool() == 2973 then
		if mobhp > 25 then
            if (mob:AnimationSub() <= 1) then
			    return 0
            end
		else
			return 1
		end
	end
    if (mob:AnimationSub() <= 1) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.PARALYSIS

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 30, 0, 300))

    return typeEffect
end
