-----------------------------------
-- Ability: Wild Flourish
-- Readies target for a skillchain. Requires at least two Finishing Moves.
-- Obtained: Dancer Level 60
-- Finishing Moves Used: 2
-- Recast Time: 0:30
-- Duration: 0:05
-----------------------------------
require("scripts/globals/weaponskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/job_util")
require("scripts/globals/msg")
-----------------------------------
function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability, action)
    -- Consume finishing moves
    local maxConsumed = 2
    local finishingMoves = jobUtil.getFinishingMoveCount(player)
    if (finishingMoves > 0) then
        local actualConsumed = jobUtil.consumeFinishingMoves(player, maxConsumed)
    end

    -- Check for shadows
    if TryShadowsAbsorb(target, ability) then
        return 1
    end

    if (target:hasStatusEffect(tpz.effect.CHAINBOUND, 0) or target:hasStatusEffect(tpz.effect.SKILLCHAIN, 0)) then
        target:delStatusEffectSilent(tpz.effect.CHAINBOUND)
        target:delStatusEffectSilent(tpz.effect.SKILLCHAIN)
    end

    target:addStatusEffectEx(tpz.effect.CHAINBOUND, 0, 1, 0, 10, 0, 1)

    local jpValue = player:getJobPointLevel(tpz.jp.FLOURISH_II_EFFECT)
    player:queue(0, function(player)
        player:addMod(tpz.mod.SKILLCHAINDMG, jpValue)
    end)
    player:queue(10*1000, function(player)
        player:delMod(tpz.mod.SKILLCHAINDMG, jpValue)
    end)

    action:animation(target:getID(), getFlourishAnimation(player:getWeaponSkillType(tpz.slot.MAIN)))
    action:speceffect(target:getID(), 1)
    return 0
end
