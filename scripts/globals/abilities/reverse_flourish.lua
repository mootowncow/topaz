-----------------------------------
-- Ability: Reverse Flourish
-- Converts remaining finishing moves into TP. Requires at least one Finishing Move.
-- Obtained: Dancer Level 40
-- Finishing Moves Used: 1-5
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
    local TPGain = 0
    local STM = 0.5 + (0.1 * player:getMod(tpz.mod.REVERSE_FLOURISH_EFFECT))
    local Merits = player:getMerit(tpz.merit.REVERSE_FLOURISH_EFFECT)
    local jpValue = player:getJobPointLevel(tpz.jp.FLOURISH_II_EFFECT) * 2 / 10
    local maxConsumed = 5
    local finishingMoves = jobUtil.getFinishingMoveCount(player)

    if (finishingMoves > 0) then
        local actualConsumed = jobUtil.consumeFinishingMoves(player, maxConsumed)
        
        if (actualConsumed > 0) then
            TPGain = (9.5 + jpValue) * actualConsumed + STM * actualConsumed ^ 2 + Merits
        end

        TPGain = TPGain * 10

        player:addTP(TPGain)

        return TPGain
    end
end
