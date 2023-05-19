---------------------------------------------
-- Sonic Boom
-- Reduces attack of targets in area of effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

--function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.ATTACK_DOWN
   -- skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 50, 0, 540)) -- 9 minutes on wiki 

  --  return typeEffect
--end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.ATTACK_DOWN
    if not target:hasStatusEffect(tpz.effect.ATTACK_DOWN) then
        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 25, 0, 540))
    else
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT)
    end
    return typeEffect
end
