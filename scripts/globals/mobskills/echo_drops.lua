---------------------------------------------
-- Echo Drops
--
-- Description: Silena's Target
-- Type: Status Cure
-- Utsusemi/Blink absorb: N/A
-- Range: 21 Yalms
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/pets")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    if (target:getStatusEffect(tpz.effect.SILENCE) ~= nil) then
        target:delStatusEffectSilent(tpz.effect.SILENCE)
        skill:setMsg(tpz.msg.basic.IS_NO_LONGER_STATUS)
    else
        skill:setMsg(tpz.msg.basic.NO_EFFECT)
    end

    return tpz.effect.SILENCE
end
