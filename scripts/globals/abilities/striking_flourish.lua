-----------------------------------
-- Ability: Striking Flourish
-- Description: Grants +5 store TP per finishing move consumed to nearby allies.
-- Obtained: DNC Level 89
-- Recast Time: 00:01:30 (Flourishes III)
-- Duration: 00:03:00
-- Cost: 1-5 Finishing Move charges
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/job_util")
require("scripts/globals/msg")
-----------------------------------
function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    local maxConsumed = 5
    local finishingMoves = jobUtil.getFinishingMoveCount(player)

    if (finishingMoves > 0) then
        local actualConsumed = jobUtil.consumeFinishingMoves(player, maxConsumed)
        local storeTPAmount = actualConsumed * 5

        if (actualConsumed > 0) then
            player:addStatusEffect(tpz.effect.STRIKING_FLOURISH, storeTPAmount, 0, 180)
        end
    end
end
