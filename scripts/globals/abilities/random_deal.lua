-----------------------------------
-- Ability: Random Deal
-- Has the possibility of resetting the reuse time of a job ability for each party member within area of effect.
-- Obtained: Corsair Level 50
-- Recast Time: 0:20:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(caster, target, ability, action)
    ability:setMsg(tpz.msg.basic.JA_RECEIVES_EFFECT_3)
    if not caster:doRandomDeal(target) then
        ability:setMsg(tpz.msg.basic.JA_MISS_2)
    end
end