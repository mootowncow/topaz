---------------------------------------------
-- Mix:Antidote
--
-- Description: Poisona's Target
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
    if (target:hasStatusEffect(tpz.effect.POISON) == true) then
        local effect = target:getStatusEffect(tpz.effect.POISON)
        local effectFlags = effect:getFlag()
        if (bit.band(effectFlags, tpz.effectFlag.WALTZABLE) ~= 0) then
            target:delStatusEffectSilent(tpz.effect.POISON)
            skill:setMsg(tpz.msg.basic.IS_NO_LONGER_STATUS)
        else
            skill:setMsg(tpz.msg.basic.NO_EFFECT)
        end
    end
    return tpz.effect.POISON
end
