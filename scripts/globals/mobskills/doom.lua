---------------------------------------------
-- Doom
--
-- Description: Inflicts Doom upon an enemy.
-- Type: Magical (Dark)
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DOOM

    if target:hasStatusEffect(tpz.effect.FEALTY) then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
    else
        skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 10, 3, 30))
    end


    return typeEffect
end
