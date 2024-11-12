-----------------------------------
-- Ability: Climactic Flourish
-- Description: Grants +5% double attack per finishing move consumed to nearby allies.
-- Obtained: DNC Level 80
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
        local doubleAttackRate = actualConsumed * 5

        if (actualConsumed > 0) then
            player:addStatusEffect(tpz.effect.CLIMACTIC_FLOURISH, doubleAttackRate, 0, 180)
        end
    end
end