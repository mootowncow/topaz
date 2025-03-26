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
    local potency = 0;

    if (player:getID() == target:getID()) then
        local maxConsumed = 5
        local finishingMoves = jobUtil.getFinishingMoveCount(player)
        if (finishingMoves > 0) then
            local actualConsumed = jobUtil.consumeFinishingMoves(player, maxConsumed)
            potency = actualConsumed * 5
        end
        player:setLocalVar("AOE_Striking_Potency", potency);
    else
        potency = player:getLocalVar("AOE_Striking_Potency");
    end

    if potency > 0 then
        target:addStatusEffect(tpz.effect.STRIKING_FLOURISH, potency, 0, 180)
    else
        printf("Potency was null or 0")
    end
end
