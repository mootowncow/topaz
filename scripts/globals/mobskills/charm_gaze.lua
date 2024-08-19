---------------------------------------------
-- Charm
-- Used by All-Seeing Onyx Eye
-- Conal + Gaze
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if (target:isFacing(mob)) then
		if target:hasStatusEffect(tpz.effect.BLINDNESS) then
			return skill:setMsg(tpz.msg.basic.SKILL_MISS)
		else
			MobCharmMove(mob, target, skill, 0, math.random(15, 20))
            return skill:setMsg(tpz.effect.CHARM_I)
		end
    end
    return skill:setMsg(tpz.msg.basic.SKILL_MISS)
end
