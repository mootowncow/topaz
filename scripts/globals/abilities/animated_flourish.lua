-----------------------------------
-- Ability: Animated Flourish
-- Provokes the target. Requires at least one, but uses two Finishing Moves.
-- Obtained: Dancer Level 20
-- Finishing Moves Used: 1-2
-- Recast Time: 00:30
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
    local jpValue = player:getJobPointLevel(tpz.jp.FLOURISH_I_EFFECT) * 10
    local maxConsumed = 2

    local finishingMoves = jobUtil.getFinishingMoveCount(player)

    if (finishingMoves > 0) then
        local actualConsumed = jobUtil.consumeFinishingMoves(player, maxConsumed)
        
        if (actualConsumed > 0) then
            local enmityValue = (actualConsumed == 1) and 1000 or 1500
            target:addEnmity(player, 0, enmityValue + jpValue)
        end
    end
end