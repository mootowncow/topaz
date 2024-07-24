---------------------------------------------
-- Mix: Panacea-1
--
-- Description: Erases Target
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
    local effect = target:eraseStatusEffect()

    if (effect == tpz.effect.NONE) then
        skill:setMsg(tpz.msg.basic.NO_EFFECT) -- no effect
    else
        skill:setMsg(tpz.msg.basic.IS_NO_LONGER_STATUS)
    end

    return effect
end
